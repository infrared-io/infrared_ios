//
// Created by Uros Milivojevic on 6/18/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRPanGestureRecognizerDescriptor.h"


@implementation IRPanGestureRecognizerDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;

        // minimumNumberOfTouches
        number = aDictionary[NSStringFromSelector(@selector(minimumNumberOfTouches))];
        if (number) {
            self.minimumNumberOfTouches = [number unsignedIntegerValue];
        } else {
            self.minimumNumberOfTouches = 1;
        }

        // maximumNumberOfTouches
        number = aDictionary[NSStringFromSelector(@selector(maximumNumberOfTouches))];
        if (number) {
            self.maximumNumberOfTouches = [number unsignedIntegerValue];
        } else {
            self.maximumNumberOfTouches = UINT_MAX;
        }
    }
    return self;
}

@end