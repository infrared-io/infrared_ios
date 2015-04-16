//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRSliderDescriptor.h"
#import "IRSliderBuilder.h"
#import "IRUtil.h"
#import "IRSlider.h"


@implementation IRSliderDescriptor

+ (NSString *) componentName
{
    return typeSliderKEY;
}
+ (Class) componentClass
{
    return [IRSlider class];
}

+ (Class) builderClass
{
    return [IRSliderBuilder class];
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;

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
            self.maximumValue = 1;
        }

        // minimumValueImage
        string = aDictionary[NSStringFromSelector(@selector(minimumValueImage))];
        self.minimumValueImage = string;

        // maximumValueImage
        string = aDictionary[NSStringFromSelector(@selector(maximumValueImage))];
        self.maximumValueImage = string;

        // continuous
        number = aDictionary[NSStringFromSelector(@selector(continuous))];
        if (number) {
            self.continuous = [number boolValue];
        } else {
            self.continuous = YES;
        }

        // minimumTrackTintColor
        string = aDictionary[NSStringFromSelector(@selector(minimumTrackTintColor))];
        self.minimumTrackTintColor = [IRUtil transformHexColorToUIColor:string];

        // maximumTrackTintColor
        string = aDictionary[NSStringFromSelector(@selector(maximumTrackTintColor))];
        self.maximumTrackTintColor = [IRUtil transformHexColorToUIColor:string];

        // thumbTintColor
        string = aDictionary[NSStringFromSelector(@selector(thumbTintColor))];
        self.thumbTintColor = [IRUtil transformHexColorToUIColor:string];
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    if (self.minimumValueImage && [IRUtil isLocalFile:self.minimumValueImage] == NO) {
        [imagePaths addObject:self.minimumValueImage];
    }
    if (self.maximumValueImage && [IRUtil isLocalFile:self.maximumValueImage] == NO) {
        [imagePaths addObject:self.maximumValueImage];
    }
}

@end