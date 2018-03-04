//
//  CRAppPickerController.m
//  carReader
//
//  Created by ipad_kid on 10/22/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "CRAppPickerController.h"
#import "CRViewerViewController.h"

@implementation CRAppPickerController {
    NSUInteger appCount;
    CGFloat scale;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
    self.navigationItem.title = @"Select App";
    appCount = self.validApps.count;
    scale = UIScreen.mainScreen.scale;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    LSApplicationProxy *appProxy = self.validApps[indexPath.row];
    cell.textLabel.text = appProxy.localizedName;
    cell.imageView.image = [UIImage _applicationIconImageForBundleIdentifier:appProxy.bundleIdentifier format:1 scale:scale];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LSApplicationProxy *appProxy = self.validApps[indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    CRViewerViewController *newViewController = [storyboard instantiateViewControllerWithIdentifier:@"Viewer"];
    newViewController.assets = [_UIAssetManager assetManagerForBundle:[NSBundle bundleWithURL:appProxy.bundleURL]];
    [self.navigationController pushViewController:newViewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return appCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
