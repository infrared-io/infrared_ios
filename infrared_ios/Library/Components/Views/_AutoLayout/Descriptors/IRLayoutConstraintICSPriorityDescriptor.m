//
// Created by Uros Milivojevic on 10/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRLayoutConstraintICSPriorityDescriptor.h"


@implementation IRLayoutConstraintICSPriorityDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSString *string;

        // contentRelationType
        string = aDictionary[NSStringFromSelector(@selector(contentRelationType))];
        self.contentRelationType = [IRLayoutConstraintDescriptor layoutConstraintICSTypeFromString:string];

        // forAxis
        string = aDictionary[NSStringFromSelector(@selector(forAxis))];
        self.forAxis = [IRLayoutConstraintDescriptor layoutConstraintAxisFromString:string];;
    }
    return self;
}

@end