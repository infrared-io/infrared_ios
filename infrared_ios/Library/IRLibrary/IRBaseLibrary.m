//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRBaseLibrary.h"


@implementation IRBaseLibrary

+ (void) registerLibrary:(JSContext *)context {

}

+ (void) unregisterLibrary:(JSContext *)context {

}

+ (NSString *) name
{
    NSAssert(false, @"IRBaseLibrary - your library MUST override \"name\" method!");
    return @"";
}

@end