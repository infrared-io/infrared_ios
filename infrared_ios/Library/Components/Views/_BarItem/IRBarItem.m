//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRBarItem.h"


@implementation IRBarItem

- (id)init
{
    self = [super init];
    if (self) {
        NSAssert(false, @"IRBarItem - IRBarItem should NEVER be built explicitly!");
    }
    return self;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Create

+ (id) create
{
    return [[IRBarItem alloc] init];
}

@end