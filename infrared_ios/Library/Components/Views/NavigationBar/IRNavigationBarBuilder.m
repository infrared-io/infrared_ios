//
// Created by Uros Milivojevic on 12/12/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRNavigationBarBuilder.h"
#import "IRNavigationBarDescriptor.h"
#import "IRNavigationBar.h"
#import "IRViewBuilder.h"
#import "IRSimpleCache.h"
#import "IRNavigationItem.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRScreenDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRViewController.h"
#import "IRUtil.h"


@implementation IRNavigationBarBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRNavigationBar *irNavigationBar;

    irNavigationBar = [[IRNavigationBar alloc] init];
    [IRNavigationBarBuilder setUpComponent:irNavigationBar componentDescriptor:descriptor viewController:viewController
                                     extra:extra];

    return irNavigationBar;
}

+ (void) setUpComponent:(IRNavigationBar *)irNavigationBar
    componentDescriptor:(IRNavigationBarDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
//    IRNavigationItem *anItem;
    NSMutableArray *array;

    [IRViewBuilder setUpComponent:irNavigationBar componentDescriptor:descriptor viewController:viewController
                            extra:extra];

    irNavigationBar.barStyle = descriptor.barStyle;
    irNavigationBar.translucent = descriptor.translucent;
    if ([descriptor.items count] > 0) {
        array = [IRBaseBuilder buildComponentsArrayFromDescriptorsArray:descriptor.items viewController:viewController
                                                                  extra:extra];
    } else {
        array = nil;
    }
    irNavigationBar.items = array;
    irNavigationBar.barTintColor = descriptor.barTintColor;
    irNavigationBar.shadowImage = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.shadowImage];
    irNavigationBar.backIndicatorImage = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.backIndicatorImage];
    irNavigationBar.backIndicatorTransitionMaskImage = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.backIndicatorTransitionMaskImage];
}

@end