//
//  SetGame.m
//  Matchismo_iOS7
//
//  Created by David Leserman on 7/9/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import "SetGame.h"
#import "SetCard.h"
#import "FlipResultsData.h"

@interface SetGame()
@property (nonatomic, readwrite) int scoreOnLastSelection;
@property (nonatomic, strong, readwrite) NSMutableArray *currentlySelectedCards;
@property (nonatomic, strong, readwrite) NSMutableArray *selectedCardsCache;
@property (nonatomic, readwrite) int totalScore;
@property (nonatomic, readwrite) NSString *flipResults;
@property (nonatomic, readwrite) int flipCount;
@property (nonatomic, strong, readwrite) FlipResultsData *flipResultsData;
@end

@implementation SetGame

// Returns YES if all three inputs have the same value or they all have different values. Else returns NO.
- (BOOL)isMatchOnProperty1:(int) prop1 property2:(int) prop2 property3:(int) prop3
{
    BOOL match;
    if (prop1 == prop2 && prop2 == prop3) match = YES;
    //    else if (prop1 != prop2 && prop2 != prop3 && prop1 != prop3) match = YES;
    else match = NO;
    return match;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super initWithCardCount:count usingDeck:deck];
    
    if (self)
    {
        self.currentlySelectedCards = [[NSMutableArray alloc] init];
        
        self.flipResultsData = [[FlipResultsData alloc] init];
    }
    
    return self;
}

- (BOOL)isMatch
{
    SetCard *card1 = self.flipResultsData.card1 = self.currentlySelectedCards[0];
    SetCard *card2 = self.flipResultsData.card2 = self.currentlySelectedCards[1];
    SetCard *card3 = self.flipResultsData.card3 = self.currentlySelectedCards[2];
    
    BOOL numberMatch = [self isMatchOnProperty1: card1.count property2: card2.count property3: card3.count];
    BOOL shapeMatch = [self isMatchOnProperty1: card1.shape property2: card2.shape property3: card3.shape];
    BOOL colorMatch = [self isMatchOnProperty1: card1.color property2: card2.color property3: card3.color];
    BOOL fillMatch = [self isMatchOnProperty1: card1.fill property2: card2.fill property3: card3.fill];
    self.flipResultsData.isMatch = (numberMatch | shapeMatch | colorMatch | fillMatch);
    
    return self.flipResultsData.isMatch;
}

static const int SELECT_COST = 1;
static const int MATCH_SCORE = 5;
// static const int MATCH_BONUS_MULTIPLIER = 4; // N/A right now
static const int MISMATCH_PENALTY = 2;

- (void)selectCardAtIndex:(NSUInteger)index
{
    SetCard *currentCard = (SetCard *)[self cardAtIndex:index];
//    [currentCard logCard];
    
    BOOL cardIsValid = [currentCard isPlayable] && ![self.currentlySelectedCards containsObject:currentCard];
    
    if (cardIsValid) {
        [self.currentlySelectedCards addObject:currentCard];
        
        self.flipCount++;
        
        self.totalScore -= SELECT_COST;
        
        if ([self.currentlySelectedCards count] == 3) {
            // compute score
            if ([self isMatch]) {
                self.scoreOnLastSelection = MATCH_SCORE;
                for (SetCard *selectedCard in self.currentlySelectedCards) {
                    selectedCard.playable = NO;
                }
                // add this match attempt success to the matchCache
            } else { // There is no match. In this case, the last card to be selected remains selected and the other cards are set deselected in the UI and removed from currentlySelectedCards.

                self.scoreOnLastSelection = -MISMATCH_PENALTY;
                
                
            }
            self.selectedCardsCache = (NSMutableArray *) [NSArray arrayWithArray:self.currentlySelectedCards];
            [self.currentlySelectedCards removeAllObjects];

            self.flipResultsData.score = self.scoreOnLastSelection;
            
            // add this match attempt to the matchCache
            [self.matchCache addObject:(self.flipResultsData)];
            
        } // else do nothing
        
        self.totalScore += self.scoreOnLastSelection;
        
        
    } 	// else do nothing
}

@end
