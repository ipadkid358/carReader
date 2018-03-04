//
//  CRFileSystemViewController.m
//  carReader
//
//  Created by ipad_kid on 3/3/18.
//  Copyright © 2018 BlackJacket. All rights reserved.
//

#import "CRFileSystemViewController.h"
#import "Private.h"
#import "CRViewerViewController.h"

@implementation CRFileSystemViewController {
    UIAlertController *infoAlert;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
    self.navigationItem.title = @"Select File";
}

- (void)dismissInfoAlert {
    if (infoAlert) {
        CGRect newBounds = infoAlert.view.bounds;
        newBounds.origin.y = self.view.bounds.size.height;
        [UIView animateWithDuration:0.15 animations:^{
            infoAlert.view.bounds = newBounds;
        } completion:^(BOOL finished) {
            [infoAlert dismissViewControllerAnimated:NO completion:nil];
            infoAlert = NULL;
        }];
    }
}

- (void)longTouch:(UILongPressGestureRecognizer *)touch {
    if (touch.state == UIGestureRecognizerStateBegan) {
        UITableViewCell *cell = (UITableViewCell *)touch.view;
        NSString *text = cell.textLabel.text;
        
        infoAlert = [UIAlertController alertControllerWithTitle:@"" message:text preferredStyle:UIAlertControllerStyleAlert];
        infoAlert.view.hidden = YES;
        [self presentViewController:infoAlert animated:NO completion:^{
            UITapGestureRecognizer *dismissRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissInfoAlert)];
            UIView *infoAlertView = infoAlert.view;
            [infoAlertView.superview.subviews.firstObject addGestureRecognizer:dismissRecognizer];
            
            CGRect originalBounds = infoAlertView.bounds;
            CGRect tmpBounds = originalBounds;
            tmpBounds.origin.y = -self.view.frame.size.height;
            infoAlertView.bounds = tmpBounds;
            infoAlertView.hidden = NO;
            
            [UIView animateWithDuration:0.15 animations:^{
                infoAlertView.bounds = originalBounds;
            }];
        }];
    }
    
    if (touch.state == UIGestureRecognizerStateEnded) {
        [self dismissInfoAlert];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longTouch:)]];
    cell.textLabel.text = _validFiles[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _validFiles.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    CRViewerViewController *newViewController = [storyboard instantiateViewControllerWithIdentifier:@"Viewer"];
    UIUserInterfaceIdiom deviceIdiom = UIDevice.currentDevice.userInterfaceIdiom;
    
    NSString *assetPath = _validFiles[indexPath.row];
    newViewController.assets = [[_UIAssetManager alloc] initWithURL:[NSURL fileURLWithPath:assetPath isDirectory:NO] idiom:deviceIdiom error:NULL];
    [self.navigationController pushViewController:newViewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
