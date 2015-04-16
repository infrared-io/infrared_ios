//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRTableViewCell.h"
#import "IRBaseBuilder.h"
#import "IRBaseDescriptor.h"
#import "IRTableViewCellDescriptor.h"


@implementation IRTableViewCell

@synthesize componentInfo;
@synthesize descriptor;

- (id)init
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
    IRTableViewCell *irTableViewCell = [[IRTableViewCell alloc] init];
    irTableViewCell.descriptor = [[IRTableViewCellDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irTableViewCell];
    return irTableViewCell;
}

- (NSString *) componentId
{
    return self.descriptor.componentId;
}

@end