//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseBuilder.h"

@class IRActivityIndicatorViewDescriptor;
@class IRActivityIndicatorView;
@class IRScreenDescriptor;
@class IRView;
@class IRBaseDescriptor;
@class IRViewDescriptor;
@class IRViewController;


@interface IRActivityIndicatorViewBuilder : IRBaseBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra;

+ (void) setUpComponent:(IRView *)irActivityIndicatorView
    componentDescriptor:(IRBaseDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra;

@end