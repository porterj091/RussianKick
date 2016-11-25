//
//  GameViewController.m
//  Russian Kick
//
//  Created by Joseph Porter on 7/1/15.
//  Copyright (c) 2015 Joseph Porter. All rights reserved.
//

#import "GameViewController.h"
#import "JBPTitleScene.h"
#import "JBPGameData.h"

@interface GameViewController() <ADInterstitialAdDelegate>

@property (nonatomic, strong) ADInterstitialAd *interstitial;
//@property BOOL requestingAd;

@end


@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self AuthenticateUser];


    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    //============ Noise =============
    NSString *path = [NSString stringWithFormat:@"%@/BackGroundNoise1.mp3", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    backGroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    backGroundMusic.numberOfLoops = -1;
    backGroundMusic.volume = 0.1;
    [backGroundMusic play];

    path = [NSString stringWithFormat:@"%@/ButtonNoise.mp3", [[NSBundle mainBundle] resourcePath]];
    soundUrl = [NSURL fileURLWithPath:path];
    _playerHolder = [[NSMutableArray alloc] init];
    _noise1Holder = [[NSMutableArray alloc] init];
    _noise2Holder = [[NSMutableArray alloc] init];
    int maxNumberOfBuffers = 10;
    
    for (int i = 0; i < maxNumberOfBuffers; i++)
    {
        AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
        [_playerHolder addObject:audioPlayer];
    }
    
    
    path = [NSString stringWithFormat:@"%@/BackNoise.mp3", [[NSBundle mainBundle] resourcePath]];
    soundUrl = [NSURL fileURLWithPath:path];
    backNoise = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    path = [NSString stringWithFormat:@"%@/GameoverNoise.mp3", [[NSBundle mainBundle] resourcePath]];
    soundUrl = [NSURL fileURLWithPath:path];
    gameoverNoise = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    gameoverNoise.volume = 0.1;
    
    
    // Create and configure the scene.
    JBPTitleScene *scene = [[JBPTitleScene alloc] initWithSize:self.view.frame.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;

    // Present the scene.
    [skView presentScene:scene];
    
#pragma mark Notification Declarations
    // Notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"hideBannerAd" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"showBannerAd" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"hideMediumAd" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:@"showMediumAd" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestFullAd) name:@"showFullAd" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveHighScore:) name:@"saveScore" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLeaderboard) name:@"showLeaderboard" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AuthenticateUser) name:@"authenticateUser" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handelMusicandNoises:) name:@"turnMusicOff" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handelMusicandNoises:) name:@"turnMusicOn" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handelMusicandNoises:) name:@"turnNoiseOff" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handelMusicandNoises:) name:@"turnNoiseOn" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handelMusicandNoises:) name:@"buttonNoise" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handelMusicandNoises:) name:@"backNoise" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handelMusicandNoises:) name:@"appClose" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handelMusicandNoises:) name:@"appOpen" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharingHandler:) name:@"twitter" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sharingHandler:) name:@"facebook" object:nil];
    
    
    topBanner = [[ADBannerView alloc] initWithFrame:CGRectZero];
    topBanner.delegate = self;
    topBanner.alpha = 0;
    [self.view addSubview:topBanner];
    
    _interstitial = [[ADInterstitialAd alloc] init];
    _interstitial.delegate = self;
}

#pragma mark - Noise and Music handlers
- (void)handelMusicandNoises:(NSNotification *)note
{
    if ([note.name isEqualToString:@"turnMusicOff"])
    {
        [JBPGameData data].musicAllowed = NO;
        backGroundMusic.volume = 0.0;
        [backGroundMusic stop];
    }
    else if ([note.name isEqualToString:@"turnMusicOn"])
    {
        [JBPGameData data].musicAllowed = YES;
        backGroundMusic.currentTime = 0;
        [backGroundMusic prepareToPlay];
        [backGroundMusic play];
        backGroundMusic.volume = 0.1;
    }
    else if ([note.name isEqualToString:@"appClose"])
    {
        [[JBPGameData data] save];
        backGroundMusic.volume = 0.0;
        [backGroundMusic stop];
    }
    else if ([note.name isEqualToString:@"appOpen"])
    {
        if ([JBPGameData data].musicAllowed)
        {
            backGroundMusic.currentTime = 0;
            [backGroundMusic prepareToPlay];
            [backGroundMusic play];
            backGroundMusic.volume = 0.1;
        }
    }
    else if ([note.name isEqualToString:@"turnNoiseOff"])
    {
        [JBPGameData data].noiseAllowed = NO;
    }
    else if ([note.name isEqualToString:@"turnNoiseOn"])
    {
        [JBPGameData data].noiseAllowed = YES;
    }
    else if ([note.name isEqualToString:@"buttonNoise"])
    {
        if ([JBPGameData data].noiseAllowed)
        {
            for (int i=0; i<_playerHolder.count; i++)
            {
                if (![[_playerHolder objectAtIndex:i] isPlaying])
                {
                    AVAudioPlayer *freePlayer = [_playerHolder objectAtIndex:i];
                    [freePlayer play];
                    break;
                }
            }
        }

    }
    else if ([note.name isEqualToString:@"backNoise"])
    {
        if ([JBPGameData data].noiseAllowed)
        {
            [backNoise play];
        }
        
    }
    
}

#pragma mark - iAd implementation

#pragma mark Interstitial Ads
- (void)requestFullAd
{
    if (_interstitial.loaded)
    {
        NSLog(@"Loaded Interstitial Ad");
        [_interstitial presentFromViewController:self];
    }
    else
    {
        NSLog(@"Interstitial Ad did not load");
    }
}

/*- (void)handleFullScreenAd:(NSNotification *)notification
{
    if ([notification.name isEqualToString:@"showFullAd"])
    {
        if (_requestingAd == NO)
        {
            _interstitial = [[ADInterstitialAd alloc] init];
            _interstitial.delegate = self;
            self.interstitialPresentationPolicy = ADInterstitialPresentationPolicyManual;
            [self requestInterstitialAdPresentation];
            NSLog(@"interstitialAdRequest");
            _requestingAd = YES;
        }
    }
    
}
 */

- (void)interstitialAd:(ADInterstitialAd *)interstitialAd didFailWithError:(NSError *)error
{
    _interstitial = nil;
    interstitialAd = nil;
    NSLog(@"interstitialAdError%@", error);
}

/*- (void)interstitialAdDidLoad:(ADInterstitialAd *)interstitialAd
{
    NSLog(@"interstitialAdDidLoad");
    if (_interstitial != nil && interstitialAd != nil && _requestingAd == YES)
    {
        [self requestInterstitialAdPresentation];
        NSLog(@"interstitialAdDidPresent");
    }
}
 */

- (void)interstitialAdDidUnload:(ADInterstitialAd *)interstitialAd
{
    _interstitial = nil;
    interstitialAd = nil;
    NSLog(@"interstitialAdDidUNLOAD");
}
 - (void)interstitialAdActionDidFinish:(ADInterstitialAd *)interstitialAd
 {
     _interstitial = nil;
     interstitialAd = nil;
     NSLog(@"interstitialAdDidFINISH");
 }

#pragma mark Banner Ads
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    NSLog(@"loaded Banner");
    [UIView animateWithDuration:0.5 animations:^{
        banner.alpha = 0.0;
        topBanner.alpha = 0.0;
    }];
    
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    SKView *skView = (SKView *)self.view;
    skView.paused = NO;
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner
               willLeaveApplication:(BOOL)willLeave
{
    SKView *skView = (SKView *)self.view;
    skView.paused = YES;
    return YES;
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    NSLog(@"Failed Ad");
    [UIView animateWithDuration:0.5 animations:^{
        banner.alpha = 0.0;
        topBanner.alpha = 0.0;
    }];
}

- (void)handleNotification:(NSNotification *)notification
{
    if ([notification.name isEqualToString:@"hideBannerAd"])
    {
        [self hidesBanner];
    }
    else if ([notification.name isEqualToString:@"showBannerAd"])
    {
        [self showsBanner];
    }
    else if ([notification.name isEqualToString:@"hideMediumAd"])
    {
        [mediumBanner setAlpha:0];
    }
    else if ([notification.name isEqualToString:@"showMediumAd"])
    {
        if (mediumBanner.isBannerLoaded)
        {
            [mediumBanner setAlpha:1];
        }
    }
}

- (void)hidesBanner
{
    [topBanner setAlpha:0];
}

- (void)showsBanner
{
    if (topBanner.isBannerLoaded)
    {
        [topBanner setAlpha:1];
    }
    else
    {
        NSLog(@"Banner did not Show");
    }
    
}

#pragma mark - Game Center Functions

- (void)AuthenticateUser
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    //Block is called each time GameKit automatically authenticates
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error)
    {
        if (viewController != nil)
        {
            NSLog(@"Authenticated the User");
            [self presentViewController:viewController animated:YES completion:nil];
        }
        
        NSLog(@"Error:%@", error);
    };
}

