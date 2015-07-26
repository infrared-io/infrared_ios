//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRTapGestureRecognizerDescriptor.h"


@implementation IRTapGestureRecognizerDescriptor

- (NSDictionary *) viewDefaults
{
    return @{
      @"numberOfTapsRequired" : @(1),
      @"numberOfTouchesRequired" : @(1)
    };
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;

        // numberOfTapsRequired
        number = aDictionary[NSStringFromSelector(@selector(numberOfTapsRequired))];
        if (number) {
            self.numberOfTapsRequired = [number unsignedIntegerValue];
        } else {
            self.numberOfTapsRequired = [[self viewDefaults][NSStringFromSelector(@selector(numberOfTapsRequired))] unsignedIntegerValue];;
        }

        // numberOfTouchesRequired
        number = aDictionary[NSStringFromSelector(@selector(numberOfTouchesRequired))];
        if (number) {
            self.numberOfTouchesRequired = [number unsignedIntegerValue];
        } else {
            self.numberOfTouchesRequired = [[self viewDefaults][NSStringFromSelector(@selector(numberOfTouchesRequired))] unsignedIntegerValue];;
        }
    }
    return self;
}

@end