//
//  AppPickerController.h
//  carReader
//
//  Created by ipad_kid on 10/22/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Private.h"
@interface AppPickerController : UITableViewController
@property (nullable, nonatomic) NSArray<LSApplicationProxy *> *validApps;
@end
