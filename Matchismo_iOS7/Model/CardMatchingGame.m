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

- (NSString *)generateEventDisplayText
{
    printf("ERROR: generateEventDisplayText called in CardMatchingGame");
    return nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    printf("ERROR: chooseCardAtIndex called in CardMatchingGame");
}

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
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




@end
