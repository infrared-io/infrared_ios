//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRViewDescriptor.h"
#import "IRTableViewDescriptor.h"
#import "IRUtil.h"
#if TARGET_OS_IPHONE
#import "IRView.h"
#import "IRTableView.h"
#import "IRTableViewBuilder.h"
#endif


@implementation IRTableViewDescriptor

+ (NSString *) componentName
{
    return typeTableViewKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRTableView class];
}

+ (Class) builderClass
{
    return [IRTableViewBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UITableView class], @protocol(UITableViewExport));
}
#endif

- (NSDictionary *) viewDefaults
{
    NSDictionary *dictionary = [super viewDefaults];
    NSMutableDictionary *defaults = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [defaults setValuesForKeysWithDictionary:@{
      @"clipsToBounds" : @(YES)
    }];
    return defaults;
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSDictionary *dictionary;
        NSArray *array;

#if TARGET_OS_IPHONE
        // style
        string = aDictionary[NSStringFromSelector(@selector(style))];
        self.style = [IRBaseDescriptor tableViewStyleFromString:string];
#endif

        // rowHeight
        number = aDictionary[NSStringFromSelector(@selector(rowHeight))];
        if (number) {
            self.rowHeight = [number floatValue];
        } else {
            self.rowHeight = CGFLOAT_UNDEFINED;
        }

        // sectionHeaderHeight
        number = aDictionary[NSStringFromSelector(@selector(sectionHeaderHeight))];
        if (number) {
            self.sectionHeaderHeight = [number floatValue];
        } else {
            self.sectionHeaderHeight = CGFLOAT_UNDEFINED;
        }

        // sectionFooterHeight
        number = aDictionary[NSStringFromSelector(@selector(sectionFooterHeight))];
        if (number) {
            self.sectionFooterHeight = [number floatValue];
        } else {
            self.sectionFooterHeight = CGFLOAT_UNDEFINED;
        }

        // estimatedRowHeight
        number = aDictionary[NSStringFromSelector(@selector(estimatedRowHeight))];
        if (number) {
            self.estimatedRowHeight = [number floatValue];
        } else {
            self.estimatedRowHeight = CGFLOAT_UNDEFINED;
        }

        // estimatedSectionHeaderHeight
        number = aDictionary[NSStringFromSelector(@selector(estimatedSectionHeaderHeight))];
        if (number) {
            self.estimatedSectionHeaderHeight = [number floatValue];
        } else {
            self.estimatedSectionHeaderHeight = CGFLOAT_UNDEFINED;
        }

        // estimatedSectionFooterHeight
        number = aDictionary[NSStringFromSelector(@selector(estimatedSectionFooterHeight))];
        if (number) {
            self.estimatedSectionFooterHeight = [number floatValue];
        } else {
            self.estimatedSectionFooterHeight = CGFLOAT_UNDEFINED;
        }

#if TARGET_OS_IPHONE
        // separatorInset
        dictionary = aDictionary[NSStringFromSelector(@selector(separatorInset))];
        self.separatorInset = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];
#endif

        // backgroundView
        dictionary = aDictionary[NSStringFromSelector(@selector(backgroundView))];
        self.backgroundView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // editing
        number = aDictionary[NSStringFromSelector(@selector(editing))];
        if (number) {
            self.editing = [number boolValue];
        } else {
            self.editing = NO;
        }

        // allowsSelection
        number = aDictionary[NSStringFromSelector(@selector(allowsSelection))];
        if (number) {
            self.allowsSelection = [number boolValue];
        } else {
            self.allowsSelection = YES;
        }

        // allowsSelectionDuringEditing
        number = aDictionary[NSStringFromSelector(@selector(allowsSelectionDuringEditing))];
        if (number) {
            self.allowsSelectionDuringEditing = [number boolValue];
        } else {
            self.allowsSelectionDuringEditing = NO;
        }

        // allowsMultipleSelection
        number = aDictionary[NSStringFromSelector(@selector(allowsMultipleSelection))];
        if (number) {
            self.allowsMultipleSelection = [number boolValue];
        } else {
            self.allowsMultipleSelection = NO;
        }

        // allowsMultipleSelectionDuringEditing
        number = aDictionary[NSStringFromSelector(@selector(allowsMultipleSelectionDuringEditing))];
        if (number) {
            self.allowsMultipleSelectionDuringEditing = [number boolValue];
        } else {
            self.allowsMultipleSelectionDuringEditing = NO;
        }

        // sectionIndexMinimumDisplayRowCount
        number = aDictionary[NSStringFromSelector(@selector(sectionIndexMinimumDisplayRowCount))];
        if (number) {
            self.sectionIndexMinimumDisplayRowCount = [number integerValue];
        } else {
            self.sectionIndexMinimumDisplayRowCount = NO;
        }

