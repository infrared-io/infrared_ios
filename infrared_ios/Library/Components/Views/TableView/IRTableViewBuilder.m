//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRTableViewBuilder.h"
#import "IRTableViewDescriptor.h"
#import "IRTableView.h"
#import "IRViewBuilder.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRScreenDescriptor.h"
#import "IRScrollViewBuilder.h"
#import "IRViewController.h"
#import "IRViewDescriptor.h"


@implementation IRTableViewBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRTableView *irTableView;

    irTableView = [[IRTableView alloc] initWithFrame:CGRectZero style:((IRTableViewDescriptor *)descriptor).style];
    [IRTableViewBuilder setUpComponent:irTableView componentDescriptor:descriptor
                        viewController:viewController
                                 extra:extra];

    return irTableView;
}

+ (void) setUpComponent:(IRTableView *)irTableView
    componentDescriptor:(IRTableViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRScrollViewBuilder setUpComponent:irTableView componentDescriptor:descriptor viewController:viewController
                                  extra:extra];

    if (descriptor.rowHeight != CGFLOAT_UNDEFINED) {
        irTableView.rowHeight = descriptor.rowHeight;
    }
    if (descriptor.sectionHeaderHeight != CGFLOAT_UNDEFINED) {
        irTableView.sectionHeaderHeight = descriptor.sectionHeaderHeight;
    }
    if (descriptor.sectionFooterHeight != CGFLOAT_UNDEFINED) {
        irTableView.sectionFooterHeight = descriptor.sectionFooterHeight;
    }
    if (descriptor.estimatedRowHeight != CGFLOAT_UNDEFINED) {
        irTableView.estimatedRowHeight = descriptor.estimatedRowHeight;
    }
    if (descriptor.estimatedSectionHeaderHeight != CGFLOAT_UNDEFINED) {
        irTableView.estimatedSectionHeaderHeight = descriptor.estimatedSectionHeaderHeight;
    }
    if (descriptor.estimatedSectionFooterHeight != CGFLOAT_UNDEFINED) {
        irTableView.estimatedSectionFooterHeight = descriptor.estimatedSectionFooterHeight;
    }
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.separatorInset, UIEdgeInsetsNull) == NO) {
        irTableView.separatorInset = descriptor.separatorInset;
    }
    irTableView.backgroundView = [IRBaseBuilder buildComponentFromDescriptor:descriptor.backgroundView
                                                              viewController:viewController extra:extra];
    irTableView.editing = descriptor.editing;
    irTableView.allowsSelectionDuringEditing = descriptor.allowsSelectionDuringEditing;
    irTableView.allowsMultipleSelection = descriptor.allowsMultipleSelection;
    irTableView.allowsMultipleSelectionDuringEditing = descriptor.allowsMultipleSelectionDuringEditing;
    irTableView.sectionIndexMinimumDisplayRowCount = descriptor.sectionIndexMinimumDisplayRowCount;
    if (descriptor.sectionIndexColor) {
        irTableView.sectionIndexColor = descriptor.sectionIndexColor;
    }
    if (descriptor.sectionIndexBackgroundColor) {
        irTableView.sectionIndexBackgroundColor = descriptor.sectionIndexBackgroundColor;
    }
    if (descriptor.sectionIndexTrackingBackgroundColor) {
        irTableView.sectionIndexTrackingBackgroundColor = descriptor.sectionIndexTrackingBackgroundColor;
    }
    irTableView.separatorStyle = descriptor.separatorStyle;
    if (descriptor.separatorColor) {
        irTableView.separatorColor = descriptor.separatorColor;
    }
    irTableView.tableHeaderView = [IRBaseBuilder buildComponentFromDescriptor:descriptor.tableHeaderView
                                                               viewController:viewController extra:extra];
    irTableView.tableFooterView = [IRBaseBuilder buildComponentFromDescriptor:descriptor.tableFooterView
                                                               viewController:viewController extra:extra];
    [irTableView setTableData:descriptor.tableData];
}

@end