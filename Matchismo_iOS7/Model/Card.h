//
//  Card.h
//  Matchismo_iOS7
//
//  Created by David Leserman on 5/4/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;

@end