#if TARGET_OS_IPHONE
        // sectionIndexColor
        string = aDictionary[NSStringFromSelector(@selector(sectionIndexColor))];
        self.sectionIndexColor = [IRUtil transformHexColorToUIColor:string];

        // sectionIndexBackgroundColor
        string = aDictionary[NSStringFromSelector(@selector(sectionIndexBackgroundColor))];
        self.sectionIndexBackgroundColor = [IRUtil transformHexColorToUIColor:string];

        // sectionIndexTrackingBackgroundColor
        string = aDictionary[NSStringFromSelector(@selector(sectionIndexTrackingBackgroundColor))];
        self.sectionIndexTrackingBackgroundColor = [IRUtil transformHexColorToUIColor:string];

        // separatorStyle
        string = aDictionary[NSStringFromSelector(@selector(separatorStyle))];
        self.separatorStyle = [IRBaseDescriptor separatorStyleFromString:string];

        // separatorColor
        string = aDictionary[NSStringFromSelector(@selector(separatorColor))];
        self.separatorColor = [IRUtil transformHexColorToUIColor:string];
#endif

        // tableHeaderView
        dictionary = aDictionary[NSStringFromSelector(@selector(tableHeaderView))];
        self.tableHeaderView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // tableFooterView
        dictionary = aDictionary[NSStringFromSelector(@selector(tableFooterView))];
        self.tableFooterView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // sectionHeadersArray
        array = aDictionary[sectionHeadersKEY];
        self.sectionHeadersArray = [IRBaseDescriptor viewDescriptorsHierarchyFromArray:array];

        // sectionFootersArray
        array = aDictionary[sectionFootersKEY];
        self.sectionFootersArray = [IRBaseDescriptor viewDescriptorsHierarchyFromArray:array];

        // cellsArray
        array = aDictionary[cellsKEY];
        self.cellsArray = [IRBaseDescriptor viewDescriptorsHierarchyFromArray:array];

        // sectionItemName
        string = aDictionary[NSStringFromSelector(@selector(sectionItemName))];
        if (string) {
            self.sectionItemName = string;
        } else {
            self.sectionItemName = sectionKEY;
        }

        // cellItemName
        string = aDictionary[NSStringFromSelector(@selector(cellItemName))];
        if (string) {
            self.cellItemName = string;
        } else {
            self.cellItemName = cellKEY;
        }

        // selectRowAction
        string = aDictionary[NSStringFromSelector(@selector(selectRowAction))];
        self.selectRowAction = string;

        // disableSelectRowAction
        number = aDictionary[NSStringFromSelector(@selector(disableSelectRowAction))];
        if (number) {
            self.disableSelectRowAction = [number boolValue];
        } else {
            self.disableSelectRowAction = NO;
        }

        // accessoryButtonAction
        string = aDictionary[NSStringFromSelector(@selector(accessoryButtonAction))];
        self.accessoryButtonAction = string;

        // tableData
        array = aDictionary[NSStringFromSelector(@selector(tableData))];
        self.tableData = array;
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    // TODO: check should 'backgroundView' be added
    [self.tableHeaderView extendImagePathsArray:imagePaths];
    [self.tableFooterView extendImagePathsArray:imagePaths];
    for (IRBaseDescriptor *anDescriptor in self.sectionHeadersArray) {
        [anDescriptor extendImagePathsArray:imagePaths];
    }
    for (IRBaseDescriptor *anDescriptor in self.sectionFootersArray) {
        [anDescriptor extendImagePathsArray:imagePaths];
    }
    for (IRBaseDescriptor *anDescriptor in self.cellsArray) {
        [anDescriptor extendImagePathsArray:imagePaths];
    }
}

@end