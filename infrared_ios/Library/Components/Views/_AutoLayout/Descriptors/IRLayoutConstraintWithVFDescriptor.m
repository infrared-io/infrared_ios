//
// Created by Uros Milivojevic on 10/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRLayoutConstraintWithVFDescriptor.h"
#import "IRLayoutConstraintMetricsDescriptor.h"

@implementation IRLayoutConstraintWithVFDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSString *string;
        NSDictionary *dictionary;
        NSArray *array;

        // visualFormat
        string = aDictionary[NSStringFromSelector(@selector(visualFormat))];
        self.visualFormat = string;

#if TARGET_OS_IPHONE
        // options
        string = aDictionary[NSStringFromSelector(@selector(options))];
        self.options = [IRLayoutConstraintDescriptor layoutFormatOptionsFromString:string];
#endif

        // metrics
        dictionary = aDictionary[NSStringFromSelector(@selector(metrics))];
        self.metrics = [[IRLayoutConstraintMetricsDescriptor alloc] initDescriptorWithDictionary:dictionary];
    }
    return self;
}

@end