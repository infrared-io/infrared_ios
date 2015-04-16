//
// Created by Uros Milivojevic on 12/4/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRScrollViewBuilder.h"
#import "IRScrollViewDescriptor.h"
#import "IRScrollView.h"
#import "IRViewBuilder.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRScreenDescriptor.h"
#import "IRViewController.h"
#import "IRViewDescriptor.h"


@implementation IRScrollViewBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRScrollView *irScrollView;

    irScrollView = [[IRScrollView alloc] init];
    [IRScrollViewBuilder setUpComponent:irScrollView componentDescriptor:descriptor viewController:viewController
                                  extra:extra];

    return irScrollView;
}

+ (void) setUpComponent:(IRScrollView *)irScrollView
    componentDescriptor:(IRScrollViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irScrollView componentDescriptor:descriptor viewController:viewController extra:extra];

    if (CGSizeEqualToSize(descriptor.contentSize, CGSizeNull) == NO) {
        irScrollView.contentSize = descriptor.contentSize;
    }
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.contentInset, UIEdgeInsetsNull) == NO) {
        irScrollView.contentInset = descriptor.contentInset;
    }
    irScrollView.indicatorStyle = descriptor.indicatorStyle;
    irScrollView.showsHorizontalScrollIndicator = descriptor.showsHorizontalScrollIndicator;
    irScrollView.showsVerticalScrollIndicator = descriptor.showsVerticalScrollIndicator;
    irScrollView.scrollEnabled = descriptor.scrollEnabled;
    irScrollView.pagingEnabled = descriptor.pagingEnabled;
    irScrollView.directionalLockEnabled = descriptor.directionalLockEnabled;
    irScrollView.bounces = descriptor.bounces;
    irScrollView.alwaysBounceVertical = descriptor.alwaysBounceVertical;
    irScrollView.alwaysBounceHorizontal = descriptor.alwaysBounceHorizontal;
    irScrollView.minimumZoomScale = descriptor.minimumZoomScale;
    irScrollView.maximumZoomScale = descriptor.maximumZoomScale;
    irScrollView.bouncesZoom = descriptor.bouncesZoom;
    irScrollView.delaysContentTouches = descriptor.delaysContentTouches;
    irScrollView.canCancelContentTouches = descriptor.canCancelContentTouches;
    irScrollView.keyboardDismissMode = descriptor.keyboardDismissMode;
}

@end