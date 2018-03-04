//
//  CRViewController.h
//  carReader
//
//  Created by ipad_kid on 9/23/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *textBox;

@end
