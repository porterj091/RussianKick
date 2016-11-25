//
//  JBPLabelScores.m
//  Russian Kick
//
//  Created by Joseph Porter on 7/20/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import "JBPLabelScores.h"

@implementation JBPLabelScores


+(id)pointsLabelWithFontNamed:(NSString *)fontName
{
    JBPLabelScores *labelScores = [JBPLabelScores labelNodeWithFontNamed:fontName];
    labelScores.text = @"0";
    labelScores.number = 0;
    return labelScores;
}

- (void)increment
{
    self.number++;
    self.text = [NSString stringWithFormat:@"%d", self.number];
}

- (void)decrement
{
    self.number--;
    self.text = [NSString stringWithFormat:@"%d", self.number];
}

- (void)reset
{
    self.number = 0;
    self.text = @"0";
}

- (void)setScore:(int)newScore
{
    self.number = newScore;
    self.text = [NSString stringWithFormat:@"%d", self.number];
}

@end
