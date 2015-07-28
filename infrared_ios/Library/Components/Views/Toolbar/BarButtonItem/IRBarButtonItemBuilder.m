//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRBarButtonItemBuilder.h"
#import "IRBarButtonItemDescriptor.h"
#import "IRBarButtonItem.h"
#import "IRScreenDescriptor.h"
#import "IRBarItemBuilder.h"
#import "IRDataController.h"
#import "IRView.h"
#import "IRViewDescriptor.h"
#import "IRBaseDescriptor.h"
#import "IRViewController.h"
#import "IRSimpleCache.h"
#import "IRUtil.h"


@implementation IRBarButtonItemBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBarButtonItemDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRBarButtonItem *irBarButtonItem;

    if (descriptor.identifier != UIBarButtonSystemItemNone) {
        irBarButtonItem = [[IRBarButtonItem alloc] initWithBarButtonSystemItem:descriptor.identifier
                                                                        target:[IRBarButtonItemBuilder class]
                                                                        action:@selector(action:)];
    } else if ([descriptor.title length] > 0) {
        irBarButtonItem = [[IRBarButtonItem alloc] initWithTitle:descriptor.title
                                                           style:descriptor.style
                                                          target:[IRBarButtonItemBuilder class]
                                                          action:@selector(action:)];
    } else if ([descriptor.image length] > 0) {
        irBarButtonItem = [[IRBarButtonItem alloc] initWithImage:[IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.image]
                                                           style:descriptor.style
                                                          target:[IRBarButtonItemBuilder class]
                                                          action:@selector(action:)];
    } else {
        irBarButtonItem = [[IRBarButtonItem alloc] init];
    }

    irBarButtonItem.componentInfo = viewController.key;
    [IRBarButtonItemBuilder setUpComponent:irBarButtonItem componentDescriptor:descriptor viewController:viewController
                                     extra:extra];

    return irBarButtonItem;
}

+ (void) setUpComponent:(IRBarButtonItem *)irBarButtonItem
    componentDescriptor:(IRBarButtonItemDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRBarItemBuilder setUpComponent:irBarButtonItem componentDescriptor:descriptor viewController:viewController
                               extra:extra];

    irBarButtonItem.style = descriptor.style;
    irBarButtonItem.width = descriptor.width;
    irBarButtonItem.possibleTitles = descriptor.possibleTitles;
    irBarButtonItem.customView = [IRBaseBuilder buildComponentFromDescriptor:descriptor.customView
                                                              viewController:viewController extra:extra];
    irBarButtonItem.target = [IRBarButtonItemBuilder class];
    irBarButtonItem.action = @selector(action:);
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

+ (void) action:(IRBarButtonItem *)irBarButtonItem
{
    IRBarButtonItemDescriptor *descriptor = (IRBarButtonItemDescriptor *) ((id<IRComponentInfoProtocol>)irBarButtonItem).descriptor;
    NSString *actions = descriptor.actions;
    [IRBarButtonItemBuilder executeAction:actions withBarButtonItem:irBarButtonItem];
}

// --------------------------------------------------------------------------------------------------------------------

+ (void)executeAction:(NSString *)action withBarButtonItem:(IRBarButtonItem *)irBarButtonItem
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (irBarButtonItem) {
        dictionary[@"control"] = irBarButtonItem;
    }
    [IRBaseBuilder executeAction:action withDictionary:dictionary sourceView:irBarButtonItem];
}

@end