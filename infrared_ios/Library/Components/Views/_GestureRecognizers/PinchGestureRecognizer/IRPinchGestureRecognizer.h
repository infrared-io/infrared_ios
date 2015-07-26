//
// Created by Uros Milivojevic on 8/30/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import "UIGestureRecognizerExport.h"
#import "UIPinchGestureRecognizerExport.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol IRPinchGestureRecognizerExport <JSExport>

//@property (nonatomic)          CGFloat scale;               // scale relative to the touch points in screen coordinates
//@property (nonatomic,readonly) CGFloat velocity;            // velocity of the pinch in scale/second

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------


@interface IRPinchGestureRecognizer : UIPinchGestureRecognizer <IRComponentInfoProtocol, UIPinchGestureRecognizerExport, IRPinchGestureRecognizerExport, UIGestureRecognizerExport>

@end