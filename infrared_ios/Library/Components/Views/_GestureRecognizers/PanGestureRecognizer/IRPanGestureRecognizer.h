//
// Created by Uros Milivojevic on 6/18/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "IRComponentInfoProtocol.h"
#import "IRGestureRecognizerExport.h"

@protocol IRPanGestureRecognizerExport <JSExport>

@property (nonatomic)          NSUInteger minimumNumberOfTouches;   // default is 1. the minimum number of touches required to match
@property (nonatomic)          NSUInteger maximumNumberOfTouches;   // default is UINT_MAX. the maximum number of touches that can be down

- (CGPoint)translationInView:(UIView *)view;                        // translation in the coordinate system of the specified view
- (void)setTranslation:(CGPoint)translation inView:(UIView *)view;

- (CGPoint)velocityInView:(UIView *)view;                           // velocity of the pan in pixels/second in the coordinate system of the specified view

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRPanGestureRecognizer : UIPanGestureRecognizer <IRComponentInfoProtocol, IRPanGestureRecognizerExport, IRGestureRecognizerExport>

@end