//
// Created by Uros Milivojevic on 6/19/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRScrollViewDescriptor.h"

@class IRViewDescriptor;


@interface IRCollectionViewDescriptor : IRScrollViewDescriptor

//@property (nonatomic, retain) UICollectionViewLayout *collectionViewLayout;
@property (nonatomic, retain) IRViewDescriptor *backgroundView; // will be automatically resized to track the size of the collection view and placed behind all cells and supplementary views.

// These properties control whether items can be selected, and if so, whether multiple items can be simultaneously selected.
@property (nonatomic) BOOL allowsSelection; // default is YES
@property (nonatomic) BOOL allowsMultipleSelection; // default is NO

// --------------------------------------------------------------------------------------------------------------------

@property (nonatomic, strong) NSArray *collectionData;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end