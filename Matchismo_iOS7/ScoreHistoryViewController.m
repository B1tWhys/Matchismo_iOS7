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

- (NSMutableArray *)labelHistoryArray
{
    if (!_labelHistoryArray) {
        _labelHistoryArray = [[NSMutableArray alloc] init];
    }

    return _labelHistoryArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.historyDisplay.editable = NO;
    NSMutableString *textToDisplay = [[NSMutableString alloc] init];
    NSString *carriageReturn = [NSString stringWithFormat:@"\n"];
    for (int i = self.labelHistoryArray.count; i > 0; i--) {
        [textToDisplay appendString:self.labelHistoryArray[i-1]];
        [textToDisplay appendString:carriageReturn];
    }

    self.historyDisplay.text = (NSString *)textToDisplay;
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
