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
#import "IRCollectionReusableViewDescriptor.h"


@implementation IRCollectionViewBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRCollectionView *irCollectionView;
    NSArray *cellsArray;
    NSArray *sectionHeadersArray;
    NSArray *sectionFootersArray;

    irCollectionView = [[IRCollectionView alloc] initWithFrame:CGRectZero
                                          collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    // -- cells
    cellsArray = ((IRCollectionViewDescriptor *)descriptor).cellsArray;
    for (IRCollectionViewCellDescriptor *cellDescriptor in cellsArray) {
        [irCollectionView registerClass:[IRCollectionViewCell class] forCellWithReuseIdentifier:cellDescriptor.componentId];
    }
    // -- section headers
    // ---- dummy header
    [irCollectionView registerClass:[IRCollectionReusableView class]
         forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                withReuseIdentifier:@"UICollectionElementKindSectionHeader"];
    // ---- headers from descriptor
    sectionHeadersArray = ((IRCollectionViewDescriptor *) descriptor).sectionHeadersArray;
    for (IRCollectionReusableViewDescriptor *sectionHeaderDescriptor in sectionHeadersArray) {
        [irCollectionView registerClass:[IRCollectionReusableView class]
             forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                    withReuseIdentifier:sectionHeaderDescriptor.componentId];
    }
    // -- section footers
    // ---- dummy footer
    [irCollectionView registerClass:[IRCollectionReusableView class]
         forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                withReuseIdentifier:@"UICollectionElementKindSectionFooter"];
    // ---- footers from descriptor
    sectionFootersArray = ((IRCollectionViewDescriptor *) descriptor).sectionFootersArray;
    for (IRCollectionReusableViewDescriptor *sectionFooterDescriptor in sectionFootersArray) {
        [irCollectionView registerClass:[IRCollectionReusableView class]
             forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                    withReuseIdentifier:sectionFooterDescriptor.componentId];
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
    irCollectionView.allowsMultipleSelection = descriptor.allowsMultipleSelection;
    ((UICollectionViewFlowLayout *)irCollectionView.collectionViewLayout).scrollDirection = descriptor.scrollDirection;
    [irCollectionView setCollectionData:descriptor.collectionData];
}

@end