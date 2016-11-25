//
//  GameScene.m
//  Russian Kick
//
//  Created by Joseph Porter on 7/1/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import "JBPTitleScene.h"
#import "JBPGameScene.h"
#import "JBPSpriteTexturesCache.h"
#import "JBPLabelScores.h"
#import "JBPGameData.h"
#import "JBPlayer.h"
#import "JBPCharacterScene.h"


@interface JBPTitleScene()
{
    SKSpriteNode *char_Head;
}

@property (nonatomic, strong) SKAction *buttonNoise;

@end

BOOL musicPressed;
BOOL noisePressed;
BOOL settingsPressed;

@implementation JBPTitleScene


-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    self.backgroundColor = [SKColor redColor];
    _buttonNoise = [SKAction playSoundFileNamed:@"ButtonNoise.mp3" waitForCompletion:NO];
    settingsPressed = NO;
    [self createAllSceneObjects];
}

#pragma mark - Handle Title Scene Creation

- (void)createAllSceneObjects
{
    //============== BackGround ================
    SKTexture *backGroundTexture = [SKTexture textureWithImageNamed:TitleSceneBackGroundFileName];
    SKSpriteNode *backGroundNode = [SKSpriteNode spriteNodeWithTexture:backGroundTexture];
    backGroundNode.size = self.size;
    backGroundNode.zPosition = -1;
    backGroundNode.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    [self addChild:backGroundNode];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideBannerAd" object:nil];
    //============== TitleLabel =================
    SKSpriteNode *titleSprite = [SKSpriteNode spriteNodeWithImageNamed:TitleNameFileName];
    titleSprite.size = CGSizeMake(self.frame.size.width / 1.5, self.frame.size.height / 5);
    titleSprite.position = CGPointMake(self.frame.size.width / 2, (self.frame.size.height * 4/5));
    [self addChild:titleSprite];

    
    //============= Play Button =================
    SKSpriteNode *startButton = [SKSpriteNode spriteNodeWithImageNamed:StartButtonUnpressedFileName];
    startButton.name = @"startButtonNode";
    startButton.size = CGSizeMake(self.frame.size.width / 2 - 20, self.frame.size.height / 8);
    startButton.position = CGPointMake(self.frame.size.width / 2, CGRectGetMinY(self.frame) + startButton.frame.size.height / 2 + 25);
    [self addChild:startButton];
    
    //============== Leader Button ==============
    SKSpriteNode *leaderButton = [SKSpriteNode spriteNodeWithImageNamed:LeaderBoardUnpressedFileName];
    leaderButton.name = @"leaderButtonNode";
    leaderButton.size = CGSizeMake(self.frame.size.height / 8, self.frame.size.height / 8);
    leaderButton.position = CGPointMake(CGRectGetMinX(startButton.frame) - leaderButton.frame.size.width / 2 - 5, CGRectGetMinY(self.frame) + startButton.frame.size.height / 2 + 25);
    [self addChild:leaderButton];
    
    [self CharacterButtonCreation];
    
    //============= Settings Button ==============
    SKSpriteNode *settingsButton = [SKSpriteNode spriteNodeWithImageNamed:SettingsUnpressedFileName];
    settingsButton.size = CGSizeMake(self.frame.size.height / 11, self.frame.size.height / 11);
    settingsButton.position = CGPointMake(CGRectGetMaxX(self.frame) - settingsButton.frame.size.width / 2 - 5, CGRectGetMaxY(self.frame) - settingsButton.frame.size.height / 2 - 5);
    settingsButton.name = @"settingsButtonNode";
    [self addChild:settingsButton];
    
    // settings additional buttons
    SKTexture *f1;
    if ([JBPGameData data].noiseAllowed)
    {
        f1 = [SKTexture textureWithImageNamed:SettingsNoiseUnpressedFileName];
        noisePressed = NO;
    }
    else
    {
        f1 = [SKTexture textureWithImageNamed:SettingsNoisePressedFileName];
        noisePressed = YES;
    }
    
    SKSpriteNode *noiseButton = [SKSpriteNode spriteNodeWithTexture:f1];
    noiseButton.size = settingsButton.size;
    noiseButton.position = CGPointMake(CGRectGetMidX(settingsButton.frame), CGRectGetMinY(settingsButton.frame) - noiseButton.frame.size.height / 2);
    noiseButton.hidden = YES;
    noiseButton.name = @"noiseButtonNode";
    [self addChild:noiseButton];
    
    if ([JBPGameData data].musicAllowed)
    {
        f1 = [SKTexture textureWithImageNamed:SettingsMusicUnpressedFileName];
        musicPressed = NO;
    }
    else
    {
        f1 = [SKTexture textureWithImageNamed:SettingsMusicPressedFileName];
        musicPressed = YES;
    }
    
    SKSpriteNode *musicButton = [SKSpriteNode spriteNodeWithTexture:f1];
    musicButton.size = settingsButton.size;
    musicButton.position = CGPointMake(CGRectGetMidX(noiseButton.frame), CGRectGetMinY(noiseButton.frame) - musicButton.frame.size.height / 2);
    musicButton.hidden = YES;
    musicButton.name = @"musicButtonNode";
    [self addChild:musicButton];
    

    //============= Player in Center ==================
    JBPlayer *centerPlayer = [JBPlayer initNewPlayer:self startingPoint:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)];
    centerPlayer.size = CGSizeMake(self.frame.size.width / 3, self.frame.size.height / 3);
    
}

