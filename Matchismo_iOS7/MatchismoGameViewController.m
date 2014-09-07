//
//  MatchismoGameViewController.m
//  Matchismo_iOS7
//
//  Created by Sky Arnold on 7/9/14.
//  Copyright (c) 2014 Skyler and David inc. All rights reserved.
//

#import "MatchismoGameViewController.h"
#import "PlayingCard.h"
#import "MatchismoGame.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"

@interface MatchismoGameViewController ()
@property (strong, nonatomic) IBOutlet UISegmentedControl *match2Or3Selector;
@property (nonatomic) BOOL matchingNumberCanBeChanged;
@end

@implementation MatchismoGameViewController

@synthesize game = _game;

- (instancetype) init
{
    self = [super init];
    return self;
}



- (MatchismoGame *)game
{
    if (!_game) {
        _game = [[MatchismoGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        _game.numberOfCardsToMatch = 2;
    }
    
    return (MatchismoGame *)_game;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // int i = 0;
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

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
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
@end
