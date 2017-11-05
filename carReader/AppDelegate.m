#import "AppDelegate.h"
#import "Private.h"
#import "CRViewerViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:NSBundle.mainBundle];
    CRViewerViewController *newViewController = [storyboard instantiateViewControllerWithIdentifier:@"Viewer"];
    newViewController.assets = [[_UIAssetManager alloc] initWithURL:url idiom:UIDevice.currentDevice.userInterfaceIdiom error:NULL];
    newViewController.navigationItem.title = @"Images";
    [(UINavigationController *)self.window.rootViewController pushViewController:newViewController animated:NO];
    return YES;
}

@end
