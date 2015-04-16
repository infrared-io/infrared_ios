//
// Created by Uros Milivojevic on 1/12/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRPinAnnotationViewBuilder.h"
#import "IRBaseDescriptor.h"
#import "IRPinAnnotationView.h"
#import "IRViewBuilder.h"
#import "IRPinAnnotationViewDescriptor.h"
#import "IRBaseAnnotationViewBuilder.h"
#import "IRBaseAnnotation.h"
#import "IRView.h"
#import "IRScreenDescriptor.h"
#import "IRViewController.h"
#import "IRViewDescriptor.h"


@implementation IRPinAnnotationViewBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRPinAnnotationView *irPinAnnotationView;
    IRBaseAnnotation *annotation;
    NSString *identifier;

    annotation = extra[annotationKEY];
    identifier = descriptor.componentId;
    irPinAnnotationView = [[IRPinAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:identifier];
    [IRPinAnnotationViewBuilder setUpComponent:irPinAnnotationView componentDescriptor:descriptor
                                viewController:viewController extra:extra];

    return irPinAnnotationView;
}

+ (void) setUpComponent:(IRPinAnnotationView *)irPinAnnotationView
    componentDescriptor:(IRPinAnnotationViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRBaseAnnotationViewBuilder setUpComponent:irPinAnnotationView componentDescriptor:descriptor
                                 viewController:viewController extra:extra];

    irPinAnnotationView.pinColor = descriptor.pinColor;
    irPinAnnotationView.animatesDrop = descriptor.animatesDrop;
}

@end