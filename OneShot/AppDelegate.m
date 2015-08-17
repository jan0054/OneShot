//
//  AppDelegate.m
//  OneShot
//
//  Created by Michael Wu on 2015/8/6.
//  Copyright (c) 2015年 tapgo Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <TwitterKit/TwitterKit.h>
#import <FBSDKCoreKit.h>
#import <MBProgressHUD.h>

NSString * const OS_APP_HUD_HIDDEN = @"OS_APP_HUD_HIDDEN";


@interface AppDelegate ()<MBProgressHUDDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Fabric with:@[CrashlyticsKit, TwitterKit]];
    
    [UINavigationBar appearance].backgroundColor = [AppDelegate primaryColor];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                          NSForegroundColorAttributeName: [AppDelegate secondaryTextColor]
                                                          
                                                          }];
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    [FBSDKAppEvents activateApp];
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "cc.tapgo.OneShot" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"OneShot" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"OneShot.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    DLog(@"sourceApplication: %@", sourceApplication);
    DLog(@"annotation: %@", annotation);
    DLog(@"openURL: %@", url);
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}


#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}




#pragma mark - Utility
+ (UIColor *)darkPrimaryColor {
    return [UIColor colorWithHex:@"#303F9F"];
}
+ (UIColor *)primaryColor {
    return [UIColor colorWithHex:@"#3F51B5"];
}
+ (UIColor *)lightPrimaryColor {
    return [UIColor colorWithHex:@"#C5CA19"];
}
+ (UIColor *)iconColor {
    return [UIColor colorWithHex:@"#FFFFFF"];
}
+ (UIColor *)primaryTextColor {
    return [UIColor colorWithHex:@"#212121"];
}
+ (UIColor *)accentColor {
    return [UIColor colorWithHex:@"#FF5722"];
}
+ (UIColor *)secondaryTextColor {
    return [UIColor colorWithHex:@"#727272"];
}
+ (UIColor *)dividerColor {
    return [UIColor colorWithHex:@"#B6B6B6"];
}

+ (CGFloat)screenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)screenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

+ (AppDelegate *)getDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}



#pragma mark - MBProgressHUD

+ (MBProgressHUD *)sharedHud {
    static MBProgressHUD *hud;
    static dispatch_once_t onceToken;

    
    dispatch_once(&onceToken, ^{
        hud = [[MBProgressHUD alloc] initWithWindow:[AppDelegate getDelegate].window];
    });
    
    hud.delegate = [AppDelegate getDelegate];
    
    return hud;
}

- (void)showHud {
    MBProgressHUD *hud = [AppDelegate sharedHud];
    if (self.window) {
        [self.window addSubview:hud];
    }

    hud.mode = MBProgressHUDModeIndeterminate;
    [hud show:true];

    
}

- (void)showHudWithTitle:(NSString *)title withDetailText:(NSString *)detailText {
    MBProgressHUD *hud = [AppDelegate sharedHud];
    if (self.window) {
        [self.window addSubview:hud];
    }
    hud.customView = nil;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.detailsLabelText = detailText;
    hud.labelText = title;
    [hud show:true];
    
}


- (void)hideHud {
    MBProgressHUD *hud = [AppDelegate sharedHud];
    [hud hide:true];
//    hud.customView = nil;
//    hud.detailsLabelText = nil;
//    hud.labelText = nil;
}
- (void)hideHudWithDelay:(NSTimeInterval)delay {
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OK"]];
    MBProgressHUD *hud = [AppDelegate sharedHud];
    hud.customView = iv;
    hud.mode = MBProgressHUDModeCustomView;
    [hud hide:true afterDelay:delay];
}

#pragma mark - MBProgressHUDDelegate
- (void)hudWasHidden:(MBProgressHUD *)hud {
    if ([hud isEqual:[AppDelegate sharedHud]]) {
        hud.customView = nil;
        hud.detailsLabelText = nil;
        hud.labelText = nil;
        [NC postNotificationName:OS_APP_HUD_HIDDEN object:self userInfo:@{@"hud":hud}];
    }
}



@end
