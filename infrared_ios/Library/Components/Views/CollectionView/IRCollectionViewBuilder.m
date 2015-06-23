//
// Created by Uros Milivojevic on 6/19/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRCollectionViewBuilder.h"
#import "IRView.h"
#import "IRCollectionView.h"
#import "IRViewDescriptor.h"
#import "IRCollectionViewDescriptor.h"
#import "IRScrollViewBuilder.h"
#import "IRCollectionViewCellDescriptor.h"
#import "IRCollectionViewCell.h"


@implementation IRCollectionViewBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRCollectionView *irCollectionView;
    NSArray *cellsArray;

    irCollectionView = [[IRCollectionView alloc] initWithFrame:CGRectZero
                                          collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    cellsArray = ((IRCollectionViewDescriptor *)descriptor).cellsArray;
    for (IRCollectionViewCellDescriptor *cellDescriptor in cellsArray) {
        [irCollectionView registerClass:[IRCollectionViewCell class] forCellWithReuseIdentifier:cellDescriptor.componentId];
    }
    [IRCollectionViewBuilder setUpComponent:irCollectionView componentDescriptor:descriptor
                             viewController:viewController
                                      extra:extra];

    return irCollectionView;
}

+ (void) setUpComponent:(IRCollectionView *)irCollectionView
    componentDescriptor:(IRCollectionViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRScrollViewBuilder setUpComponent:irCollectionView componentDescriptor:descriptor viewController:viewController
                                  extra:extra];

    irCollectionView.backgroundView = [IRBaseBuilder buildComponentFromDescriptor:descriptor.backgroundView
                                                              viewController:viewController extra:extra];
    irCollectionView.allowsSelection = descriptor.allowsSelection;
    irCollectionView.allowsSelection = descriptor.allowsMultipleSelection;
    ((UICollectionViewFlowLayout *)irCollectionView.collectionViewLayout).scrollDirection = descriptor.scrollDirection;
    [irCollectionView setCollectionData:descriptor.collectionData];
}

@end