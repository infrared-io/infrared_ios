//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRSliderBuilder.h"
#import "IRSliderDescriptor.h"
#import "IRSlider.h"
#import "IRViewBuilder.h"
#import "IRSimpleCache.h"
#import "IRScreenDescriptor.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRViewController.h"
#import "IRViewDescriptor.h"
#import "IRUtil.h"


@implementation IRSliderBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRSlider *irSlider;

    irSlider = [[IRSlider alloc] init];
    [IRSliderBuilder setUpComponent:irSlider componentDescriptor:descriptor viewController:viewController extra:extra];

    return irSlider;
}

+ (void) setUpComponent:(IRSlider *)irSlider
    componentDescriptor:(IRSliderDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{

    [IRViewBuilder setUpComponent:irSlider componentDescriptor:descriptor viewController:viewController extra:extra];
    [IRBaseBuilder setUpUIControlInterfaceForComponent:irSlider fromDescriptor:descriptor];

    irSlider.value = descriptor.value;
    irSlider.minimumValue = descriptor.minimumValue;
    irSlider.maximumValue = descriptor.maximumValue;
    // TODO: implement setting image
    irSlider.minimumValueImage = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.minimumValueImage];
    irSlider.maximumValueImage = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.maximumValueImage];
    irSlider.continuous = descriptor.continuous;
    irSlider.minimumTrackTintColor = descriptor.minimumTrackTintColor;
    irSlider.maximumTrackTintColor = descriptor.maximumTrackTintColor;
    irSlider.thumbTintColor = descriptor.thumbTintColor;
}

@end