//
// Created by Uros Milivojevic on 10/21/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JSContext;

@interface IRJSContextUtil : NSObject

+ (void) exposeObjCStructureCreators:(JSContext *)jsContext;
+ (void) exposeNSData:(JSContext *)jsContext;
+ (void) exposeNSDate:(JSContext *)jsContext;
+ (void) exposeUIColor:(JSContext *)jsContext;
+ (void) exposeUIImage:(JSContext *)jsContext;
+ (void) exposeUINavigationItem:(JSContext *)jsContext;
+ (void) exposeUIApplication:(JSContext *)jsContext;
+ (void) exposeNSIndexPath:(JSContext *)jsContext;
+ (void) exposeNSURL:(JSContext *)jsContext;
+ (void) exposeCLLocationManager:(JSContext *)jsContext;
+ (void) exposeMKUserLocation:(JSContext *)jsContext;
+ (void) addConsoleNSLogToJSContext:(JSContext *)jsContext;

+ (void) addInfraredJSExtensionToJSContext:(JSContext *)jsContext;

@end