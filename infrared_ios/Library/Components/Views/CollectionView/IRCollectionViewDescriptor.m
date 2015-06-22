//
// Created by Uros Milivojevic on 6/19/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

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

        // collectionData
        array = aDictionary[NSStringFromSelector(@selector(collectionData))];
        self.collectionData = array;
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    // TODO: check should 'backgroundView' be added
}

@end