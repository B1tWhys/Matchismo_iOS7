//
//  Deck.h
//  Matchismo_iOS7
//
//  Created by David Leserman on 5/11/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
- (void)addCard: (Card *)card atTop:(BOOL)atTop;
- (void)addCard: (Card *)card;

- (Card *)drawRandomCard;
@end
