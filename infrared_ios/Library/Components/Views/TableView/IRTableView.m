//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>
#import "IRTableView.h"
#import "IRTableViewObserver.h"
#import "IRBaseBuilder.h"
#import "IRBaseDescriptor.h"
#import "IRDataController.h"
#import "IRTableViewDescriptor.h"
#import "IRTableViewHeaderOrFooter.h"
#import "IRTableViewHeaderOrFooterDescriptor.h"


@implementation IRTableView

@synthesize componentInfo;
@synthesize descriptor;
@synthesize translatesAutoresizingMaskIntoConstraintsValue;

- (instancetype) initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.observer = [[IRTableViewObserver alloc] init];
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

+ (id) createWithFrame:(CGRect)frame
                 style:(UITableViewStyle)style
           componentId:(NSString *)componentId
{
    IRTableView *irTableView = [[IRTableView alloc] initWithFrame:(CGRect)frame style:(UITableViewStyle)style];
    irTableView.descriptor = [[IRTableViewDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irTableView];
    return irTableView;
}

+ (id) createWithStyle:(UITableViewStyle)style componentId:(NSString *)componentId
{
    IRTableView *irTableView = [[IRTableView alloc] initWithFrame:CGRectZero style:(UITableViewStyle)style];
    irTableView.descriptor = [[IRTableViewDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irTableView];
    return irTableView;
}

+ (id) createWithComponentId:(NSString *)componentId
{
    NSLog(@"For creating TableView use 'createWithFrameStyleComponentId' or 'createWithStyleComponentId' instead of 'createWithComponentId:'");
    return nil;
}

- (NSString *) componentId
{
    return self.descriptor.componentId;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (void) dynamicAutolayoutHeightUpdate
{
    IRTableViewHeaderOrFooter *header;
    IRTableViewHeaderOrFooter *footer;
    IRTableViewHeaderOrFooterDescriptor *headerOrFooterDescriptor;
    CGSize size;
    CGFloat height;
    CGRect frame;

    header = (IRTableViewHeaderOrFooter *)self.tableHeaderView;
    headerOrFooterDescriptor = (IRTableViewHeaderOrFooterDescriptor *) header.descriptor;
    if (header
        && [headerOrFooterDescriptor isKindOfClass:[IRTableViewHeaderOrFooterDescriptor class]]
        && headerOrFooterDescriptor.dynamicAutolayoutHeight)
    {
        [header setNeedsLayout];
        [header layoutIfNeeded];

        size = [header systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        height = size.height;
        if (headerOrFooterDescriptor.dynamicAutolayoutHeightMinimum != CGFLOAT_UNDEFINED
            && height < headerOrFooterDescriptor.dynamicAutolayoutHeightMinimum)
        {
            height = headerOrFooterDescriptor.dynamicAutolayoutHeightMinimum;
        }
        frame = header.frame;
        frame.size.height = height;
        header.frame = frame;

        self.tableHeaderView = header;
    }

    footer = (IRTableViewHeaderOrFooter *)self.tableFooterView;
    headerOrFooterDescriptor = (IRTableViewHeaderOrFooterDescriptor *) footer.descriptor;
    if (footer
        && [headerOrFooterDescriptor isKindOfClass:[IRTableViewHeaderOrFooterDescriptor class]]
        && headerOrFooterDescriptor.dynamicAutolayoutHeight)
    {
        [footer setNeedsLayout];
        [footer layoutIfNeeded];

        size = [footer systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        height = size.height;
        if (headerOrFooterDescriptor.dynamicAutolayoutHeightMinimum != CGFLOAT_UNDEFINED
            && height < headerOrFooterDescriptor.dynamicAutolayoutHeightMinimum)
        {
            height = headerOrFooterDescriptor.dynamicAutolayoutHeightMinimum;
        }
        frame = footer.frame;
        frame.size.height = height;
        footer.frame = frame;

        self.tableFooterView = footer;
    }
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (void) setTableData:(NSArray *)tableData
{
    self.observer.tableDataArray = tableData;
    [self reloadData];
}

- (NSArray *) subComponentsArray
{
    NSMutableArray *array = [NSMutableArray array];
    if (self.tableHeaderView) {
        [array addObject:self.tableHeaderView];
        if ([self.tableHeaderView isKindOfClass:[IRView class]]) {
            ((IRView *)self.tableHeaderView).translatesAutoresizingMaskIntoConstraintsValue = @(YES);
        }
    }
    if (self.tableFooterView) {
        [array addObject:self.tableFooterView];
        if ([self.tableFooterView isKindOfClass:[IRView class]]) {
            ((IRView *)self.tableFooterView).translatesAutoresizingMaskIntoConstraintsValue = @(YES);
        }
    }
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