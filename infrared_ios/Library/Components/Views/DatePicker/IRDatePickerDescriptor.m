//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRDatePickerDescriptor.h"
#import "IRDatePickerBuilder.h"
#import "IRDatePicker.h"


@implementation IRDatePickerDescriptor

+ (NSString *) componentName
{
    return typeDatePickerKEY;
}
+ (Class) componentClass
{
    return [IRDatePicker class];
}

+ (Class) builderClass
{
    return [IRDatePickerBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UIDatePicker class], @protocol(UIDatePickerExport));
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;

        // datePickerMode
        string = aDictionary[NSStringFromSelector(@selector(datePickerMode))];
        self.datePickerMode = [IRBaseDescriptor datePickerModeFromString:string];

        // date
        string = aDictionary[NSStringFromSelector(@selector(date))];
        self.date = [IRBaseDescriptor dateWithISO8601String:string];

        // minimumDate
        string = aDictionary[NSStringFromSelector(@selector(minimumDate))];
        self.minimumDate = [IRBaseDescriptor dateWithISO8601String:string];

        // maximumDate
        string = aDictionary[NSStringFromSelector(@selector(maximumDate))];
        self.maximumDate = [IRBaseDescriptor dateWithISO8601String:string];

        // countDownDuration
        number = aDictionary[NSStringFromSelector(@selector(countDownDuration))];
        if (number) {
            self.countDownDuration = (NSTimeInterval)[number floatValue];
        } else {
            self.countDownDuration = 0;
        }

        // minuteInterval
        number = aDictionary[NSStringFromSelector(@selector(minuteInterval))];
        if (number) {
            self.minuteInterval = [number integerValue];
        } else {
            self.minuteInterval = 0;
        }
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{

}

@end