//
//  CreatePostVC.m
//  OneShot
//
//  Created by Michael Wu on 2015/8/17.
//  Copyright (c) 2015年 tapgo Inc. All rights reserved.
//

#import "CreatePostVC.h"
#import "AppDelegate.h"
#import <UIImage+Resize.h>
#import <MBProgressHUD.h>


@interface CreatePostVC () <UIScrollViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *postTV;
@end

@implementation CreatePostVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.imageView.image = self.image;
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame = self.view.bounds;
    
    
    
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:self.view.bounds];
    iv.image = self.image;
    UIView *v = [[UIView alloc] init];
    [v addSubview:iv];
    [v addSubview:visualEffectView];
    [self.tableView setBackgroundView:v];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [NC addObserver:self selector:@selector(onHudHidden:) name:OS_APP_HUD_HIDDEN object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return [AppDelegate screenWidth];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        return [AppDelegate screenHeight] - [AppDelegate screenWidth];
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BOOL)prefersStatusBarHidden {
    return true;
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.postTV.isFirstResponder) {
        [self.postTV resignFirstResponder];
    }
}


#pragma mark - UI Event
- (IBAction)onBack {
    
    if (self.navigationController.childViewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:true];
    } else {
        [self dismissViewControllerAnimated:true completion:nil];
    }
    

}

- (IBAction)onPost {
    [[AppDelegate getDelegate] showHudWithTitle:nil withDetailText:@"detail"];

    [[AppDelegate getDelegate] hideHudWithDelay:3.0f];
}

- (void)onHudHidden:(NSNotification *)noti {
    DLog(@"Check if the posting succeeds");
    if (self.navigationController) {
        [self.navigationController dismissViewControllerAnimated:true completion:nil];
    } else {
        [self dismissViewControllerAnimated:true completion:nil];
    }
}


@end
