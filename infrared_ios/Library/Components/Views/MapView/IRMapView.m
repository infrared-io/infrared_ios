//
// Created by Uros Milivojevic on 12/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRMapView.h"
#import "IRMapViewObserver.h"
#import "IRBaseAnnotation.h"
#import "IRPinAnnotation.h"
#import "IRMapViewBuilder.h"
#import "IRBaseDescriptor.h"
#import "IRDataController.h"
#import "IRMapViewDescriptor.h"


@implementation IRMapView

@synthesize componentInfo;
@synthesize descriptor;

- (id)init
{
    self = [super init];
    if (self) {
        self.observer = [[IRMapViewObserver alloc] init];
        self.delegate = self.observer;
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
    IRMapView *irMapView = [[IRMapView alloc] init];
    irMapView.descriptor = [[IRMapViewDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irMapView];
    return irMapView;
}

- (NSString *) componentId
{
    return self.descriptor.componentId;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (void) setMapData:(NSArray *)mapData
{
    NSArray *array = [IRMapViewBuilder mapDataFromArray:mapData];
    self.observer.mapDataArray = array;
    // -- remove all old annotations
    [self removeAnnotations:self.annotations];
    // -- add new annotations
    if ([array count] > 0) {
        [self addAnnotations:array];
    }
}

@end