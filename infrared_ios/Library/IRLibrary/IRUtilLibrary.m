//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRUtilLibrary.h"
#import "IRView.h"
#import "IRViewController.h"
#import "IRDataController.h"
#import "IRScreenDescriptor.h"


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
    return @"IR";
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
- (void) showComponentWithId:(NSString *)componentId
              viewController:(IRViewController *)viewController
{
    IRView *view = [[IRDataController sharedInstance] viewWithId:componentId
                                                  viewController:viewController];
    view.hidden = NO;
}

// --------------------------------------------------------------------------------------------------------------------
- (void) hideComponentWithId:(NSString *)componentId
              viewController:(IRViewController *)viewController
{
    IRView *view = [[IRDataController sharedInstance] viewWithId:componentId
                                                  viewController:viewController];
    view.hidden = YES;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (MBProgressHUD *)showGlobalProgressHUDWithTitle:(NSString *)title
{
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
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
    UIWindow *window = [[[UIApplication sharedApplication] windows] lastObject];
    [MBProgressHUD hideHUDForView:window animated:YES];
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