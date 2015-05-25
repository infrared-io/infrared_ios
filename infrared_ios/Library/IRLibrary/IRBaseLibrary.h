//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


@interface IRBaseLibrary : NSObject

+ (void)registerLibrary:(JSContext *)context;
+ (void)unregisterLibrary:(JSContext *)context;

+ (NSString *) parent;
+ (NSString *) name;

+ (void) setValue:(id)value parent:(NSString *)parent name:(NSString *)name context:(JSContext *)context;

@end