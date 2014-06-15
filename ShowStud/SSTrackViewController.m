//
//  SSTrackViewController.m
//  ShowStud
//
//  Created by Amanda Canyon on 6/14/14.
//  Copyright (c) 2014 Amanda Canyon. All rights reserved.
//

#import "SSTrackViewController.h"

#import "SCUI.h"

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
        
        // NOTE -- some urls arent streamable:
        //    http://vidz-lab.biz/user61/2014/05/08/soundcloud-api-stream_urls-sole-artist-operative-anymore-404/
        [SCRequest performMethod:SCRequestMethodGET
                      onResource:[NSURL URLWithString:(streamURL)]
                 usingParameters:nil
                     withAccount:account
          sendingProgressHandler:nil
                 responseHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                     NSLog(@"%@", error);
                     NSError *playerError;
                     self.player = [[AVAudioPlayer alloc] initWithData:data error:&playerError];
                     [self.player prepareToPlay];
                     [self.player play];
                     
                     NSLog(@"Playing track");
                     
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
