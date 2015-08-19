//
// Created by Uros Milivojevic on 10/21/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRJSContextUtil.h"
#import "IRUtil.h"
#import "UIColorExport.h"
#import "UIImageExport.h"
#import "UIApplicationExport.h"
#import "NSURLExport.h"
#import "NSDateExport.h"
#import "MKUserLocationExport.h"
#import "CLLocationManagerExport.h"
#import "NSIndexPathExport.h"
#import "NSDataExport.h"
#import "UINavigationItemExport.h"
#import <objc/runtime.h>
#import <MapKit/MapKit.h>


@implementation IRJSContextUtil

+ (void) exposeObjCStructureCreators:(JSContext *)jsContext
{
    // -- CGRect
    jsContext[@"CGRectMake"] = ^(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
        return CGRectMake(x, y, width, height);
    };
//    jsContext[@"CGRectZero"] = CGRectZero;

    // -- CGPoint
    jsContext[@"CGPointMake"] = ^(CGFloat x, CGFloat y) {
        return CGPointMake(x, y);
    };
//    jsContext[@"CGPointZero"] = CGPointZero;

    // -- CGSize
    jsContext[@"CGSizeMake"] = ^(CGFloat width, CGFloat height) {
        return CGSizeMake(width, height);
    };
//    jsContext[@"CGSizeZero"] = CGSizeZero;

    // -- UIEdgeInsets
    jsContext[@"UIEdgeInsetsMake"] = ^(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
        return UIEdgeInsetsMake(top, left, bottom, right);
    };
//    jsContext[@"UIEdgeInsetsZero"] = UIEdgeInsetsZero;
}

+ (void) exposeNSData:(JSContext *)jsContext
{
    class_addProtocol([NSData class], @protocol(NSDataExport));
    jsContext[@"NSData"] = [NSData class];
}

+ (void) exposeNSDate:(JSContext *)jsContext
{
    class_addProtocol([NSDate class], @protocol(NSDateExport));
    jsContext[@"NSDate"] = [NSDate class];
}

+ (void) exposeUIColor:(JSContext *)jsContext
{
    class_addProtocol([UIColor class], @protocol(UIColorExport));
    jsContext[@"UIColor"] = [UIColor class];
}

+ (void) exposeUIImage:(JSContext *)jsContext
{
    class_addProtocol([UIImage class], @protocol(UIImageExport));
    jsContext[@"UIImage"] = [UIImage class];
}

+ (void) exposeUIApplication:(JSContext *)jsContext
{
    class_addProtocol([UIApplication class], @protocol(UIApplicationExport));
    jsContext[@"UIApplication"] = [UIApplication class];
}

+ (void) exposeNSIndexPath:(JSContext *)jsContext
{
    class_addProtocol([NSIndexPath class], @protocol(NSIndexPathExport));
    jsContext[@"NSIndexPath"] = [NSIndexPath class];
}

+ (void) exposeNSURL:(JSContext *)jsContext
{
    class_addProtocol([NSURL class], @protocol(NSURLExport));
    jsContext[@"NSURL"] = [NSURL class];
}

+ (void) exposeCLLocationManager:(JSContext *)jsContext;
{
    class_addProtocol([CLLocationManager class], @protocol(CLLocationManagerExport));
    class_addProtocol([CLLocation class], @protocol(CLLocationExport));
    class_addProtocol([CLHeading class], @protocol(CLHeadingExport));
    jsContext[@"CLLocationManager"] = [CLLocationManager class];
}

+ (void) exposeMKUserLocation:(JSContext *)jsContext;
{
    class_addProtocol([MKUserLocation class], @protocol(MKUserLocationExport));
}

+ (void) addConsoleNSLogToJSContext:(JSContext *)jsContext
{
//    jsContext[@"console"][@"nslog"] = ^(NSString *msg) {
    jsContext[@"NSLog"] = ^(NSString *msg) {
        NSLog(@"JS: %@", msg);
    };
}

@end