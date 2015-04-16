//
// Created by Uros Milivojevic on 3/15/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol NSIndexPathExport <JSExport>

+ (instancetype)indexPathWithIndex:(NSUInteger)index;
+ (instancetype)indexPathWithIndexes:(const NSUInteger [])indexes length:(NSUInteger)length;

//- (instancetype)initWithIndexes:(const NSUInteger [])indexes length:(NSUInteger)length NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithIndex:(NSUInteger)index;


- (NSIndexPath *)indexPathByAddingIndex:(NSUInteger)index;
- (NSIndexPath *)indexPathByRemovingLastIndex;

- (NSUInteger)indexAtPosition:(NSUInteger)position;
@property (readonly) NSUInteger length;

- (void)getIndexes:(NSUInteger *)indexes;

// comparison support
- (NSComparisonResult)compare:(NSIndexPath *)otherObject; // sorting an array of indexPaths using this comparison results in an array representing nodes in depth-first traversal order

#pragma mark - UITableView

+ (NSIndexPath *)indexPathForRow:(NSInteger)row inSection:(NSInteger)section;

@property(nonatomic,readonly) NSInteger section;
@property(nonatomic,readonly) NSInteger row;

#pragma mark - UICollectionViewAdditions

+ (NSIndexPath *)indexPathForItem:(NSInteger)item inSection:(NSInteger)section NS_AVAILABLE_IOS(6_0);

@property (nonatomic, readonly) NSInteger item NS_AVAILABLE_IOS(6_0);

@end