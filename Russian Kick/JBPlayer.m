//
//  JBPlayer.m
//  Russian Kick
//
//  Created by Joseph Porter on 7/2/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import "JBPlayer.h"

@interface JBPlayer()

@property (nonatomic, strong) SKAction *noise1;
@property (nonatomic, strong) SKAction *noise2;

@end

@implementation JBPlayer

#pragma mark - Initilaization

+ (JBPlayer *)initNewPlayer:(SKScene *)whichScene startingPoint:(CGPoint)location
{
    
    
    // Create Player
    SKTexture *f1 = [SKTexture textureWithImageNamed:PlayerIdle1FileName];
    JBPlayer *player = [JBPlayer spriteNodeWithTexture:f1];
    player.position = location;
    player.name = @"PlayerNode";
    [player setAnimations];
    [player resetToidle];
    [whichScene addChild:player];
    [player createNoiseFiles];

    
    return player;
    
    
}

- (void)setAnimations
{
    /* 
     ============= Menu for Characters ===================
     
            0: Russian      - starting character
            1: Scottish     - 250 coins
            2: English      - 250 coins
            3: American     - 300 coins
            4: Mexican      - 300 coins
            5: Viking       - 350 coins
            6: French       - 350 coins
            7: Australian   - 400 coins
            8: General      - 400 coins
            9: Japanese     - 500 coins
     
     =====================================================
     */
    switch ([JBPGameData data].currentPlayer)
    {
        case Russian:     // Russian
        {
#pragma mark Russian
            _standingAnimation = [JBPSpriteTexturesCache sharedTextures].russianStandingTextures;
            _leftkickAnimation = [JBPSpriteTexturesCache sharedTextures].russianLeftKickTextures;
            _rightkickAnimation = [JBPSpriteTexturesCache sharedTextures].russianRightKickTextures;
            _endNoises = [JBPSpriteTexturesCache sharedTextures].russianEndNoises;
            break;
        }
        case Scottish:     // Scottish
        {
#pragma mark Scottish
            _standingAnimation = [JBPSpriteTexturesCache sharedTextures].scottishStandingTextures;
            _leftkickAnimation = [JBPSpriteTexturesCache sharedTextures].scottishLeftKickTextures;
            _rightkickAnimation = [JBPSpriteTexturesCache sharedTextures].scottishRightKickTextures;
            _endNoises = [JBPSpriteTexturesCache sharedTextures].scottishEndNoises;
            break;
        }
        case English:     // English
        {
#pragma mark English
            _standingAnimation = [JBPSpriteTexturesCache sharedTextures].englishStandingTextures;
            _leftkickAnimation = [JBPSpriteTexturesCache sharedTextures].englishLeftKickTextures;
            _rightkickAnimation = [JBPSpriteTexturesCache sharedTextures].englishRightKickTextures;
            _endNoises = [JBPSpriteTexturesCache sharedTextures].englishEndNoises;
            break;
        }
        case Cowboy:     // American
        {
#pragma mark American
            _standingAnimation = [JBPSpriteTexturesCache sharedTextures].americanStandingTextures;
            _leftkickAnimation = [JBPSpriteTexturesCache sharedTextures].americanLeftKickTextures;
            _rightkickAnimation = [JBPSpriteTexturesCache sharedTextures].americanRightKickTextures;
            _endNoises = [JBPSpriteTexturesCache sharedTextures].americanEndNoises;
            break;
        }
        case Mexican:     // Mexican
        {
#pragma mark Mexican
            _standingAnimation = [JBPSpriteTexturesCache sharedTextures].mexicanStandingTextures;
            _leftkickAnimation = [JBPSpriteTexturesCache sharedTextures].mexicanLeftKickTextures;
            _rightkickAnimation = [JBPSpriteTexturesCache sharedTextures].mexicanRightKickTextures;
            _endNoises = [JBPSpriteTexturesCache sharedTextures].mexicanEndNoises;
            break;
        }
        case Viking:     // Viking
        {
#pragma mark Viking
            _standingAnimation = [JBPSpriteTexturesCache sharedTextures].vikingStandingTextures;
            _leftkickAnimation = [JBPSpriteTexturesCache sharedTextures].vikingLeftKickTextures;
            _rightkickAnimation = [JBPSpriteTexturesCache sharedTextures].vikingRightKickTextures;
            _endNoises = [JBPSpriteTexturesCache sharedTextures].vikingEndNoises;
            break;
        }
        case French:     // French
        {
#pragma mark French
            _standingAnimation = [JBPSpriteTexturesCache sharedTextures].frenchStandingTextures;
            _leftkickAnimation = [JBPSpriteTexturesCache sharedTextures].frenchLeftKickTextures;
            _rightkickAnimation = [JBPSpriteTexturesCache sharedTextures].frenchRightKickTextures;
            _endNoises = [JBPSpriteTexturesCache sharedTextures].frenchEndNoises;
            break;
        }
        case Australian:     // Australian
        {
#pragma mark Australian
            _standingAnimation = [JBPSpriteTexturesCache sharedTextures].australianStandingTextures;
            _leftkickAnimation = [JBPSpriteTexturesCache sharedTextures].australianLeftKickTextures;
            _rightkickAnimation = [JBPSpriteTexturesCache sharedTextures].australianRightKickTextures;
            _endNoises = [JBPSpriteTexturesCache sharedTextures].australianEndNoises;
            break;
        }
        case General:     // General
        {
#pragma mark General
            _standingAnimation = [JBPSpriteTexturesCache sharedTextures].generalStandingTextures;
            _leftkickAnimation = [JBPSpriteTexturesCache sharedTextures].generalLeftKickTextures;
            _rightkickAnimation = [JBPSpriteTexturesCache sharedTextures].generalRightKickTextures;
            _endNoises = [JBPSpriteTexturesCache sharedTextures].generalEndNoises;
            break;
        }
        case Japanese:     // Japanese
        {
#pragma mark Japanese
            _standingAnimation = [JBPSpriteTexturesCache sharedTextures].japaneseStandingTextures;
            _leftkickAnimation = [JBPSpriteTexturesCache sharedTextures].japaneseLeftKickTextures;
            _rightkickAnimation = [JBPSpriteTexturesCache sharedTextures].japaneseRightKickTextures;
            _endNoises = [JBPSpriteTexturesCache sharedTextures].japaneseEndNoises;
            break;
        }
    }
}

