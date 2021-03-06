//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRStepperDescriptor.h"
#import "IRUtil.h"
#if TARGET_OS_IPHONE
#import "IRStepperBuilder.h"
#import "IRStepper.h"
#endif


@implementation IRStepperDescriptor

+ (NSString *) componentName
{
    return typeStepperKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRStepper class];
}

+ (Class) builderClass
{
    return [IRStepperBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UIStepper class], @protocol(UIStepperExport));
}
#endif

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;

        // continuous
        number = aDictionary[NSStringFromSelector(@selector(continuous))];
        if (number) {
            self.continuous = [number boolValue];
        } else {
            self.continuous = YES;
        }

        // autorepeat
        number = aDictionary[NSStringFromSelector(@selector(autorepeat))];
        if (number) {
            self.autorepeat = [number boolValue];
        } else {
            self.autorepeat = YES;
        }

        // wraps
        number = aDictionary[NSStringFromSelector(@selector(wraps))];
        if (number) {
            self.wraps = [number boolValue];
        } else {
            self.wraps = YES;
        }

        // value
        number = aDictionary[NSStringFromSelector(@selector(value))];
        if (number) {
            self.value = [number floatValue];
        } else {
            self.value = 0;
        }

        // minimumValue
        number = aDictionary[NSStringFromSelector(@selector(minimumValue))];
        if (number) {
            self.minimumValue = [number floatValue];
        } else {
            self.minimumValue = 0;
        }

        // maximumValue
        number = aDictionary[NSStringFromSelector(@selector(maximumValue))];
        if (number) {
            self.maximumValue = [number floatValue];
        } else {
            self.maximumValue = 100;
        }

        // stepValue
        number = aDictionary[NSStringFromSelector(@selector(stepValue))];
        if (number) {
            self.stepValue = [number floatValue];
        } else {
            self.stepValue = 1;
        }
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor
{

}

@end