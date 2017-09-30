//
//  ImageViewController.m
//  carReader
//
//  Created by ipad_kid on 9/23/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "ImageViewController.h"

@implementation ImageViewController

- (instancetype)initWithImage:(UIImage *)image {
    ImageViewController *newViewController = [self init];
    newViewController.imageData = UIImagePNGRepresentation(image);
    return newViewController;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.view.backgroundColor isEqual:UIColor.whiteColor]) self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    else self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

- (void)flipBackground {
    UIColor *black = UIColor.blackColor;
    if ([self.view.backgroundColor isEqual:black]) {
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
        self.view.backgroundColor = UIColor.whiteColor;
    } else {
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        self.view.backgroundColor = black;
    }
}

- (void)shareImage:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[self.imageData] applicationActivities:NULL];
        [self presentViewController:activityView animated:YES completion:nil];
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
