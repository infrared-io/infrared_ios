//
// Created by Uros Milivojevic on 12/12/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRNavigationItemDescriptor.h"
#import "IRNavigationItemBuilder.h"
#import "IRViewDescriptor.h"
#import "IRNavigationItem.h"


@implementation IRNavigationItemDescriptor

+ (NSString *) componentName
{
    return typeNavigationItemKEY;
}
+ (Class) componentClass
{
    return [IRNavigationItem class];
}

+ (Class) builderClass
{
    return [IRNavigationItemBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UINavigationItem class], @protocol(UINavigationItemExport));
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSArray *array;
        NSDictionary *dictionary;

        // title
        string = aDictionary[NSStringFromSelector(@selector(title))];
        self.title = string;

        // backBarButtonItem
        dictionary = aDictionary[NSStringFromSelector(@selector(backBarButtonItem))];
        self.backBarButtonItem = [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // titleView
        dictionary = aDictionary[NSStringFromSelector(@selector(titleView))];
        self.titleView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // prompt
        string = aDictionary[NSStringFromSelector(@selector(prompt))];
        self.prompt = string;

        // hidesBackButton
        number = aDictionary[NSStringFromSelector(@selector(hidesBackButton))];
        if (number) {
            self.hidesBackButton = [number boolValue];
        } else {
            self.hidesBackButton = YES;
        }

        // leftBarButtonItems
        array = aDictionary[NSStringFromSelector(@selector(leftBarButtonItems))];
        self.leftBarButtonItems = [IRBaseDescriptor viewDescriptorsHierarchyFromArray:array];

        // rightBarButtonItems
        array = aDictionary[NSStringFromSelector(@selector(rightBarButtonItems))];
        self.rightBarButtonItems = [IRBaseDescriptor viewDescriptorsHierarchyFromArray:array];

        // leftItemsSupplementBackButton
        number = aDictionary[NSStringFromSelector(@selector(leftItemsSupplementBackButton))];
        if (number) {
            self.leftItemsSupplementBackButton = [number boolValue];
        } else {
            self.leftItemsSupplementBackButton = NO;
        }

        // leftBarButtonItem
        dictionary = aDictionary[NSStringFromSelector(@selector(leftBarButtonItem))];
        self.leftBarButtonItem = [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // rightBarButtonItem
        dictionary = aDictionary[NSStringFromSelector(@selector(rightBarButtonItem))];
        self.rightBarButtonItem = [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{

}

@end