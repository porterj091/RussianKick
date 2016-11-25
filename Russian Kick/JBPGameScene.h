//
//  JBPGameScene.h
//  Russian Kick
//
//  Created by Joseph Porter on 7/1/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <iAd/iAd.h>
#import "JBPTextureScores.h"
#import "GameViewController.h"

#define TopBufferZone           65
#define SideBufferZone          50

#define SliderBarHeight         50
#define SliderSpeed             40
#define SliderDividedBy         25

#define BumperStartingXMax      40
#define BumperDividedByBar      14

#define BumperSpeed             0.35

#define NumberBackGroundImages  5

@interface JBPGameScene : SKScene

@property (nonatomic, strong) JBPTextureScores *scoreDisplay;

@property int playerScore;
@property int highScore;


@end
