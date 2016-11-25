//
//  JBPSpriteTexturesCache.m
//  Russian Kick
//
//  Created by Joseph Porter on 7/2/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import "JBPSpriteTexturesCache.h"

@implementation JBPSpriteTexturesCache

+ (instancetype)sharedTextures
{
    static id sharedTexures = nil;
    
    if (sharedTexures == nil)
    {
        sharedTexures = [[JBPSpriteTexturesCache alloc] init];
        [sharedTexures createAnimationTextures];
    }
    
    return sharedTexures;
}

- (void)createAnimationTextures
{
    
    NSMutableArray *un_Chars = [[NSMutableArray alloc] init];
    //=========== Russian Player ===============
    
#pragma mark Russian Player
    // Idle Animations
    SKTexture *f1 = [SKTexture textureWithImageNamed:PlayerIdle1FileName];
    SKTexture *f2 = [SKTexture textureWithImageNamed:PlayerIdle2FileName];
    SKTexture *f3 = [SKTexture textureWithImageNamed:PlayerIdle3FileName];
    SKTexture *f4 = [SKTexture textureWithImageNamed:PlayerIdle4FileName];
    SKTexture *f5 = [SKTexture textureWithImageNamed:PlayerIdle5FileName];
    SKTexture *f6 = [SKTexture textureWithImageNamed:PlayerIdle6FileName];
    _russianStandingTextures = @[f1, f2, f3, f4, f6, f6, f5, f5, f3];
    [un_Chars addObject:f1];
    
    // RightKick Animations
    f1 = [SKTexture textureWithImageNamed:PlayerRightKickFileName];
    _russianRightKickTextures = @[f1];
    
    // LeftKick Animations
    f1 = [SKTexture textureWithImageNamed:PlayerLeftKickFileName];
    _russianLeftKickTextures = @[f1];
    
    // End Noises
    SKAction *noise1 = [SKAction playSoundFileNamed:@"End_Noise1.mp3" waitForCompletion:NO];
    SKAction *noise2 = [SKAction playSoundFileNamed:@"End_Noise2.mp3" waitForCompletion:NO];
    SKAction *noise3 = [SKAction playSoundFileNamed:@"End_Noise3.mp3" waitForCompletion:NO];
    _russianEndNoises = @[noise1, noise2, noise3];
    
    //========== Scottish Player ===============
    
#pragma mark Scottish Player
    // Idle Animations
    f1 = [SKTexture textureWithImageNamed:ScottishIdle1FileName];
    f2 = [SKTexture textureWithImageNamed:ScottishIdle2FileName];
    f3 = [SKTexture textureWithImageNamed:ScottishIdle3FileName];
    f4 = [SKTexture textureWithImageNamed:ScottishIdle4FileName];
    f5 = [SKTexture textureWithImageNamed:ScottishIdle5FileName];
    f6 = [SKTexture textureWithImageNamed:ScottishIdle6FileName];
    _scottishStandingTextures = @[f1, f2, f3, f4, f5, f6, f5, f4, f3, f2, f1];
    [un_Chars addObject:f1];
    
    // RightKick Animations
    f1 = [SKTexture textureWithImageNamed:ScottishRickKickFileName];
    _scottishRightKickTextures = @[f1];
    
    // Leftkick Animations
    f1 = [SKTexture textureWithImageNamed:ScottishLeftKickFileName];
    _scottishLeftKickTextures = @[f1];
    
    // End Noises
    SKAction *n1 = [SKAction playSoundFileNamed:@"Scottish1.mp3" waitForCompletion:NO];
    SKAction *n2 = [SKAction playSoundFileNamed:@"Scottish2.mp3" waitForCompletion:NO];
    SKAction *n3 = [SKAction playSoundFileNamed:@"Scottish3.mp3" waitForCompletion:NO];
    _scottishEndNoises = @[n1, n2, n3];
    
    //========== Mexican Player ===============
    
#pragma mark Mexican Player
    // Idle Animations
    f1 = [SKTexture textureWithImageNamed:MexicanIdle1FileName];
    f2 = [SKTexture textureWithImageNamed:MexicanIdle2FileName];
    f3 = [SKTexture textureWithImageNamed:MexicanIdle3FileName];
    f4 = [SKTexture textureWithImageNamed:MexicanIdle4FileName];
    f5 = [SKTexture textureWithImageNamed:MexicanIdle5FileName];
    f6 = [SKTexture textureWithImageNamed:MexicanIdle6FileName];
    _mexicanStandingTextures = @[f1, f2, f3, f4, f5, f6, f5, f4, f3, f2, f1];
    [un_Chars addObject:f1];
    
    // RightKick Animations
    f1 = [SKTexture textureWithImageNamed:MexicanRickKickFileName];
    _mexicanRightKickTextures = @[f1];
    
    // Leftkick Animations
    f1 = [SKTexture textureWithImageNamed:MexicanLeftKickFileName];
    _mexicanLeftKickTextures = @[f1];
    
    // End Noises
    n1 = [SKAction playSoundFileNamed:@"End_Noise1.mp3" waitForCompletion:NO];
    _mexicanEndNoises = @[n1];
    
    //========== Japanese Player ===============
    
#pragma mark Japanese Player
    // Idle Animations
    f1 = [SKTexture textureWithImageNamed:JapaneseIdle1FileName];
    f2 = [SKTexture textureWithImageNamed:JapaneseIdle2FileName];
    f3 = [SKTexture textureWithImageNamed:JapaneseIdle3FileName];
    f4 = [SKTexture textureWithImageNamed:JapaneseIdle4FileName];
    f5 = [SKTexture textureWithImageNamed:JapaneseIdle5FileName];
    f6 = [SKTexture textureWithImageNamed:JapaneseIdle6FileName];
    _japaneseStandingTextures = @[f1, f2, f3, f4, f5, f6, f5, f4, f3, f2, f1];
    [un_Chars addObject:f1];
    
    // RightKick Animations
    f1 = [SKTexture textureWithImageNamed:JapaneseRickKickFileName];
    _japaneseRightKickTextures = @[f1];
    
    // Leftkick Animations
    f1 = [SKTexture textureWithImageNamed:JapaneseLeftKickFileName];
    _japaneseLeftKickTextures = @[f1];
    
    // End Noises
    n1 = [SKAction playSoundFileNamed:@"End_Noise1.mp3" waitForCompletion:NO];
    _japaneseEndNoises = @[n1];
    
    //========== English Player ===============
    
#pragma mark English Player
    // Idle Animations
    f1 = [SKTexture textureWithImageNamed:EnglishIdle1FileName];
    f2 = [SKTexture textureWithImageNamed:EnglishIdle2FileName];
    f3 = [SKTexture textureWithImageNamed:EnglishIdle3FileName];
    f4 = [SKTexture textureWithImageNamed:EnglishIdle4FileName];
    f5 = [SKTexture textureWithImageNamed:EnglishIdle5FileName];
    f6 = [SKTexture textureWithImageNamed:EnglishIdle6FileName];
    _englishStandingTextures = @[f1, f2, f3, f4, f5, f6, f5, f4, f3, f2, f1];
    [un_Chars addObject:f1];
    
    // RightKick Animations
    f1 = [SKTexture textureWithImageNamed:EnglishRickKickFileName];
    _englishRightKickTextures = @[f1];
    
    // Leftkick Animations
    f1 = [SKTexture textureWithImageNamed:EnglishLeftKickFileName];
    _englishLeftKickTextures = @[f1];
    
    // End Noises
    n1 = [SKAction playSoundFileNamed:@"End_Noise1.mp3" waitForCompletion:NO];
    _englishEndNoises = @[n1];
    
    //========== French Player ===============
    
#pragma mark French Player
    // Idle Animations
    f1 = [SKTexture textureWithImageNamed:FrenchIdle1FileName];
    f2 = [SKTexture textureWithImageNamed:FrenchIdle2FileName];
    f3 = [SKTexture textureWithImageNamed:FrenchIdle3FileName];
    f4 = [SKTexture textureWithImageNamed:FrenchIdle4FileName];
    f5 = [SKTexture textureWithImageNamed:FrenchIdle5FileName];
    f6 = [SKTexture textureWithImageNamed:FrenchIdle6FileName];
    _frenchStandingTextures = @[f1, f2, f3, f4, f5, f6, f5, f4, f3, f2, f1];
    [un_Chars addObject:f1];
    
    // RightKick Animations
    f1 = [SKTexture textureWithImageNamed:FrenchRickKickFileName];
    _frenchRightKickTextures = @[f1];
    
    // Leftkick Animations
    f1 = [SKTexture textureWithImageNamed:FrenchLeftKickFileName];
    _frenchLeftKickTextures = @[f1];
    
    // End Noises
    n1 = [SKAction playSoundFileNamed:@"End_Noise1.mp3" waitForCompletion:NO];
    _frenchEndNoises = @[n1];
    
    //========== Indian Player ===============
    
#pragma mark Viking Player
    // Idle Animations
    f1 = [SKTexture textureWithImageNamed:VikingIdle1FileName];
    f2 = [SKTexture textureWithImageNamed:VikingIdle2FileName];
    f3 = [SKTexture textureWithImageNamed:VikingIdle3FileName];
    f4 = [SKTexture textureWithImageNamed:VikingIdle4FileName];
    f5 = [SKTexture textureWithImageNamed:VikingIdle5FileName];
    f6 = [SKTexture textureWithImageNamed:VikingIdle6FileName];
    _vikingStandingTextures = @[f1, f2, f3, f4, f5, f6, f5, f4, f3, f2, f1];
    [un_Chars addObject:f1];
    
    // RightKick Animations
    f1 = [SKTexture textureWithImageNamed:VikingRickKickFileName];
    _vikingRightKickTextures = @[f1];
    
    // Leftkick Animations
    f1 = [SKTexture textureWithImageNamed:VikingLeftKickFileName];
    _vikingLeftKickTextures = @[f1];
    
    // End Noises
    n1 = [SKAction playSoundFileNamed:@"End_Noise1.mp3" waitForCompletion:NO];
    _vikingEndNoises = @[n1];
    
    //========== General Player ===============
    
#pragma mark General Player
    // Idle Animations
    f1 = [SKTexture textureWithImageNamed:GeneralIdle1FileName];
    f2 = [SKTexture textureWithImageNamed:GeneralIdle2FileName];
    f3 = [SKTexture textureWithImageNamed:GeneralIdle3FileName];
    f4 = [SKTexture textureWithImageNamed:GeneralIdle4FileName];
    f5 = [SKTexture textureWithImageNamed:GeneralIdle5FileName];
    f6 = [SKTexture textureWithImageNamed:GeneralIdle6FileName];
    _generalStandingTextures = @[f1, f2, f3, f4, f5, f6, f5, f4, f3, f2, f1];
    [un_Chars addObject:f1];
    
    // RightKick Animations
    f1 = [SKTexture textureWithImageNamed:GeneralRickKickFileName];
    _generalRightKickTextures = @[f1];
    
    // Leftkick Animations
    f1 = [SKTexture textureWithImageNamed:GeneralLeftKickFileName];
    _generalLeftKickTextures = @[f1];
    
    // End Noises
    n1 = [SKAction playSoundFileNamed:@"End_Noise1.mp3" waitForCompletion:NO];
    _generalEndNoises = @[n1];
    
    //========== Australian Player ===============
    
#pragma mark Australian Player
    // Idle Animations
    f1 = [SKTexture textureWithImageNamed:AustralianIdle1FileName];
    f2 = [SKTexture textureWithImageNamed:AustralianIdle2FileName];
    f3 = [SKTexture textureWithImageNamed:AustralianIdle3FileName];
    f4 = [SKTexture textureWithImageNamed:AustralianIdle4FileName];
    f5 = [SKTexture textureWithImageNamed:AustralianIdle5FileName];
    f6 = [SKTexture textureWithImageNamed:AustralianIdle6FileName];
    _australianStandingTextures = @[f1, f2, f3, f4, f5, f6, f5, f4, f3, f2, f1];
    [un_Chars addObject:f1];
    
    // RightKick Animations
    f1 = [SKTexture textureWithImageNamed:AustralianRickKickFileName];
    _australianRightKickTextures = @[f1];
    
    // Leftkick Animations
    f1 = [SKTexture textureWithImageNamed:AustralianLeftKickFileName];
    _australianLeftKickTextures = @[f1];
    
    // End Noises
    n1 = [SKAction playSoundFileNamed:@"End_Noise1.mp3" waitForCompletion:NO];
    _australianEndNoises = @[n1];
    
    //========== American Player ===============
    
#pragma mark American Player
    // Idle Animations
    f1 = [SKTexture textureWithImageNamed:AmericanIdle1FileName];
    f2 = [SKTexture textureWithImageNamed:AmericanIdle2FileName];
    f3 = [SKTexture textureWithImageNamed:AmericanIdle3FileName];
    f4 = [SKTexture textureWithImageNamed:AmericanIdle4FileName];
    f5 = [SKTexture textureWithImageNamed:AmericanIdle5FileName];
    f6 = [SKTexture textureWithImageNamed:AmericanIdle6FileName];
    _americanStandingTextures = @[f1, f2, f3, f4, f5, f6, f5, f4, f3, f2, f1];
    [un_Chars addObject:f1];
    
    // RightKick Animations
    f1 = [SKTexture textureWithImageNamed:AmericanRickKickFileName];
    _americanRightKickTextures = @[f1];
    
    // Leftkick Animations
    f1 = [SKTexture textureWithImageNamed:AmericanLeftKickFileName];
    _americanLeftKickTextures = @[f1];
    
    // End Noises
    n1 = [SKAction playSoundFileNamed:@"Cowboy1.mp3" waitForCompletion:NO];
    n2 = [SKAction playSoundFileNamed:@"Cowboy2.mp3" waitForCompletion:NO];
    n3 = [SKAction playSoundFileNamed:@"Cowboy3.mp3" waitForCompletion:NO];
    SKAction *n4 = [SKAction playSoundFileNamed:@"Cowboy4.mp3" waitForCompletion:NO];
    _americanEndNoises = @[n1, n2, n3, n4];
    
    
    //============ Charcter Scene stuff =============
    _unlockedChars = [NSArray arrayWithArray:(NSArray *)un_Chars];
    
    // Locked character array
    SKTexture *t1 = [SKTexture textureWithImageNamed:RussianLocked];
    SKTexture *t2 = [SKTexture textureWithImageNamed:ScottishLocked];
    SKTexture *t3 = [SKTexture textureWithImageNamed:MexicanLocked];
    SKTexture *t4 = [SKTexture textureWithImageNamed:JapaneseLocked];
    SKTexture *t5 = [SKTexture textureWithImageNamed:EnglishLocked];
    SKTexture *t6 = [SKTexture textureWithImageNamed:FrenchLocked];
    SKTexture *t7 = [SKTexture textureWithImageNamed:VikingLocked];
    SKTexture *t8 = [SKTexture textureWithImageNamed:GeneralLocked];
    SKTexture *t9 = [SKTexture textureWithImageNamed:AustralianLocked];
    SKTexture *t10 = [SKTexture textureWithImageNamed:CowboyLocked];
    _lockedChars = @[t1, t2, t3, t4, t5, t6, t7, t8, t9, t10];
    
    //=========== Game Scene Textures ================
    
    //=============== Coin ===================
    f1 = [SKTexture textureWithImageNamed:CoinFileName1];
    f2 = [SKTexture textureWithImageNamed:CoinFileName2];
    f3 = [SKTexture textureWithImageNamed:CoinFileName3];
    _coinTextures = @[f1, f2, f3];
    
    // Slider bars
    f1 = [SKTexture textureWithImageNamed:SliderBar_PlainFileName];
    _sliderBarTextures = @[f1];
    
    // Sliders
    f1 = [SKTexture textureWithImageNamed:SliderSprite_PlainFileName];
    _sliderTextures = @[f1];
}

@end
