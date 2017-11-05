//
//  CRImageViewController.h
//  carReader
//
//  Created by ipad_kid on 9/23/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRImageViewController : UIViewController
- (instancetype)initWithImage:(UIImage *)image;
- (void)flipBackground;
- (void)shareImage:(UIGestureRecognizer *)gestureRecognizer;
@end
