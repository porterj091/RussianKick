//
//  JBPCharacterScroller.h
//  Russian Kick
//
//  Created by Joseph Porter on 12/2/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "JBPGameData.h"

typedef enum
{
    HORIZONTAL,
    VERTICAL
} ScrollDirection;

@interface JBPCharacterScroller : SKSpriteNode

@property ScrollDirection scrollDirection;
@property CGSize contentSize;
@property CURRENTPLAYER currentChar;
@property (nonatomic, strong) SKScene *theScene;
@property (nonatomic, strong) UIColor *backgroundColor;

- (instancetype)initWithSize:(CGSize)size whichScene:(SKScene *)scene;

- (void)addSprite:(NSArray *)sprites;

- (void)swipeLeft;
- (void)swipeRight;
- (void)swipeUp;
- (void)swipeDown;
- (void)reset;

@end
