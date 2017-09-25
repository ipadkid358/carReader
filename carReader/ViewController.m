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
    
    // Usually, I wouldn't use valueForKey(Path): but after catalog, it goes into CoreUI, which is a PrivateFramework
    NSArray *allRenditionNames = [assets valueForKeyPath:@"catalog.themeStore.store.allRenditionNames"];
    NSMutableDictionary<NSString *, UIImage *> *images = NSMutableDictionary.new;
    for (NSString *renditionName in allRenditionNames) [images setValue:[assets imageNamed:renditionName] forKey:renditionName];
    
    [self.navigationController pushViewController:[ViewerViewController viewerWithImages:images] animated:YES];
}

- (IBAction)pasteButton {
    self.textBox.text = UIPasteboard.generalPasteboard.string;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
