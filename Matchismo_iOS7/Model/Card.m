//
//  Card.m
//  Matchismo_iOS7
//
//  Created by David Leserman on 5/4/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
    int score = 0;
    printf("ERROR: match called in Card");
    return score;
}

- (Card *) deepCopy
{
    Card *cardCopy = [[Card alloc] init];
    cardCopy.contents = self.contents;
    cardCopy.chosen = self.chosen;
    cardCopy.matched = self.matched;
    
    return cardCopy;
}

- (void)logCard{}

@end
