//
// Created by Uros Milivojevic on 12/12/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRNavigationBarDescriptor.h"
#import "IRNavigationBarBuilder.h"
#import "IRUtil.h"
#import "IRNavigationBar.h"


@implementation IRNavigationBarDescriptor

+ (NSString *) componentName
{
    return typeNavigationBarKEY;
}
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

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSArray *array;

        // barStyle
        string = aDictionary[NSStringFromSelector(@selector(barStyle))];
        self.barStyle = [IRBaseDescriptor barStyleFromString:string];

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

        // barTintColor
        string = aDictionary[NSStringFromSelector(@selector(barTintColor))];
        self.barTintColor = [IRUtil transformHexColorToUIColor:string];

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
{
    if (self.shadowImage && [IRUtil isLocalFile:self.shadowImage] == NO) {
        [imagePaths addObject:self.shadowImage];
    }
    if (self.backIndicatorImage && [IRUtil isLocalFile:self.backIndicatorImage] == NO) {
        [imagePaths addObject:self.backIndicatorImage];
    }
    if (self.backIndicatorTransitionMaskImage && [IRUtil isLocalFile:self.backIndicatorTransitionMaskImage] == NO) {
        [imagePaths addObject:self.backIndicatorTransitionMaskImage];
    }
}

@end