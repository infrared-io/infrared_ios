//
//  IRView.m
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRBaseBuilder.h"
#import "IRUtil.h"
#import "IRDataController.h"
#import "IRViewDescriptor.h"


@implementation IRView

@synthesize componentInfo;
@synthesize descriptor;
@synthesize translatesAutoresizingMaskIntoConstraintsValue;

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

#pragma mark - Subview methods

- (void)removeFromSuperview
{
    [[IRDataController sharedInstance] unregisterView:self];

    [super removeFromSuperview];
}
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
    [super insertSubview:view atIndex:index];

    if ([view conformsToProtocol:@protocol(IRComponentInfoProtocol)] && ((IRView *)view).descriptor.jsInit) {
        [[IRDataController sharedInstance] registerView:(IRView *) view inSameScreenAsParentView:self];
    }
}
- (void)addSubview:(UIView *)view
{
    [super addSubview:view];

    if ([view conformsToProtocol:@protocol(IRComponentInfoProtocol)] && ((IRView *)view).descriptor.jsInit) {
        [[IRDataController sharedInstance] registerView:(IRView *) view inSameScreenAsParentView:self];
    }
}
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview
{
    [super insertSubview:view belowSubview:siblingSubview];

    if ([view conformsToProtocol:@protocol(IRComponentInfoProtocol)] && ((IRView *)view).descriptor.jsInit) {
        [[IRDataController sharedInstance] registerView:(IRView *) view inSameScreenAsParentView:self];
    }
}
- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview
{
    [super insertSubview:view aboveSubview:siblingSubview];

    if ([view conformsToProtocol:@protocol(IRComponentInfoProtocol)] && ((IRView *)view).descriptor.jsInit) {
        [[IRDataController sharedInstance] registerView:(IRView *) view inSameScreenAsParentView:self];
    }
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Create

+ (id) createWithComponentId:(NSString *)componentId
{
    IRView *irView = [[IRView alloc] init];
    irView.descriptor = [[IRViewDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irView];
    return irView;
}

- (NSString *) componentId
{
    return self.descriptor.componentId;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (NSArray *) subComponentsArray
{
    NSMutableArray *array = [NSMutableArray array];
    if (self.subviews) {
        [array addObject:self.subviews];
    }
    return array;
}

@end
