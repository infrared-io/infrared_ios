//
// Created by Uros Milivojevic on 6/22/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRCollectionViewCell.h"
#import "IRCollectionViewCellDescriptor.h"
#import "IRBaseBuilder.h"


@implementation IRCollectionViewCell

@synthesize componentInfo;
@synthesize descriptor;

- (instancetype) init
{
    self = [super init];
    if (self) {
        // Initialization code
    }
    return self;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Create

+ (id) createWithComponentId:(NSString *)componentId
{
    IRCollectionViewCell *irTableViewCell = [[IRCollectionViewCell alloc] init];
    irTableViewCell.descriptor = [[IRCollectionViewCellDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irTableViewCell];
    return irTableViewCell;
}

- (NSString *) componentId
{
    return self.descriptor.componentId;
}

@end