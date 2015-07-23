//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRProgressViewBuilder.h"
#import "IRProgressView.h"
#import "IRProgressViewDescriptor.h"
#import "IRScreenDescriptor.h"
#import "IRViewBuilder.h"
#import "IRSimpleCache.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRViewController.h"
#import "IRViewDescriptor.h"
#import "IRUtil.h"


@implementation IRProgressViewBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRProgressView *irProgressView;

    irProgressView = [[IRProgressView alloc] init];
    [IRProgressViewBuilder setUpComponent:irProgressView componentDescriptor:descriptor viewController:viewController
                                    extra:extra];

    return irProgressView;
}

+ (void) setUpComponent:(IRProgressView *)irProgressView
    componentDescriptor:(IRProgressViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irProgressView componentDescriptor:descriptor viewController:viewController
                            extra:extra];

    irProgressView.progressViewStyle = descriptor.progressViewStyle;
    irProgressView.progress = descriptor.progress;
    irProgressView.progressTintColor = descriptor.progressTintColor;
    irProgressView.trackTintColor = descriptor.trackTintColor;
    irProgressView.progressImage = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.progressImage];
    irProgressView.trackImage = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.trackImage];
}

@end