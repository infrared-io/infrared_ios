//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRBarItemBuilder.h"
#import "IRBarItemDescriptor.h"
#import "IRBarItem.h"
#import "IRSimpleCache.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRScreenDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRViewController.h"
#import "IRUtil.h"


@implementation IRBarItemBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    NSAssert(false, @"IRBarItemBuilder - IRBarItem should NEVER be built explicitly!");
    return nil;
}

+ (void) setUpComponent:(IRBarItem *)irBarItem
    componentDescriptor:(IRBarItemDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    NSString *imagePath;

    [IRBaseBuilder setUpComponent:irBarItem componentDescriptor:descriptor viewController:viewController extra:extra];

    irBarItem.enabled = descriptor.enabled;
    irBarItem.title = [IRBaseBuilder textWithI18NCheck:descriptor.title];
    irBarItem.image = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.image];
    irBarItem.landscapeImagePhone = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.landscapeImagePhone];
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.imageInsets, UIEdgeInsetsNull) == NO) {
        irBarItem.imageInsets = descriptor.imageInsets;
    }
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.landscapeImagePhoneInsets, UIEdgeInsetsNull) == NO) {
        irBarItem.landscapeImagePhoneInsets = descriptor.landscapeImagePhoneInsets;
    }
    irBarItem.tag = descriptor.tag;
}
@end