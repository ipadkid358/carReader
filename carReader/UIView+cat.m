//
//  UIView+cat.m
//  carReader
//
//  Created by ipad_kid on 9/23/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "UIView+cat.h"

@implementation UIView (BlackJacket)

- (void)addLayoutConstraint:(NSLayoutAttribute)attribute toItem:(id)item offset:(CGFloat)offset {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:item attribute:attribute relatedBy:NSLayoutRelationEqual toItem:self attribute:attribute multiplier:1 constant:offset]];
}

- (void)addLayoutConstraint:(NSLayoutAttribute)lengthAttribute offset:(CGFloat)offset {
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:lengthAttribute relatedBy:NSLayoutRelationEqual toItem:NULL attribute:lengthAttribute multiplier:1 constant:offset]];
}

@end
