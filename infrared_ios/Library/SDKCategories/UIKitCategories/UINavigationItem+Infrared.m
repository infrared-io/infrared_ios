//
// Created by Uros Milivojevic on 7/29/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "UINavigationItem+Infrared.h"
#import "IRNavigationControllerSubDescriptor.h"
#import "JRSwizzle.h"


@implementation UINavigationItem (Infrared)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error;
        BOOL result;
        result = [[self class] jr_swizzleMethod:@selector(setTitle:)
                                     withMethod:@selector(setTitle_swizzled:)
                                          error:&error];
        if (!result || error) {
            NSLog(@"Can't swizzle methods - %@", [error description]);
        }

        error = nil;
        result = [[self class] jr_swizzleMethod:@selector(setLeftBarButtonItem:)
                                     withMethod:@selector(setLeftBarButtonItem_swizzled:)
                                          error:&error];
        if (!result || error) {
            NSLog(@"Can't swizzle methods - %@", [error description]);
        }

        error = nil;
        result = [[self class] jr_swizzleMethod:@selector(setRightBarButtonItem:)
                                     withMethod:@selector(setRightBarButtonItem_swizzled:)
                                          error:&error];
        if (!result || error) {
            NSLog(@"Can't swizzle methods - %@", [error description]);
        }
    });
}


- (void) setTitle_swizzled:(NSString *)title
{
    if ([NSThread isMainThread]) {
        [self setTitle_swizzled:title];
    } else {
        __weak UINavigationItem *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf setTitle_swizzled:title];
        });
    }
}

- (void) setLeftBarButtonItem_swizzled:(UIBarButtonItem *)barButtonItem
{
    if ([NSThread isMainThread]) {
        [self setLeftBarButtonItem_swizzled:barButtonItem];
    } else {
        __weak UINavigationItem *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf setLeftBarButtonItem_swizzled:barButtonItem];
        });
    }
}
- (void) setRightBarButtonItem_swizzled:(UIBarButtonItem *)barButtonItem;
{
    if ([NSThread isMainThread]) {
        [self setRightBarButtonItem_swizzled:barButtonItem];
    } else {
        __weak UINavigationItem *weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf setRightBarButtonItem_swizzled:barButtonItem];
        });
    }
}

@end