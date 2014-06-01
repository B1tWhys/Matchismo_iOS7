//
//  CardMatchingGame.m
//  Matchismo_iOS7
//
//  Created by David Leserman on 5/25/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Cards
@end

@implementation CardMatchingGame
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
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
            if (self.numberOfCardsToMatch == 2) {
                // match against another chosen cards
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            otherCard.matched = YES;
                            card.matched = YES;
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                        }
                        break; // can only choose 2 cards for now
                    }
                }
            } else if (self.numberOfCardsToMatch == 3) {
                for (Card *otherCard1 in self.cards) {
                    if (otherCard1.isChosen && !otherCard1.isMatched) {
                        for (Card *otherCard2 in self.cards) {
                            if (otherCard2.isChosen && !otherCard1.isMatched && (otherCard2 != otherCard1)) {
                                int matchScore = [card match:@[otherCard1, otherCard2]];
                                if (matchScore) {
                                    self.score += matchScore * MATCH_BONUS;
                                    otherCard1.matched = YES;
                                    otherCard2.matched = YES;
                                    card.matched = YES;
                                } else {
                                    self.score -= MISMATCH_PENALTY;
                                    otherCard1.chosen = NO;
                                    otherCard2.chosen = NO;
                                    card.chosen = NO; // Adding this on 6/1/14 did not solve the problem.
                                }
                            }
                        }
                    }
                }
            } else {
                printf("numberOfCardsToMatch is invalid (not 2 or 3)");
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end
