//
// Created by Uros Milivojevic on 8/30/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRGestureRecognizerDescriptor.h"


@interface IRPinchGestureRecognizerDescriptor : IRGestureRecognizerDescriptor

@property(nonatomic) CGFloat scale;

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

@end