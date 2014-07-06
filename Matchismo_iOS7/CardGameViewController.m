//
//  CardGameViewController.m
//  Matchismo_iOS7
//
//  Created by Skyler Arnold on 4/30/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutlet UISegmentedControl *match2Or3Selector;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) BOOL matchingNumberCanBeChanged;
@property (strong, nonatomic) IBOutlet UILabel *eventDisplayLabel;

@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
       _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        _game.numberOfCardsToMatch = 2;
    }
    
    return _game;
}

- (void)setMatchingNumberCanBeChanged:(BOOL)matchingNumberCanBeChanged
{
    _matchingNumberCanBeChanged = matchingNumberCanBeChanged;
    
    self.match2Or3Selector.enabled = matchingNumberCanBeChanged;
}

- (IBAction)deal
{
    self.matchingNumberCanBeChanged = YES;
    self.game = nil;
    [self updateUI];
}

- (IBAction)changeGameMode:(UISegmentedControl *)sender
{   if (self.matchingNumberCanBeChanged) {
        [self deal];
        self.game.numberOfCardsToMatch = sender.selectedSegmentIndex + 2;
    }
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    self.matchingNumberCanBeChanged = NO;
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    if (self.match2Or3Selector.selectedSegmentIndex == 0) {
        self.game.numberOfCardsToMatch = 2;
    } else {
        self.game.numberOfCardsToMatch = 3;
    }
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    if (self.game.currentMatch.count == (self.match2Or3Selector.selectedSegmentIndex + 2)) {
        self.eventDisplayLabel.text = [self.game generateEventDisplayText];
        [self resetCurrentMatch];
    } else {
        self.eventDisplayLabel.text = @"Pick another card.";
    }
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (void)resetCurrentMatch
{
    self.game.currentMatch = [[NSArray alloc] init];
}

//- (NSString *)generateEventDisplayText {
//    NSString *outputText;
//    if (self.match2Or3Selector.selectedSegmentIndex == 0) {
//        if (self.game.wasMatch) {
//            outputText = [NSString stringWithFormat:@"%@ and %@ match. (+%i points)", ((PlayingCard *)(self.game.currentMatch[0])).contents, ((PlayingCard *)(self.game.currentMatch[1])).contents, self.game.deltaScore];
//            [self resetCurrentMatch];
//        } else {
//            outputText = [NSString stringWithFormat:@"%@ and %@ don't match. (%i points)", ((PlayingCard *)(self.game.currentMatch[0])).contents, ((PlayingCard *)(self.game.currentMatch[1])).contents, self.game.deltaScore];
//            [self resetCurrentMatch];
//        }
//    } else {
//        if (self.game.wasMatch) {
//            outputText = [NSString stringWithFormat:@"%@, %@ and %@ constitute a match. (+%i points)", ((PlayingCard *)(self.game.currentMatch[0])).contents, ((PlayingCard *)(self.game.currentMatch[1])).contents, ((PlayingCard *)(self.game.currentMatch[2])).contents, self.game.deltaScore];
//            [self resetCurrentMatch];
//        } else {
//            outputText = [NSString stringWithFormat:@"%@, %@ and %@ constitute a don't match. (%i points)", ((PlayingCard *)(self.game.currentMatch[0])).contents, ((PlayingCard *)(self.game.currentMatch[1])).contents, ((PlayingCard *)(self.game.currentMatch[2])).contents, self.game.deltaScore];
//            [self resetCurrentMatch];
//        }
//    }
//    
//    return outputText;
//}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

@end
