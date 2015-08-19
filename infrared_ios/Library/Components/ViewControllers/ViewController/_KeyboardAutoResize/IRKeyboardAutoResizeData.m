//
// Created by Uros Milivojevic on 1/5/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRDesctiptorDefaultKeys.h"
#import "IRKeyboardAutoResizeData.h"
#import "IRView.h"


@implementation IRKeyboardAutoResizeData

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.originalBottomPosition = CGFLOAT_UNDEFINED;
    }

    return self;
}


@end