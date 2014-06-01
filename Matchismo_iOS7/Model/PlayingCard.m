//
//  PlayingCard.m
//  Matchismo_iOS7
//
//  Created by David Leserman on 5/4/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
@synthesize suit = _suit;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
    } else if ([otherCards count] == 2) {
        PlayingCard *otherCard = otherCards[0];
        PlayingCard *otherCard2 = otherCards[1];
        if ((otherCard.rank == self.rank) && (otherCard2.rank == self.rank)) {
            score = 6;
        } else if ([otherCard.suit isEqualToString:self.suit] && [otherCard2.suit isEqualToString:self.suit]) {
            score = 3;
        } else {
            score = [self match:@[otherCard]];
            score += [self match:@[otherCard2]];
            score += [otherCard match:@[otherCard2]];
        }
    }
    
    return score;
}

//- (int)match:(NSArray *)otherCards numberOfCardsToMatch:(int)numberOfCardsToMatch
//{
//    int score = 0;
//    
//    if (numberOfCardsToMatch == 2) {
//        int matchCode = [self match2Cards:@[[otherCards firstObject], self]];
//        
//        if (matchCode == 3) { // matched rank
//            score = 4;
//        } else if (matchCode == 1) { // matched suit
//            score = 2;
//        } else { // no match
//            score = 0;
//        }
//    } else if (numberOfCardsToMatch == 3 && ([otherCards count] == 2)) {
//        int matchResult = 0;
//        matchResult = [self match2Cards:@[otherCards[0], self]];
//        matchResult += [self match2Cards:otherCards];
//        
//        if (matchResult == 6) { // both sets matched ranks
//            score = 10;
//        } else if (matchResult == 3) { // matched 1 set of ranks
//            score = 3;
//        } else if (matchResult == 2) { // both sets matched suits
//            score = 6;
//        } else if (matchResult == 1) { // mathed 1 set of suits
//            score = 1;
//        } else { // no match
//            score = 0;
//        }
//    }
//    
//    return score;
//}
//
//- (int)match2Cards:(NSArray *)cardsToMatch
//{
//    PlayingCard *card1 = [cardsToMatch firstObject];
//    PlayingCard *card2 = [cardsToMatch lastObject];
//    
//    int resultCode = 0;
//    
//    if (card1.rank == card2.rank) {
//        resultCode = 3; // rank match
//    } else if ([card1.suit isEqualToString:card2.suit]) {
//        resultCode = 1; // suit match
//    } else {
//        resultCode = 0; // no match
//    }
//    
//    return resultCode;
//}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+ (NSArray *)validSuits
{
    return @[@"♠", @"♣", @"♥", @"♦"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6",
             @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger *)maxRank
{
    return (NSUInteger *) ([self.rankStrings count] - 1);
}

@end
