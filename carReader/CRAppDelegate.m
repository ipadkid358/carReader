//
//  CRAppDelegate.m
//  carReader
//
//  Created by ipad_kid on 9/23/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "CRAppDelegate.h"
#import "Private.h"
#import "CRViewerViewController.h"

@implementation CRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    CRViewerViewController *newViewController = [storyboard instantiateViewControllerWithIdentifier:@"Viewer"];
    newViewController.assets = [[_UIAssetManager alloc] initWithURL:url idiom:UIDevice.currentDevice.userInterfaceIdiom error:NULL];
    [(UINavigationController *)self.window.rootViewController pushViewController:newViewController animated:NO];
    return YES;
}

@end
