//
// Created by Uros Milivojevic on 6/22/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRCollectionViewCellDescriptor.h"
#if TARGET_OS_IPHONE
#import "IRCollectionViewCell.h"
#import "IRCollectionViewCellBuilder.h"
#endif


@implementation IRCollectionViewCellDescriptor

+ (NSString *) componentName
{
    return typeCollectionViewCellKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRCollectionViewCell class];
}

+ (Class) builderClass
{
    return [IRCollectionViewCellBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UICollectionViewCell class], @protocol(UICollectionViewCellExport));
}
#endif

- (NSDictionary *) viewDefaults
{
    NSDictionary *dictionary = [super viewDefaults];
    NSMutableDictionary *defaults = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [defaults setValuesForKeysWithDictionary:@{
      @"clipsToBounds" : @(YES)
    }];
    return defaults;
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSDictionary *dictionary;

        // selected
        number = aDictionary[NSStringFromSelector(@selector(selected))];
        if (number) {
            self.selected = [number boolValue];
        } else {
            self.selected = NO;
        }

        // highlighted
        number = aDictionary[NSStringFromSelector(@selector(highlighted))];
        if (number) {
            self.highlighted = [number boolValue];
        } else {
            self.highlighted = NO;
        }

        // backgroundView
        dictionary = aDictionary[NSStringFromSelector(@selector(backgroundView))];
        self.backgroundView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // selectedBackgroundView
        dictionary = aDictionary[NSStringFromSelector(@selector(selectedBackgroundView))];
        self.selectedBackgroundView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // selectItemAction
        string = aDictionary[NSStringFromSelector(@selector(selectItemAction))];
        self.selectItemAction = string;

        // cellSize
        dictionary = aDictionary[NSStringFromSelector(@selector(cellSize))];
        self.cellSize = [IRBaseDescriptor sizeFromDictionary:dictionary];

#if TARGET_OS_IPHONE
        // insets
        dictionary = aDictionary[NSStringFromSelector(@selector(insets))];
        self.insets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];
#endif
    }
    return self;
}

@end