- (void)showLeaderboard
{
    GKGameCenterViewController *leaderboard = [[GKGameCenterViewController alloc] init];
    
    if ([GKLocalPlayer localPlayer].authenticated)
    {
        leaderboard.gameCenterDelegate = self;
        leaderboard.viewState = GKGameCenterViewControllerStateLeaderboards;
        leaderboard.leaderboardIdentifier = @"RussianKick_Leaderboard01";
        [self presentViewController:leaderboard animated:YES completion:nil];
    }
}

- (void)saveHighScore:(NSNotification *)notification
{
    if ([GKLocalPlayer localPlayer].authenticated)
    {
        GKScore *scoreReporter = [[GKScore alloc] initWithLeaderboardIdentifier:@"RussianKick_Leaderboard01"];
        NSNumber *thescore = [notification.userInfo objectForKey:@"HIGHSCORE"];
        int score = [thescore intValue];
        scoreReporter.value = score;
        scoreReporter.context = 0;
        
        NSArray *scores = @[scoreReporter];
        [GKScore reportScores:scores withCompletionHandler:^(NSError *error) {
        }];
        NSLog(@"Saved Score:%d", score);
    }
}

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Sharing functions
- (void)sharingHandler:(NSNotification *)note
{
    if ([note.name isEqualToString:@"twitter"])
    {
        [self shareTweet];
    }
    else if ([note.name isEqualToString:@"facebook"])
    {
        [self shareFacebook];
    }
}

