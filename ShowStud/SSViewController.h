//
//  SSViewController.h
//  ShowStud
//
//  Created by Amanda Canyon on 6/14/14.
//  Copyright (c) 2014 Amanda Canyon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVAudioPlayer.h>

@interface SSViewController : UIViewController

@property (nonatomic, strong) AVAudioPlayer *player;

- (IBAction)logIn:(id)sender;
- (IBAction)playTrack:(id)sender;

@end
