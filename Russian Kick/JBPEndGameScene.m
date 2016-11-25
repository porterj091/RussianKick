//
//  EndGameScene.m
//  Russian Kick
//
//  Created by Joseph Porter on 7/15/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import "JBPEndGameScene.h"
#import "JBPSpriteTexturesCache.h"
#import "JBPGameScene.h"
#import "JBPGameData.h"
#import "JBPTextureScores.h"
#import "JBPTitleScene.h"

@interface JBPEndGameScene()


@end

@implementation JBPEndGameScene

#pragma mark - Scene Creation and Initilizion
- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor blueColor];
        [self createSceneContents];
        
    }
    
    return self;
}

- (void)createSceneContents
{
    //=========== BackGround =========
    SKTexture *backGroundTexture = [SKTexture textureWithImageNamed:EndBackGroundFileName];
    SKSpriteNode *backGroundNode = [SKSpriteNode spriteNodeWithTexture:backGroundTexture];
    backGroundNode.size = self.size;
    backGroundNode.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    backGroundNode.zPosition = -1;
    [self addChild:backGroundNode];
    //=========== iAd ================
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideAd" object:nil];
    
    //============= Play Button =================
    SKSpriteNode *startButton = [SKSpriteNode spriteNodeWithImageNamed:StartButtonUnpressedFileName];
    startButton.name = @"startButtonNode";
    startButton.size = CGSizeMake(self.frame.size.width / 2 - 20, self.frame.size.height / 8);
    startButton.position = CGPointMake(self.frame.size.width / 4, CGRectGetMinY(self.frame) + startButton.frame.size.height / 2 + 25);
    [self addChild:startButton];
    
    //============== Leader Button ==============
    SKSpriteNode *leaderButton = [SKSpriteNode spriteNodeWithImageNamed:LeaderBoardUnpressedFileName];
    leaderButton.name = @"leaderButtonNode";
    leaderButton.size = CGSizeMake(self.frame.size.width / 2 - 20, self.frame.size.height / 8);
    leaderButton.position = CGPointMake(self.frame.size.width / 4 + self.frame.size.width / 2, CGRectGetMinY(self.frame) + startButton.frame.size.height / 2 + 25);
    [self addChild:leaderButton];
    
    //============== Back Button ================
    SKSpriteNode *backButton = [SKSpriteNode spriteNodeWithImageNamed:BackButton_UnpressedFileName];
    backButton.name = @"backButtonNode";
    backButton.size = CGSizeMake(self.frame.size.height / 10, self.frame.size.height / 10);
    backButton.position = CGPointMake(CGRectGetMinX(self.frame) + backButton.frame.size.width / 2 + 5, CGRectGetMaxY(self.frame) - backButton.frame.size.height / 2 - 5);
    [self addChild:backButton];
    
    //=========== Title ================
    SKTexture *titleTexture = [SKTexture textureWithImageNamed:EndTitleFileName];
    SKSpriteNode *titleNode = [SKSpriteNode spriteNodeWithTexture:titleTexture];
    titleNode.name = @"titleNode";
    titleNode.size = CGSizeMake(self.frame.size.width / 2, self.frame.size.height / 4);
    titleNode.position = CGPointMake(self.frame.size.width / 2, CGRectGetMaxY(self.frame) - titleNode.frame.size.height / 2 - 20);
    [self addChild:titleNode];
    
    //=========== Scores ==============
    
    JBPTextureScores *highScores = [[JBPTextureScores alloc] init];
    [highScores initNewNumberTextures:self startingPoint:CGPointMake(self.frame.size.width / 2 + 50, self.frame.size.height / 2 - 25) startingSize:CGSizeMake(25, 30) startingScore:[JBPGameData data].highScore name:@"digit" fileName:@"Number"];
    
    JBPTextureScores *currentScore = [[JBPTextureScores alloc] init];
    [currentScore initNewNumberTextures:self startingPoint:CGPointMake(self.frame.size.width / 2 + 50, self.frame.size.height / 2 + 25) startingSize:CGSizeMake(25, 30) startingScore:[JBPGameData data].playerScore name:@"digit1" fileName:@"Number"];
    
    // Best label
    SKSpriteNode *bestLabel = [SKSpriteNode spriteNodeWithImageNamed:BestLabelFileName];
    bestLabel.size = CGSizeMake(50, 25);
    bestLabel.position = CGPointMake(self.frame.size.width / 2 - 50, self.frame.size.height / 2 - 25);
    [self addChild:bestLabel];
    
    // Score Label
    SKSpriteNode *scoreLabel = [SKSpriteNode spriteNodeWithImageNamed:ScoreLabelFileName];
    scoreLabel.size = CGSizeMake(50, 25);
    scoreLabel.position = CGPointMake(self.frame.size.width / 2 - 50, self.frame.size.height / 2 + 25);
    [self addChild:scoreLabel];
    
    // Seperating Bar
    SKSpriteNode *seperationBar = [SKSpriteNode spriteNodeWithColor:[UIColor whiteColor] size:CGSizeMake(self.frame.size.width / 2, 5)];
    seperationBar.position = CGPointMake(self.frame.size.width / 2 , self.frame.size.height / 2);
    [self addChild:seperationBar];
    
    //========== Sharing ==============
    SKSpriteNode *facebookButton = [SKSpriteNode spriteNodeWithImageNamed:FacebookButtonFileName];
    facebookButton.size = CGSizeMake(self.frame.size.height / 15, self.frame.size.height / 15);
    facebookButton.position = CGPointMake(self.frame.size.width / 2 - 50, CGRectGetMaxY(startButton.frame) + facebookButton.frame.size.height / 2 + 30);
    facebookButton.name = @"facebookNode";
    [self addChild:facebookButton];
    
    SKSpriteNode *twitterButton = [SKSpriteNode spriteNodeWithImageNamed:TwitterButtonFileName];
    twitterButton.size = CGSizeMake(self.frame.size.height / 15, self.frame.size.height / 15);
    twitterButton.position = CGPointMake(self.frame.size.width / 2 + 50, CGRectGetMaxY(startButton.frame) + twitterButton.frame.size.height / 2 + 30);
    twitterButton.name = @"twitterNode";
    [self addChild:twitterButton];
    
}

