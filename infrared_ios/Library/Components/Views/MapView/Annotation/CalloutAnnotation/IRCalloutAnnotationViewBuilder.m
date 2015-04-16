//
// Created by Uros Milivojevic on 1/12/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRCalloutAnnotationViewBuilder.h"
#import "IRBaseDescriptor.h"
#import "IRScreenDescriptor.h"
#import "IRView.h"
#import "IRCalloutAnnotationViewDescriptor.h"
#import "IRCalloutAnnotationView.h"
#import "IRBaseAnnotationViewBuilder.h"
#import "IRBaseAnnotation.h"
#import "IRViewController.h"


@implementation IRCalloutAnnotationViewBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRCalloutAnnotationView *irCalloutAnnotationView;
    IRBaseAnnotation *annotation;
    NSString *identifier;

    annotation = extra[annotationKEY];
    identifier = descriptor.componentId;
    irCalloutAnnotationView = [[IRCalloutAnnotationView alloc] initWithAnnotation:annotation
                                                                  reuseIdentifier:identifier];
    [IRCalloutAnnotationViewBuilder setUpComponent:irCalloutAnnotationView componentDescriptor:descriptor
                                    viewController:viewController extra:extra];

    return irCalloutAnnotationView;
}

+ (void) setUpComponent:(IRCalloutAnnotationView *)irCalloutAnnotationView
    componentDescriptor:(IRCalloutAnnotationViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRBaseAnnotationViewBuilder setUpComponent:irCalloutAnnotationView componentDescriptor:descriptor
                                 viewController:viewController extra:extra];

}

@end