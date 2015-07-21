//
// Created by Uros Milivojevic on 6/19/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRViewDescriptor.h"
#import "IRCollectionViewDescriptor.h"
#import "IRView.h"
#import "IRCollectionView.h"
#import "IRCollectionViewBuilder.h"


@implementation IRCollectionViewDescriptor

+ (NSString *) componentName
{
    return typeCollectionViewKEY;
}
+ (Class) componentClass
{
    return [IRCollectionView class];
}

+ (Class) builderClass
{
    return [IRCollectionViewBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UICollectionView class], @protocol(UICollectionViewExport));
}

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
        NSArray *array;

        // collectionViewLayout

        // backgroundView
        dictionary = aDictionary[NSStringFromSelector(@selector(backgroundView))];
        self.backgroundView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // allowsSelection
        number = aDictionary[NSStringFromSelector(@selector(allowsSelection))];
        if (number) {
            self.allowsSelection = [number boolValue];
        } else {
            self.allowsSelection = YES;
        }

        // allowsMultipleSelection
        number = aDictionary[NSStringFromSelector(@selector(allowsMultipleSelection))];
        if (number) {
            self.allowsMultipleSelection = [number boolValue];
        } else {
            self.allowsMultipleSelection = NO;
        }

        // scrollDirection
        string = aDictionary[NSStringFromSelector(@selector(scrollDirection))];
        self.scrollDirection = [IRBaseDescriptor scrollDirectionFromString:string];

        // sectionHeadersArray
        array = aDictionary[sectionHeadersKEY];
        self.sectionHeadersArray = [IRBaseDescriptor viewDescriptorsHierarchyFromArray:array];

        // sectionFootersArray
        array = aDictionary[sectionFootersKEY];
        self.sectionFootersArray = [IRBaseDescriptor viewDescriptorsHierarchyFromArray:array];

        // cellsArray
        array = aDictionary[cellsKEY];
        self.cellsArray = [IRBaseDescriptor viewDescriptorsHierarchyFromArray:array];

        // sectionItemName
        string = aDictionary[NSStringFromSelector(@selector(sectionItemName))];
        if (string) {
            self.sectionItemName = string;
        } else {
            self.sectionItemName = sectionKEY;
        }

        // cellItemName
        string = aDictionary[NSStringFromSelector(@selector(cellItemName))];
        if (string) {
            self.cellItemName = string;
        } else {
            self.cellItemName = cellKEY;
        }

        // selectItemAction
        string = aDictionary[NSStringFromSelector(@selector(selectItemAction))];
        self.selectItemAction = string;

        // sectionHeaderHeight
        number = aDictionary[NSStringFromSelector(@selector(sectionHeaderHeight))];
        if (number) {
            self.sectionHeaderHeight = [number floatValue];
        } else {
            self.sectionHeaderHeight = CGFLOAT_UNDEFINED;
        }

        // sectionFooterHeight
        number = aDictionary[NSStringFromSelector(@selector(sectionFooterHeight))];
        if (number) {
            self.sectionFooterHeight = [number floatValue];
        } else {
            self.sectionFooterHeight = CGFLOAT_UNDEFINED;
        }

        // cellSize
        dictionary = aDictionary[NSStringFromSelector(@selector(cellSize))];
        self.cellSize = [IRBaseDescriptor sizeFromDictionary:dictionary];

        // sectionEdgeInsets
        dictionary = aDictionary[NSStringFromSelector(@selector(sectionEdgeInsets))];
        self.sectionEdgeInsets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];

        // collectionData
        array = aDictionary[NSStringFromSelector(@selector(collectionData))];
        self.collectionData = array;
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    // TODO: check should 'backgroundView' be added
    for (IRBaseDescriptor *anDescriptor in self.sectionHeadersArray) {
        [anDescriptor extendImagePathsArray:imagePaths];
    }
    for (IRBaseDescriptor *anDescriptor in self.sectionFootersArray) {
        [anDescriptor extendImagePathsArray:imagePaths];
    }
    for (IRBaseDescriptor *anDescriptor in self.cellsArray) {
        [anDescriptor extendImagePathsArray:imagePaths];
    }
}

@end