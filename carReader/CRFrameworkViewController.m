//
//  CRFrameworkViewController.m
//  carReader
//
//  Created by ipad_kid on 11/4/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "CRFrameworkViewController.h"
#import "CRViewerViewController.h"
#import "Private.h"

@implementation CRFrameworkViewController

- (void)viewDidLoad {
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"Cell"];
    self.navigationItem.title = @"Select Framework";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSArray<NSBundle *> *frameworkSet = indexPath.section ? self.privateFrameworks : self.publicFrameworks;
    NSBundle *targetBundle = frameworkSet[indexPath.row];
    cell.textLabel.text = targetBundle.executablePath.lastPathComponent;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ? self.privateFrameworks.count : self.publicFrameworks.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray<NSBundle *> *frameworkSet = indexPath.section ? self.privateFrameworks : self.publicFrameworks;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    CRViewerViewController *newViewController = [storyboard instantiateViewControllerWithIdentifier:@"Viewer"];
    NSBundle *targetBundle = frameworkSet[indexPath.row];
    newViewController.assets = [_UIAssetManager assetManagerForBundle:targetBundle];
    [self.navigationController pushViewController:newViewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return section ? @"Private" : @"Public";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
