//
//  ViewerViewController.m
//  carReader
//
//  Created by ipad_kid on 9/23/17.
//  Copyright © 2017 BlackJacket. All rights reserved.
//

#import "ViewerViewController.h"
#import "ImageViewController.h"
#import "ImageViewCell.h"

@implementation ViewerViewController {
    NSArray<NSString *> *imageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    imageNames = self.images.allKeys;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.tableView.tableFooterView = UIView.new;
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

- (ImageViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSString *imageName = imageNames[indexPath.row];
    
    cell.nameLabel.text = imageName;
    
    UIImage *image = self.images[imageName];
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
