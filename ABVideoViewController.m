//
//  ABVideoViewController.m
//  Jeremy Footage
//
//  Created by HoodsDream on 10/21/14.
//  Copyright (c) 2014 Asteroid Blues. All rights reserved.
//

#import "ABVideoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ABCollectionViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >>16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float) (rgbValue & 0xFF))/255.0 alpha:1.0]


@interface ABVideoViewController ()

@property (strong, nonatomic) AVPlayer *avPlayer;
@property (strong, nonatomic) IBOutlet UIView *movieView;
@property (strong, nonatomic) IBOutlet UIView *gradientView;
@property (strong, nonatomic) IBOutlet UIView *contentView;


@end

@implementation ABVideoViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Not affecting background music playing
    NSError *sessionError = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&sessionError];
    [[AVAudioSession sharedInstance] setActive:YES error:&sessionError];
    
    //Set up player
    NSURL *movieURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"jeremy" ofType:@"mov"]];
    AVAsset *avAsset = [AVAsset assetWithURL:movieURL];
    AVPlayerItem *avPlayerItem =[[AVPlayerItem alloc]initWithAsset:avAsset];
    self.avPlayer = [[AVPlayer alloc]initWithPlayerItem:avPlayerItem];
    AVPlayerLayer *avPlayerLayer =[AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    [avPlayerLayer setBackgroundColor:(__bridge CGColorRef)([UIColor redColor])];
    [self.movieView.layer addSublayer:avPlayerLayer];
    [self.avPlayer play];
    

    
    //Config player
    [self.avPlayer seekToTime:kCMTimeZero];
    [self.avPlayer setVolume:0.0f];
    [self.avPlayer setActionAtItemEnd:AVPlayerActionAtItemEndNone];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[self.avPlayer currentItem]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerStartPlaying)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
    //Config dark gradient view
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = [[UIScreen mainScreen] bounds];
    [self.gradientView.layer insertSublayer:gradient atIndex:0];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.avPlayer pause];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.avPlayer play];
}


- (void)playerItemDidReachEnd:(NSNotification *)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
}

- (void)playerStartPlaying
{
    [self.avPlayer play];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)buttonPressed:(id)sender {
    ABCollectionViewController *viewController =[[ABCollectionViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}






















@end
