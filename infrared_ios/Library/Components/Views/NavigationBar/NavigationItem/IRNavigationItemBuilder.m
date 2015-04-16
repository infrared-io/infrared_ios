//
// Created by Uros Milivojevic on 12/12/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRNavigationItemBuilder.h"
#import "IRNavigationItem.h"
#import "IRNavigationItemDescriptor.h"
#import "IRView.h"
#import "IRScreenDescriptor.h"
#import "IRBaseDescriptor.h"
#import "IRViewController.h"


@implementation IRNavigationItemBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRNavigationItem *irNavigationItem;

    irNavigationItem = [[IRNavigationItem alloc] init];
    [IRNavigationItemBuilder setUpComponent:irNavigationItem componentDescriptor:descriptor
                             viewController:viewController extra:extra];

    return irNavigationItem;
}

+ (void) setUpComponent:(IRNavigationItem *)irNavigationItem
    componentDescriptor:(IRNavigationItemDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRBaseBuilder setUpComponent:irNavigationItem componentDescriptor:descriptor viewController:viewController
                            extra:extra];

    irNavigationItem.title = [IRBaseBuilder textWithI18NCheck:descriptor.title];
    irNavigationItem.backBarButtonItem = (id) [IRBaseBuilder buildComponentFromDescriptor:descriptor.backBarButtonItem
                                                                           viewController:viewController extra:extra];
    irNavigationItem.titleView = (id) [IRBaseBuilder buildComponentFromDescriptor:(id) descriptor.titleView
                                                                   viewController:viewController extra:extra];
    irNavigationItem.prompt = descriptor.prompt;
    irNavigationItem.hidesBackButton = descriptor.hidesBackButton;
    irNavigationItem.leftBarButtonItems = [IRBaseBuilder buildComponentsArrayFromDescriptorsArray:descriptor.leftBarButtonItems
                                                                                   viewController:viewController
                                                                                            extra:extra];
    irNavigationItem.rightBarButtonItems = [IRBaseBuilder buildComponentsArrayFromDescriptorsArray:descriptor.rightBarButtonItems
                                                                                    viewController:viewController
                                                                                             extra:extra];
    irNavigationItem.leftItemsSupplementBackButton = descriptor.leftItemsSupplementBackButton;
    irNavigationItem.leftBarButtonItem = (id) [IRBaseBuilder buildComponentFromDescriptor:descriptor.leftBarButtonItem
                                                                           viewController:viewController extra:extra];
    irNavigationItem.rightBarButtonItem = (id) [IRBaseBuilder buildComponentFromDescriptor:descriptor.rightBarButtonItem
                                                                            viewController:viewController extra:extra];

}

@end