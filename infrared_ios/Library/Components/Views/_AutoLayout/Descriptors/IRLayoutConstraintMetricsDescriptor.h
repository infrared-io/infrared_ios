//
// Created by Uros Milivojevic on 10/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseDescriptor.h"


@interface IRLayoutConstraintMetricsDescriptor : IRBaseDescriptor

@property (nonatomic, strong) NSDictionary *values;

@property (nonatomic, strong) NSString *referenceId;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

@end