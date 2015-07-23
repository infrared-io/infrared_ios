//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRBarButtonItem.h"
#import "IRBaseBuilder.h"
#import "IRBaseDescriptor.h"
#import "IRBarButtonItemBuilder.h"
#import "IRSimpleCache.h"
#import "IRBarButtonItemDescriptor.h"
#import "IRUtil.h"


@implementation IRBarButtonItem

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

+ (id) createWithType:(UIButtonType)buttonType componentId:(NSString *)componentId
{
    IRBarButtonItem *irBarButtonItem = [[IRBarButtonItem alloc] init];
    irBarButtonItem.title = @"";
    irBarButtonItem.image = nil;
    irBarButtonItem.descriptor = [[IRBarButtonItemDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irBarButtonItem];
    return irBarButtonItem;
}

+ (id) createWithTitle:(NSString *)title componentId:(NSString *)componentId
{
    IRBarButtonItem *irBarButtonItem = [[IRBarButtonItem alloc] initWithTitle:title
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:[IRBarButtonItemBuilder class]
                                                                       action:@selector(action:)];
    irBarButtonItem.descriptor = [[IRBarButtonItemDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irBarButtonItem];
    return irBarButtonItem;
}

+ (id) createWithImagePath:(NSString *)imagePath componentId:(NSString *)componentId
{
    IRBarButtonItem *irBarButtonItem = [[IRBarButtonItem alloc] initWithImage:[IRUtil imagePrefixedWithBaseUrlIfNeeded:imagePath]
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:[IRBarButtonItemBuilder class]
                                                                       action:@selector(action:)];
    irBarButtonItem.descriptor = [[IRBarButtonItemDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irBarButtonItem];
    return irBarButtonItem;
}

+ (id) createWithComponentId:(NSString *)componentId
{
    IRBarButtonItem *irBarButtonItem = [[IRBarButtonItem alloc] init];
    irBarButtonItem.descriptor = [[IRBarButtonItemDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irBarButtonItem];
    return irBarButtonItem;
}

- (NSString *) componentId
{
    return self.descriptor.componentId;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Actions

- (NSString *) actions
{
    return ((IRBarButtonItemDescriptor *)self.descriptor).actions;
}
- (void) setActions:(NSString *)actions
{
    ((IRBarButtonItemDescriptor *)self.descriptor).actions = actions;
}

@end