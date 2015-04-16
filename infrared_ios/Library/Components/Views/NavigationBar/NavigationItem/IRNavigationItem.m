//
// Created by Uros Milivojevic on 12/12/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRNavigationItem.h"
#import "IRBaseBuilder.h"
#import "IRBaseDescriptor.h"
#import "IRNavigationItemDescriptor.h"


@implementation IRNavigationItem

@synthesize componentInfo;
@synthesize descriptor;

- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Create

+ (id) createWithComponentId:(NSString *)componentId
{
    IRNavigationItem *irNavigationItem = [[IRNavigationItem alloc] init];
    irNavigationItem.descriptor = [[IRNavigationItemDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irNavigationItem];
    return irNavigationItem;
}

- (NSString *) componentId
{
    return self.descriptor.componentId;
}

@end