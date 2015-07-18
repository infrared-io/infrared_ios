//
// Created by Uros Milivojevic on 10/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseBuilder.h"

@class IRViewController;
@class IRViewControllerDescriptor;
@class IRScreenDescriptor;
@protocol RESideMenuDelegate;


@interface IRViewControllerBuilder : IRBaseBuilder

+ (IRViewController *) buildAndWrapViewControllerFromScreenDescriptor:(IRScreenDescriptor *)descriptor
                                                                 data:(id)data;

+ (IRViewController *) buildViewControllerFromScreenDescriptor:(IRScreenDescriptor *)descriptor
                                                          data:(id)data;

+ (void) setUpComponent:(IRViewController *)irViewController
         fromDescriptor:(IRViewControllerDescriptor *)descriptor;

+ (IRViewController *) wrapInTabBarControllerAndNavigationControllerAndSideMenuIfNeeded:(IRViewController *)irViewController;
+ (IRViewController *) wrapInTabBarControllerAndNavigationControllerIfNeeded:(IRViewController *)irViewController;
+ (IRViewController *) wrapInNavigationControllerIfNeeded:(IRViewController *)irViewController
                                               descriptor:(IRViewControllerDescriptor *)viewControllerDescriptor;
+ (IRViewController *) wrapInTabBarControllerIfNeeded:(IRViewController *)irViewController
                                           descriptor:(IRViewControllerDescriptor *)viewControllerDescriptor;

+ (IRViewController *) wrapInSideMenuIfNeeded:(IRViewController *)irViewController
                                   descriptor:(IRViewControllerDescriptor *)viewControllerDescriptor
                             sideMenuDelegate:(id <RESideMenuDelegate>)delegate;

+ (void) addAutoLayoutConstraintsForRootView:(IRViewController *)irViewController;
+ (void) addDataBindingsForRootView:(IRViewController *)irViewController;
+ (void) addRequireGestureRecognizerToFailForRootView:(IRViewController *)irViewController;

@end