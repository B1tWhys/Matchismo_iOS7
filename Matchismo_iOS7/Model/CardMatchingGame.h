//
//  CardMatchingGame.h
//  Matchismo_iOS7
//
//  Created by David Leserman on 5/25/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject
// designated initilizer
- (instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic) int numberOfCardsToMatch;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSArray *currentMatch;
@property (nonatomic, readonly) BOOL wasMatch;
@property (nonatomic, readonly) int deltaScore;
@end
