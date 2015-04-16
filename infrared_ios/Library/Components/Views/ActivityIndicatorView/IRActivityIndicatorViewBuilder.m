//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRActivityIndicatorViewBuilder.h"
#import "IRActivityIndicatorViewDescriptor.h"
#import "IRActivityIndicatorView.h"
#import "IRScreenDescriptor.h"
#import "IRViewBuilder.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRViewController.h"
#import "IRViewDescriptor.h"


@implementation IRActivityIndicatorViewBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRActivityIndicatorView *irActivityIndicatorView;

    irActivityIndicatorView = [[IRActivityIndicatorView alloc] init];
    [IRActivityIndicatorViewBuilder setUpComponent:irActivityIndicatorView componentDescriptor:descriptor
                                    viewController:viewController extra:extra];

    return irActivityIndicatorView;
}

+ (void) setUpComponent:(IRActivityIndicatorView *)irActivityIndicatorView
    componentDescriptor:(IRActivityIndicatorViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irActivityIndicatorView componentDescriptor:descriptor viewController:viewController
                            extra:extra];

    irActivityIndicatorView.activityIndicatorViewStyle = descriptor.activityIndicatorViewStyle;
    irActivityIndicatorView.hidesWhenStopped = descriptor.hidesWhenStopped;
    if (descriptor.animating) {
        [irActivityIndicatorView startAnimating];
    }
    irActivityIndicatorView.color = descriptor.color;
}

@end