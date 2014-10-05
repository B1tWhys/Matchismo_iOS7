//
//  ScoreHistoryViewController.m
//  Matchismo_iOS7
//
//  Created by Skyler Arnold on 7/2/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import "ScoreHistoryViewController.h"
#import "SetGameViewController.h"

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

    if ([self.labelHistoryArray[0] class] == [NSMutableString class]) {
        [self updateHistoryDisplayToNSString];
    } else {
        [self updateHistoryDisplayToNSAttributedString];
    }
}

- (void)updateHistoryDisplayToNSString // NEVER CALLED?
{
    NSMutableString *textToDisplay = [[NSMutableString alloc] init];
    NSString *carriageReturn = [NSString stringWithFormat:@"\n"];
    for (int i = self.labelHistoryArray.count; i > 0; i--) {
        [textToDisplay appendString:self.labelHistoryArray[i-1]];
        [textToDisplay appendString:carriageReturn];
    }

    NSLog(@"3. %@", self.labelHistoryArray[0]);

    self.historyDisplay.text = (NSString *)textToDisplay;
}

- (void)updateHistoryDisplayToNSAttributedString
{
    NSMutableAttributedString *textToDisplay = [[NSMutableAttributedString alloc] init];
    NSAttributedString *carriageReturn = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"\n"] attributes:@{}];
    NSMutableAttributedString *historyLabelElement;
    for (int i = self.labelHistoryArray.count; i > 0; i--) {
        NSLog(@"|%@|", NSStringFromClass([self.labelHistoryArray[i-1] class]));
//        if ([[self.labelHistoryArray[i-1] class] isKindOfClass:[NSMutableAttributedString class]]) {
//            historyLabelElement = self.labelHistoryArray[i-1];
//        } else {
//            historyLabelElement = [[NSMutableAttributedString alloc] initWithString:self.labelHistoryArray[i-1] attributes:@{}];
//        }

        NSString *constString = @"abc";
        id stringClass = [constString class];
        
        NSLog(@"[self.labelHistoryArray[0] class]: %@", [self.labelHistoryArray[0] class]);
        NSLog(@"[NSMutableAttributedString class]: %@", [NSString class]);
        NSLog(@"stringClass: %@", stringClass);
        
// Note:
//    Matchismo - crashed on branch 2
//    2014-10-05 16:47:31.647 Matchismo_iOS7[10971:60b] [self.labelHistoryArray[0] class]: __NSCFString
//    2014-10-05 16:47:31.647 Matchismo_iOS7[10971:60b] [NSMutableAttributedString class]: NSMutableAttributedString
//    
//    Set - success on branch 2
//    2014-10-05 16:45:32.899 Matchismo_iOS7[10971:60b] [self.labelHistoryArray[0] class]: NSConcreteMutableAttributedString
//    2014-10-05 16:45:32.899 Matchismo_iOS7[10971:60b] [NSMutableAttributedString class]: NSMutableAttributedString
        

        
//        if ([[self.labelHistoryArray[0] class] isKindOfClass:stringClass]) { // works for Set Game
        if ([stringClass isKindOfClass:[self.labelHistoryArray[0] class]]) { // works for Set Game
            historyLabelElement = [[NSMutableAttributedString alloc] initWithString:self.labelHistoryArray[i-1] attributes:@{}];
            NSLog(@"1. %@", historyLabelElement);
        } else { // for Matchismo game
            historyLabelElement = (NSMutableAttributedString *)self.labelHistoryArray[i-1]; // works for Matchismo
            NSLog(@"2. %@", historyLabelElement);
        }

        
//        id testVar = [self nextResponder];
//        
//        if (self.nextResponder == [SetGameViewController class]) { // works for Set Game
//            historyLabelElement = [[NSMutableAttributedString alloc] initWithString:self.labelHistoryArray[i-1] attributes:@{}];
//            NSLog(@"1. %@", historyLabelElement);
//        } else { // for Matchismo game
//            historyLabelElement = (NSMutableAttributedString *)self.labelHistoryArray[i-1]; // works for Matchismo
//            NSLog(@"2. %@", historyLabelElement);
//        }
        
        [textToDisplay appendAttributedString: historyLabelElement];
        [textToDisplay appendAttributedString:carriageReturn];
    }
    self.historyDisplay.attributedText = (NSAttributedString *)textToDisplay;
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
