//
// Created by Uros Milivojevic on 7/29/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "UINavigationItem+Infrared.h"
#import "IRNavigationControllerSubDescriptor.h"


@implementation UINavigationItem (Infrared)

- (void) setLeftBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    __weak UINavigationItem *weakSelf = self;
//    __weak UIBarButtonItem *weakButton = barButtonItem;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf setLeftBarButtonItem:/*weakButton*/barButtonItem animated:NO];
    });
}
- (void) setRightBarButtonItem:(UIBarButtonItem *)barButtonItem;
{
    __weak UINavigationItem *weakSelf = self;
//    __weak UIBarButtonItem *weakButton = barButtonItem;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf setRightBarButtonItem:/*weakButton*/barButtonItem animated:NO];
    });
}

@end