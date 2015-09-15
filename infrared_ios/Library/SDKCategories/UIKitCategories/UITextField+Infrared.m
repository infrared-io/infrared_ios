//
// Created by Uros Milivojevic on 6/17/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "UITextField+Infrared.h"
#import "JRSwizzle.h"


@implementation UITextField (Infrared)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error;
        BOOL result = [[self class] jr_swizzleMethod:@selector(becomeFirstResponder)
                                          withMethod:@selector(becomeFirstResponder_swizzled)
                                               error:&error];
        if (!result || error) {
            NSLog(@"Can't swizzle methods - %@", [error description]);
        }
    });
}

- (BOOL) resignFirstResponder
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [super resignFirstResponder];
    });
    return YES;
}

- (BOOL)becomeFirstResponder_swizzled
{
    if ([NSThread isMainThread]) {
        [self becomeFirstResponder_swizzled];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self becomeFirstResponder_swizzled];
        });
    }
    return YES;
}

@end