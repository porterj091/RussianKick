//
//  JBPCharacterScene.m
//  Russian Kick
//
//  Created by Joseph Porter on 11/18/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import "JBPCharacterScene.h"
#import "JBPSpriteTexturesCache.h"
#import "JBPGameData.h"
#import "JBPCharacterScroller.h"
#import "JBPTitleScene.h"

@interface JBPCharacterScene ()
{
    CGPoint initialTouch;
    JBPCharacterScroller *scroll;
    
    // Buttons
    SKSpriteNode *back_Button;
    SKSpriteNode *select_Button;
}
@end

@implementation JBPCharacterScene

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
    //====== BackGround ============
    SKTexture *backgroundTexture = [SKTexture textureWithImageNamed:EndBackGroundFileName];
    SKSpriteNode *backgroundNode = [SKSpriteNode spriteNodeWithTexture:backgroundTexture];
    backgroundNode.size = self.size;
    backgroundNode.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    backgroundNode.zPosition = -1;
    [self addChild:backgroundNode];
    
    //============== Back Button ================
    SKSpriteNode *backButton = [SKSpriteNode spriteNodeWithImageNamed:BackButton_UnpressedFileName];
    backButton.name = @"backButtonNode";
    backButton.size = CGSizeMake(self.frame.size.height / 10, self.frame.size.height / 10);
    backButton.position = CGPointMake(CGRectGetMinX(self.frame) + backButton.frame.size.width / 2 + 5, CGRectGetMaxY(self.frame) - backButton.frame.size.height / 2 - 5);
    [self addChild:backButton];
    back_Button = backButton;
    
    //========== Select Button ================
    SKSpriteNode *selectButton = [SKSpriteNode spriteNodeWithImageNamed:StartButtonUnpressedFileName];
    selectButton.size = CGSizeMake(self.frame.size.width / 2, self.frame.size.height / 5);
    selectButton.position = CGPointMake(self.frame.size.width / 2, CGRectGetMinY(self.frame) + selectButton.frame.size.height / 2 + 25);
    [self addChild:selectButton];
    select_Button = selectButton;
    
    [self characterCreation];
    
}

- (void)characterCreation
{
    NSMutableArray *chars = [[NSMutableArray alloc] initWithCapacity:Num_Char];
    for (int i = 0; i < Num_Char; i++)
    {
        if ([[JBPGameData data].unlockedCharacters[1] isEqualToString:@"Locked"])
        {
            [chars addObject:[JBPSpriteTexturesCache sharedTextures].lockedChars[i]];
        }
        else
        {
            [chars addObject:[JBPSpriteTexturesCache sharedTextures].unlockedChars[i]];
        }
        
    }
    
    
    JBPCharacterScroller *scroller = [[JBPCharacterScroller alloc] initWithSize:CGSizeMake(self.frame.size.width, self.frame.size.height / 2) whichScene:self];
    scroller.scrollDirection = HORIZONTAL;
    scroller.backgroundColor = [SKColor purpleColor];
    [scroller addSprite:(NSArray *)chars];
    scroll = scroller;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    
    // Back Button
    if (CGRectContainsPoint(back_Button.frame, location))
    {
        SKTexture *f1 = [SKTexture textureWithImageNamed:BackButton_PressedFileName];
        [back_Button setTexture:f1];
        
    }
    // Select Button
    if (CGRectContainsPoint(select_Button.frame, location))
    {
        SKTexture *f1 = [SKTexture textureWithImageNamed:StartButtonPressedFileName];
        [select_Button setTexture:f1];
    }
    
    if (location.x < self.frame.size.width / 2 && CGRectContainsPoint(scroll.frame, location))
    {
        [scroll swipeRight];
    }
    else if (location.x > self.frame.size.width / 2 && CGRectContainsPoint(scroll.frame, location))
    {
        [scroll swipeLeft];
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        
        // Back Button
        if (CGRectContainsPoint(back_Button.frame, location))
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
            [back_Button setTexture:f1];
        }
        
        if (CGRectContainsPoint(select_Button.frame, location))
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonNoise" object:nil];
            [JBPGameData data].currentPlayer = scroll.currentChar;
            JBPTitleScene *titleScene = [[JBPTitleScene alloc] initWithSize:self.size];
            SKTransition *slideUp = [SKTransition moveInWithDirection:SKTransitionDirectionLeft duration:0.5];
            [self.view presentScene:titleScene transition:slideUp];
            [self removeAllActions];
            [self removeAllChildren];
        }
        else
        {
            SKTexture *f1 = [SKTexture textureWithImageNamed:StartButtonUnpressedFileName];
            [select_Button setTexture:f1];
        }
    }


}
@end
