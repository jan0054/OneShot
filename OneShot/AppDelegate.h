//
//  AppDelegate.h
//  OneShot
//
//  Created by Michael Wu on 2015/8/6.
//  Copyright (c) 2015年 tapgo Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

extern NSString * const OS_APP_HUD_HIDDEN;


@class MBProgressHUD;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (AppDelegate *)getDelegate;

+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

+ (UIColor *)darkPrimaryColor;
+ (UIColor *)primaryColor;
+ (UIColor *)lightPrimaryColor;
+ (UIColor *)iconColor;
+ (UIColor *)primaryTextColor;
+ (UIColor *)accentColor;
+ (UIColor *)secondaryTextColor;
+ (UIColor *)dividerColor;

+ (MBProgressHUD *)sharedHud;
- (void)showHud;
- (void)showHudWithTitle:(NSString *)title withDetailText:(NSString *)detailText;
- (void)hideHud;
- (void)hideHudWithDelay:(NSTimeInterval)delay;


@end

