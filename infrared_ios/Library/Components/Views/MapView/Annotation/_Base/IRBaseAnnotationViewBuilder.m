//
// Created by Uros Milivojevic on 1/12/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "IRBaseAnnotationViewBuilder.h"
#import "IRBaseAnnotationViewDescriptor.h"
#import "IRSimpleCache.h"
#import "IRView.h"
#import "IRViewDescriptor.h"
#import "IRViewBuilder.h"
#import "IRScreenDescriptor.h"
#import "IRViewController.h"
#import "IRBaseDescriptor.h"
#import "IRUtil.h"


@implementation IRBaseAnnotationViewBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    NSAssert(false, @"IRBarItemBuilder - IRBarItem should NEVER be built explicitly!");
    return nil;
}

+ (void) setUpComponent:(MKAnnotationView *)mkAnnotationView
    componentDescriptor:(IRBaseAnnotationViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:mkAnnotationView componentDescriptor:descriptor viewController:viewController
                            extra:extra];

    mkAnnotationView.image = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.image];
    mkAnnotationView.centerOffset = descriptor.centerOffset;
    mkAnnotationView.calloutOffset = descriptor.calloutOffset;
    mkAnnotationView.enabled = descriptor.enabled;
    mkAnnotationView.highlighted = descriptor.highlighted;
    mkAnnotationView.selected = descriptor.selected;
    mkAnnotationView.canShowCallout = descriptor.canShowCallout;
    mkAnnotationView.leftCalloutAccessoryView = [IRBaseBuilder buildComponentFromDescriptor:descriptor.leftCalloutAccessoryView
                                                                             viewController:viewController extra:extra];
    mkAnnotationView.rightCalloutAccessoryView = [IRBaseBuilder buildComponentFromDescriptor:descriptor.rightCalloutAccessoryView
                                                                              viewController:viewController extra:extra];
    mkAnnotationView.draggable = descriptor.draggable;
}

@end