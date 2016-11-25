//
//  GameViewController.h
//  Russian Kick
//

//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <iAd/iAd.h>
#import <AVFoundation/AVFoundation.h>
#import <GameKit/GameKit.h>
#import <Social/Social.h>
#import "JBPGameData.h"

@interface GameViewController : UIViewController <ADBannerViewDelegate, GKGameCenterControllerDelegate>
{
    ADBannerView *topBanner;
    ADBannerView *mediumBanner;
    AVAudioPlayer *backGroundMusic;
    AVAudioPlayer *backNoise;
    AVAudioPlayer *gameoverNoise;

    BOOL bannerIsVisible;
}

@property (nonatomic, strong) NSMutableArray *playerHolder;
@property (nonatomic, strong) NSMutableArray *noise1Holder;
@property (nonatomic, strong) NSMutableArray *noise2Holder;


- (void)showsBanner;
- (void)hidesBanner;

@end
