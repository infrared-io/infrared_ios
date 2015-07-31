//
// Created by Uros Milivojevic on 6/17/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "UITextField+Infrared.h"


@implementation UITextField (Infrared)

- (BOOL) resignFirstResponder
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [super resignFirstResponder];
    });
    return YES;
}

@end