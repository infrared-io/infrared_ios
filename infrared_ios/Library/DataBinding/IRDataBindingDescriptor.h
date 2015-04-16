//
// Created by Uros Milivojevic on 10/17/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseDescriptor.h"


@interface IRDataBindingDescriptor : IRBaseDescriptor

@property (nonatomic, strong) NSString *property;
@property (nonatomic) DataBindingMode mode;
@property (nonatomic, strong) NSString *data;

+ (IRDataBindingDescriptor *) newDataBindingDescriptorWithDictionary:(NSDictionary *)dictionary;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

@end