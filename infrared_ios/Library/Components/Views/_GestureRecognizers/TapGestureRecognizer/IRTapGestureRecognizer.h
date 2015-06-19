//
// Created by Uros Milivojevic on 8/30/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import "IRGestureRecognizerExport.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol IRTapGestureRecognizerExport <JSExport>

@property (nonatomic) NSUInteger  numberOfTapsRequired;       // Default is 1. The number of taps required to match
@property (nonatomic) NSUInteger  numberOfTouchesRequired;    // Default is 1. The number of fingers required to match

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRTapGestureRecognizer : UITapGestureRecognizer <IRComponentInfoProtocol, IRTapGestureRecognizerExport, IRGestureRecognizerExport>

@end