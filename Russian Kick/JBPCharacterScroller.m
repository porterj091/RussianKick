//
//  JBPCharacterScroller.m
//  Russian Kick
//
//  Created by Joseph Porter on 12/2/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import "JBPCharacterScroller.h"
@interface JBPCharacterScroller ()
{
    int num_of_sprite;
    NSMutableArray *nodes;
}
@end

@implementation JBPCharacterScroller



- (instancetype)initWithSize:(CGSize)size whichScene:(SKScene *)scene
{
    if (self = [super initWithColor:[SKColor clearColor] size:size])
    {
        self.size = size;
        _contentSize = size;
        _theScene = scene;
        self.name = @"Scroller";
        _backgroundColor = [SKColor clearColor];
    }
    
    return self;
}

// Will accept an arry of SKSpriteNodes and place them into the scroller
- (void)addSprite:(NSArray *)sprites
{
    NSMutableArray *object = [[NSMutableArray alloc] init];
    num_of_sprite = (int)[sprites count];
    self.size = CGSizeMake(self.size.width * ([sprites count] + 3), self.size.height);
    SKSpriteNode *back = [SKSpriteNode spriteNodeWithColor:_backgroundColor size:self.size];
    [self addChild:back];
    
    // Create the sprites in the order they arrived from the array
    for (int i = 0; i < [sprites count]; i++)
    {
        SKSpriteNode *page = [SKSpriteNode spriteNodeWithTexture:sprites[i]];
        page.size = CGSizeMake(page.size.width, self.frame.size.height);
        page.name = [NSString stringWithFormat:@"page%d", i];
        [object addObject:page];
        
        // Adjust the position of sprite by the scroll direction
        if (self.scrollDirection == HORIZONTAL)
        {
            page.position = CGPointMake((_theScene.frame.size.width / 2) + (_theScene.frame.size.width / 2 * i), -self.frame.size.height / 2 + page.frame.size.height / 2);
        }
        else
        {
            
        }
        
        SKAction *scaleBig = [SKAction scaleTo:1 duration:0.5];
        scaleBig.timingMode = SKActionTimingEaseIn;
        SKAction *scaleSmall = [SKAction scaleTo:0.5 duration:0.5];
        scaleSmall.timingMode = SKActionTimingEaseIn;
        
        if (i == 0)
        {
            [page runAction:scaleBig];
        }
        else
        {
            [page runAction:scaleSmall];
        }
        
        [self addChild:page];
    }
    
    nodes = object;
    
    if (self.scrollDirection == HORIZONTAL)
    {
        self.position = CGPointMake(0, _theScene.frame.size.height / 2);
    }
    else
    {
        self.position = CGPointMake(self.frame.size.width / 2, 0);
    }
    
    _currentChar = 0;
    [_theScene addChild:self];
    
}

- (void)swipeLeft
{
    if (_currentChar == num_of_sprite - 1)
    {
        [self reset];
        return;
    }
    SKAction *scaleBig = [SKAction scaleTo:1 duration:0.5];
    scaleBig.timingMode = SKActionTimingEaseIn;
    SKAction *scaleSmall = [SKAction scaleTo:0.5 duration:0.5];
    scaleSmall.timingMode = SKActionTimingEaseIn;

    SKAction *moveX = [SKAction moveToX:-((_currentChar + 1) * _theScene.frame.size.width / 2) duration:0.5];
    moveX.timingMode = SKActionTimingEaseIn;
    [self runAction:moveX];
    _currentChar++;
    
    if (_currentChar == 0)
    {
        SKSpriteNode *nd = [nodes objectAtIndex:_currentChar + 1];
        [nd runAction:scaleSmall];
    }
    else if (_currentChar == num_of_sprite - 1)
    {
        SKSpriteNode *nd = [nodes objectAtIndex:_currentChar - 1];
        [nd runAction:scaleSmall];
    }
    else
    {
        SKSpriteNode *nd1 = [nodes objectAtIndex:_currentChar - 1];
        SKSpriteNode *nd2 = [nodes objectAtIndex:_currentChar + 1];
        [nd1 runAction:scaleSmall];
        [nd2 runAction:scaleSmall];
    }
    SKSpriteNode *nd = [nodes objectAtIndex:_currentChar];
    [nd runAction:scaleBig];
    
}

- (void)swipeRight
{
    if (_currentChar == 0)
    {
        [self reset];
        return;
    }
    
    SKAction *scaleBig = [SKAction scaleTo:1 duration:0.5];
    scaleBig.timingMode = SKActionTimingEaseIn;
    SKAction *scaleSmall = [SKAction scaleTo:0.5 duration:0.5];
    scaleSmall.timingMode = SKActionTimingEaseIn;
    
    _currentChar--;
    SKAction *moveX = [SKAction moveToX:-((_currentChar) * _theScene.frame.size.width / 2) duration:0.5];
    [self runAction:moveX];
    
    if (_currentChar == 0)
    {
        SKSpriteNode *nd = [nodes objectAtIndex:_currentChar + 1];
        [nd runAction:scaleSmall];
    }
    else if (_currentChar == num_of_sprite - 1)
    {
        SKSpriteNode *nd = [nodes objectAtIndex:_currentChar - 1];
        [nd runAction:scaleSmall];
    }
    else
    {
        SKSpriteNode *nd1 = [nodes objectAtIndex:_currentChar - 1];
        SKSpriteNode *nd2 = [nodes objectAtIndex:_currentChar + 1];
        [nd1 runAction:scaleSmall];
        [nd2 runAction:scaleSmall];
    }
    SKSpriteNode *nd = [nodes objectAtIndex:_currentChar];
    [nd runAction:scaleBig];
}

- (void)swipeUp
{
    
}

- (void)swipeDown
{
    
}

- (void)reset
{
    if (self.scrollDirection == HORIZONTAL)
    {
        SKAction *move;
        move.timingMode = SKActionTimingEaseIn;
        if (_currentChar == num_of_sprite - 1)
        {
            move = [SKAction moveToX:-((_currentChar) * _theScene.frame.size.width / 2) duration:0.5];
        }
        else if (_currentChar == 0)
        {
            move = [SKAction moveToX:-((_currentChar) * _theScene.frame.size.width / 2) duration:0.5];
        }
        [self runAction:move];
    }
    else
    {
        
    }
}

@end
