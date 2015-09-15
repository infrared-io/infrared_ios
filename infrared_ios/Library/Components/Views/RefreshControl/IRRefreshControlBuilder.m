//
// Created by Uros Milivojevic on 9/14/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRRefreshControlBuilder.h"
#import "IRRefreshControl.h"
#import "IRRefreshControlDescriptor.h"
#import "IRViewBuilder.h"


@implementation IRRefreshControlBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRRefreshControl *refreshControl;

    refreshControl = [[IRRefreshControl alloc] init];
    [IRRefreshControlBuilder setUpComponent:refreshControl
                        componentDescriptor:descriptor
                             viewController:viewController
                                      extra:extra];

    return refreshControl;
}

+ (void) setUpComponent:(IRRefreshControl *)irSegmentedControl
    componentDescriptor:(IRRefreshControlDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irSegmentedControl componentDescriptor:descriptor viewController:viewController
                            extra:extra];
    [IRBaseBuilder setUpUIControlInterfaceForComponent:irSegmentedControl fromDescriptor:descriptor];
}

@end