//
// Created by Uros Milivojevic on 6/18/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRGestureRecognizerDescriptor.h"


@interface IRScreenEdgePanGestureRecognizerDescriptor : IRGestureRecognizerDescriptor

#if TARGET_OS_IPHONE
@property (readwrite, nonatomic, assign) UIRectEdge edges; //< The edges on which this gesture recognizes, relative to the current interface orientation
#endif

@end