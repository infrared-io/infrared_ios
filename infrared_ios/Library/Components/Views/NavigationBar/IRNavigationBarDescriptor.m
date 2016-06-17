//
// Created by Uros Milivojevic on 12/12/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRNavigationBarDescriptor.h"
#import "IRUtil.h"
#if TARGET_OS_IPHONE
#import "IRNavigationBarBuilder.h"
#import "IRNavigationBar.h"
#endif


@implementation IRNavigationBarDescriptor

+ (NSString *) componentName
{
    return typeNavigationBarKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRNavigationBar class];
}

+ (Class) builderClass
{
    return [IRNavigationBarBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UINavigationBar class], @protocol(UINavigationBarExport));
}
#endif

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSArray *array;

#if TARGET_OS_IPHONE
        // barStyle
        string = aDictionary[NSStringFromSelector(@selector(barStyle))];
        self.barStyle = [IRBaseDescriptor barStyleFromString:string];
#endif

        // translucent
        number = aDictionary[NSStringFromSelector(@selector(translucent))];
        if (number) {
            self.translucent = [number boolValue];
        } else {
            self.translucent = YES;
        }

        // items
        array = aDictionary[NSStringFromSelector(@selector(items))];
        self.items = [IRBaseDescriptor viewDescriptorsHierarchyFromArray:array];

#if TARGET_OS_IPHONE
        // barTintColor
        string = aDictionary[NSStringFromSelector(@selector(barTintColor))];
        self.barTintColor = [IRUtil transformHexColorToUIColor:string];
#endif

        // shadowImage
        string = aDictionary[NSStringFromSelector(@selector(shadowImage))];
        self.shadowImage = string;

        // titleTextAttributes


        // backIndicatorImage
        string = aDictionary[NSStringFromSelector(@selector(backIndicatorImage))];
        self.backIndicatorImage = string;

        // backIndicatorTransitionMaskImage
        string = aDictionary[NSStringFromSelector(@selector(backIndicatorTransitionMaskImage))];
        self.backIndicatorTransitionMaskImage = string;

    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor
{
    if (self.shadowImage && [IRUtil isFileForDownload:self.shadowImage appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.shadowImage];
    }
    if (self.backIndicatorImage && [IRUtil isFileForDownload:self.backIndicatorImage appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.backIndicatorImage];
    }
    if (self.backIndicatorTransitionMaskImage && [IRUtil isFileForDownload:self.backIndicatorTransitionMaskImage appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.backIndicatorTransitionMaskImage];
    }
}

@end