//
// Created by Uros Milivojevic on 6/18/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import "UIGestureRecognizerExport.h"
#import "UIRotationGestureRecognizerExport.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol IRRotationGestureRecognizerExport <JSExport>

//@property (nonatomic)          CGFloat rotation;            // rotation in radians
//@property (nonatomic,readonly) CGFloat velocity;            // velocity of the pinch in radians/second

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRRotationGestureRecognizer : UIRotationGestureRecognizer <IRComponentInfoProtocol, UIRotationGestureRecognizerExport, IRRotationGestureRecognizerExport, UIGestureRecognizerExport>

@end