//
// Created by Uros Milivojevic on 6/18/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import "IRGestureRecognizerExport.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol IRScreenEdgeGestureRecognizerExport <JSExport>

@property (readwrite, nonatomic, assign) UIRectEdge edges; //< The edges on which this gesture recognizes, relative to the current interface orientation

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRScreenEdgePanGestureRecognizer : UIScreenEdgePanGestureRecognizer <IRComponentInfoProtocol, IRScreenEdgeGestureRecognizerExport, IRGestureRecognizerExport>

@end