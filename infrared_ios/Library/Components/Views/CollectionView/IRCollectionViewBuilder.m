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


@implementation IRCollectionViewBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRCollectionView *irCollectionView;

    irCollectionView = [[IRCollectionView alloc] initWithFrame:CGRectZero
                                          collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    [irCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
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
    [irCollectionView setCollectionData:descriptor.collectionData];
}

@end