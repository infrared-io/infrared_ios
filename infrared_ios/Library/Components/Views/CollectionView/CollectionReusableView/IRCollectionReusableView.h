//
// Created by Uros Milivojevic on 6/23/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRView.h"
#import "UICollectionReusableViewExport.h"


@protocol IRCollectionReusableViewExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRCollectionReusableView : UICollectionReusableView <IRComponentInfoProtocol, UICollectionReusableViewExport, IRCollectionReusableViewExport, UIViewExport, IRViewExport>

@property (nonatomic) BOOL setUpDone;

@end