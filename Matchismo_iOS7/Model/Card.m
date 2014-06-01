//
//  Card.m
//  Matchismo_iOS7
//
//  Created by David Leserman on 5/4/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards numberOfCardsToMatch:(int)numberOfCardsToMatch
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

@end
