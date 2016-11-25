//
//  JBPGameScene.m
//  Russian Kick
//
//  Created by Joseph Porter on 7/1/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import "JBPGameScene.h"
#import "JBPTitleScene.h"
#import "JBPSpriteTexturesCache.h"
#import "JBPlayer.h"
#import "JBPGameData.h"
#import "JBPEndGameScene.h"
#import "JBPCoin.h"

int adinterval;
int additionalInterval;
BOOL firstTouch;
BOOL gameOver;
BOOL bumperRestart;
BOOL allowIncrement;

@interface JBPGameScene()

@property (nonatomic, strong) SKEmitterNode *sparksRight;
@property (nonatomic, strong) SKEmitterNode *sparksLeft;

@end


@implementation JBPGameScene 


#pragma mark - Initialization
- (id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor blueColor];
        [self createSceneObjects];
        adinterval = 50;
        additionalInterval = 1;
        firstTouch = YES;
        gameOver = NO;
        bumperRestart = NO;
        allowIncrement = NO;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
        self.physicsWorld.gravity = CGVectorMake(0, -1.0f);
    }
    
    return self;
}

#pragma mark - Create Scene Onjects

- (void)createSceneObjects
{
    //JBPCoin *theCoin = [JBPCoin initCoin:self startingPoint:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) startingSize:CGSizeMake(10, 10)];
    //============ BackGround ============
    int num = (arc4random() % NumberBackGroundImages) + 1;
    SKTexture *backgroundTexture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"GameScreen_BackGround_%d", num]];
    SKSpriteNode *backGround = [SKSpriteNode spriteNodeWithTexture:backgroundTexture];
    backGround.size = self.frame.size;
    backGround.zPosition = -1;
    backGround.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    [self addChild:backGround];
    
    //============ BackGround Particles ==========
    if (num == 4 || num == 5)
    {
        NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"SnowParticles" ofType:@"sks"];
        SKEmitterNode *backgroundParts = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
        backgroundParts.zPosition = 0;
        backgroundParts.position = CGPointMake(self.frame.size.width / 2, CGRectGetMaxY(self.frame));
        backgroundParts.name = @"snow";
        backgroundParts.targetNode = self;
        [self addChild:backgroundParts];
    }
    
    //============ Player ================
    JBPlayer *player = [JBPlayer initNewPlayer:self startingPoint:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 3)];
    player.size = CGSizeMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
    //=========== Slider Bar ============
    
    SKTexture *sliderBarTexture = [SKTexture textureWithImageNamed:SliderBar_PlainFileName];
    SKSpriteNode *sliderBarSprite = [SKSpriteNode spriteNodeWithTexture:sliderBarTexture];
    sliderBarSprite.position = CGPointMake(self.frame.size.width / 2, CGRectGetMaxY(player.frame) + TopBufferZone);
    sliderBarSprite.size = CGSizeMake(315, SliderBarHeight);
    sliderBarSprite.zPosition = 0.1;
    sliderBarSprite.name = @"BarNode";
    [self addChild:sliderBarSprite];
    
    //=========== Slider ===========
    
    SKTexture *sliderTexture = [SKTexture textureWithImageNamed:SliderSprite_PlainFileName];
    SKSpriteNode *sliderSprite = [SKSpriteNode spriteNodeWithTexture:sliderTexture];
    sliderSprite.size = CGSizeMake(10, sliderBarSprite.frame.size.height / 2);
    sliderSprite.position = CGPointMake(self.frame.size.width / 2, (CGRectGetMinY(sliderBarSprite.frame) + sliderSprite.frame.size.height /2 + 5));
    sliderSprite.zPosition = 1;
    sliderSprite.name = @"sliderSpriteNode";

    [self addChild:sliderSprite];
    
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"SliderParticlesRight" ofType:@"sks"];
    SKEmitterNode *bling = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
    _sparksRight = bling;
    
    emitterPath = [[NSBundle mainBundle] pathForResource:@"SliderParticlesLeft" ofType:@"sks"];
    bling = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
    _sparksLeft = bling;




    
    //=========== Bumpers ==============
    
    // Left Bumper
    SKSpriteNode *bumperLeft = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(20, sliderBarSprite.frame.size.height - 8)];
    bumperLeft.position = CGPointMake(CGRectGetMinX(sliderBarSprite.frame) + BumperStartingXMax, sliderBarSprite.position.y);
    bumperLeft.zPosition = 1;
    bumperLeft.name = @"LeftBumperNode";
    [self addChild:bumperLeft];
    
    // Right Bumper
    SKSpriteNode *bumperRight = [SKSpriteNode spriteNodeWithColor:[UIColor blackColor] size:CGSizeMake(20, sliderBarSprite.frame.size.height - 8)];
    bumperRight.position = CGPointMake(CGRectGetMaxX(sliderBarSprite.frame) - BumperStartingXMax, sliderBarSprite.position.y);
    bumperRight.zPosition = 1;
    bumperRight.name = @"RightBumperNode";

    [self addChild:bumperRight];

    
    //============ Scoreing ==============
    _playerScore = 0;
    JBPTextureScores *playerScore = [[JBPTextureScores alloc] init];
    [playerScore initNewNumberTextures:self startingPoint:CGPointMake(self.frame.size.width / 2, CGRectGetMaxY(sliderBarSprite.frame) + 60) startingSize:CGSizeMake(25, 50) startingScore:_playerScore name:@"digit" fileName:@"Number"];
    _scoreDisplay = playerScore;

    
    // HighScore
    _highScore = [JBPGameData data].highScore;
    
    //============ Instructions =============
    SKTexture *instructionTexture = [SKTexture textureWithImageNamed:TaptostartFileName];
    SKSpriteNode *instructionNode = [SKSpriteNode spriteNodeWithTexture:instructionTexture];
    instructionNode.name = @"InstructionNode";
    instructionNode.size = CGSizeMake(self.frame.size.width / 2, 30);
    instructionNode.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    instructionNode.zPosition = 1;
    [self addChild:instructionNode];
    
    SKSpriteNode *leftTapNode = [SKSpriteNode spriteNodeWithImageNamed:LeftTapFileName];
    leftTapNode.size = CGSizeMake(60, 90);
    leftTapNode.position = CGPointMake(bumperLeft.position.x, CGRectGetMaxY(bumperLeft.frame) + leftTapNode.frame.size.height / 2 + 10);
    leftTapNode.name = @"leftTapNode";
    [self addChild:leftTapNode];
    
    SKSpriteNode *rightTapNode = [SKSpriteNode spriteNodeWithImageNamed:RightTapFileName];
    rightTapNode.size = CGSizeMake(60, 90);
    rightTapNode.position = CGPointMake(bumperRight.position.x, CGRectGetMaxY(bumperRight.frame) + rightTapNode.frame.size.height / 2 + 10);
    rightTapNode.name = @"rightTapNode";
    [self addChild:rightTapNode];
    

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showBannerAd" object:nil];
    



}

