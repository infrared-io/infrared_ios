//
// Created by Uros Milivojevic on 6/18/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol IRRotationGestureRecognizerExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRRotationGestureRecognizer : UIRotationGestureRecognizer <IRComponentInfoProtocol, IRRotationGestureRecognizerExport>

@end