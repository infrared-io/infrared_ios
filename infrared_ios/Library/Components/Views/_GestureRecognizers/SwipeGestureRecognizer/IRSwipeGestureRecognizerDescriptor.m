//
// Created by Uros Milivojevic on 8/30/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRSwipeGestureRecognizerDescriptor.h"


@implementation IRSwipeGestureRecognizerDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSString *string;
        NSNumber *number;

        // direction
        string = aDictionary[NSStringFromSelector(@selector(direction))];
        self.direction = [IRGestureRecognizerDescriptor swipeGestureRecognizerDirectionForString:string];

        // numberOfTouchesRequired
        number = aDictionary[NSStringFromSelector(@selector(numberOfTouchesRequired))];
        if (number) {
            self.numberOfTouchesRequired = [number unsignedIntegerValue];
        } else {
            self.numberOfTouchesRequired = 1;
        }
    }
    return self;
}

@end