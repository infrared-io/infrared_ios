//
// Created by Uros Milivojevic on 6/25/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseBuilder.h"


@interface IRWebViewBuilder : IRBaseBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra;

+ (void) setUpComponent:(IRView *)irWebView
    componentDescriptor:(IRBaseDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra;
@end