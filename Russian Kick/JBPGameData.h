//
//  JBPGameData.h
//  Russian Kick
//
//  Created by Joseph Porter on 7/20/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import <Foundation/Foundation.h>


#define NumberOfCharacters          10

typedef enum
{
    Russian = 0,
    Scottish = 1,
    Mexican = 2,
    Japanese = 3,
    English = 4,
    French = 5,
    Viking = 6,
    General = 7,
    Australian = 8,
    Cowboy = 9
} CURRENTPLAYER;

@interface JBPGameData : NSObject

@property (assign, nonatomic) int highScore;
@property (assign, nonatomic) int playerScore;
@property (assign, nonatomic) CURRENTPLAYER currentPlayer;
@property (assign, nonatomic) int coinCount;
@property (assign, nonatomic) BOOL musicAllowed;
@property (assign, nonatomic) BOOL noiseAllowed;
@property (strong, nonatomic) NSArray* unlockedCharacters;



+ (instancetype)data;
- (void)save;
- (void)loadData;
- (void)resetCoin;

// Debug Code delete after user
- (void)DEBUGCOIN;
- (void)UnlockChars;

@end
