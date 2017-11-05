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
#import "Private.h"

@implementation CRViewController

- (IBAction)goButton {
    NSString *assetPath = self.textBox.text;
    
    UIUserInterfaceIdiom deviceIdiom = UIDevice.currentDevice.userInterfaceIdiom;
    _UIAssetManager *assets = [[_UIAssetManager alloc] initWithURL:[NSURL fileURLWithPath:assetPath] idiom:deviceIdiom error:NULL];
    if (!assets) return;
    
    CRViewerViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Viewer"];
    newViewController.assets = assets;
    newViewController.navigationItem.title = @"Images";
    [self.navigationController pushViewController:newViewController animated:YES];
}

- (IBAction)pasteButton {
    NSString *pasteboard = UIPasteboard.generalPasteboard.string;
    if (pasteboard.absolutePath) self.textBox.text = pasteboard;
}

- (IBAction)pickAppHit {
    UIAlertController *loadAlert = [UIAlertController alertControllerWithTitle:@"Loading" message:@"Finding all valid apps, please wait" preferredStyle:1];
    [self presentViewController:loadAlert animated:YES completion:^{
        NSMutableArray<LSApplicationProxy *> *testApps = NSMutableArray.new;
        for (LSApplicationProxy *app in LSApplicationWorkspace.defaultWorkspace.allInstalledApplications) if ([_UIAssetManager assetManagerForBundle:[NSBundle bundleWithURL:app.bundleURL]]) [testApps addObject:app];
        
        CRAppPickerController *appPicker = CRAppPickerController.new;
        appPicker.validApps = testApps;
        
        [loadAlert dismissViewControllerAnimated:YES completion:^{
            [self.navigationController pushViewController:appPicker animated:YES];
        }];
    }];
}

- (IBAction)pickFrameworkHit {
    UIAlertController *loadAlert = [UIAlertController alertControllerWithTitle:@"Loading" message:@"Finding all valid frameworks, please wait" preferredStyle:1];
    [self presentViewController:loadAlert animated:YES completion:^{
        NSMutableArray<NSBundle *> *testPublicFrameworks = NSMutableArray.new;
        NSString *publicPath = @"/System/Library/Frameworks/";
        for (NSString *frameworkPath in [NSFileManager.defaultManager contentsOfDirectoryAtPath:publicPath error:NULL]) {
            NSBundle *frameworkBundle = [NSBundle bundleWithPath:[publicPath stringByAppendingString:frameworkPath]];
            if ([_UIAssetManager assetManagerForBundle:frameworkBundle]) [testPublicFrameworks addObject:frameworkBundle];
        }
        
        NSMutableArray<NSBundle *> *testPrivateFrameworks = NSMutableArray.new;
        NSString *privatePath = @"/System/Library/PrivateFrameworks/";
        for (NSString *frameworkPath in [NSFileManager.defaultManager contentsOfDirectoryAtPath:privatePath error:NULL]) {
            NSBundle *frameworkBundle = [NSBundle bundleWithPath:[privatePath stringByAppendingString:frameworkPath]];
            if ([_UIAssetManager assetManagerForBundle:frameworkBundle]) [testPrivateFrameworks addObject:frameworkBundle];
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

@end
