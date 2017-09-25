//
//  UIView+cat.h
//  carReader
//
//  Created by ipad_kid on 9/23/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BlackJacket)

// do not use for setting self constraints such as Width
- (void)addLayoutConstraint:(NSLayoutAttribute)attribute toItem:(id)item offset:(CGFloat)offset;

// should only be used for setting self constraints
- (void)addLayoutConstraint:(NSLayoutAttribute)lengthAttribute offset:(CGFloat)offset;

@end
