//
//  SSTrackViewController.h
//  ShowStud
//
//  Created by Amanda Canyon on 6/14/14.
//  Copyright (c) 2014 Amanda Canyon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AVFoundation/AVAudioPlayer.h>

@interface SSTrackViewController : UIViewController

@property (nonatomic, strong) NSArray *tracks;
@property (nonatomic, strong) AVAudioPlayer *player;

@property (weak, nonatomic) IBOutlet UIImageView *album_artwork;

@property (weak, nonatomic) IBOutlet UILabel *track_name;

@property (weak, nonatomic) IBOutlet UILabel *artist_name;

@end
