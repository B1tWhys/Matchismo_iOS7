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

/* An idea ala David for caching match objects instead of a descriptive 00string.
struct matchData {
    bool wasMatch;
    int numberOfCardsToMatch;
    NSString *contents1;
    NSString *contents2;
};
*/

@interface CardMatchingGame : NSObject
// designated initilizer
- (instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (NSString *)generateEventDisplayText;

@property (nonatomic) int numberOfCardsToMatch;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSArray *currentMatch;
@property (nonatomic, readonly) BOOL wasMatch;
@property (nonatomic, readonly) int deltaScore;
@property (nonatomic, strong, readonly) NSMutableArray *matchCache;
@end