#pragma mark - Handle Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInNode:self];
    SKSpriteNode *theSlider = (SKSpriteNode *)[self childNodeWithName:@"sliderSpriteNode"];
    SKNode *rightBumper = [self childNodeWithName:@"RightBumperNode"];
    SKNode *leftBumper = [self childNodeWithName:@"LeftBumperNode"];
    JBPlayer *thePlayer = (JBPlayer *)[self childNodeWithName:@"PlayerNode"];
    SKNode *instructions = [self childNodeWithName:@"InstructionNode"];
    SKNode *leftTap = [self childNodeWithName:@"leftTapNode"];
    SKNode *rightTap = [self childNodeWithName:@"rightTapNode"];
    self.userInteractionEnabled = NO;
    
    if (firstTouch)
    {
        [instructions removeFromParent];
        [leftTap removeFromParent];
        [rightTap removeFromParent];
        firstTouch = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideBannerAd" object:nil];
        
        //============ Start Animations =========
        SKAction *delay = [SKAction waitForDuration:1];
        [self runAction:delay completion:^
         {
             
             int num = arc4random() % 2;
             if (num == 0)
                 [self sliderLeft:theSlider];
             else
                 [self sliderRight:theSlider];
         }];
        
        SKAction *moveRight = [SKAction moveByX:5 y:0 duration:BumperSpeed];
        SKAction *moveForever = [SKAction repeatActionForever:moveRight];
        [self runAction:delay completion:^
         {
             [leftBumper runAction:moveForever];
         }];
        
        SKAction *moveLeft = [SKAction moveByX:-5 y:0 duration:BumperSpeed];
        moveForever = [SKAction repeatActionForever:moveLeft];
        [self runAction:delay completion:^
         {
             [rightBumper runAction:moveForever];
         }];
    }
    else
    {
        if (!gameOver)
        {
            if (![theSlider intersectsNode:leftBumper] && ![theSlider intersectsNode:rightBumper] && location.y < CGRectGetMidY(self.frame))
            {
                [theSlider removeAllActions];
                [leftBumper removeAllActions];
                [rightBumper removeAllActions];
                [theSlider removeAllChildren];
                [self gameOver];

            }
        
            if (location.x < CGRectGetMidX(self.frame) && [theSlider intersectsNode:leftBumper] && location.y < CGRectGetMidY(self.frame))
            {
                allowIncrement = YES;
                [self sliderRight:theSlider];
                [thePlayer leftLegKick];
            
            }
            else if (location.x > CGRectGetMidX(self.frame) && [theSlider intersectsNode:rightBumper] && location.y < CGRectGetMidY(self.frame))
            {
                allowIncrement = YES;
                [self sliderLeft:theSlider];
                [thePlayer rightLegKick];
            }
        }
    }
    
    
}

