//
// Created by Uros Milivojevic on 8/30/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import "IRGestureRecognizerExport.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol IRSwipeGestureRecognizerExport <JSExport>

@property(nonatomic) NSUInteger                        numberOfTouchesRequired; // default is 1. the number of fingers that must swipe
@property(nonatomic) UISwipeGestureRecognizerDirection direction;               // default is UISwipeGestureRecognizerDirectionRight. the desired direction of the swipe. multiple directions may be specified if they will result in the same behavior (for example, UITableView swipe delete)

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRSwipeGestureRecognizer : UISwipeGestureRecognizer <IRComponentInfoProtocol, IRSwipeGestureRecognizerExport, IRGestureRecognizerExport>

@end