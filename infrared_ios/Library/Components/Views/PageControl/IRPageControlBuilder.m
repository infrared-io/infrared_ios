//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRPageControlBuilder.h"
#import "IRPageControl.h"
#import "IRPageControlDescriptor.h"
#import "IRScreenDescriptor.h"
#import "IRViewBuilder.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRViewController.h"


@implementation IRPageControlBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRPageControl *irPageControl;

    irPageControl = [[IRPageControl alloc] init];
    [IRPageControlBuilder setUpComponent:irPageControl componentDescriptor:descriptor viewController:viewController
                                   extra:extra];

    return irPageControl;
}

+ (void) setUpComponent:(IRPageControl *)irPageControl
    componentDescriptor:(IRPageControlDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irPageControl componentDescriptor:descriptor viewController:viewController
                            extra:extra];
    [IRBaseBuilder setUpUIControlInterfaceForComponent:irPageControl fromDescriptor:descriptor];

    irPageControl.numberOfPages = descriptor.numberOfPages;
    irPageControl.currentPage = descriptor.currentPage;
    irPageControl.hidesForSinglePage = descriptor.hidesForSinglePage;
    irPageControl.defersCurrentPageDisplay = descriptor.defersCurrentPageDisplay;
    irPageControl.pageIndicatorTintColor = descriptor.pageIndicatorTintColor;
    irPageControl.currentPageIndicatorTintColor = descriptor.currentPageIndicatorTintColor;
}

@end