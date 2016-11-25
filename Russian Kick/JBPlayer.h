//
//  JBPlayer.h
//  Russian Kick
//
//  Created by Joseph Porter on 7/2/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "JBPSpriteTexturesCache.h"
#import <AVFoundation/AVFoundation.h>
#import "JBPGameData.h"

#define PlayerAnimationSpeed            0.15

@interface JBPlayer : SKSpriteNode

enum character_Name
{
    russian,
    scottish,
    english,
    american,
    australian,
    jamacian,
    mexican,
    indian,
    japanese,
    french
};

// Player Animations
@property (nonatomic, strong) NSArray* rightkickAnimation;
@property (nonatomic, strong) NSArray* leftkickAnimation;
@property (nonatomic, strong) NSArray* standingAnimation;

// Player Noises
@property (nonatomic, strong) NSArray* endNoises;


+ (JBPlayer *)initNewPlayer:(SKScene *)whichScene startingPoint:(CGPoint)location;

- (void)endNoise;
- (void)rightLegKick;
- (void)leftLegKick;

@end
