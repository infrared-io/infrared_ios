//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRPickerViewBuilder.h"
#import "IRPickerView.h"
#import "IRViewBuilder.h"
#import "IRPickerViewDescriptor.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRScreenDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRViewController.h"


@implementation IRPickerViewBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRPickerView *irPickerView;

    irPickerView = [[IRPickerView alloc] init];
    [IRPickerViewBuilder setUpComponent:irPickerView componentDescriptor:descriptor viewController:viewController
                                  extra:extra];

    return irPickerView;
}

+ (void) setUpComponent:(IRPickerView *)irPickerView
    componentDescriptor:(IRPickerViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irPickerView componentDescriptor:descriptor viewController:viewController extra:extra];

    irPickerView.showsSelectionIndicator = descriptor.showsSelectionIndicator;
}
@end