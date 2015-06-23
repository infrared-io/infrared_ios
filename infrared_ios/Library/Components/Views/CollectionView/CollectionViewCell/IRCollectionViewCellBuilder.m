//
// Created by Uros Milivojevic on 6/22/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRCollectionViewCellBuilder.h"
#import "IRCollectionViewCell.h"
#import "IRCollectionViewCellDescriptor.h"
#import "IRCollectionViewBuilder.h"
#import "IRViewBuilder.h"
#import "IRTableViewBuilder.h"
#import "IRTableViewBuilder+AutoLayout.h"
#import "IRCollectionViewBuilder+AutoLayout.h"


@implementation IRCollectionViewCellBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRCollectionViewCell *irCollectionViewCell;

    // -- build cell
    irCollectionViewCell = [[IRCollectionViewCell alloc] init];
    // -- extended set up cell
    [IRCollectionViewCellBuilder extendedSetUpComponent:irCollectionViewCell
                                    componentDescriptor:descriptor
                                         viewController:viewController
                                                  extra:extra];

    return irCollectionViewCell;
}

+ (void) extendedSetUpComponent:(IRView *)irCollectionViewCell
            componentDescriptor:(IRBaseDescriptor *)descriptor
                 viewController:(IRViewController *)viewController
                          extra:(id)extra
{
    // -- set up cell
    [IRCollectionViewCellBuilder setUpComponent:irCollectionViewCell componentDescriptor:descriptor
                                 viewController:viewController
                                          extra:extra];
    // -- add AutoLayout constraints
    [IRCollectionViewBuilder addAutoLayoutConstraintsForCollectionViewCell:irCollectionViewCell];
}

+ (void) setUpComponent:(IRCollectionViewCell *)irCollectionViewCell
    componentDescriptor:(IRCollectionViewCellDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irCollectionViewCell componentDescriptor:descriptor viewController:viewController
                            extra:extra];

    irCollectionViewCell.backgroundView = [IRBaseBuilder buildComponentFromDescriptor:descriptor.backgroundView
                                                                  viewController:viewController extra:extra];
    irCollectionViewCell.selectedBackgroundView = [IRBaseBuilder buildComponentFromDescriptor:descriptor.selectedBackgroundView
                                                                          viewController:viewController extra:extra];
    irCollectionViewCell.selected = descriptor.selected;
    irCollectionViewCell.highlighted = descriptor.highlighted;
}

@end