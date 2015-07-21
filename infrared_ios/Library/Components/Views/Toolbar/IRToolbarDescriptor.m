//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRToolbarDescriptor.h"
#import "IRToolbarBuilder.h"
#import "IRUtil.h"
#import "IRToolbar.h"


@implementation IRToolbarDescriptor

+ (NSString *) componentName
{
    return typeToolbarKEY;
}
+ (Class) componentClass
{
    return [IRToolbar class];
}

+ (Class) builderClass
{
    return [IRToolbarBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UIToolbar class], @protocol(UIToolbarExport));
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

        // items
        array = aDictionary[NSStringFromSelector(@selector(items))];
        self.items = [IRBaseDescriptor viewDescriptorsHierarchyFromArray:array];

        // translucent
        number = aDictionary[NSStringFromSelector(@selector(translucent))];
        if (number) {
            self.translucent = [number boolValue];
        } else {
            self.translucent = YES;
        }

        // barTintColor
        string = aDictionary[NSStringFromSelector(@selector(barTintColor))];
        self.barTintColor = [IRUtil transformHexColorToUIColor:string];
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{

}

@end