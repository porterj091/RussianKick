//
//  JBPGameData.m
//  Russian Kick
//
//  Created by Joseph Porter on 7/20/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import "JBPGameData.h"

@interface JBPGameData()

@property NSString *filePath;

@end

@implementation JBPGameData

+(instancetype)data
{
    // sharedInstance will contain all saved game data
    static id sharedInstance = nil;
    
    if (sharedInstance == nil)
    {
        sharedInstance = [[JBPGameData alloc] init];
        [sharedInstance loadData];
        [sharedInstance save];
    }
    
    return sharedInstance;
}

- (void)save
{
    // Record all other variables in standard User Defaults
    [[NSUserDefaults standardUserDefaults] setInteger:_highScore forKey:@"HIGHSCORE"];
    [[NSUserDefaults standardUserDefaults] setInteger:_playerScore forKey:@"PLAYERSCORE"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:_currentPlayer] forKey:@"CURRENTPLAYER"];
    [[NSUserDefaults standardUserDefaults] setInteger:_coinCount forKey:@"COINCOUNT"];
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
    // Place every character's info into UserDefaults
    for (int i = 0; i < [_unlockedCharacters count]; i++)
    {
        [[NSUserDefaults standardUserDefaults] setObject:[_unlockedCharacters objectAtIndex:i] forKey:[NSString stringWithFormat:@"UNLOCKEDCHARACTERS%d", i]];
    }
    
}

- (void)loadData
{
    // On first load noise and music will be allowed, can be changed later
    _noiseAllowed = YES;
    _musicAllowed = YES;
    
    
    // All other saved objects will be loaded here
    _highScore = (int)[[[NSUserDefaults standardUserDefaults] objectForKey:@"HIGHSCORE"] integerValue];
    _playerScore = (int)[[[NSUserDefaults standardUserDefaults] objectForKey:@"PLAYERSCORE"] integerValue];
    _currentPlayer = [[[NSUserDefaults standardUserDefaults] objectForKey:@"CURRENTPLAYER"] integerValue];
    _coinCount = (int)[[[NSUserDefaults standardUserDefaults] objectForKey:@"COINCOUNT"] integerValue];
    
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
    // Load if characters are locked or unlocked
    NSMutableArray *characterSystem = [[NSMutableArray alloc] initWithCapacity:NumberOfCharacters];
    for (int i = 0; i < NumberOfCharacters; i++)
    {
        @try {
            [characterSystem insertObject:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"UNLOCKEDCHARACTERS%d", i]] atIndex:i];
        }
        @catch (NSException *exception) {
            break;
        }
    }
    _unlockedCharacters = [NSArray arrayWithArray:characterSystem];
    
    // If this is first time set unlockedcharacters to default
    if ([_unlockedCharacters count] == 0)
    {
        NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:NumberOfCharacters];
        [temp addObject:@"Unlocked"];
        for (int i = 1; i < 10; i++)
        {
            [temp addObject:@"Locked"];
        }
        
        _unlockedCharacters = [NSArray arrayWithArray:temp];
    }
}

- (void)resetCoin
{
    _coinCount = 0;
}

- (void)DEBUGCOIN
{
    _coinCount = 9999;
}

- (void)UnlockChars
{
    
}

@end
