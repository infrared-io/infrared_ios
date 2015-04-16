//
// Created by Uros Milivojevic on 12/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseBuilder.h"

@class IRMapViewDescriptor;
@class IRMapView;
@class IRScreenDescriptor;
@class IRBaseDescriptor;
@class IRView;
@class IRViewDescriptor;
@class IRViewController;


@interface IRMapViewBuilder : IRBaseBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra;

+ (void) setUpComponent:(IRView *)irMapView
    componentDescriptor:(IRBaseDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra;

+ (NSArray *) mapDataFromArray:(NSArray *)array;

@end