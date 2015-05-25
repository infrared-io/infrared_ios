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

+ (NSString *) parent
{
    return nil;
}
+ (NSString *) name
{
    NSAssert(false, @"IRBaseLibrary - your library MUST override \"name\" method!");
    return @"";
}

+ (void) setValue:(id)value parent:(NSString *)parent name:(NSString *)name context:(JSContext *)context
{
    JSValue *parentObject = context;
    NSArray *libraryParentComponentsArray;
    NSString *anParentComponent;
    if ([parent length] > 0) {
        libraryParentComponentsArray = [parent componentsSeparatedByString:@"."];
        for (uint i = 0; i < [libraryParentComponentsArray count]; ++i) {
            anParentComponent = libraryParentComponentsArray[i];
            parentObject = parentObject[anParentComponent];
        }
    }
    parentObject[name] = value;
}

@end