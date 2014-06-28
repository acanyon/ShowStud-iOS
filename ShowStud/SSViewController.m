//
//  SSViewController.m
//  ShowStud
//
//  Created by Amanda Canyon on 6/14/14.
//  Copyright (c) 2014 Amanda Canyon. All rights reserved.
//

#import "SSViewController.h"

#import "SSTrackViewController.h"
#import "SCUI.h"

@interface SSViewController ()

@end

@implementation SSViewController

- (void)viewDidLoad
{
    UIImage *background = [UIImage imageNamed: @"concert_hands_yellow.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: background];
    [self.view insertSubview: imageView atIndex:0];
    
    NSLog(@"Should have set the bg img");
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logIn:(id)sender
{
    SCLoginViewControllerCompletionHandler handler = ^(NSError *error) {
        if (SC_CANCELED(error)) {
            NSLog(@"Canceled!");
        } else if (error) {
            NSLog(@"Error: %@", [error localizedDescription]);
        } else {
            NSLog(@"Done!");
        }
    };
    
    [SCSoundCloud requestAccessWithPreparedAuthorizationURLHandler:^(NSURL *preparedURL) {
        SCLoginViewController *loginViewController;
        
        loginViewController = [SCLoginViewController
                               loginViewControllerWithPreparedURL:preparedURL
                               completionHandler:handler];
        [self presentModalViewController:loginViewController animated:YES];
    }];
}

- (IBAction)playTrack:(id)sender {
    SCAccount *account = [SCSoundCloud account];
    
    SCRequestResponseHandler handler;
    handler = ^(NSURLResponse *response, NSData *data, NSError *error) {
        NSError *jsonError = nil;
        NSJSONSerialization *jsonResponse = [NSJSONSerialization
                                             JSONObjectWithData:data
                                             options:0
                                             error:&jsonError];
        if (!jsonError && [jsonResponse isKindOfClass:[NSArray class]]) {
            SSTrackViewController *trackVC = (SSTrackViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"trackView"];
            trackVC.tracks = (NSArray *)jsonResponse;
            [trackVC setModalPresentationStyle:UIModalPresentationFormSheet];
            [self presentViewController:trackVC animated:YES completion:NULL];
        }
    };

    [SCRequest performMethod:SCRequestMethodGET
                  onResource:[NSURL URLWithString:@"https://api.soundcloud.com/users/3994791/tracks.json"]
             usingParameters:nil
                 withAccount:account
      sendingProgressHandler:nil
             responseHandler:handler];
    


}
@end
