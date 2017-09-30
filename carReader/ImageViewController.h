//
//  ImageViewController.h
//  carReader
//
//  Created by ipad_kid on 9/23/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController
@property (strong, nonatomic) NSData *imageData;

- (instancetype)initWithImage:(UIImage *)image;
- (void)flipBackground;
- (void)shareImage:(UIGestureRecognizer *)gestureRecognizer;
@end
