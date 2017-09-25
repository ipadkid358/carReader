//
//  ViewerViewController.h
//  carReader
//
//  Created by ipad_kid on 9/23/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewerViewController : UITableViewController
@property (strong, nonatomic) NSMutableDictionary<NSString *, UIImage *> *images;

+ (instancetype)viewerWithImages:(NSMutableDictionary<NSString *, UIImage *> *)images;

@end
