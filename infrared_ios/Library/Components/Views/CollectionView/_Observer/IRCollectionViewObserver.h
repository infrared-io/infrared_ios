//
// Created by Uros Milivojevic on 6/19/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface IRCollectionViewObserver : NSObject <UICollectionViewDataSource, /*UICollectionViewDelegate,*/ UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *collectionDataArray;

@end