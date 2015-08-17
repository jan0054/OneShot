//
//  OSTabBarVC.m
//  OneShot
//
//  Created by Michael Wu on 2015/8/16.
//  Copyright (c) 2015年 tapgo Inc. All rights reserved.
//

#import "OSTabBarVC.h"
#import "AppDelegate.h"
#import <DBCameraViewController.h>
#import <DBCameraContainerViewController.h>
#import <CreatePostVC.h>

@interface OSTabBarVC () <DBCameraContainerDelegate, DBCameraViewControllerDelegate>
@property UIButton *shotBtn;
@property UINavigationController *navVC;
@end

@implementation OSTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.shotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shotBtn.layer.cornerRadius = 5.0f;
    self.shotBtn.clipsToBounds = true;
    
    CGRect frame = self.tabBar.frame;
    frame.size.width /= 5;
    frame.origin.x = frame.size.width*2;
    
    frame.origin.y = 0;

    self.shotBtn.frame = frame;
    
    
    [self.shotBtn setImage:[UIImage imageNamed:@"Shot"] forState:UIControlStateNormal];
    self.shotBtn.backgroundColor = [AppDelegate accentColor];
    [self.shotBtn addTarget:self action:@selector(doShot) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.tabBar addSubview:self.shotBtn];
    
//    [NC addObserver:self selector:@selector(onStatusBarChange:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UI Event

- (void)doShot {
    DLog(@" ");
    //[self performSegueWithIdentifier:@"doShot" sender:self];

#if TARGET_IPHONE_SIMULATOR
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CreatePostVC *postVC = (CreatePostVC *)[sb instantiateViewControllerWithIdentifier:@"CreatePostVC"];
    ;
    if (!self.navVC) {
        self.navVC = [[UINavigationController alloc] initWithRootViewController:postVC];
        [self.navVC setNavigationBarHidden:true];
    }
    postVC.image = [UIImage imageNamed:@"sample_1.jpg"];
    [self presentViewController:self.navVC animated:YES completion:nil];

#else
    
    DBCameraViewController *cameraController = [DBCameraViewController initWithDelegate:self];
    [cameraController setForceQuadCrop:YES];
    
    DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    [container setCameraViewController:cameraController];
    [container setFullScreenMode];
    
    if (!self.navVC) {
        self.navVC = [[UINavigationController alloc] initWithRootViewController:container];
    }
    [self presentViewController:self.navVC animated:YES completion:nil];
    [self.navVC setNavigationBarHidden:true];
    
#endif
    
}

#pragma mark - DBCameraViewControllerDelegate
- (void)backFromController:(id)fromController {
    DLog(@"fromController: %@", fromController);
}

- (void)switchFromController:(id)fromController toController:(id)controller {
    DLog(@"fromController: %@, toController: %@", fromController, controller);
}

- (void)dismissCamera:(id)cameraViewController {
    DLog(@"cameraViewController: %@", cameraViewController);
    
    [cameraViewController dismissViewControllerAnimated:true completion:nil];
    
}

- (void)camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata {
    DLog(@"cameraViewController: %@, self.navVC: %@", cameraViewController, self.navVC);
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CreatePostVC *postVC = (CreatePostVC *)[sb instantiateViewControllerWithIdentifier:@"CreatePostVC"];
    ;
    DLog(@"image: %@", image);
    postVC.image = image;
    
    
    [self.navVC pushViewController:postVC animated:true];
    
}


@end
