//
// Created by Uros Milivojevic on 10/26/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewDescriptor.h"


@interface IRTableViewHeaderOrFooterDescriptor : IRViewDescriptor

@property (nonatomic) BOOL dynamicAutolayoutHeight;
@property (nonatomic) CGFloat dynamicAutolayoutHeightMinimum;

@end