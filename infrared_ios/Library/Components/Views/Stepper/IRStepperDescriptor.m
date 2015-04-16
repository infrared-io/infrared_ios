//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRStepperDescriptor.h"
#import "IRStepperBuilder.h"
#import "IRUtil.h"
#import "IRStepper.h"


@implementation IRStepperDescriptor

+ (NSString *) componentName
{
    return typeStepperKEY;
}
+ (Class) componentClass
{
    return [IRStepper class];
}

+ (Class) builderClass
{
    return [IRStepperBuilder class];
}

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
{

}

@end