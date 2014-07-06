//
//  ScoreHistoryViewController.m
//  Matchismo_iOS7
//
//  Created by Skyler Arnold on 7/2/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import "ScoreHistoryViewController.h"

@interface ScoreHistoryViewController ()
@property (strong, nonatomic) IBOutlet UITextView *historyDisplay;

@end

@implementation ScoreHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.historyDisplay.editable = NO;
    NSMutableString *textToDisplay;
    for (NSString *label in self.labelHistoryArray) {
        [textToDisplay appendString:label];
    }

    self.historyDisplay.text = (NSString *)textToDisplay;
//    self.historyDisplay.text = @"test text";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
