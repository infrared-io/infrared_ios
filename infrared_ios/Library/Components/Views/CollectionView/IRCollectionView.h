//
// Created by Uros Milivojevic on 6/19/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRView.h"
#import "IRScrollView.h"
#import "UICollectionViewExport.h"

@class IRCollectionViewObserver;

@protocol IRCollectionViewExport <JSExport>

+ (id) createWithComponentId:(NSString *)componentId;

// -----------------------------------------------------------------------------------

- (void) setCollectionData:(NSArray *)collectionData;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRCollectionView : UICollectionView <IRComponentInfoProtocol, IRAutoLayoutSubComponentsProtocol, UICollectionViewExport, IRCollectionViewExport, UIScrollViewExport, IRScrollViewExport, UIViewExport, IRViewExport>

@property (nonatomic, strong) IRCollectionViewObserver *observer;

@end