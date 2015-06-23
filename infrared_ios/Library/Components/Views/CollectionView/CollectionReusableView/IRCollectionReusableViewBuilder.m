//
// Created by Uros Milivojevic on 6/23/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRCollectionReusableViewBuilder.h"
#import "IRView.h"
#import "IRCollectionReusableView.h"
#import "IRCollectionReusableViewDescriptor.h"
#import "IRViewBuilder.h"


@implementation IRCollectionReusableViewBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRCollectionReusableView *irCollectionReusableView;

    irCollectionReusableView = [[IRCollectionReusableView alloc] init];
    [IRCollectionReusableViewBuilder setUpComponent:irCollectionReusableView
                                componentDescriptor:descriptor
                                     viewController:viewController
                                              extra:extra];

    return irCollectionReusableView;
}

+ (void) setUpComponent:(IRCollectionReusableView *)irCollectionReusableView
    componentDescriptor:(IRCollectionReusableViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irCollectionReusableView componentDescriptor:descriptor viewController:viewController
                            extra:extra];

}

@end