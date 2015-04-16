//
// Created by Uros Milivojevic on 10/21/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseBuilder.h"

@class IRGestureRecognizerDescriptor;
@class IRView;
@class IRScreenDescriptor;
@class IRViewController;

@interface IRBaseBuilder (GestureRecognizer)

+ (void) addGestureRecognizersForView:(UIView *)uiView
              gestureRecognizersArray:(NSArray *)gestureRecognizersArray
                       viewController:(IRViewController *)viewController
                                extra:(id)extra;

+ (void) setRequireGestureRecognizerToFailForView:(UIView *)uiView
                                   viewController:(IRViewController *)viewController;

@end