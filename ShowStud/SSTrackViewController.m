//
//  SSTrackViewController.m
//  ShowStud
//
//  Created by Amanda Canyon on 6/14/14.
//  Copyright (c) 2014 Amanda Canyon. All rights reserved.
//

#import "SSTrackViewController.h"

#import "SCUI.h"
#import <AudioToolbox/AudioToolbox.h>

@interface SSTrackViewController ()

@end


@implementation SSTrackViewController

@synthesize tracks;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImage *background = [UIImage imageNamed: @"concert_hands_yellow.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
    imageView.alpha = 0.5;
    [self.view insertSubview: imageView atIndex:0];
    
    [self playTrack:0];
    
}

- (void)playTrack:(int)index
{
    
    if (index >= [self.tracks count] ) {
        NSLog(@"Finished playing!");
        return;
    }
    
    SCAccount *account = [SCSoundCloud account];
    
    NSDictionary *track = [self.tracks objectAtIndex:index];
    
    if ([track objectForKey:@"stream_url"]) {
        NSString *streamURL = [track objectForKey:@"stream_url"];
        NSLog(@"Attempting to play: %@", streamURL);
        NSLog(@"Link: %@", [track objectForKey:@"permalink_url"]);
        
        NSString *artwork_url = [track objectForKey:@"artwork_url"];
        NSLog(@"%@", artwork_url);
        [self.album_artwork setImage:[[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:artwork_url]]]];
        NSString *title = [track objectForKey:@"title"];
        [self.track_name setText:title];
        
        // NOTE -- some urls arent streamable:
        //    http://vidz-lab.biz/user61/2014/05/08/soundcloud-api-stream_urls-sole-artist-operative-anymore-404/
        [SCRequest performMethod:SCRequestMethodGET
                      onResource:[NSURL URLWithString:(streamURL)]
                 usingParameters:nil
                     withAccount:account
          sendingProgressHandler:nil
                 responseHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                     if(error){
                         NSLog(@"Errors: %@", error);
                     }
                     NSError *playerError;
                     self.player = [[AVAudioPlayer alloc] initWithData:data error:&playerError];
                     [self.player prepareToPlay];
                     [self.player play];
                     
                     
                     NSLog(@"Playing track");
                     
                     while ([self.player isPlaying]){}
                     
                     NSLog(@"Track Done");
                     
                     [self playTrack:(index + 1)];
                 }];
    } else {
        [self playTrack:(index + 1)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setThis:(NSArray *)somevar
{
    NSLog(@"Set!");
}

@end
