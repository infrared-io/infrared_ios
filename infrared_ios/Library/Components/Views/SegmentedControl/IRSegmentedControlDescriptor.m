//
// Created by Uros Milivojevic on 12/6/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRSegmentedControlDescriptor.h"
#import "IRSegmentedControlBuilder.h"
#import "IRSegment.h"
#import "IRUtil.h"
#import "IRSegmentedControl.h"


@implementation IRSegmentedControlDescriptor

+ (NSString *) componentName
{
    return typeSegmentedControlKEY;
}
+ (Class) componentClass
{
    return [IRSegmentedControl class];
}

+ (Class) builderClass
{
    return [IRSegmentedControlBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UISegmentedControl class], @protocol(UISegmentedControlExport));
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSArray *array;
        NSDictionary *dictionary;
        IRSegment *anSegment;
        CGSize aSize;

        // momentary
        number = aDictionary[NSStringFromSelector(@selector(momentary))];
        if (number) {
            self.momentary = [number boolValue];
        } else {
            self.momentary = NO;
        }

        // segmentsArray
        array = aDictionary[segmentsKEY];
        self.segmentsArray = [NSMutableArray array];
        for (NSDictionary *anSegmentDictionary in array) {
            anSegment = [[IRSegment alloc] init];
            [self.segmentsArray addObject:anSegment];

            // -- title
            string = anSegmentDictionary[NSStringFromSelector(@selector(title))];
            anSegment.title = string;

            // -- image
            string = anSegmentDictionary[NSStringFromSelector(@selector(image))];
            anSegment.image = string;

            // -- enabled
            number = anSegmentDictionary[NSStringFromSelector(@selector(enabled))];
            if (number) {
                anSegment.enabled = [number boolValue];
            } else {
                anSegment.enabled = YES;
            }

            // -- selected
            number = anSegmentDictionary[NSStringFromSelector(@selector(selected))];
            if (number) {
                anSegment.selected = [number boolValue];
            } else {
                anSegment.selected = NO;
            }

            // -- contentOffset
            dictionary = anSegmentDictionary[NSStringFromSelector(@selector(contentOffset))];
            if (dictionary) {
                aSize = CGSizeZero;
                string = dictionary[widthKEY];
                aSize.width = [string floatValue];
                string = dictionary[heightKEY];
                aSize.height = [string floatValue];
                anSegment.contentOffset = aSize;
            } else {
                anSegment.contentOffset = CGSizeNull;
            }
        }
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    for (IRSegment *anSegment in self.segmentsArray) {
        if ([anSegment.image length] > 0 && [IRUtil isLocalFile:anSegment.image] == NO) {
            [imagePaths addObject:anSegment.image];
        }
    }
}

@end