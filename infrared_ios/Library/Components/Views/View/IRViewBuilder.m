//
// Created by Uros Milivojevic on 10/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRViewBuilder.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRGestureRecognizerDescriptor.h"
#import "IRDataController.h"
#import "IRBaseBuilder+GestureRecognizer.h"
#import "IRTableViewCell.h"
#import "IRScreenDescriptor.h"
#import "IRViewController.h"
#import "IRCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>


@implementation IRViewBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRView *irView;

    irView = [[IRView alloc] init];
    [IRViewBuilder setUpComponent:irView componentDescriptor:descriptor viewController:viewController extra:extra];

    return irView;
}

+ (void) setUpComponent:(IRView *)irView
    componentDescriptor:(IRViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    IRView *irParentView;
    IRView *irSubview;

    if (viewController) {
        [IRBaseBuilder setUpComponent:irView componentDescriptor:descriptor viewController:viewController extra:extra];
    } else {
        [IRBaseBuilder setUpComponentWithoutRegistration:irView fromDescriptor:descriptor];
    }

    irView.componentInfo = extra;

    if ([descriptor.restrictToOrientationsArray count] > 0) {
        [viewController addViewForOrientationRestriction:irView];
    }

    if (CGRectIsNull(descriptor.frame) == NO) {
        irView.frame = descriptor.frame;
    }
    irView.contentMode = descriptor.contentMode;
    irView.tag = descriptor.tag;
    irView.userInteractionEnabled = descriptor.userInteractionEnabled;
    irView.multipleTouchEnabled = descriptor.multipleTouchEnabled;
    irView.alpha = descriptor.alpha; // irView.alpha = 1;
    irView.backgroundColor = descriptor.backgroundColor;
    irView.tintColor = descriptor.tintColor;
    irView.opaque = descriptor.opaque;
    irView.hidden = descriptor.hidden;
    irView.clearsContextBeforeDrawing = descriptor.clearsContextBeforeDrawing;
    irView.clipsToBounds = descriptor.clipsToBounds;
    [irView setIsAccessibilityElement:descriptor.isAccessibilityElement];
    [irView setAccessibilityLabel:descriptor.accessibilityLabel];
    [irView setAccessibilityHint:descriptor.accessibilityHint];
    [irView setAccessibilityTraits:descriptor.accessibilityTraits];

    if (descriptor.cornerRadius != CGFLOAT_UNDEFINED) {
        irView.layer.cornerRadius = descriptor.cornerRadius;
        irView.layer.masksToBounds = YES;
    }

    if (descriptor.borderColor) {
        irView.layer.borderColor = [descriptor.borderColor CGColor];
    }

    if (descriptor.borderWidth != CGFLOAT_UNDEFINED) {
        irView.layer.borderWidth = descriptor.borderWidth;
    }

    if (descriptor.subviewsArray) {
        if ([irView isKindOfClass:[IRTableViewCell class]]) {
            irParentView = ((IRTableViewCell *) irView).contentView;
        } else if ([irView isKindOfClass:[IRCollectionViewCell class]]) {
            irParentView = ((IRCollectionViewCell *) irView).contentView;
        } else {
            irParentView = irView;
        }
        for (IRBaseDescriptor *anDescriptor in descriptor.subviewsArray) {
            irSubview = [IRBaseBuilder buildComponentFromDescriptor:anDescriptor viewController:viewController
                                                              extra:extra];
            [irParentView addSubview:irSubview];
        }
    }

    if (descriptor.gestureRecognizersArray) {
        [IRBaseBuilder addGestureRecognizersForView:irView
                            gestureRecognizersArray:((IRViewDescriptor *) irView.descriptor).gestureRecognizersArray
                                     viewController:viewController
                                              extra:extra];
    }
}

+ (void) setUpRootView:(UIView *)uiView
   componentDescriptor:(IRViewDescriptor *)descriptor
        viewController:(IRViewController *)viewController
                 extra:(id)extra
{
    if (CGRectIsNull(descriptor.frame) == NO) {
        uiView.frame = descriptor.frame;
    }
    uiView.contentMode = descriptor.contentMode;
    uiView.tag = descriptor.tag;
    uiView.userInteractionEnabled = descriptor.userInteractionEnabled;
    uiView.multipleTouchEnabled = descriptor.multipleTouchEnabled;
    uiView.alpha = descriptor.alpha; // uiView.alpha = 1;
    uiView.backgroundColor = descriptor.backgroundColor;
    uiView.tintColor = descriptor.tintColor;
    uiView.opaque = descriptor.opaque;
    uiView.hidden = descriptor.hidden;
    uiView.clearsContextBeforeDrawing = descriptor.clearsContextBeforeDrawing;
    uiView.clipsToBounds = descriptor.clipsToBounds;
    [uiView setIsAccessibilityElement:descriptor.isAccessibilityElement];
    [uiView setAccessibilityLabel:descriptor.accessibilityLabel];
    [uiView setAccessibilityHint:descriptor.accessibilityHint];
    [uiView setAccessibilityTraits:descriptor.accessibilityTraits];

    if (descriptor.cornerRadius != CGFLOAT_UNDEFINED) {
        uiView.layer.cornerRadius = descriptor.cornerRadius;
        uiView.layer.masksToBounds = YES;
    }

    if (descriptor.borderColor) {
        uiView.layer.borderColor = [descriptor.borderColor CGColor];
    }

    if (descriptor.borderWidth != CGFLOAT_UNDEFINED) {
        uiView.layer.borderWidth = descriptor.borderWidth;
    }

    if (descriptor.gestureRecognizersArray) {
        [IRBaseBuilder addGestureRecognizersForView:uiView
                            gestureRecognizersArray:descriptor.gestureRecognizersArray
                                     viewController:viewController
                                              extra:extra];
    }
}

@end