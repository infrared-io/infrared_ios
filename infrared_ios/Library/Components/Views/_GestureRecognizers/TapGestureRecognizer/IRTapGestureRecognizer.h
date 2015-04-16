//
// Created by Uros Milivojevic on 8/30/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol IRTapGestureRecognizerExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRTapGestureRecognizer : UITapGestureRecognizer <IRComponentInfoProtocol, IRTapGestureRecognizerExport>



@end