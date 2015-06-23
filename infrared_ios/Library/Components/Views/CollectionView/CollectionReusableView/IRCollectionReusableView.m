//
// Created by Uros Milivojevic on 6/23/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRCollectionReusableView.h"
#import "IRBaseBuilder.h"
#import "IRCollectionReusableViewDescriptor.h"


@implementation IRCollectionReusableView

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
    IRCollectionReusableView *irTableViewCell = [[IRCollectionReusableView alloc] init];
    irTableViewCell.descriptor = [[IRCollectionReusableViewDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irTableViewCell];
    return irTableViewCell;
}

- (NSString *) componentId
{
    return self.descriptor.componentId;
}

@end