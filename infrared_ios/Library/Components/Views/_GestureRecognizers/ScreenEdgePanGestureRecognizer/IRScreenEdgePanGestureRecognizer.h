//
// Created by Uros Milivojevic on 6/18/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol IRScreenEdgeGestureRecognizerExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRScreenEdgePanGestureRecognizer : UIScreenEdgePanGestureRecognizer <IRComponentInfoProtocol, IRScreenEdgeGestureRecognizerExport>
@end