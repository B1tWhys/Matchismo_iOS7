//
//  SetGame.h
//  Matchismo_iOS7
//
//  Created by David Leserman on 7/9/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import "CardMatchingGame.h"
#import "SetCard.h"

@interface FlipResultsData : NSObject
@property (nonatomic, strong)SetCard *card1;
@property (nonatomic, strong) SetCard *card2;
@property (nonatomic, strong) SetCard *card3;
@property BOOL isMatch;
@end

@interface SetGame : CardMatchingGame
- (void)selectCardAtIndex:(NSUInteger)index;
@property (nonatomic, strong, readonly) NSMutableArray *currentlySelectedCards;
@property (nonatomic, strong, readonly) NSMutableArray *selectedCardsCache;
@property (nonatomic, readonly) int scoreOnLastSelection;
@property (nonatomic, readonly) int flipCount;
@property (nonatomic, readonly) int totalScore;
@end
