//
// Created by Uros Milivojevic on 10/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRLayoutConstraintMetricsDescriptor.h"
#import "IRDataController.h"


@implementation IRLayoutConstraintMetricsDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSString *string;
        NSDictionary *dictionary;

        // values
        dictionary = aDictionary[NSStringFromSelector(@selector(values))];
        self.values = dictionary;

        // referenceId
        string = aDictionary[NSStringFromSelector(@selector(referenceId))];
        self.referenceId = string;

        [[IRDataController sharedInstance] registerGlobalLayoutConstraintMetrics:self];
    }
    return self;
}

- (BOOL) isIdRequired
{
    return NO;
}

- (NSDictionary *) values
{
    NSDictionary *finalValue = nil;
    if (self.referenceId) {
        finalValue = [[IRDataController sharedInstance] layoutConstraintMetricsWithId:self.referenceId].values;
    } else {
        finalValue = _values;
    }
    return finalValue;
}

@end