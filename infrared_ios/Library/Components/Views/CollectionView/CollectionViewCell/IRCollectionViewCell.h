//
// Created by Uros Milivojevic on 6/22/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRView.h"
#import "IRCollectionReusableView.h"
#import "UICollectionViewCellExport.h"


@protocol IRCollectionViewCellExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRCollectionViewCell : UICollectionViewCell <IRComponentInfoProtocol, IRCollectionViewCellExport, UICollectionViewCellExport, IRCollectionReusableViewExport, UIViewExport, IRViewExport>

@property (nonatomic) BOOL setUpDone;

@end