//
//  ViewerViewController.m
//  carReader
//
//  Created by ipad_kid on 9/23/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "ViewerViewController.h"
#import "ImageViewController.h"
#import "UIView+cat.h"

@implementation ViewerViewController {
    NSArray<NSString *> *imageNames;
}

+ (instancetype)viewerWithImages:(NSMutableDictionary<NSString *,UIImage *> *)images {
    ViewerViewController *newViewController = [[ViewerViewController alloc] init];
    newViewController.images = images;
    newViewController.navigationItem.title = @"Images";
    return newViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    imageNames = self.images.allKeys;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.images.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *imageName = imageNames[indexPath.row];
    UIImage *image = self.images[imageName];
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat imageScaler = self.view.bounds.size.width/(imageWidth+32);
    if (imageScaler < 1) imageHeight *= imageScaler;
    return imageHeight+46;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    UIView *cellView = cell.contentView;
    NSString *imageName = imageNames[indexPath.row];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = imageName;
    [cellView addSubview:label];
    [label setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [cellView addLayoutConstraint:NSLayoutAttributeRight toItem:label offset:-18];
    [cellView addLayoutConstraint:NSLayoutAttributeBottom toItem:label offset:-12];
    
    UIImage *image = self.images[imageName];
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat imageScaler = self.view.bounds.size.width/(imageWidth*1.075);
    if (imageScaler < 1) {
        imageHeight *= imageScaler;
        imageWidth *= imageScaler;
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [cellView addSubview:imageView];
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [cellView addLayoutConstraint:NSLayoutAttributeCenterY toItem:imageView offset:-12];
    [cellView addLayoutConstraint:NSLayoutAttributeLeft toItem:imageView offset:16];
    [imageView addLayoutConstraint:NSLayoutAttributeWidth offset:imageWidth];
    [imageView addLayoutConstraint:NSLayoutAttributeHeight offset:imageHeight];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *imageName = imageNames[indexPath.row];
    UIImage *image = self.images[imageName];
    ImageViewController *imageViewController = [[ImageViewController alloc] initWithImage:image];
    imageViewController.navigationItem.title = imageName;
    [self.navigationController pushViewController:imageViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
