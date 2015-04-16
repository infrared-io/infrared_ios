//
// Created by Uros Milivojevic on 8/30/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRPinchGestureRecognizerDescriptor.h"


@implementation IRPinchGestureRecognizerDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;

        // scale
        number = aDictionary[NSStringFromSelector(@selector(scale))];
        if (number) {
            self.scale = [number floatValue];
        } else {
            self.scale = 1;
        }
    }
    return self;
}

@end