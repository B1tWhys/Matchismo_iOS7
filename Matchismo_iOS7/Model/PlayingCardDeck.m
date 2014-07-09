//
//  PlayingCardDeck.m
//  Matchismo_iOS7
//
//  Created by David Leserman on 5/11/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"
// this class could also be named MatchismoCardDeck should this name prove to be too confusing.

@implementation PlayingCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= (int) [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    return self;
}

@end
