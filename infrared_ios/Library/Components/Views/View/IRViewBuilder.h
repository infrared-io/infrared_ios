//
// Created by Uros Milivojevic on 10/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseBuilder.h"

@class IRView;
@class IRBaseDescriptor;
@class IRViewDescriptor;
@class IRScreenDescriptor;
@class IRViewController;

@interface IRViewBuilder : IRBaseBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra;

+ (void) setUpComponent:(IRView *)irView
    componentDescriptor:(IRViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra;

+ (void) setUpRootView:(UIView *)uiView
   componentDescriptor:(IRViewDescriptor *)descriptor
        viewController:(IRViewController *)viewController
                 extra:(id)extra;

@end