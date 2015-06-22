//
// Created by Uros Milivojevic on 6/19/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRCollectionView.h"
#import "IRCollectionViewObserver.h"
#import "IRDataController.h"
#import "IRBaseDescriptor.h"
#import "IRCollectionViewDescriptor.h"
#import "IRBaseBuilder.h"


@implementation IRCollectionView

@synthesize componentInfo;
@synthesize descriptor;
//@synthesize translatesAutoresizingMaskIntoConstraintsValue;

- (instancetype) initWithFrame:(CGRect)frame
          collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.observer = [[IRCollectionViewObserver alloc] init];
        self.delegate = self.observer;
        self.dataSource = self.observer;
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
    IRCollectionView *irImageView = [[IRCollectionView alloc] init];
    irImageView.descriptor = [[IRCollectionViewDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irImageView];
    return irImageView;
}

- (NSString *) componentId
{
    return self.descriptor.componentId;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (void) setCollectionData:(NSArray *)collectionData
{
    self.observer.collectionDataArray = collectionData;
    [self reloadData];
}

- (NSArray *) subComponentsArray
{
    NSMutableArray *array = [NSMutableArray array];
    // TODO: add other potential subViews (look into IRTableView)
    // TODO: check should 'backgroundView' be added
//    if (self.backgroundView) {
//        [array addObject:self.backgroundView];
//        if ([self.backgroundView isKindOfClass:[IRView class]]) {
//            ((IRView *)self.backgroundView).translatesAutoresizingMaskIntoConstraintsValue = @(YES);
//        }
//    }
    return array;
}

@end