//
// Created by Uros Milivojevic on 6/18/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRRotationGestureRecognizerDescriptor.h"


@implementation IRRotationGestureRecognizerDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;

        // rotation
        number = aDictionary[NSStringFromSelector(@selector(rotation))];
        if (number) {
            self.rotation = [number floatValue];
        } else {
            self.rotation = CGFLOAT_UNDEFINED;
        }
    }
    return self;
}

@end