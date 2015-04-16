//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRStepperBuilder.h"
#import "IRStepperDescriptor.h"
#import "IRStepper.h"
#import "IRViewBuilder.h"
#import "IRScreenDescriptor.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRViewController.h"
#import "IRViewDescriptor.h"


@implementation IRStepperBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRStepper *irStepper;

    irStepper = [[IRStepper alloc] init];
    [IRStepperBuilder setUpComponent:irStepper componentDescriptor:descriptor viewController:viewController extra:extra];

    return irStepper;
}

+ (void) setUpComponent:(IRStepper *)irStepper
    componentDescriptor:(IRStepperDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irStepper componentDescriptor:descriptor viewController:viewController extra:extra];
    [IRBaseBuilder setUpUIControlInterfaceForComponent:irStepper fromDescriptor:descriptor];

    irStepper.continuous = descriptor.continuous;
    irStepper.autorepeat = descriptor.autorepeat;
    irStepper.wraps = descriptor.wraps;
    irStepper.value = descriptor.value;
    irStepper.minimumValue = descriptor.minimumValue;
    irStepper.maximumValue = descriptor.maximumValue;
    irStepper.stepValue = descriptor.stepValue;
}

@end