#pragma mark - Touch Functions
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKSpriteNode *startButton = (SKSpriteNode *)[self childNodeWithName:@"startButtonNode"];
        SKSpriteNode *leaderButton = (SKSpriteNode *)[self childNodeWithName:@"leaderButtonNode"];
        SKSpriteNode *backButton = (SKSpriteNode *)[self childNodeWithName:@"backButtonNode"];
        SKNode *twitterButton = [self childNodeWithName:@"twitterNode"];
        SKNode *facebookButton = [self childNodeWithName:@"facebookNode"];
        
        // Start Button
        if (CGRectContainsPoint(startButton.frame, location))
        {
            SKTexture *f1 = [SKTexture textureWithImageNamed:StartButtonPressedFileName];
            [startButton setTexture:f1];
        }
        
        // Leader Button
        if (CGRectContainsPoint(leaderButton.frame, location))
        {
            SKTexture *f1 = [SKTexture textureWithImageNamed:LeaderBoardsPressedFileName];
            [leaderButton setTexture:f1];
        }
        
        // Back Button
        if (CGRectContainsPoint(backButton.frame, location))
        {
            SKTexture *f1 = [SKTexture textureWithImageNamed:BackButton_PressedFileName];
            [backButton setTexture:f1];

        }
        
        // Facebook Button
        if (CGRectContainsPoint(facebookButton.frame, location))
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"facebook" object:nil];
        }

        
        // Twitter Button
        if (CGRectContainsPoint(twitterButton.frame, location))
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"twitter" object:nil];
        }
        
        
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        SKSpriteNode *startButton = (SKSpriteNode *)[self childNodeWithName:@"startButtonNode"];
        SKSpriteNode *leaderButton = (SKSpriteNode *)[self childNodeWithName:@"leaderButtonNode"];
        SKSpriteNode *backButton = (SKSpriteNode *)[self childNodeWithName:@"backButtonNode"];
        
        // Start Button
        if (CGRectContainsPoint(startButton.frame, location))
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonNoise" object:nil];
            JBPGameScene *gameScene = [[JBPGameScene alloc] initWithSize:self.size];
            [self.view presentScene:gameScene];
            [self removeAllActions];
            [self removeAllChildren];

        }
        else
        {
            SKTexture *f1 = [SKTexture textureWithImageNamed:StartButtonUnpressedFileName];
            [startButton setTexture:f1];
        }
        
        // Leader Button
        if (CGRectContainsPoint(leaderButton.frame, location))
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonNoise" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showLeaderboard" object:nil];
            SKTexture *f1 = [SKTexture textureWithImageNamed:LeaderBoardUnpressedFileName];
            [leaderButton setTexture:f1];
        }
        else
        {
            SKTexture *f1 = [SKTexture textureWithImageNamed:LeaderBoardUnpressedFileName];
            [leaderButton setTexture:f1];
        }
        
        // Back Button
        if (CGRectContainsPoint(backButton.frame, location))
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"backNoise" object:nil];
            JBPTitleScene *titleScene = [[JBPTitleScene alloc] initWithSize:self.size];
            SKTransition *slideUp = [SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:0.5];
            [self.view presentScene:titleScene transition:slideUp];
            [self removeAllActions];
            [self removeAllChildren];
        }
        else
        {
            SKTexture *f1 = [SKTexture textureWithImageNamed:BackButton_UnpressedFileName];
            [backButton setTexture:f1];
        }
    }
}





@end
