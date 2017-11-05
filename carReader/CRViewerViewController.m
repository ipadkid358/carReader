//
//  CRViewerViewController.m
//  carReader
//
//  Created by ipad_kid on 9/23/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "CRViewerViewController.h"
#import "CRImageViewController.h"
#import "CRImageViewCell.h"

@implementation CRViewerViewController {
    NSDictionary<NSString *, UIImage *> *images;
    NSArray<NSString *> *imageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray<NSString *> *allImageNames = [self.assets valueForKeyPath:@"catalog.themeStore.allImageNames"];
    NSMutableDictionary<NSString *, UIImage *> *testImages = NSMutableDictionary.new;
    for (NSString *imageName in allImageNames) [testImages setValue:[self.assets imageNamed:imageName] forKey:imageName];
    images = testImages;
    imageNames = images.allKeys;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.tableView.tableFooterView = UIView.new;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return images.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *imageName = imageNames[indexPath.row];
    UIImage *image = images[imageName];
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat imageScaler = self.view.bounds.size.width/(imageWidth+32);
    if (imageScaler < 1) imageHeight *= imageScaler;
    return imageHeight+46;
}

- (CRImageViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CRImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSString *imageName = imageNames[indexPath.row];
    
    cell.nameLabel.text = imageName;
    
    UIImage *image = images[imageName];
    CGFloat imageWidth = image.size.width;
    CGFloat imageHeight = image.size.height;
    CGFloat imageScaler = (self.view.bounds.size.width-32)/imageWidth;
    if (imageScaler < 1) {
        imageHeight *= imageScaler;
        imageWidth *= imageScaler;
    }
    cell.imageImageView.image = image;
    cell.imageWidth.constant = imageWidth;
    cell.imageHeight.constant = imageHeight;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *imageName = imageNames[indexPath.row];
    UIImage *image = images[imageName];
    CRImageViewController *imageViewController = [[CRImageViewController alloc] initWithImage:image];
    imageViewController.navigationItem.title = imageName;
    
    [self.navigationController pushViewController:imageViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
