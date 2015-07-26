//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRBarButtonItemDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRUtil.h"
#if TARGET_OS_IPHONE
#import "IRBarButtonItemBuilder.h"
#import "IRBarButtonItem.h"
#endif


@implementation IRBarButtonItemDescriptor

+ (NSString *) componentName
{
    return typeBarButtonItemKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRBarButtonItem class];
}

+ (Class) builderClass
{
    return [IRBarButtonItemBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UIBarButtonItem class], @protocol(UIBarButtonItemExport));
    class_addProtocol([UIBarItem class], @protocol(UIBarItemExport));
}
#endif

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSArray *array;
        NSDictionary *dictionary;

#if TARGET_OS_IPHONE
        // identifier
        string = aDictionary[NSStringFromSelector(@selector(identifier))];
        self.identifier = [IRBaseDescriptor barButtonSystemItemFromString:string];

        // style
        string = aDictionary[NSStringFromSelector(@selector(style))];
        self.style = [IRBaseDescriptor barButtonItemStyleFromString:string];
#endif

        // width
        number = aDictionary[NSStringFromSelector(@selector(width))];
        self.width = [number floatValue];

        // possibleTitles
        array = aDictionary[NSStringFromSelector(@selector(possibleTitles))];
        if ([array count] > 0) {
            self.possibleTitles = [NSSet setWithArray:array];
        } else {
            self.possibleTitles = nil;
        }

        // customView
        dictionary = aDictionary[NSStringFromSelector(@selector(customView))];
        self.customView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // action
        string = aDictionary[NSStringFromSelector(@selector(actions))];
        self.actions = string;
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    if (self.image && [IRUtil isFileForDownload:self.image]) {
        [imagePaths addObject:self.image];
    }
    [self.customView extendImagePathsArray:imagePaths];
}

@end