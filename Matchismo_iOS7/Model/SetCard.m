//
//  SetCard.m
//  Matchismo_iOS7
//
//  Created by David Leserman on 7/9/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()
@property (nonatomic)int count; // 0 = undefined, 1-3 are valid values
@property (nonatomic)int shape; // 0 = undefined, 1 = square, 2 = circle, 3 = triangle
@property (nonatomic)int fill; // 0 = undefined, 1 = none, 2 = shaded, 3 = solid
@property (nonatomic)int color; // 0 = undefined, 1 = red, 2 = green, 3 = blue
@end

@implementation SetCard

static int logCardCount;

- (SetCard *)deepCopy
{
    SetCard *setCardCopy = (SetCard *)[[SetCard alloc] init];
    
    setCardCopy.contents = self.contents;
    setCardCopy.chosen = self.chosen;
    setCardCopy.matched = self.matched;
    setCardCopy.count = self.count;
    setCardCopy.shape = self.shape;
    setCardCopy.fill = self.fill;
    setCardCopy.color = self.color;
    
    return setCardCopy;
}

- (void)setPlayable:(BOOL)playable
{
    _playable = playable;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.count = 0;
        self.shape = 0;
        self.fill = 0;
        self.color = 0;
        self.playable = YES;
    }
    return self;
}

- (id)initWithCount:(int)count shape:(int)shape fill:(int)fill color:(int)color
{
    if (self = [super init]) {
        self.count = count;
        self.shape = shape;
        self.fill = fill;
        self.color = color;
        self.playable = YES;
    }
    
    return self;
}

- (void)logCard
{
    logCardCount += 1;
    NSString *shapeString = @[@"X", @"square", @"circle", @"triangle"][self.shape];
    NSString *colorString = @[@"X", @"red", @"green", @"blue"][self.color];
    NSString *fillString = @[@"X", @"none", @"shaded", @"solid"][self.fill];
    NSLog(@"%i  %i  %@  %@  %@  //Logged from SetCard", logCardCount, self.count, colorString, shapeString, fillString);
}

@end
