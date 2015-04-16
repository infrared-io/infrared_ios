//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRToolbarBuilder.h"
#import "IRToolbar.h"
#import "IRToolbarDescriptor.h"
#import "IRViewBuilder.h"
#import "IRBarButtonItem.h"
#import "IRScreenDescriptor.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRViewController.h"


@implementation IRToolbarBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRToolbar *irToolbar;

    irToolbar = [[IRToolbar alloc] init];
    [IRToolbarBuilder setUpComponent:irToolbar componentDescriptor:descriptor viewController:viewController extra:extra];

    return irToolbar;
}

+ (void) setUpComponent:(IRToolbar *)irToolbar
    componentDescriptor:(IRToolbarDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
//    IRBarButtonItem *anItem;
    NSMutableArray *array;

    [IRViewBuilder setUpComponent:irToolbar componentDescriptor:descriptor viewController:viewController extra:extra];

    irToolbar.barStyle = descriptor.barStyle;
    if ([descriptor.items count] > 0) {
        array = [IRBaseBuilder buildComponentsArrayFromDescriptorsArray:descriptor.items viewController:viewController
                                                                  extra:extra];
    } else {
        array = nil;
    }
    irToolbar.items = array;
    irToolbar.items = array;
    irToolbar.translucent = descriptor.translucent;
    irToolbar.barTintColor = descriptor.barTintColor;
}

@end