#pragma mark - Update Events

- (void)update:(NSTimeInterval)currentTime
{
    SKSpriteNode *theSlider = (SKSpriteNode *)[self childNodeWithName:@"sliderSpriteNode"];
    SKNode *rightBumper = [self childNodeWithName:@"RightBumperNode"];
    SKNode *leftBumper = [self childNodeWithName:@"LeftBumperNode"];
    SKNode *sliderBar = [self childNodeWithName:@"BarNode"];
    
    [self bumperAdjustments];
    
    if (CGRectGetMaxX(theSlider.frame) < (CGRectGetMinX(leftBumper.frame) + 3) || CGRectGetMinX(theSlider.frame) > (CGRectGetMaxX(rightBumper.frame) - 3))
    {
        self.userInteractionEnabled = NO;
        [theSlider removeAllActions];
        [theSlider removeAllChildren];
        [leftBumper removeAllActions];
        [rightBumper removeAllActions];
        [self gameOver];

    }
    
    if ((CGRectGetMinX(rightBumper.frame) - CGRectGetMaxX(leftBumper.frame)) <= 40)
    {
        if (!bumperRestart)
        {
            [leftBumper removeAllActions];
            [rightBumper removeAllActions];
        }
    }
    
    if ((CGRectGetMinX(leftBumper.frame) < CGRectGetMinX(sliderBar.frame) + BumperStartingXMax - 11) && CGRectGetMaxX(rightBumper.frame) > CGRectGetMaxX(sliderBar.frame) - BumperStartingXMax + 11)
    {
        if (bumperRestart)
        {
            [leftBumper removeAllActions];
            [rightBumper removeAllActions];
            [self bumpersMiddle];
        }


    }
    
    [self incrementScore];
    
}

- (void)bumperAdjustments
{
    if (_playerScore == (adinterval * additionalInterval))
    {
        [self resetBumpers];

        additionalInterval++;
        bumperRestart = YES;
    }
    
}

- (void)incrementScore
{
    if (!gameOver && allowIncrement)
    {
        if (_playerScore < 9999)
        {
            _playerScore++;
            [_scoreDisplay updateNumber:_playerScore];
            allowIncrement = NO;
        }
    }
}

#pragma mark - GameView Handlers

- (void)sliderLeft:(SKSpriteNode *)slider
{
    [slider removeAllChildren];
    self.userInteractionEnabled = YES;
    int num = (arc4random() % 5) + SliderSpeed;
    [slider removeAllActions];
    SKAction *moveLeft = [SKAction moveByX:-num y:0 duration:0.2];
    SKAction *moveForever = [SKAction repeatActionForever:moveLeft];
    
    [slider runAction:moveForever];
    
    //============= Particles for slider =============
    
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"SliderParticlesRight" ofType:@"sks"];
    SKEmitterNode *bling = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
    bling.zPosition = 1;
    bling.position = CGPointMake(5, -10);
    bling.name = @"sparks";
    bling.targetNode = slider;
    [slider addChild:bling];
     /*
    _sparksRight.zPosition = 1;
    _sparksRight.position = CGPointMake(5, -10);
    _sparksRight.name = @"sparks";
    _sparksRight.targetNode = slider;
    [slider addChild:_sparksRight];
      */

}

