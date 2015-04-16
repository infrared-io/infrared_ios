//
// Created by Uros Milivojevic on 8/30/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol IRPinchGestureRecognizerExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------


@interface IRPinchGestureRecognizer : UIPinchGestureRecognizer <IRComponentInfoProtocol, IRPinchGestureRecognizerExport>



@end