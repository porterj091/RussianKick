//
//  JBPCoin.h
//  Russian Kick
//
//  Created by Joseph Porter on 11/18/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "JBPSpriteTexturesCache.h"
#import "JBPGameData.h"


#define CoinAnimationSpeed      0.15
#define CoinTime                3

@interface JBPCoin : SKSpriteNode <SKPhysicsContactDelegate>

// Animation
@property (nonatomic, strong) NSArray *animation;


+ (JBPCoin *)initCoin:(SKScene *)whichScene startingPoint:(CGPoint)location startingSize:(CGSize)theSize;

@end
