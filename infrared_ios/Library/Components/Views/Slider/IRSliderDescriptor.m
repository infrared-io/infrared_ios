//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRSliderDescriptor.h"
#import "IRUtil.h"
#if TARGET_OS_IPHONE
#import "IRSliderBuilder.h"
#import "IRSlider.h"
#endif


@implementation IRSliderDescriptor

+ (NSString *) componentName
{
    return typeSliderKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRSlider class];
}

+ (Class) builderClass
{
    return [IRSliderBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UISlider class], @protocol(UISliderExport));
}
#endif

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

#if TARGET_OS_IPHONE
        // minimumTrackTintColor
        string = aDictionary[NSStringFromSelector(@selector(minimumTrackTintColor))];
        self.minimumTrackTintColor = [IRUtil transformHexColorToUIColor:string];

        // maximumTrackTintColor
        string = aDictionary[NSStringFromSelector(@selector(maximumTrackTintColor))];
        self.maximumTrackTintColor = [IRUtil transformHexColorToUIColor:string];

        // thumbTintColor
        string = aDictionary[NSStringFromSelector(@selector(thumbTintColor))];
        self.thumbTintColor = [IRUtil transformHexColorToUIColor:string];
#endif
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor
{
    if (self.minimumValueImage && [IRUtil isFileForDownload:self.minimumValueImage appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.minimumValueImage];
    }
    if (self.maximumValueImage && [IRUtil isFileForDownload:self.maximumValueImage appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.maximumValueImage];
    }
}

@end