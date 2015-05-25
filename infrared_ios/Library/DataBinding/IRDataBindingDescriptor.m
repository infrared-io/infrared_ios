//
// Created by Uros Milivojevic on 10/17/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRDataBindingDescriptor.h"


@implementation IRDataBindingDescriptor

+ (IRDataBindingDescriptor *) newDataBindingDescriptorWithDictionary:(NSDictionary *)dictionary
{
    IRDataBindingDescriptor *descriptor = [[IRDataBindingDescriptor alloc] initDescriptorWithDictionary:dictionary];
    return descriptor;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super init];
    if (self) {
        NSString *string;

        // property
        string = aDictionary[NSStringFromSelector(@selector(property))];
        self.property = string;

        // mode
        string = aDictionary[NSStringFromSelector(@selector(mode))];
        self.mode = [IRBaseDescriptor dataBindingModeForString:string];

        // data
        string = aDictionary[NSStringFromSelector(@selector(data))];
        self.data = string;
    }
    return self;
}

@end