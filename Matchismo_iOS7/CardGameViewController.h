//
//  CardGameViewController.h
//  Matchismo_iOS7
//
//  Created by Skyler Arnold on 4/30/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventDisplayLabel;
@property (strong, nonatomic) CardMatchingGame *game;

- (void)updateUI;
- (void)resetCurrentMatch;
- (IBAction)deal:(id)sender;
@end
