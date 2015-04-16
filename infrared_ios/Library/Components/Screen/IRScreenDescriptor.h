//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseDescriptor.h"
#import "IRViewControllerDescriptor.h"

@class IRViewDescriptor;

@interface IRScreenDescriptor : IRBaseDescriptor

@property (nonatomic, strong) IRViewControllerDescriptor *viewControllerDescriptor;
@property (nonatomic, strong) IRViewDescriptor *rootViewDescriptor;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

@end