- (void)sliderRight:(SKSpriteNode *)slider
{
    [slider removeAllChildren];
    self.userInteractionEnabled = YES;
    int num = (arc4random() % 5) + SliderSpeed;
    [slider removeAllActions];
    SKAction *moveRight = [SKAction moveByX:num y:0 duration:0.2];
    SKAction *moveForever = [SKAction repeatActionForever:moveRight];
    
    [slider runAction:moveForever];
    
    //============= Particles for slider =============
    
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:@"SliderParticlesLeft" ofType:@"sks"];
    SKEmitterNode *bling = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
    bling.zPosition = 1;
    bling.position = CGPointMake(-5, -10);
    bling.name = @"sparks";
    bling.targetNode = slider;
    [slider addChild:bling];
    /*
    _sparksLeft.zPosition = 1;
    _sparksLeft.position = CGPointMake(-5, -10);
    _sparksLeft.name = @"sparks";
    _sparksLeft.targetNode = slider;
    [slider addChild:_sparksLeft];
     */

}

- (void)resetBumpers
{
    SKNode *rightBumper = [self childNodeWithName:@"RightBumperNode"];
    SKNode *leftBumper = [self childNodeWithName:@"LeftBumperNode"];
    
    SKAction *moveRight = [SKAction moveByX:5 y:0 duration:BumperSpeed];
    SKAction *moveForever = [SKAction repeatActionForever:moveRight];
    
    [rightBumper runAction:moveForever];
    
    SKAction *moveLeft = [SKAction moveByX:-5 y:0 duration:BumperSpeed];
    moveForever = [SKAction repeatActionForever:moveLeft];
    
    [leftBumper runAction:moveForever];
    
    bumperRestart = NO;
    
}

- (void)bumpersMiddle
{
    SKNode *rightBumper = [self childNodeWithName:@"RightBumperNode"];
    SKNode *leftBumper = [self childNodeWithName:@"LeftBumperNode"];
    
    SKAction *moveRight = [SKAction moveByX:5 y:0 duration:BumperSpeed];
    SKAction *moveForever = [SKAction repeatActionForever:moveRight];
    
    [leftBumper runAction:moveForever];
    
    SKAction *moveLeft = [SKAction moveByX:-5 y:0 duration:BumperSpeed];
    moveForever = [SKAction repeatActionForever:moveLeft];
    
    [rightBumper runAction:moveForever];
    
    bumperRestart = NO;
}

#pragma mark - End Game handlers
- (void)gameOver
{
    if (!gameOver)
    {
        self.userInteractionEnabled = NO;
        // Handle ads for game over
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideBannerAd" object:nil];
        gameOver = YES;
        int num = (arc4random() % 4);
        if (num == 0)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showFullAd" object:nil];
        }
        
        NSDictionary *theScore = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:_highScore] forKey:@"HIGHSCORE"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"saveScore" object:nil userInfo:theScore];

        
        // Update the HighScore if needed
        if (_playerScore > _highScore)
        {
            NSDictionary *theScore = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:_highScore] forKey:@"HIGHSCORE"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"saveScore" object:nil userInfo:theScore];
            _highScore = _playerScore;
            
        }
        
        [JBPGameData data].highScore = _highScore;
        [JBPGameData data].playerScore = _playerScore;
        [[JBPGameData data] save];
        
        // Present the EndGame Scene
        SKAction *delay = [SKAction waitForDuration:0.5];
        [self runAction:delay completion:^
         {
             JBPlayer *thePlayer = (JBPlayer *)[self childNodeWithName:@"PlayerNode"];
             [thePlayer endNoise];
             
             SKTransition *slideDown = [SKTransition moveInWithDirection:SKTransitionDirectionUp duration:0.5];
             
             JBPEndGameScene *nextScene = [[JBPEndGameScene alloc] initWithSize:self.size];
             nextScene.playerScore = _playerScore;
             [self.view presentScene:nextScene transition:slideDown];
             [self removeAllActions];
             [self removeAllChildren];

         }];

    }

}


@end
