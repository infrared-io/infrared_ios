//
// Created by Uros Milivojevic on 7/26/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSExport;

@protocol UIRotationGestureRecognizerExport <JSExport>

@property (nonatomic)          CGFloat rotation;            // rotation in radians
@property (nonatomic,readonly) CGFloat velocity;            // velocity of the pinch in radians/second

@end