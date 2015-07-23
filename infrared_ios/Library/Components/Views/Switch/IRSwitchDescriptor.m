//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRSwitchDescriptor.h"
#import "IRUtil.h"
#if TARGET_OS_IPHONE
#import "IRSwitchBuilder.h"
#import "IRSwitch.h"
#endif


@implementation IRSwitchDescriptor

+ (NSString *) componentName
{
    return typeSwitchKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRSwitch class];
}

+ (Class) builderClass
{
    return [IRSwitchBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UISwitch class], @protocol(UISwitchExport));
}
#endif

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;

#if TARGET_OS_IPHONE
        // onTintColor
        string = aDictionary[NSStringFromSelector(@selector(onTintColor))];
        self.onTintColor = [IRUtil transformHexColorToUIColor:string];

        // tintColor
        string = aDictionary[NSStringFromSelector(@selector(tintColor))];
        self.tintColor = [IRUtil transformHexColorToUIColor:string];

        // thumbTintColor
        string = aDictionary[NSStringFromSelector(@selector(thumbTintColor))];
        self.thumbTintColor = [IRUtil transformHexColorToUIColor:string];
#endif

        // onImage
        string = aDictionary[NSStringFromSelector(@selector(onImage))];
        self.onImage = string;

        // offImage
        string = aDictionary[NSStringFromSelector(@selector(offImage))];
        self.offImage = string;

        // on
        number = aDictionary[NSStringFromSelector(@selector(on))];
        if (number) {
            self.on = [number boolValue];
        } else {
            self.on = NO;
        }
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    if (self.onImage && [IRUtil isFileForDownload:self.onImage]) {
        [imagePaths addObject:self.onImage];
    }
    if (self.offImage && [IRUtil isFileForDownload:self.offImage]) {
        [imagePaths addObject:self.offImage];
    }
}

@end