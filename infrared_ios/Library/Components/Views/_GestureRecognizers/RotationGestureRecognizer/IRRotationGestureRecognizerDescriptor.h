//
// Created by Uros Milivojevic on 6/18/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRGestureRecognizerDescriptor.h"


@interface IRRotationGestureRecognizerDescriptor : IRGestureRecognizerDescriptor

@property (nonatomic)          CGFloat rotation;            // rotation in radians

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

@end