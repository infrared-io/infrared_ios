//
// Created by Uros Milivojevic on 10/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseBuilder.h"

@class IRButtonDescriptor;
@class IRButton;
@class IRView;
@class IRBaseDescriptor;
@class IRScreenDescriptor;
@class IRViewDescriptor;
@class IRViewController;


@interface IRButtonBuilder : IRBaseBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra;

+ (void) setUpComponent:(IRView *)irButton
    componentDescriptor:(IRBaseDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra;

@end