//
// Created by Uros Milivojevic on 8/30/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRGestureRecognizerDescriptor.h"


@interface IRSwipeGestureRecognizerDescriptor : IRGestureRecognizerDescriptor

#if TARGET_OS_IPHONE
/*
UISwipeGestureRecognizerDirectionRight, UISwipeGestureRecognizerDirectionLeft, UISwipeGestureRecognizerDirectionUp, UISwipeGestureRecognizerDirectionDown
 */
@property(nonatomic) UISwipeGestureRecognizerDirection direction;
#endif
@property(nonatomic) NSUInteger numberOfTouchesRequired;

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

@end