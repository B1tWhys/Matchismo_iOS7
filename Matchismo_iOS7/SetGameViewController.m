//
//  SetGameViewController.m
//  Matchismo_iOS7
//
//  Created by Sky Arnold on 7/9/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "FlipResultsData.h"
#import "ScoreHistoryViewController.h"
#import <CoreImage/CIColor.h>
#import <CoreImage/CIImage.h>

@interface SetGameViewController ()
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UILabel *setGameFlipResults;
//@property (strong, nonatomic) NSMutableArray *historyCache;
@end

@implementation SetGameViewController

- (void)viewWillAppear:(BOOL)animated
{
    int i = 1;
}

- (SetGame *) game
{
    if (!super.game) {
        SetCardDeck *scDeck = [[SetCardDeck alloc] init];
        super.game = [[SetGame alloc] initWithCardCount:self.cardButtons.count usingDeck:scDeck];
    }
    return (SetGame *) super.game;
}

- (IBAction)setCard:(UIButton *)sender //called when the user selects a card
{
    [(SetGame *) self.game selectCardAtIndex: [self.cardButtons indexOfObject:sender]];
    [self updateUI];
}

- (void)viewDidLoad
{
    [self updateUI];
    
//    self.historyCache = [[NSMutableArray alloc] init];
	// Do any additional setup after loading the view.
}

- (NSString *)getDisplayCharacter:(int)shapeCode
{
    NSString *returnShape;
    switch (shapeCode) {
        case 1: returnShape = @"■"; break; // \u2583 \u2588 \uFFED, has funky fill: ◼
        case 2: returnShape = @"\u25CF"; break; // \u25EF, ●
        case 3: returnShape = @"\u25B2"; break; // ▲
        default: returnShape = @"!"; break;
    }
    
    return returnShape;
}

- (UIColor *)getDisplayColor:(int)colorCode
{
    UIColor *color;
    switch (colorCode) {
        case 1: color = [UIColor redColor]; break;
        case 2: color = [UIColor greenColor]; break;
        case 3: color = [UIColor blueColor]; break;
        default: color = [UIColor magentaColor]; break;
    }
    return color;
}

- (UIColor *)getDisplayColorWithAlpha:(UIColor *)originalColor fillCode:(int)fillCode
{
    float alpha;
    switch (fillCode) {
        case 1: alpha = 0.0; break;
        case 2: alpha = 0.4; break;
        case 3: alpha = 1.0; break;
        default: alpha = -1.0; break;
    }
    UIColor *returnColor = [originalColor colorWithAlphaComponent:alpha];
    return returnColor;
}

- (NSString *) getDisplayString:(NSString *) shapeChar shapeCount:(int) numberOfShapes
{
    NSString *outputString = @"";
    for (int i = 1; i <= numberOfShapes; i++) {
        outputString = [NSString stringWithFormat:@"%@%@", outputString, shapeChar];
    }
    return outputString;
}

- (float)getFontSize:(int)shapeCode
{
    float fontSize;
    switch (shapeCode) {
        case 1: fontSize = 18; break; // ◼
        case 2: fontSize = 30; break; // ●
        case 3: fontSize = 18; break; // ▲
        default: fontSize = 30; break;
    }
    
    return fontSize - 3; // minus 3 because they were all too big, causing small circles after the shapes.
}

- (NSNumber *)getBaselineOffset:(int)shapeCode
{
    float baselineOffset;
    switch (shapeCode) {
        case 1: baselineOffset = 0; break; // ◼
        case 2: baselineOffset = 1; break; // ●
        case 3: baselineOffset = -1; break; // ▲
        default: baselineOffset = 20; break;
    }
    return [NSNumber numberWithFloat: baselineOffset];
}

- (NSAttributedString *)getAttributedStringFromCard:(SetCard *) card ignorePlayablility:(BOOL) ignorePlayablility
{
    NSString *shapeCharacter = [self getDisplayCharacter:card.shape];
    NSString *displayString = [self getDisplayString:shapeCharacter shapeCount:card.count];
    UIColor *color = [self getDisplayColor:card.color];
    UIColor *colorWithAlpha = [self getDisplayColorWithAlpha:color fillCode:card.fill];
    float fontSize = [self getFontSize:card.shape];
    UIFont *fontWithSize = [UIFont fontWithName:@"Helvetica" size: fontSize];
    NSNumber *strokeWidth = [NSNumber numberWithFloat: -3.0];
    NSNumber *baselineOffset = [self getBaselineOffset:card.shape];
    
    if (!(card.isPlayable || ignorePlayablility)) {
        displayString = @"";
    }
    
    NSAttributedString *cardText = [[NSAttributedString alloc] initWithString:displayString
                                                                   attributes:@{NSFontAttributeName: fontWithSize,
                                                                                NSStrokeWidthAttributeName: strokeWidth,
                                                                                NSStrokeColorAttributeName: color,
                                                                                NSForegroundColorAttributeName: colorWithAlpha,
                                                                                NSBaselineOffsetAttributeName: baselineOffset}];
    
    return cardText;
}

