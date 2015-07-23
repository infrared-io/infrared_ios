//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRPickerViewDescriptor.h"
#if TARGET_OS_IPHONE
#import "IRPickerViewBuilder.h"
#import "IRPickerView.h"
#endif


@implementation IRPickerViewDescriptor

+ (NSString *) componentName
{
    return typePickerViewKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRPickerView class];
}

+ (Class) builderClass
{
    return [IRPickerViewBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UIPickerView class], @protocol(UIPickerViewExport));
}
#endif

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSArray *array;

        // showsSelectionIndicator
        number = aDictionary[NSStringFromSelector(@selector(showsSelectionIndicator))];
        if (number) {
            self.showsSelectionIndicator = [number boolValue];
        } else {
            self.showsSelectionIndicator = NO;
        }

        // selectRowAction
        string = aDictionary[NSStringFromSelector(@selector(selectRowAction))];
        self.selectRowAction = string;

        // pickerData
        array = aDictionary[NSStringFromSelector(@selector(pickerData))];
        self.pickerData = array;
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{

}

@end