- (void)CharacterButtonCreation
{
    SKSpriteNode *startButton = (SKSpriteNode *)[self childNodeWithName:@"startButtonNode"];
    
    // Character Button
    SKSpriteNode *charButton = [SKSpriteNode spriteNodeWithImageNamed:CharacterUnpressedFileName];
    charButton.size = CGSizeMake(self.frame.size.height / 8, self.frame.size.height / 8);
    charButton.name = @"charButtonNode";
    charButton.position = CGPointMake(CGRectGetMaxX(startButton.frame) + charButton.frame.size.width / 2 + 5, CGRectGetMinY(self.frame) + startButton.frame.size.height / 2 + 25);
    [self addChild:charButton];
    
    // charTexture is the head
    SKTexture *charTexture = [[SKTexture alloc] init];
    switch ([JBPGameData data].currentPlayer)
    {
        case Russian:     // Russian
        {
            charTexture = [SKTexture textureWithImageNamed:@"Russian.png"];
            break;
        }
        case Scottish:     // Scottish
        {
            charTexture = [SKTexture textureWithImageNamed:@"Scottish.png"];
            break;
        }
        case English:     // English
        {
            charTexture = [SKTexture textureWithImageNamed:@"English.png"];
            break;
        }
        case Cowboy:     // American
        {
            charTexture = [SKTexture textureWithImageNamed:@"Cowboy.png"];
            break;
        }
        case Mexican:     // Mexican
        {
            charTexture = [SKTexture textureWithImageNamed:@"Mexican.png"];
            break;
        }
        case Viking:     // Viking
        {
            charTexture = [SKTexture textureWithImageNamed:@"Viking.png"];
            break;
        }
        case French:     // French
        {
            charTexture = [SKTexture textureWithImageNamed:@"French.png"];
            break;
        }
        case Australian:     // Australian
        {
            charTexture = [SKTexture textureWithImageNamed:@"Australian.png"];
            break;
        }
        case General:     // General
        {
            charTexture = [SKTexture textureWithImageNamed:@"General.png"];
            break;
        }
        case Japanese:     // Japanese
        {
            charTexture = [SKTexture textureWithImageNamed:@"Japanese.png"];
            break;
        }
    }
    
    SKSpriteNode *charHead = [SKSpriteNode spriteNodeWithTexture:charTexture];
    charHead.size = CGSizeMake(charButton.frame.size.width - 15, charButton.frame.size.height - 15);
    charHead.position = charButton.position;
    charHead.zPosition = 1;
    [self addChild:charHead];
    char_Head = charHead;

}

