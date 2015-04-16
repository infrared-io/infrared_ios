//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRBarButtonItemDescriptor.h"
#import "IRBarButtonItemBuilder.h"
#import "IRViewDescriptor.h"
#import "IRBarButtonItem.h"


@implementation IRBarButtonItemDescriptor

+ (NSString *) componentName
{
    return typeBarButtonItemKEY;
}
+ (Class) componentClass
{
    return [IRBarButtonItem class];
}

+ (Class) builderClass
{
    return [IRBarButtonItemBuilder class];
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSArray *array;
        NSDictionary *dictionary;

        // identifier
        string = aDictionary[NSStringFromSelector(@selector(identifier))];
        self.identifier = [IRBaseDescriptor barButtonSystemItemFromString:string];

        // style
        string = aDictionary[NSStringFromSelector(@selector(style))];
        self.style = [IRBaseDescriptor barButtonItemStyleFromString:string];

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

@end