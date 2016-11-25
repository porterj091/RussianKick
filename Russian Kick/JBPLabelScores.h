//
//  JBPLabelScores.h
//  Russian Kick
//
//  Created by Joseph Porter on 7/20/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface JBPLabelScores : SKLabelNode

@property (nonatomic) int number;

+(id)pointsLabelWithFontNamed:(NSString *)fontName;
- (void)increment;
- (void)decrement;
- (void)reset;
- (void)setScore:(int)newScore;


@end
