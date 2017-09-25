//
//  ImageViewController.m
//  carReader
//
//  Created by ipad_kid on 9/23/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "ImageViewController.h"

@implementation ImageViewController

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

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
