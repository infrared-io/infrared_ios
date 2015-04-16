//
// Created by Uros Milivojevic on 10/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRLayoutConstraintWithItemDescriptor.h"

@implementation IRLayoutConstraintWithItemDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSString *string;
        NSNumber *number;

        // withItem
        string = aDictionary[NSStringFromSelector(@selector(withItem))];
        self.withItem = string;

        // withItemAttribute
        string = aDictionary[NSStringFromSelector(@selector(withItemAttribute))];
        self.withItemAttribute = [IRLayoutConstraintDescriptor layoutAttributeFromString:string];

        // relatedBy
        string = aDictionary[NSStringFromSelector(@selector(relatedBy))];
        self.relatedBy = [IRLayoutConstraintDescriptor layoutRelationFromString:string];;

        // toItem
        string = aDictionary[NSStringFromSelector(@selector(toItem))];
        self.toItem = string;

        // toItemAttribute
        string = aDictionary[NSStringFromSelector(@selector(toItemAttribute))];
        self.toItemAttribute = [IRLayoutConstraintDescriptor layoutAttributeFromString:string];

        // multiplier
        number = aDictionary[NSStringFromSelector(@selector(multiplier))];
        self.multiplier = number;

        // constant
        number = aDictionary[NSStringFromSelector(@selector(constant))];
        self.constant = number;
    }
    return self;
}

@end