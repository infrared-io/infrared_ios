//
// Created by Uros Milivojevic on 10/17/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseBuilder.h"

@class IRView;
@class IRViewController;

@interface IRBaseBuilder (DataBinding)

+ (void) addDataBindingsForViewsArray:(NSArray *)viewsArray
                       viewController:(IRViewController *)viewController;

+ (void) addDataBindingsForView:(UIView *)uiView
                 viewController:(IRViewController *)viewController
                   dataBindings:(NSArray *)dataBindingsArray;

@end