//
// Created by Uros Milivojevic on 6/18/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRLongPressGestureRecognizerDescriptor.h"


@implementation IRLongPressGestureRecognizerDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;

        // minimumPressDuration
        number = aDictionary[NSStringFromSelector(@selector(minimumPressDuration))];
        if (number) {
            self.minimumPressDuration = [number doubleValue];
        } else {
            self.minimumPressDuration = 0.5;
        }

        // allowableMovement
        number = aDictionary[NSStringFromSelector(@selector(allowableMovement))];
        if (number) {
            self.allowableMovement = [number floatValue];
        } else {
            self.allowableMovement = 10;
        }
    }
    return self;
}

@end