//
//  ViewController.m
//  carReader
//
//  Created by ipad_kid on 9/23/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "ViewController.h"
#import "_UIAssetManager.h"
#import "ViewerViewController.h"

@implementation ViewController

- (IBAction)goButton {
    NSString *pathForBundle = self.textBox.text;
    
    NSString *assetsName = pathForBundle.lastPathComponent;
    NSBundle *assetsBundle = [NSBundle bundleWithPath:pathForBundle.stringByDeletingLastPathComponent];
    UIUserInterfaceIdiom deviceIdiom = UIDevice.currentDevice.userInterfaceIdiom;
    _UIAssetManager *assets = [[_UIAssetManager alloc] initWithName:assetsName inBundle:assetsBundle idiom:deviceIdiom];
    if (!assets) return;
    
    // Usually, I wouldn't use valueForKey(Path), but after `catalog` the value
    // goes into CoreUI, which is a PrivateFramework (annoying to link against)
    NSArray<NSString *> *allImageNames = [assets valueForKeyPath:@"catalog.themeStore.allImageNames"];
    NSMutableDictionary<NSString *, UIImage *> *images = NSMutableDictionary.new;
    for (NSString *imageName in allImageNames) [images setValue:[assets imageNamed:imageName] forKey:imageName];
    
    ViewerViewController *newViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Viewer"];
    newViewController.images = images;
    newViewController.navigationItem.title = @"Images";
    [self.navigationController pushViewController:newViewController animated:YES];
}

- (IBAction)pasteButton {
    self.textBox.text = UIPasteboard.generalPasteboard.string;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
