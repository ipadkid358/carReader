//
//  Private.h
//  AppInfo
//
//  Created by ipad_kid on 10/9/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>

@interface LSResourceProxy
@property (nonatomic, copy, null_unspecified) NSString *localizedName;
@end

@interface LSBundleProxy : LSResourceProxy
@property (nonatomic, readonly, null_unspecified) NSString *bundleIdentifier;
@property (nonatomic, readonly, null_unspecified) NSString *localizedShortName;
@property (nonatomic, readonly, null_unspecified) NSURL *bundleURL;
@end

@interface LSApplicationProxy : LSBundleProxy
@end

@interface LSApplicationWorkspace : NSObject
+ (nonnull instancetype)defaultWorkspace;
- (nullable NSArray<LSApplicationProxy *> *)allInstalledApplications;
@end

@interface UIImage (BlackJacketPrivate)
+ (nonnull UIImage *)_applicationIconImageForBundleIdentifier:(nonnull NSString *)bundleIdentifier format:(int)format scale:(CGFloat)scale;
@end

@interface _UIAssetManager : NSObject
+ (nullable instancetype)assetManagerForBundle:(nullable NSBundle *)bundle;
- (nullable instancetype)initWithName:(nullable NSString *)name inBundle:(nullable NSBundle *)bundle idiom:(UIUserInterfaceIdiom)idiom;
- (nullable UIImage *)imageNamed:(nullable NSString *)imageName;
- (nullable UIImage *)imageNamed:(nullable NSString *)imageName idiom:(UIUserInterfaceIdiom)idiom;
@end
