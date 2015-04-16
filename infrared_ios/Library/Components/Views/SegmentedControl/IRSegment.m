//
// Created by Uros Milivojevic on 12/6/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRSegment.h"
#import "IRDesctiptorDefaultKeys.h"


@implementation IRSegment

- (id) init
{
    self = [super init];
    if (self) {
        self.title = nil;
        self.image = nil;
        self.enabled = YES;
        self.selected = NO;
        self.contentOffset = CGSizeNull;
    }
    return self;
}

@end