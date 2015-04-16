//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRDatePickerBuilder.h"
#import "IRDatePickerDescriptor.h"
#import "IRDatePicker.h"
#import "IRViewBuilder.h"
#import "IRScreenDescriptor.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRViewController.h"
#import "IRViewDescriptor.h"


@implementation IRDatePickerBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRDatePicker *irDatePicker;

    irDatePicker = [[IRDatePicker alloc] init];
    [IRDatePickerBuilder setUpComponent:irDatePicker componentDescriptor:descriptor viewController:viewController
                                  extra:extra];

    return irDatePicker;
}

+ (void) setUpComponent:(IRDatePicker *)irDatePicker
    componentDescriptor:(IRDatePickerDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irDatePicker componentDescriptor:descriptor viewController:viewController extra:extra];
    [IRBaseBuilder setUpUIControlInterfaceForComponent:irDatePicker fromDescriptor:descriptor];

    irDatePicker.datePickerMode = descriptor.datePickerMode;
    if (descriptor.date) {
        irDatePicker.date = descriptor.date;
    }
    irDatePicker.minimumDate = descriptor.minimumDate;
    irDatePicker.maximumDate = descriptor.maximumDate;
    irDatePicker.countDownDuration = descriptor.countDownDuration;
    irDatePicker.minuteInterval = descriptor.minuteInterval;
}

@end