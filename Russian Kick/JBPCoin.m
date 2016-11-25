//
//  JBPCoin.m
//  Russian Kick
//
//  Created by Joseph Porter on 11/18/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import "JBPCoin.h"

@implementation JBPCoin

+ (JBPCoin *)initCoin:(SKScene *)whichScene startingPoint:(CGPoint)location startingSize:(CGSize)theSize
{
    SKTexture *f1 = [SKTexture textureWithImageNamed:SettingsPressedFileName];
    JBPCoin *coin = [JBPCoin spriteNodeWithTexture:f1];
    coin.name = @"theCoin";
    coin.size = theSize;
    coin.position = location;
    coin.zPosition = 1;
    [coin createAnimations];
    [whichScene addChild:coin];
    return coin;
}

- (void)createAnimations
{
    // Make the coin flip
    _animation = [JBPSpriteTexturesCache sharedTextures].coinTextures;
    SKAction *ani = [SKAction animateWithTextures:_animation timePerFrame:CoinAnimationSpeed];
    SKAction *aniForever = [SKAction repeatActionForever:ani];
    [self runAction:aniForever];
    
    // Move the coin either right or left
    int num = arc4random() % 2;
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    self.physicsBody.allowsRotation = NO;
    SKAction *moveHorizontal = [SKAction moveByX:(num == 0 ? -1 : 1) * 20.0f y:0.0f duration:0.5f];
    SKAction *moveForever = [SKAction repeatActionForever:moveHorizontal];
    [self runAction:moveForever];

    
    // Destroy the coin after time has passed
    SKAction *time = [SKAction waitForDuration:CoinTime];
    [self runAction:time completion:^
     {
         [self removeFromParent];
     }];
}

@end
