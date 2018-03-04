//
//  CRViewController.m
//  carReader
//
//  Created by ipad_kid on 9/23/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "CRViewController.h"
#import "CRViewerViewController.h"
#import "CRAppPickerController.h"
#import "CRFrameworkViewController.h"
#import "CRFileSystemViewController.h"
#import "Private.h"

@implementation CRViewController

- (IBAction)goButton {
    NSString *assetPath = self.textBox.text;
    
    UIUserInterfaceIdiom deviceIdiom = UIDevice.currentDevice.userInterfaceIdiom;
    _UIAssetManager *assets = [[_UIAssetManager alloc] initWithURL:[NSURL fileURLWithPath:assetPath isDirectory:NO] idiom:deviceIdiom error:NULL];
    if (!assets) {
        return;
    }
    
    CRViewerViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Viewer"];
    newViewController.assets = assets;
    [self.navigationController pushViewController:newViewController animated:YES];
}

- (void)recursiveDump:(NSString *)dir list:(NSMutableArray<NSString *> *)list {
    NSFileManager *fileManager = NSFileManager.defaultManager;
    for (NSString *file in [fileManager contentsOfDirectoryAtPath:dir error:NULL]) {
        NSString *path = [dir stringByAppendingPathComponent:file];
        BOOL isDir;
        if ([fileManager fileExistsAtPath:path isDirectory:&isDir]) {
            if (isDir) {
                [self recursiveDump:path list:list];
            } else if ([path.pathExtension isEqualToString:@"car"]) {
                [list addObject:path];
            }
        }
    }
}

- (void)dumpFS {
    UIAlertController *loadAlert = [UIAlertController alertControllerWithTitle:@"Loading" message:@"Finding all files with .car extension" preferredStyle:1];
    [self presentViewController:loadAlert animated:YES completion:^{
        NSMutableArray<NSString *> *list = NSMutableArray.new;
        [self recursiveDump:@"/" list:list];
        
        CRFileSystemViewController *filePicker = CRFileSystemViewController.new;
        filePicker.validFiles = list;
        [loadAlert dismissViewControllerAnimated:YES completion:^{
            [self.navigationController pushViewController:filePicker animated:YES];
        }];
    }];
}

- (void)pasteButton {
    NSString *pasteboard = UIPasteboard.generalPasteboard.string;
    if (pasteboard.absolutePath) {
        self.textBox.text = pasteboard;
    }
}

- (void)pickAppHit {
    UIAlertController *loadAlert = [UIAlertController alertControllerWithTitle:@"Loading" message:@"Finding all valid apps, please wait" preferredStyle:1];
    [self presentViewController:loadAlert animated:YES completion:^{
        NSMutableArray<LSApplicationProxy *> *testApps = NSMutableArray.new;
        for (LSApplicationProxy *app in LSApplicationWorkspace.defaultWorkspace.allInstalledApplications) {
            if ([_UIAssetManager assetManagerForBundle:[NSBundle bundleWithURL:app.bundleURL]]) {
                [testApps addObject:app];
            }
        }
        
        CRAppPickerController *appPicker = CRAppPickerController.new;
        appPicker.validApps = testApps;
        
        [loadAlert dismissViewControllerAnimated:YES completion:^{
            [self.navigationController pushViewController:appPicker animated:YES];
        }];
    }];
}

- (void)pickFrameworkHit {
    UIAlertController *loadAlert = [UIAlertController alertControllerWithTitle:@"Loading" message:@"Finding all valid frameworks, please wait" preferredStyle:1];
    [self presentViewController:loadAlert animated:YES completion:^{
        NSMutableArray<NSBundle *> *testPublicFrameworks = NSMutableArray.new;
        NSString *publicPath = @"/System/Library/Frameworks/";
        for (NSString *frameworkPath in [NSFileManager.defaultManager contentsOfDirectoryAtPath:publicPath error:NULL]) {
            NSBundle *frameworkBundle = [NSBundle bundleWithPath:[publicPath stringByAppendingString:frameworkPath]];
            if ([_UIAssetManager assetManagerForBundle:frameworkBundle]) {
                [testPublicFrameworks addObject:frameworkBundle];
            }
        }
        
        NSMutableArray<NSBundle *> *testPrivateFrameworks = NSMutableArray.new;
        NSString *privatePath = @"/System/Library/PrivateFrameworks/";
        for (NSString *frameworkPath in [NSFileManager.defaultManager contentsOfDirectoryAtPath:privatePath error:NULL]) {
            NSBundle *frameworkBundle = [NSBundle bundleWithPath:[privatePath stringByAppendingString:frameworkPath]];
            if ([_UIAssetManager assetManagerForBundle:frameworkBundle]) {
                [testPrivateFrameworks addObject:frameworkBundle];
            }
        }
        
        CRFrameworkViewController *frameworkPicker = CRFrameworkViewController.new;
        frameworkPicker.publicFrameworks = testPublicFrameworks;
        frameworkPicker.privateFrameworks = testPrivateFrameworks;
        [loadAlert dismissViewControllerAnimated:YES completion:^{
            [self.navigationController pushViewController:frameworkPicker animated:YES];
        }];
    }];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSString *titleText = @"Error";
    switch (indexPath.row) {
        case 0:
            titleText = @"Clipboard";
            break;
        case 1:
            titleText = @"Pick App";
            break;
        case 2:
            titleText = @"Pick Framework";
            break;
        case 3:
            titleText = @"All Files";
            break;
    }
    
    UILabel *cellLabel = cell.textLabel;
    cellLabel.text = titleText;
    cellLabel.font = [cellLabel.font fontWithSize:15];
    cellLabel.textColor = self.view.tintColor;
    
    cell.layer.cornerRadius = 5;
    cell.clipsToBounds = YES;
    cell.layer.masksToBounds = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self pasteButton];
            break;
        case 1:
            [self pickAppHit];
            break;
        case 2:
            [self pickFrameworkHit];
            break;
        case 3:
            [self dumpFS];
            break;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

@end
