//
//  AppPickerController.m
//  carReader
//
//  Created by ipad_kid on 10/22/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "AppPickerController.h"
#import "ViewerViewController.h"

@implementation AppPickerController {
    NSUInteger appCount;
    CGFloat scale;
}

- (void)viewDidLoad {
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
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LSApplicationProxy *appProxy = self.validApps[indexPath.row];
    _UIAssetManager *assets = [_UIAssetManager assetManagerForBundle:[NSBundle bundleWithURL:appProxy.bundleURL]];
    
    NSArray<NSString *> *allImageNames = [assets valueForKeyPath:@"catalog.themeStore.allImageNames"];
    NSMutableDictionary<NSString *, UIImage *> *images = NSMutableDictionary.new;
    for (NSString *imageName in allImageNames) [images setValue:[assets imageNamed:imageName] forKey:imageName];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    ViewerViewController *newViewController = [storyboard instantiateViewControllerWithIdentifier:@"Viewer"];
    newViewController.images = images;
    newViewController.navigationItem.title = appProxy.localizedShortName;
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
