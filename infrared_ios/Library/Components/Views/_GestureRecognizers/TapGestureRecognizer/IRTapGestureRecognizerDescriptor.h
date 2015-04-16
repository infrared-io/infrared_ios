//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRGestureRecognizerDescriptor.h"


@interface IRTapGestureRecognizerDescriptor : IRGestureRecognizerDescriptor

@property(nonatomic) NSUInteger numberOfTapsRequired;
@property(nonatomic) NSUInteger numberOfTouchesRequired;

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

@end