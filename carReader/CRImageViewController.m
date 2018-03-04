//
//  CRImageViewController.m
//  carReader
//
//  Created by ipad_kid on 9/23/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "CRImageViewController.h"
#import "UIView+layout.h"

@implementation CRImageViewController {
    UIActivityViewController *activityView;
    UIImage *showingImage;
    UIScrollView *scrollView;
}

- (void)updateConstraints {
    scrollView.contentSize = showingImage.size;
    
    UIView *imageVCView = self.view;
    CGSize imageViewSize = imageVCView.frame.size;
    
    CGFloat imageWidth = showingImage.size.width;
    CGFloat imageHeight = showingImage.size.height;
    CGFloat scrollWidth = MIN(imageWidth, imageViewSize.width);
    CGFloat scrollHeight = MIN(imageHeight, imageViewSize.height);
    self.automaticallyAdjustsScrollViewInsets = (scrollHeight != imageHeight);
    
    [scrollView removeConstraints:scrollView.constraints];
    [imageVCView removeConstraints:scrollView.constraints];
    
    [scrollView addLayoutConstraint:NSLayoutAttributeWidth offset:scrollWidth];
    [scrollView addLayoutConstraint:NSLayoutAttributeHeight offset:scrollHeight];
    [imageVCView addLayoutConstraint:NSLayoutAttributeCenterX toItem:scrollView offset:0];
    [imageVCView addLayoutConstraint:NSLayoutAttributeCenterY toItem:scrollView offset:0];
}

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [self init]) {
        activityView = [[UIActivityViewController alloc] initWithActivityItems:@[UIImagePNGRepresentation(image)] applicationActivities:NULL];
        showingImage = image;
        
        UIView *imageVCView = self.view;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        
        scrollView = UIScrollView.new;
        scrollView.scrollsToTop = NO;
        [scrollView addSubview:imageView];
        [imageVCView addSubview:scrollView];
        
        scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self updateConstraints];
        
        SEL flipBackgroundAction = @selector(flipBackground);
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Invert background" style:UIBarButtonItemStylePlain target:self action:flipBackgroundAction];
        
        [imageVCView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(shareImage:)]];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:flipBackgroundAction];
        doubleTap.numberOfTapsRequired = 2;
        [imageVCView addGestureRecognizer:doubleTap];
        
        self.view.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self updateConstraints];
    });
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
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        [self presentViewController:activityView animated:YES completion:nil];
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
