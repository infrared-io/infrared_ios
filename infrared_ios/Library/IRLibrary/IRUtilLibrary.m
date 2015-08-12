//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRUtilLibrary.h"
#import "IRView.h"
#import "IRViewController.h"
#import "IRDataController.h"
#import "IRScreenDescriptor.h"
#import "SSKeychain.h"
#import "IRUtil.h"


@implementation IRUtilLibrary
{

}

static IRUtilLibrary *sharedIRLibrary = nil;

- (id) init
{
    self = [super init];
    if (self) {

    }
    return self;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Public methods

+ (void) registerLibrary:(JSContext *)context
{
    [super registerLibrary:context];

    [IRBaseLibrary setValue:[IRUtilLibrary sharedInstance]
                     parent:[IRUtilLibrary parent]
                       name:[IRUtilLibrary name]
                    context:context];
}

+ (void) unregisterLibrary:(JSContext *)context
{
    [super unregisterLibrary:context];

    [IRBaseLibrary setValue:nil
                     parent:[IRUtilLibrary parent]
                       name:[IRUtilLibrary name]
                    context:context];
}

+ (NSString *) parent
{
    return IR_JS_LIBRARY_KEY;
}

+ (NSString *) name
{
    return @"Util";
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Pubic methods

- (IRView *) viewWithId:(NSString *)viewId
         viewController:(IRViewController *)viewController
{
    return [[IRDataController sharedInstance] viewWithId:viewId
                                          viewController:viewController];
}

// --------------------------------------------------------------------------------------------------------------------
- (NSArray *) controllersWithId:(NSString *)controllerId
{
    return [[IRDataController sharedInstance] controllersWithId:controllerId];
}

// --------------------------------------------------------------------------------------------------------------------
- (NSArray *) controllersWithScreenId:(NSString *)screenId
{
    NSString *controllerId = [[IRDataController sharedInstance] controllerIdForScreenId:screenId];
    return [[IRDataController sharedInstance] controllersWithId:controllerId];
}

// --------------------------------------------------------------------------------------------------------------------
- (void) showViewWithId:(NSString *)componentId
         viewController:(IRViewController *)viewController
{
    IRView *view = [[IRDataController sharedInstance] viewWithId:componentId
                                                  viewController:viewController];
    view.hidden = NO;
}

// --------------------------------------------------------------------------------------------------------------------
- (void) hideViewWithId:(NSString *)componentId
         viewController:(IRViewController *)viewController
{
    IRView *view = [[IRDataController sharedInstance] viewWithId:componentId
                                                  viewController:viewController];
    view.hidden = YES;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (NSString *) prefixFilePathWithBaseUrlIfNeeded:(NSString *)filePath
{
    return [IRUtil prefixFilePathWithBaseUrlIfNeeded:filePath];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - NSUserDefaults

- (void) setUserDefaultsValue:(NSString *)value forKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}
- (NSString *) userDefaultsValueForKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *value = [defaults objectForKey:key];
    return value;
}
- (void) removeDefaultsValueForKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}
// --------------------------------------------------------------------------------------------------------------------
- (void) setUserDefaultsValue:(NSString *)value forKey:(NSString *)key withSuitedName:(NSString *)name
{
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:name];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
}
- (NSString *) userDefaultsValueForKey:(NSString *)key withSuitedName:(NSString *)name
{
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:name];
    NSString *value = [defaults objectForKey:key];
    return value;
}
- (void) removeDefaultsValueForKey:(NSString *)key withSuitedName:(NSString *)name
{
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:name];
    [defaults removeObjectForKey:key];
    [defaults synchronize];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Keychain

- (void) setKeychainPassword:(NSString *)password
                      forKey:(NSString *)key
                  andAccount:(NSString *)account
{
    [SSKeychain setPassword:password forService:key account:account];
}
- (NSString *) keychainPasswordForKey:(NSString *)key
                           andAccount:(NSString *)account
{
    return [SSKeychain passwordForService:key account:account];
}
- (void) removeKeychainPasswordForKey:(NSString *)key andAccount:(NSString *)account
{
    [SSKeychain deletePasswordForService:key account:account];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    [MBProgressHUD hideAllHUDsForView:window animated:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.labelText = title;
    return hud;
}
- (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title mode:(MBProgressHUDMode)mode
{
    MBProgressHUD *hud = [self showGlobalProgressHUDWithTitle:title];
    hud.mode = mode;
    return hud;
}
- (void)dismissGlobalHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        [MBProgressHUD hideAllHUDsForView:window animated:YES];
    });
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Singleton object methods

+ (IRUtilLibrary *) sharedInstance
{
    static dispatch_once_t pred;

    dispatch_once(&pred, ^{
        sharedIRLibrary = [[IRUtilLibrary alloc] init];
    });
    return sharedIRLibrary;
}

@end