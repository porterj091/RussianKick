//
//  JBPTextureScores.m
//  Russian Kick
//
//  Created by Joseph Porter on 7/23/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import "JBPTextureScores.h"

@interface JBPTextureScores()


@property (nonatomic) SKScene *mainScene;
@property double NumberSpacing;

@end

@implementation JBPTextureScores



- (void)initNewNumberTextures:(SKScene *)whichScene startingPoint:(CGPoint)location startingSize:(CGSize)setSize startingScore:(int)startScore name:(NSString *)startname fileName:(NSString *)numberFile
{
    
    // Sets the properties that the class needs to create the scoring system
    _mainScene = whichScene;
    _requiredSize = setSize;
    _setLocation = location;
    _NumberSpacing = setSize.width;
    _setName = startname;
    _fileName = numberFile;
    
    if (!_numberTextures)
    {
        [self createTextureArray];
    }
    

    
    
    // Will update the score to the starting score
    [self updateNumber:startScore];
}

- (void)updateNumber:(int)newNumber
{
    NSString *number = [NSString stringWithFormat:@"%d", newNumber];
    int sides;
    double val1;
    
    // Delete the previous digits so they don't everlap
    [_mainScene enumerateChildNodesWithName:_setName usingBlock:^(SKNode *node, BOOL *stop) {
        [node removeFromParent];
    }];
    
    switch ([number length])
    {
        // One digit
        case 1:
        {
            int num = [number intValue];
            SKSpriteNode *theDigit = [SKSpriteNode spriteNodeWithTexture:[_numberTextures objectAtIndex:num]];
            theDigit.position = _setLocation;
            theDigit.name = _setName;
            theDigit.size = _requiredSize;
            [_mainScene addChild:theDigit];
            break;
        }
           
        // Two digits
        case 2:
        {
            for (int i = 0; i < [number length]; i++)
            {
                sides = (i != 0) ? 1 : -1;
                NSString *digit = [number substringWithRange:NSMakeRange(i, 1)];
                SKSpriteNode *newDigit = [SKSpriteNode spriteNodeWithTexture:[_numberTextures objectAtIndex:[digit intValue]]];
                newDigit.name = _setName;
                newDigit.size = _requiredSize;
                if ([digit intValue] == 1)
                {
                    val1 = numberOneSmallerGap;
                }
                else
                {
                    val1 = 0;
                }
                
                newDigit.position = CGPointMake(_setLocation.x + (_NumberSpacing - val1 - (_requiredSize.width / 3)) * sides, _setLocation.y);
                [_mainScene addChild:newDigit];
            }
            
            break;
            
        }
           
        // Three digits
        case 3:
        {
            for (int i = 0; i < [number length]; i++)
            {
                if (i == 0)
                    sides = -1;
                else if (i == 1)
                    sides = 0;
                else
                    sides = 1;
                
                NSString *digit = [number substringWithRange:NSMakeRange(i, 1)];
                SKSpriteNode *newDigit = [SKSpriteNode spriteNodeWithTexture:[_numberTextures objectAtIndex:[digit intValue]]];
                newDigit.name = _setName;
                newDigit.size = _requiredSize;
                if ([digit intValue] == 1)
                {
                    val1 = numberOneSmallerGap;
                }
                else
                {
                    val1 = 0;
                }
                
                newDigit.position = CGPointMake(_setLocation.x + ((_NumberSpacing - val1) * sides), _setLocation.y);
                [_mainScene addChild:newDigit];
            
            }
            
            break;
        }
        
        // Four digits
        case 4:
        {
            double additionalSpacing = 0;
            for (int i = 0; i < [number length]; i++)
            {
                if (i == 0)
                    sides = -2;
                else if (i == 1)
                {
                    sides =  -1;
                    additionalSpacing = 5;
                }
                else if (i == 2)
                {
                    sides = 1;
                    additionalSpacing = -5;
                }
                else
                    sides = 2;
                
                NSString *digit = [number substringWithRange:NSMakeRange(i, 1)];
                SKSpriteNode *newDigit = [SKSpriteNode spriteNodeWithTexture:[_numberTextures objectAtIndex:[digit intValue]]];
                newDigit.name = _setName;
                newDigit.size = _requiredSize;
                if ([digit intValue] == 1)
                {
                    val1 = numberOneSmallerGap;
                }
                else
                {
                    val1 = 0;
                }
                
                newDigit.position = CGPointMake(_setLocation.x + ((_NumberSpacing - val1 - (_requiredSize.width / 3)) * sides) + additionalSpacing, _setLocation.y);
                [_mainScene addChild:newDigit];
                additionalSpacing = 0;
                
            }
            
            break;
        }
            
            default:
        {
            [self updateNumber:9999];
            break;
        }
            
    }
}


// Creates all of the textures that this class uses to represent the numbers
// will be used within the initilizer to present the scene with the correct image
- (void)createTextureArray
{
    NSMutableArray *startingNumberTextures = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 10; i++)
    {
        SKTexture *fileTexture = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@_%d.png", _fileName, i]];
        [startingNumberTextures insertObject:fileTexture atIndex:i];
    }

    _numberTextures = [NSArray arrayWithArray:startingNumberTextures];
}

@end
