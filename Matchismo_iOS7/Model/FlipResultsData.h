//
//  FlipResultsData.h
//  Matchismo_iOS7
//
//  Created by David Leserman on 8/24/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SetCard.h"

@interface FlipResultsData : NSObject
@property (nonatomic, strong) SetCard *card1;
@property (nonatomic, strong) SetCard *card2;
@property (nonatomic, strong) SetCard *card3;
@property (nonatomic) int score;
@property BOOL isMatch;
@end
