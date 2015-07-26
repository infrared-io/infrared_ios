//
// Created by Uros Milivojevic on 10/21/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRBaseBuilder+GestureRecognizer.h"
#import "IRView.h"
#import "IRDataController.h"
#import "IRViewDescriptor.h"
#import "IRGestureRecognizerDescriptor.h"
#import "IRTapGestureRecognizerDescriptor.h"
#import "IRSwipeGestureRecognizerDescriptor.h"
#import "IRScreenDescriptor.h"
#import "IRPinchGestureRecognizerDescriptor.h"
#import "IRTapGestureRecognizer.h"
#import "IRViewController.h"
#import "IRSwipeGestureRecognizer.h"
#import "IRPinchGestureRecognizer.h"
#import "IRRotationGestureRecognizerDescriptor.h"
#import "IRRotationGestureRecognizer.h"
#import "IRPanGestureRecognizerDescriptor.h"
#import "IRPanGestureRecognizer.h"
#import "IRLongPressGestureRecognizer.h"
#import "IRLongPressGestureRecognizerDescriptor.h"
#import "IRScreenEdgePanGestureRecognizerDescriptor.h"
#import "IRScreenEdgePanGestureRecognizer.h"


@implementation IRBaseBuilder (GestureRecognizer)

+ (void) addGestureRecognizersForView:(UIView *)uiView
              gestureRecognizersArray:(NSArray *)gestureRecognizersArray
                       viewController:(IRViewController *)viewController
                                extra:(id)extra
{
    UIGestureRecognizer *gestureRecognizer;
    for (IRGestureRecognizerDescriptor *anDescriptor in gestureRecognizersArray) {
        if ([anDescriptor.gestureActions length] > 0) {
            gestureRecognizer = [IRBaseBuilder createGestureRecognizerForDescriptor:anDescriptor];
            if (gestureRecognizer) {
                ((id <IRComponentInfoProtocol>) gestureRecognizer).componentInfo = extra;

                [IRBaseBuilder setTargetActionInterceptor:gestureRecognizer];
                [uiView addGestureRecognizer:gestureRecognizer];

                [[IRDataController sharedInstance] registerGestureRecognizer:gestureRecognizer
                                                              viewController:viewController];
            }
        }
    }
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

+ (UIGestureRecognizer *) createGestureRecognizerForDescriptor:(IRGestureRecognizerDescriptor *)descriptor
{
    UIGestureRecognizer *gestureRecognizer = nil;
    if ([descriptor isKindOfClass:[IRTapGestureRecognizerDescriptor class]]
        && [descriptor isKindOfClass:[IRLongPressGestureRecognizerDescriptor class]] == NO)
    {
        gestureRecognizer = [IRBaseBuilder createTapGestureRecognizerForDescriptor:(IRTapGestureRecognizerDescriptor *) descriptor];
    } else if ([descriptor isKindOfClass:[IRSwipeGestureRecognizerDescriptor class]]) {
        gestureRecognizer = [IRBaseBuilder createSwipeGestureRecognizerForDescriptor:(IRSwipeGestureRecognizerDescriptor *) descriptor];
    } else if ([descriptor isKindOfClass:[IRPinchGestureRecognizerDescriptor class]]) {
        gestureRecognizer = [IRBaseBuilder createPinchGestureRecognizerForDescriptor:(IRPinchGestureRecognizerDescriptor *) descriptor];
    } else if ([descriptor isKindOfClass:[IRRotationGestureRecognizerDescriptor class]]) {
        gestureRecognizer = [IRBaseBuilder createRotationGestureRecognizerForDescriptor:(IRRotationGestureRecognizerDescriptor *) descriptor];
    } else if ([descriptor isKindOfClass:[IRPanGestureRecognizerDescriptor class]]
               && [descriptor isKindOfClass:[IRScreenEdgePanGestureRecognizerDescriptor class]] == NO)
    {
        gestureRecognizer = [IRBaseBuilder createPanGestureRecognizerForDescriptor:(IRPanGestureRecognizerDescriptor *) descriptor];
    } else if ([descriptor isKindOfClass:[IRLongPressGestureRecognizerDescriptor class]]) {
        gestureRecognizer = [IRBaseBuilder createLongPressGestureRecognizerForDescriptor:(IRLongPressGestureRecognizerDescriptor *) descriptor];
    } else if ([descriptor isKindOfClass:[IRScreenEdgePanGestureRecognizerDescriptor class]]) {
        gestureRecognizer = [IRBaseBuilder createScreenEdgePanGestureRecognizerForDescriptor:(IRScreenEdgePanGestureRecognizerDescriptor *) descriptor];
    }
    return gestureRecognizer;
}

+ (IRTapGestureRecognizer *) createTapGestureRecognizerForDescriptor:(IRTapGestureRecognizerDescriptor *)descriptor
{
    IRTapGestureRecognizer *gestureRecognizer = [[IRTapGestureRecognizer alloc] init];
    gestureRecognizer.descriptor = descriptor;
    gestureRecognizer.numberOfTapsRequired = descriptor.numberOfTapsRequired;
    gestureRecognizer.numberOfTouchesRequired = descriptor.numberOfTouchesRequired;
    return gestureRecognizer;
}

+ (IRSwipeGestureRecognizer *) createSwipeGestureRecognizerForDescriptor:(IRSwipeGestureRecognizerDescriptor *)descriptor
{
    IRSwipeGestureRecognizer *gestureRecognizer = [[IRSwipeGestureRecognizer alloc] init];
    gestureRecognizer.descriptor = descriptor;
    gestureRecognizer.direction = descriptor.direction;
    gestureRecognizer.numberOfTouchesRequired = descriptor.numberOfTouchesRequired;
    return gestureRecognizer;
}

+ (IRPinchGestureRecognizer *) createPinchGestureRecognizerForDescriptor:(IRPinchGestureRecognizerDescriptor *)descriptor
{
    IRPinchGestureRecognizer *gestureRecognizer = [[IRPinchGestureRecognizer alloc] init];
    gestureRecognizer.descriptor = descriptor;
    gestureRecognizer.scale = descriptor.scale;
    return gestureRecognizer;
}

+ (IRRotationGestureRecognizer *) createRotationGestureRecognizerForDescriptor:(IRRotationGestureRecognizerDescriptor *)descriptor
{
    IRRotationGestureRecognizer *gestureRecognizer = [[IRRotationGestureRecognizer alloc] init];
    gestureRecognizer.descriptor = descriptor;
    if (descriptor.rotation != CGFLOAT_UNDEFINED) {
        gestureRecognizer.rotation = descriptor.rotation;
    }
    return gestureRecognizer;
}

+ (IRPanGestureRecognizer *) createPanGestureRecognizerForDescriptor:(IRPanGestureRecognizerDescriptor *)descriptor
{
    IRPanGestureRecognizer *gestureRecognizer = [[IRPanGestureRecognizer alloc] init];
    gestureRecognizer.descriptor = descriptor;
    gestureRecognizer.minimumNumberOfTouches = descriptor.minimumNumberOfTouches;
    gestureRecognizer.maximumNumberOfTouches = descriptor.maximumNumberOfTouches;
    return gestureRecognizer;
}

+ (IRLongPressGestureRecognizer *) createLongPressGestureRecognizerForDescriptor:(IRLongPressGestureRecognizerDescriptor *)descriptor
{
    IRLongPressGestureRecognizer *gestureRecognizer = [[IRLongPressGestureRecognizer alloc] init];
    gestureRecognizer.descriptor = descriptor;
    gestureRecognizer.minimumPressDuration = descriptor.minimumPressDuration;
    gestureRecognizer.allowableMovement = descriptor.allowableMovement;
    return gestureRecognizer;
}

+ (IRScreenEdgePanGestureRecognizer *) createScreenEdgePanGestureRecognizerForDescriptor:(IRScreenEdgePanGestureRecognizerDescriptor *)descriptor
{
    IRScreenEdgePanGestureRecognizer *gestureRecognizer = [[IRScreenEdgePanGestureRecognizer alloc] init];
    gestureRecognizer.descriptor = descriptor;
    gestureRecognizer.edges = descriptor.edges;
    return gestureRecognizer;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

+ (void) setRequireGestureRecognizerToFailForViewsArray:(NSArray *)viewsArray
                                         viewController:(IRViewController *)viewController
{
    for (IRView *anIRView in viewsArray) {
        [IRBaseBuilder setRequireGestureRecognizerToFailForView:anIRView
                                                 viewController:viewController];
    }
}

+ (void) setRequireGestureRecognizerToFailForView:(UIView *)uiView
                                   viewController:(IRViewController *)viewController
{
    for (UIGestureRecognizer *anGestureRecognizer in uiView.gestureRecognizers) {
        if ([anGestureRecognizer conformsToProtocol:@protocol(IRComponentInfoProtocol)]) {
            [IRBaseBuilder setRequireGestureRecognizerToFail:anGestureRecognizer viewController:viewController];
        }
    }

    if ([uiView.subviews count] > 0) {
        [IRBaseBuilder setRequireGestureRecognizerToFailForViewsArray:uiView.subviews viewController:viewController];
    }
}

+ (void) setRequireGestureRecognizerToFail:(UIGestureRecognizer *)gestureRecognizer
                            viewController:(IRViewController *)viewController
{
    UIGestureRecognizer *gestureRecognizerToFail;
    IRGestureRecognizerDescriptor *descriptor = (IRGestureRecognizerDescriptor *) ((id <IRComponentInfoProtocol>) gestureRecognizer).descriptor;
    if (descriptor.requireGestureRecognizerToFail) {
        gestureRecognizerToFail = [[IRDataController sharedInstance] gestureRecognizerWithId:descriptor.requireGestureRecognizerToFail
                                                                              viewController:viewController];
        [gestureRecognizer requireGestureRecognizerToFail:gestureRecognizerToFail];
    }
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

+ (void) setTargetActionInterceptor:(UIGestureRecognizer *)gestureRecognizer
{
    [gestureRecognizer addTarget:[IRBaseBuilder class] action:@selector(handleGestureRecognizer:)];
}

+ (void) handleGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    IRGestureRecognizerDescriptor *descriptor = (IRGestureRecognizerDescriptor *) ((id <IRComponentInfoProtocol>) gestureRecognizer).descriptor;
    NSString *action = descriptor.gestureActions;
    [IRBaseBuilder executeAction:action withGestureRecognizer:gestureRecognizer];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

+ (void) executeAction:(NSString *)action
 withGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (gestureRecognizer) {
        dictionary[@"gestureRecognizer"] = gestureRecognizer;
    }
    if (((id <IRComponentInfoProtocol>) gestureRecognizer).componentInfo) {
        dictionary[@"extra"] = ((id <IRComponentInfoProtocol>) gestureRecognizer).componentInfo;
    }
    [IRBaseBuilder executeAction:action withDictionary:dictionary sourceView:gestureRecognizer.view];
}

@end