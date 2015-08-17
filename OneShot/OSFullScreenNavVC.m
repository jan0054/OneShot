//
//  OSFullScreenNavVC.m
//  OneShot
//
//  Created by Michael Wu on 2015/8/16.
//  Copyright (c) 2015年 tapgo Inc. All rights reserved.
//

#import "OSFullScreenNavVC.h"

@interface OSFullScreenNavVC ()

@end

@implementation OSFullScreenNavVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationBarHidden = YES;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    if (self.topViewController.presentedViewController) {
        return self.topViewController.presentedViewController.supportedInterfaceOrientations;
    }
    return self.topViewController.supportedInterfaceOrientations;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return self.topViewController.preferredInterfaceOrientationForPresentation;
}

@end
