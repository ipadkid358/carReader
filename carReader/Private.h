//
//  Private.h
//  AppInfo
//
//  Created by ipad_kid on 10/9/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>

@interface LSResourceProxy
@property (nonatomic, copy) NSString *localizedName;
@end

@interface LSBundleProxy : LSResourceProxy
@property (nonatomic, readonly) NSString *bundleIdentifier;
@property (nonatomic, readonly) NSString *localizedShortName;
@property (nonatomic, readonly) NSURL *bundleURL;
@end

@interface LSApplicationProxy : LSBundleProxy
@end

@interface LSApplicationWorkspace : NSObject
+ (instancetype)defaultWorkspace;
- (NSArray<LSApplicationProxy *> *)allInstalledApplications;
@end

@interface UIImage (BlackJacketPrivate)
+ (UIImage *)_applicationIconImageForBundleIdentifier:(NSString *)bundleIdentifier format:(int)format scale:(CGFloat)scale;
@end

@interface _UIAssetManager : NSObject
+ (instancetype)assetManagerForBundle:(NSBundle *)bundle;
- (instancetype)initWithName:(NSString *)name inBundle:(NSBundle *)bundle idiom:(UIUserInterfaceIdiom)idiom;
- (instancetype)initWithURL:(NSURL *)url idiom:(UIUserInterfaceIdiom)idiom error:(NSError **)error;
- (UIImage *)imageNamed:(NSString *)imageName;
- (UIImage *)imageNamed:(NSString *)imageName idiom:(UIUserInterfaceIdiom)idiom;
- (NSBundle *)bundle;
@end
