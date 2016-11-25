//
//  JBPTextureScores.h
//  Russian Kick
//
//  Created by Joseph Porter on 7/23/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

//============== Number textures =============
// Number's file name must be "Number_(digit number).png"
// Will load based on first file name

// Additional class requirments
#define numberOneSmallerGap     3

@interface JBPTextureScores : NSObject

@property (nonatomic) CGSize requiredSize;
@property (nonatomic) CGPoint setLocation;
@property (nonatomic, strong) NSArray *numberTextures;
@property (nonatomic, strong) NSString *setName;
@property (nonatomic, strong) NSString *fileName;


// Must initilize this before setting the new number
- (void)initNewNumberTextures:(SKScene *)whichScene startingPoint:(CGPoint)location startingSize:(CGSize)setSize startingScore:(int)startScore name:(NSString *)startname fileName:(NSString *)numberFile;

// Use this to update the number
- (void)updateNumber:(int)newNumber;

@end
