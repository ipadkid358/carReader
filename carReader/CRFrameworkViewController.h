//
//  CRFrameworkViewController.h
//  carReader
//
//  Created by ipad_kid on 11/4/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRFrameworkViewController : UITableViewController

@property (strong, nonatomic) NSArray<NSBundle *> *publicFrameworks;
@property (strong, nonatomic) NSArray<NSBundle *> *privateFrameworks;

@end
