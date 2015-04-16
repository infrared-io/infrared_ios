//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRSwitchBuilder.h"
#import "IRSwitch.h"
#import "IRSlider.h"
#import "IRSwitchDescriptor.h"
#import "IRViewBuilder.h"
#import "IRSimpleCache.h"
#import "IRScreenDescriptor.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRViewController.h"


@implementation IRSwitchBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRSwitch *irSwitch;

    irSwitch = [[IRSwitch alloc] init];
    [IRSwitchBuilder setUpComponent:irSwitch componentDescriptor:descriptor viewController:viewController extra:extra];

    return irSwitch;
}

+ (void) setUpComponent:(IRSwitch *)irSwitch
    componentDescriptor:(IRSwitchDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irSwitch componentDescriptor:descriptor viewController:viewController extra:extra];
    [IRBaseBuilder setUpUIControlInterfaceForComponent:irSwitch fromDescriptor:descriptor];

    irSwitch.onTintColor = descriptor.onTintColor;
    irSwitch.tintColor = descriptor.tintColor;
    irSwitch.thumbTintColor = descriptor.thumbTintColor;
    irSwitch.onImage = [[IRSimpleCache sharedInstance] imageForURI:descriptor.onImage];
    irSwitch.offImage = [[IRSimpleCache sharedInstance] imageForURI:descriptor.offImage];
}

@end