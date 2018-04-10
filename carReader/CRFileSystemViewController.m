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

#define kCellIdentifier @"Cell"

@implementation CRFileSystemViewController {
    NSArray *_filesAtCurrentPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_currentPath) {
        _currentPath = @"/";
    }
    
    _filesAtCurrentPath = [NSFileManager.defaultManager contentsOfDirectoryAtPath:_currentPath error:NULL];
    
    self.navigationItem.title = _currentPath.lastPathComponent;
    
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kCellIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _filesAtCurrentPath.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *dirObject = _filesAtCurrentPath[indexPath.row];
    NSString *fullPath = [_currentPath stringByAppendingPathComponent:dirObject];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = dirObject;
    
    BOOL isDir;
    [NSFileManager.defaultManager fileExistsAtPath:fullPath isDirectory:&isDir];
    cell.accessoryType = isDir ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    cell.userInteractionEnabled = cell.textLabel.enabled = (isDir || [dirObject.pathExtension isEqualToString:@"car"]);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *fullPath = [_currentPath stringByAppendingPathComponent:cell.textLabel.text];
    
    BOOL isDir;
    [NSFileManager.defaultManager fileExistsAtPath:fullPath isDirectory:&isDir];
    if (isDir) {
        typeof(self) newViewController = self.class.new;
        newViewController.currentPath = fullPath;
        [self.navigationController pushViewController:newViewController animated:YES];
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
        CRViewerViewController *newViewController = [storyboard instantiateViewControllerWithIdentifier:@"Viewer"];
        NSURL *integrityPath = [NSURL fileURLWithPath:fullPath isDirectory:NO];
        UIUserInterfaceIdiom deviceIdiom = UIDevice.currentDevice.userInterfaceIdiom;
        newViewController.assets = [[_UIAssetManager alloc] initWithURL:integrityPath idiom:deviceIdiom error:NULL];
        [self.navigationController pushViewController:newViewController animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
