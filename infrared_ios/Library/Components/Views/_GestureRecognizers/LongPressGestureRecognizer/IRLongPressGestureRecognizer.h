//
// Created by Uros Milivojevic on 6/18/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "IRComponentInfoProtocol.h"
#import "IRGestureRecognizerExport.h"
#import "IRTapGestureRecognizer.h"

@protocol IRLongPressGestureRecognizerExport <JSExport>

@property (nonatomic) CFTimeInterval minimumPressDuration; // Default is 0.5. Time in seconds the fingers must be held down for the gesture to be recognized
@property (nonatomic) CGFloat allowableMovement;           // Default is 10. Maximum movement in pixels allowed before the gesture fails. Once recognized (after minimumPressDuration) there is no limit on finger movement for the remainder of the touch tracking

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRLongPressGestureRecognizer : UILongPressGestureRecognizer  <IRComponentInfoProtocol, IRLongPressGestureRecognizerExport, IRTapGestureRecognizerExport, IRGestureRecognizerExport>

@end