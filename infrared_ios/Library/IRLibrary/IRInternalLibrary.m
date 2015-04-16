//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRInternalLibrary.h"
#import "IRView.h"
#import "IRViewController.h"
#import "IRDataController.h"
#import "IRScreenDescriptor.h"


@implementation IRInternalLibrary
{

}

static IRInternalLibrary *sharedIRLibrary = nil;

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

    context[[IRInternalLibrary name]] = [IRInternalLibrary sharedInstance];
}

+ (void) unregisterLibrary:(JSContext *)context
{
    [super unregisterLibrary:context];

    context[[IRInternalLibrary name]] = nil;
}

+ (NSString *) name
{
    return @"IR";
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

#pragma mark - Singleton object methods

+ (IRInternalLibrary *) sharedInstance
{
    static dispatch_once_t pred;

    dispatch_once(&pred, ^{
        sharedIRLibrary = [[IRInternalLibrary alloc] init];
    });
    return sharedIRLibrary;
}

@end