#pragma mark - Touch handlers

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKSpriteNode *startButton = (SKSpriteNode *)[self childNodeWithName:@"startButtonNode"];
        SKSpriteNode *leaderButton = (SKSpriteNode *)[self childNodeWithName:@"leaderButtonNode"];
        SKSpriteNode *noiseButton = (SKSpriteNode *)[self childNodeWithName:@"noiseButtonNode"];
        SKSpriteNode *musicButton = (SKSpriteNode *)[self childNodeWithName:@"musicButtonNode"];
        SKSpriteNode *charButton = (SKSpriteNode *)[self childNodeWithName:@"charButtonNode"];

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
        
        // Character Button
        if (CGRectContainsPoint(charButton.frame, location))
        {
            SKTexture *f1 = [SKTexture textureWithImageNamed:CharacterPressedFileName];
            [charButton setTexture:f1];
            char_Head.position = CGPointMake(char_Head.position.x, char_Head.position.y - 5);
        }
        
        // Settings Button
        
        // Additional Settings Buttons
        if (CGRectContainsPoint(noiseButton.frame, location) && !noiseButton.isHidden)
        {
            if (noisePressed)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"turnNoiseOn" object:nil];
                SKTexture *f1 = [SKTexture textureWithImageNamed:SettingsNoiseUnpressedFileName];
                [noiseButton setTexture:f1];
                noisePressed = NO;
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"turnNoiseOff" object:nil];
                SKTexture *f1 = [SKTexture textureWithImageNamed:SettingsNoisePressedFileName];
                [noiseButton setTexture:f1];
                noisePressed = YES;
            }

        }
        
        if (CGRectContainsPoint(musicButton.frame, location) && !musicButton.isHidden)
        {
            if (musicPressed)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"turnMusicOn" object:nil];
                SKTexture *f1 = [SKTexture textureWithImageNamed:SettingsMusicUnpressedFileName];
                [musicButton setTexture:f1];
                musicPressed = NO;
            }
            else
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"turnMusicOff" object:nil];
                SKTexture *f1 = [SKTexture textureWithImageNamed:SettingsMusicPressedFileName];
                [musicButton setTexture:f1];
                musicPressed = YES;
            }

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
        SKSpriteNode *settingsButton = (SKSpriteNode *)[self childNodeWithName:@"settingsButtonNode"];
        SKSpriteNode *noiseButton = (SKSpriteNode *)[self childNodeWithName:@"noiseButtonNode"];
        SKSpriteNode *musicButton = (SKSpriteNode *)[self childNodeWithName:@"musicButtonNode"];
        SKSpriteNode *charButton = (SKSpriteNode *)[self childNodeWithName:@"charButtonNode"];
        
#pragma mark Scene Transicions
        // Start Button
        if (CGRectContainsPoint(startButton.frame, location))
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonNoise" object:nil];
            JBPGameScene *gameScene = [[JBPGameScene alloc] initWithSize:self.size];
            SKTransition *openUp = [SKTransition doorsOpenVerticalWithDuration:0.5];
            [self.view presentScene:gameScene transition:openUp];
            //JBPCharacterScene *charScene = [[JBPCharacterScene alloc] initWithSize:self.size];
            //[self.view presentScene:charScene];
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
        
        // Character Button
        if (CGRectContainsPoint(charButton.frame, location))
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonNoise" object:nil];
            JBPCharacterScene *charScene = [[JBPCharacterScene alloc] initWithSize:self.size];
            [self.view presentScene:charScene];
            [self removeAllActions];
            [self removeAllChildren];
        }
        else
        {
            SKTexture *f1 = [SKTexture textureWithImageNamed:CharacterUnpressedFileName];
            [charButton setTexture:f1];
            char_Head.position = CGPointMake(char_Head.position.x, char_Head.position.y + 5);
        }
        
        // Settings Button
        if (CGRectContainsPoint(settingsButton.frame, location))
        {
            if (!settingsPressed)
            {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonNoise" object:nil];

                SKTexture *f1 = [SKTexture textureWithImageNamed:SettingsPressedFileName];
                [settingsButton setTexture:f1];
                noiseButton.hidden = NO;
                musicButton.hidden = NO;
                settingsPressed = YES;
            }
            else
            {
                if ([JBPGameData data].noiseAllowed)
                {
                    [self runAction:_buttonNoise];
                }
                [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonNoise" object:nil];
                noiseButton.hidden = YES;
                musicButton.hidden = YES;
                SKTexture *f1 = [SKTexture textureWithImageNamed:SettingsUnpressedFileName];
                [settingsButton setTexture:f1];
                settingsPressed = NO;
            }

        }
        else if (!(CGRectContainsPoint(settingsButton.frame, location) || CGRectContainsPoint(musicButton.frame, location) || CGRectContainsPoint(noiseButton.frame, location)))
        {
            SKTexture *f1 = [SKTexture textureWithImageNamed:SettingsUnpressedFileName];
            [settingsButton setTexture:f1];
            noiseButton.hidden = YES;
            musicButton.hidden = YES;
            settingsPressed = NO;
        }
        
        // Additional Settings Buttons

    
    }
}

#pragma mark - Update handlers

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}


@end