- (NSAttributedString *)convertStringToNSAttributedString:(NSString *)inputString
{
    NSAttributedString *returnAttributedString = [[NSAttributedString alloc] initWithString:inputString attributes: @{}];
    return returnAttributedString;
}

- (NSAttributedString *)getEnglishListOfThreeCards:(FlipResultsData *)flipResult
{
    NSArray *selectedCards = @[flipResult.card1, flipResult.card2, flipResult.card3];
    NSMutableAttributedString *threeCardsText = [[NSMutableAttributedString alloc] init];
    
    [threeCardsText appendAttributedString:[self getAttributedStringFromCard:selectedCards[0] ignorePlayablility:true]];
    [threeCardsText appendAttributedString:[self convertStringToNSAttributedString:@", "]];
    [threeCardsText appendAttributedString:[self getAttributedStringFromCard:selectedCards[1] ignorePlayablility:true]];
    [threeCardsText appendAttributedString:[self convertStringToNSAttributedString:@" and "]];
    [threeCardsText appendAttributedString:[self getAttributedStringFromCard:selectedCards[2] ignorePlayablility:true]];
    [threeCardsText appendAttributedString:[self convertStringToNSAttributedString:@" "]];
    return threeCardsText;

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ScoreHistoryViewController *destinationViewController = segue.destinationViewController;
    
    // For each element in self.game.matchCache add a NSAttributedString object to the labelHistoryArray
    // using renderFlipResults to perform the mapping
    
    int i = 0;
    
    for (FlipResultsData *flipResult in self.game.matchCache) {
        [destinationViewController.labelHistoryArray addObject:[self renderFlipResults:flipResult]];
        i++;
    }
}

- (void)updateUI
{
    // count - 0 = undefined, 1-3 are valid values
    // shape - 0 = undefined, 1 = square, 2 = circle, 3 = triangle
    // fill - 0 = undefined, 1 = none, 2 = shaded, 3 = solid
    // color - 0 = undefined, 1 = red, 2 = green, 3 = blue

    SetGame *setGame = (SetGame *)self.game;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", setGame.totalScore];
    
    // Compute and set the UI state for each cardButton.
    for (UIButton *cardButton in self.cardButtons) {
        SetCard *card = (SetCard *) [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];

        NSAttributedString *cardText = [self getAttributedStringFromCard:card ignorePlayablility:false];
        
//        NSLog(@"cardText:%@", [cardText string]);
        
        [cardButton setAttributedTitle:cardText forState:UIControlStateNormal];
//        [cardButton setAttributedTitle:cardText forState:UIControlStateSelected];
        
        // If the card associated with this cardButton is in the list of currentlySelectedCards,
        // then we'll set the background of the cardButton to illustrate this.
        cardButton.selected = [((SetGame *) self.game).currentlySelectedCards containsObject:card];
//        NSLog(@"buttonTitle:%@", [cardButton.titleLabel.attributedText string]);
    }
    
//    NSAttributedString *flipResultsText = [self renderFlipResultsFromSetGame:setGame];
    NSAttributedString *flipResultsText = [self renderFlipResults:[self.game.matchCache lastObject]];
    [self.setGameFlipResults setAttributedText:flipResultsText];
}


- (NSAttributedString *)renderFlipResults:(FlipResultsData *)flipResult
{
    NSMutableAttributedString *flipResultsText = [[NSMutableAttributedString alloc] init];
    
    if (flipResult.score == 0) {
        [flipResultsText appendAttributedString:[self convertStringToNSAttributedString:@"Flip a card."]];
    } else if (flipResult.score > 0) {
        [flipResultsText appendAttributedString:[self convertStringToNSAttributedString:@"Matched "]];
        [flipResultsText appendAttributedString:[self getEnglishListOfThreeCards:flipResult]];
        [flipResultsText appendAttributedString:[self convertStringToNSAttributedString:@" for "]];
        [flipResultsText appendAttributedString:[self convertStringToNSAttributedString:[NSString stringWithFormat:@"%i points!", flipResult.score]]];
    } else {
        [flipResultsText appendAttributedString:[self getEnglishListOfThreeCards:flipResult]];
        [flipResultsText appendAttributedString:[self convertStringToNSAttributedString:@"do not match."]];
        [flipResultsText appendAttributedString:[self convertStringToNSAttributedString:[NSString stringWithFormat:@" %i point penalty!", -flipResult.score]]];
    }
    
    // Set font, notice the range is for the whole string
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:11];
    [flipResultsText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [flipResultsText length])];
    
    return flipResultsText;
}

@end
