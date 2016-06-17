//
// Created by Uros Milivojevic on 12/12/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRTableViewCellDescriptor.h"
#if TARGET_OS_IPHONE
#import "IRTableViewCellBuilder.h"
#import "IRTableViewCell.h"
#endif


@implementation IRTableViewCellDescriptor

+ (NSString *) componentName
{
    return typeTableViewCellKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRTableViewCell class];
}

+ (Class) builderClass
{
    return [IRTableViewCellBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UITableViewCell class], @protocol(UITableViewCellExport));
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

#if TARGET_OS_IPHONE
        // style
        string = aDictionary[NSStringFromSelector(@selector(style))];
        self.style = [IRBaseDescriptor tableViewCellStyleFromString:string];
#endif

        // backgroundView
        dictionary = aDictionary[NSStringFromSelector(@selector(backgroundView))];
        self.backgroundView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // selectedBackgroundView
        dictionary = aDictionary[NSStringFromSelector(@selector(selectedBackgroundView))];
        self.selectedBackgroundView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // multipleSelectionBackgroundView
        dictionary = aDictionary[NSStringFromSelector(@selector(multipleSelectionBackgroundView))];
        self.multipleSelectionBackgroundView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

#if TARGET_OS_IPHONE
        // selectionStyle
        string = aDictionary[NSStringFromSelector(@selector(selectionStyle))];
        self.selectionStyle = [IRBaseDescriptor tableViewCellSelectionStyleFromString:string];
#endif

        // selected
        number = aDictionary[NSStringFromSelector(@selector(selected))];
        if (number) {
            self.selected = [number boolValue];
        } else {
            self.selected = NO;
        }

        // highlighted
        number = aDictionary[NSStringFromSelector(@selector(highlighted))];
        if (number) {
            self.highlighted = [number boolValue];
        } else {
            self.highlighted = NO;
        }

#if TARGET_OS_IPHONE
        // editingStyle
        string = aDictionary[NSStringFromSelector(@selector(editingStyle))];
        self.editingStyle = [IRBaseDescriptor tableViewCellEditingStyleFromString:string];
#endif

        // showsReorderControl
        number = aDictionary[NSStringFromSelector(@selector(showsReorderControl))];
        if (number) {
            self.showsReorderControl = [number boolValue];
        } else {
            self.showsReorderControl = NO;
        }

        // shouldIndentWhileEditing
        number = aDictionary[NSStringFromSelector(@selector(shouldIndentWhileEditing))];
        if (number) {
            self.shouldIndentWhileEditing = [number boolValue];
        } else {
            self.shouldIndentWhileEditing = YES;
        }

#if TARGET_OS_IPHONE
        // accessoryType
        string = aDictionary[NSStringFromSelector(@selector(accessoryType))];
        self.accessoryType = [IRBaseDescriptor tableViewCellAccessoryTypeFromString:string];
#endif

        // accessoryView
        dictionary = aDictionary[NSStringFromSelector(@selector(accessoryView))];
        self.accessoryView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

#if TARGET_OS_IPHONE
        // editingAccessoryType
        string = aDictionary[NSStringFromSelector(@selector(editingAccessoryType))];
        self.editingAccessoryType = [IRBaseDescriptor tableViewCellAccessoryTypeFromString:string];
#endif

        // editingAccessoryView
        dictionary = aDictionary[NSStringFromSelector(@selector(editingAccessoryView))];
        self.editingAccessoryView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // indentationLevel
        number = aDictionary[NSStringFromSelector(@selector(indentationLevel))];
        self.indentationLevel = [number integerValue];

        // indentationWidth
        number = aDictionary[NSStringFromSelector(@selector(indentationWidth))];
        if (number) {
            self.indentationWidth = [number floatValue];
        } else {
            self.indentationWidth = 10.0;
        }

#if TARGET_OS_IPHONE
        // separatorInset
        dictionary = aDictionary[NSStringFromSelector(@selector(indentationLevel))];
        self.separatorInset = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];
#endif

        // editing
        number = aDictionary[NSStringFromSelector(@selector(editing))];
        if (number) {
            self.editing = [number boolValue];
        } else {
            self.editing = NO;
        }

        // selectRowAction
        string = aDictionary[NSStringFromSelector(@selector(selectRowAction))];
        self.selectRowAction = string;

        // accessoryButtonAction
        string = aDictionary[NSStringFromSelector(@selector(accessoryButtonAction))];
        self.accessoryButtonAction = string;

        // disableSelectRowAction
        number = aDictionary[NSStringFromSelector(@selector(disableSelectRowAction))];
        if (number) {
            self.disableSelectRowAction = [number boolValue];
        } else {
            self.disableSelectRowAction = NO;
        }

        // rowHeight
        number = aDictionary[NSStringFromSelector(@selector(rowHeight))];
        if (number) {
            self.rowHeight = [number floatValue];
        } else {
            self.rowHeight = CGFLOAT_UNDEFINED;
        }

        // dynamicAutolayoutRowHeight
        number = aDictionary[NSStringFromSelector(@selector(dynamicAutolayoutRowHeight))];
        if (number) {
            self.dynamicAutolayoutRowHeight = [number boolValue];
        } else {
            self.dynamicAutolayoutRowHeight = NO;
        }

        // dynamicAutolayoutRowHeightMinimum
        number = aDictionary[NSStringFromSelector(@selector(dynamicAutolayoutRowHeightMinimum))];
        if (number) {
            self.dynamicAutolayoutRowHeightMinimum = [number floatValue];
        } else {
            self.dynamicAutolayoutRowHeightMinimum = CGFLOAT_UNDEFINED;
        }
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor
{
    [self.backgroundView extendImagePathsArray:imagePaths appDescriptor:appDescriptor];
    [self.selectedBackgroundView extendImagePathsArray:imagePaths appDescriptor:appDescriptor];
    [self.multipleSelectionBackgroundView extendImagePathsArray:imagePaths appDescriptor:appDescriptor];
    [self.accessoryView extendImagePathsArray:imagePaths appDescriptor:appDescriptor];
    [self.editingAccessoryView extendImagePathsArray:imagePaths appDescriptor:appDescriptor];
}

@end