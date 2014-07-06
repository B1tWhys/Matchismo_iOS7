//
//  CardMatchingGame.m
//  Matchismo_iOS7
//
//  Created by David Leserman on 5/25/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"
@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Cards
@property (nonatomic, readwrite) BOOL wasMatch;
@property (nonatomic, readwrite) int deltaScore;
@property (nonatomic, strong, readwrite) NSMutableArray *matchCache;
@end

@implementation CardMatchingGame
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSString *)generateEventDisplayText {
    NSString *outputText;
    if (self.numberOfCardsToMatch == 2) {
        if (self.wasMatch) {
            outputText = [NSString stringWithFormat:@"%@ and %@ match. (+%i points)", ((PlayingCard *)(self.currentMatch[0])).contents, ((PlayingCard *)(self.currentMatch[1])).contents, self.deltaScore];
        } else {
            outputText = [NSString stringWithFormat:@"%@ and %@ don't match. (%i points)", ((PlayingCard *)(self.currentMatch[0])).contents, ((PlayingCard *)(self.currentMatch[1])).contents, self.deltaScore];
        }
    } else {
        if (self.wasMatch) {
            outputText = [NSString stringWithFormat:@"%@, %@ and %@ constitute a match. (+%i points)", ((PlayingCard *)(self.currentMatch[0])).contents, ((PlayingCard *)(self.currentMatch[1])).contents, ((PlayingCard *)(self.currentMatch[2])).contents, self.deltaScore];
        } else {
            outputText = [NSString stringWithFormat:@"%@, %@ and %@ constitute a don't match. (%i points)", ((PlayingCard *)(self.currentMatch[0])).contents, ((PlayingCard *)(self.currentMatch[1])).contents, ((PlayingCard *)(self.currentMatch[2])).contents, self.deltaScore];
        }
    }
    
    return outputText;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        _matchCache = [[NSMutableArray alloc] init];
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
            
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            self.deltaScore = 0; // reset deltaScore
            
            if (self.numberOfCardsToMatch == 2) {
                // match against another chosen cards
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        self.currentMatch = @[card, otherCard];
                        if (matchScore) {
                            self.wasMatch = YES;
                            self.deltaScore += matchScore * MATCH_BONUS;
                            otherCard.matched = YES;
                            card.matched = YES;
                        } else {
                            self.wasMatch = NO;
                            self.deltaScore -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                        }
                        break;
                    }
                }
            } else if (self.numberOfCardsToMatch == 3) {
                for (Card *otherCard1 in self.cards) {
                    if (otherCard1.isChosen && !otherCard1.isMatched) {
                        for (Card *otherCard2 in self.cards) {
                            if (otherCard2.isChosen && !otherCard2.isMatched && (otherCard2 != otherCard1)) {
                                int matchScore = [card match:@[otherCard1, otherCard2]];
                                self.currentMatch = @[card, otherCard1, otherCard2];
                                if (matchScore) {
                                    self.wasMatch = YES;
                                    self.deltaScore += matchScore * MATCH_BONUS;
                                    otherCard1.matched = YES;
                                    otherCard2.matched = YES;
                                    card.matched = YES;
                                } else {
                                    self.wasMatch = NO;
                                    self.deltaScore -= MISMATCH_PENALTY;
                                    otherCard1.chosen = NO;
                                    otherCard2.chosen = NO;
                                    card.chosen = NO;
                                }
                            }
                        }
                    }
                }
            } else {
                printf("numberOfCardsToMatch is invalid (not 2 or 3)");
            }
            if (self.deltaScore != 0) {
                self.deltaScore -= COST_TO_CHOOSE;
                NSString *eventDisplayText = [self generateEventDisplayText];
                [self.matchCache addObject:eventDisplayText];
            } else {
                self.deltaScore -= COST_TO_CHOOSE;
            }
            
            self.score += self.deltaScore;
            card.chosen = YES;
        }
    }
}

@end
