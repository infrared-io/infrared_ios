//
// Created by Uros Milivojevic on 10/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseBuilder.h"

@class IRLabelDescriptor;
@class IRLabel;
@class IRView;
@class IRBaseDescriptor;
@class IRScreenDescriptor;
@class IRViewDescriptor;
@class IRViewController;


@interface IRLabelBuilder : IRBaseBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra;

+ (void) setUpComponent:(IRView *)irLabel
    componentDescriptor:(IRBaseDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra;

@end