- (void)createNoiseFiles
{

    _noise1 = [SKAction playSoundFileNamed:@"Noise1.mp3" waitForCompletion:NO];
    _noise2 = [SKAction playSoundFileNamed:@"Noise2.mp3" waitForCompletion:NO];
}

#pragma mark - Kicking Animations
- (void)rightLegKick
{
    [self removeAllActions];
    int num = (arc4random() % 2) + 1;
    SKAction *rightKick = [SKAction animateWithTextures:_rightkickAnimation timePerFrame:0.25];
    SKAction *noise = num == 1 ? _noise1 : _noise2;
    SKAction *grouped;
    if ([JBPGameData data].noiseAllowed)
    {
        grouped = [SKAction group:@[rightKick, noise]];
    }
    else
    {
        grouped = [SKAction group:@[rightKick]];
    }
    
    [self runAction:grouped completion:^
     {
         [self resetToidle];
     }];
}

- (void)leftLegKick
{
    [self removeAllActions];
    int num = (arc4random() % 2) + 1;
    SKAction *leftKick = [SKAction animateWithTextures:_leftkickAnimation timePerFrame:0.25];
    SKAction *noise = num == 1 ? _noise1 : _noise2;
    SKAction *grouped;
    if ([JBPGameData data].noiseAllowed)
    {
        grouped = [SKAction group:@[leftKick, noise]];
    }
    else
    {
        grouped = [SKAction group:@[leftKick]];
    }

    [self runAction:grouped completion:^
     {
         [self resetToidle];
     }];
}

- (void)resetToidle
{
    [self removeAllActions];
    SKAction *idleAnimtions = [SKAction animateWithTextures:_standingAnimation timePerFrame:PlayerAnimationSpeed];
    SKAction *idleForever = [SKAction repeatActionForever:idleAnimtions];
    [self runAction:idleForever];
}

- (void)endNoise
{
    if ([JBPGameData data].noiseAllowed)
    {
        int rand = arc4random() % [_endNoises count];
        [self runAction:[_endNoises objectAtIndex:rand]];
    }
}

@end