- (void)shareTweet
{
    SLComposeViewController *tweetSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:
                                           SLServiceTypeTwitter];
    
    JBPGameData *data = [[JBPGameData alloc] init];
    [data loadData];
    
    // Sets the completion handler.  Note that we don't know which thread the
    // block will be called on, so we need to ensure that any required UI
    // updates occur on the main queue
    tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
        switch(result) {
                //  This means the user cancelled without sending the Tweet
            case SLComposeViewControllerResultCancelled:
                break;
                //  This means the user hit 'Send'
            case SLComposeViewControllerResultDone:
                break;
        }
    };
    
    //  Set the initial body of the Tweet
    [tweetSheet setInitialText:[NSString stringWithFormat:@"I just kicked my way to %d points in #RussianKick! Try to beat my score!!! #SpadoGames", data.playerScore]];
    
    //  Adds an image to the Tweet.  Image named image.png
    if (![tweetSheet addImage:[UIImage imageNamed:@"Icon.png"]]) {
        NSLog(@"Error: Unable to add image");
    }
    
    //  Add an URL to the Tweet.  You can add multiple URLs.
    if (![tweetSheet addURL:[NSURL URLWithString:@"https://twitter.com/RussianKickReal"]]){
        NSLog(@"Error: Unable to URL");
    }
    UIViewController *controller = self.view.window.rootViewController;
    [controller presentViewController:tweetSheet animated: YES completion:nil];
}

- (void)shareFacebook
{
    SLComposeViewController *facebookSheet = [SLComposeViewController
                                           composeViewControllerForServiceType:
                                           SLServiceTypeFacebook];
    
    JBPGameData *data = [[JBPGameData alloc] init];
    [data loadData];
    
    // Sets the completion handler.  Note that we don't know which thread the
    // block will be called on, so we need to ensure that any required UI
    // updates occur on the main queue
    facebookSheet.completionHandler = ^(SLComposeViewControllerResult result) {
        switch(result) {
                //  This means the user cancelled without sending the Tweet
            case SLComposeViewControllerResultCancelled:
                break;
                //  This means the user hit 'Send'
            case SLComposeViewControllerResultDone:
                break;
        }
    };
    
    //  Set the initial body of the Tweet
    [facebookSheet setInitialText:[NSString stringWithFormat:@"I just kicked my way to %d points in Russian Kick! Try to beat my score!!!", data.playerScore]];
    
    //  Adds an image to the Tweet.  Image named image.png
    if (![facebookSheet addImage:[UIImage imageNamed:@"Icon.png"]]) {
        NSLog(@"Error: Unable to add image");
    }
    
    //  Add an URL to the Tweet.  You can add multiple URLs.
    if (![facebookSheet addURL:[NSURL URLWithString:@"https://www.facebook.com/RussianKick"]]){
        NSLog(@"Error: Unable to URL");
    }
    UIViewController *controller = self.view.window.rootViewController;
    [controller presentViewController:facebookSheet animated: YES completion:nil];
}


#pragma mark - Micellenious functions
- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
