//
// Created by Uros Milivojevic on 7/26/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSExport;

@protocol UIPanGestureRecognizerExport <JSExport>

@property (nonatomic)          NSUInteger minimumNumberOfTouches;   // default is 1. the minimum number of touches required to match
@property (nonatomic)          NSUInteger maximumNumberOfTouches;   // default is UINT_MAX. the maximum number of touches that can be down

- (CGPoint)translationInView:(UIView *)view;                        // translation in the coordinate system of the specified view
- (void)setTranslation:(CGPoint)translation inView:(UIView *)view;

- (CGPoint)velocityInView:(UIView *)view;                           // velocity of the pan in pixels/second in the coordinate system of the specified view

@end