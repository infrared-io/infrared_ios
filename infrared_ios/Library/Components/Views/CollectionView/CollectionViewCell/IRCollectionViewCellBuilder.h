//
// Created by Uros Milivojevic on 6/22/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseBuilder.h"


@interface IRCollectionViewCellBuilder : IRBaseBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra;

+ (void) extendedSetUpComponent:(IRView *)irCollectionViewCell
            componentDescriptor:(IRBaseDescriptor *)descriptor
                 viewController:(IRViewController *)viewController
                          extra:(id)extra;

+ (void) setUpComponent:(IRView *)irCollectionViewCell
    componentDescriptor:(IRBaseDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra;

@end