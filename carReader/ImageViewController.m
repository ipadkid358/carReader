//
//  ImageViewController.m
//  carReader
//
//  Created by ipad_kid on 9/23/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "ImageViewController.h"
#import "UIView+cat.h"

@implementation ImageViewController {
    UIActivityViewController *activityView;
}

- (instancetype)initWithImage:(UIImage *)image {
    ImageViewController *newViewController = [self init];
    activityView = [[UIActivityViewController alloc] initWithActivityItems:@[UIImagePNGRepresentation(image)] applicationActivities:NULL];
    UIView *imageVCView = newViewController.view;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    UIScrollView *scrollView = UIScrollView.new;
    scrollView.contentSize = image.size;
    scrollView.scrollsToTop = NO;
    [scrollView addSubview:imageView];
    [imageVCView addSubview:scrollView];
    
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat scrollWidth = MIN(imageWidth, imageVCView.frame.size.width);
    CGFloat scrollHeight = MIN(imageHeight, imageVCView.frame.size.height);
    newViewController.automaticallyAdjustsScrollViewInsets = (scrollHeight != imageHeight);
    
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [scrollView addLayoutConstraint:NSLayoutAttributeWidth offset:scrollWidth];
    [scrollView addLayoutConstraint:NSLayoutAttributeHeight offset:scrollHeight];
    [imageVCView addLayoutConstraint:NSLayoutAttributeCenterX toItem:scrollView offset:0];
    [imageVCView addLayoutConstraint:NSLayoutAttributeCenterY toItem:scrollView offset:0];
    
    UIBarButtonItem *invertButton = [[UIBarButtonItem alloc] init];
    invertButton.title = @"Invert background";
    invertButton.target = newViewController;
    invertButton.action = @selector(flipBackground);
    newViewController.navigationItem.rightBarButtonItem = invertButton;
    
    [imageVCView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:newViewController action:@selector(shareImage:)]];
    
    newViewController.view.backgroundColor = UIColor.whiteColor;
    return newViewController;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = [self.view.backgroundColor isEqual:UIColor.blackColor];
}

- (void)flipBackground {
    UIColor *white = UIColor.whiteColor;
    BOOL isWhite = [self.view.backgroundColor isEqual:white];
    self.navigationController.navigationBar.barStyle = isWhite;
    self.view.backgroundColor = isWhite ? UIColor.blackColor : white;
}

- (void)shareImage:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) [self presentViewController:activityView animated:YES completion:nil];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
