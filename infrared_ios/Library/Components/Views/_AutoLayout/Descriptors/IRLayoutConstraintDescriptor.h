//
// Created by Uros Milivojevic on 10/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

/*
 I set up a quick test project with various combinations of autoresizing masks and the logging format is pretty straightforward.

    h= or v= indicates that we are talking about constraints in the horizontal or vertical direction.
    - indicates a fixed size
    & indicates a flexible size
    The order of symbols represents margin, dimension, margin

 Therefore, h=&-& means you have flexible left and right margins and a fixed width, v=-&- means fixed top and bottom margins and flexible height, and so forth.
 "v=--&" would be fixed top gap, fixed height, flexible bottom gap.
 */

#import <Foundation/Foundation.h>
#import "IRBaseDescriptor.h"

typedef enum {
    LayoutConstraintICSTypeNone,
    LayoutConstraintICSTypeCompressionResistance,
    LayoutConstraintICSTypeHugging
} LayoutConstraintICSType;

typedef enum {
    LayoutConstraintDescriptorTypeNone,
    LayoutConstraintDescriptorTypeICS,
    LayoutConstraintDescriptorTypeVisualFormat,
    LayoutConstraintDescriptorTypeWithItem
} LayoutConstraintDescriptorType;

@interface IRLayoutConstraintDescriptor : IRBaseDescriptor

@property (nonatomic, strong) NSNumber *priority;

+ (IRLayoutConstraintDescriptor *) newLayoutConstraintDescriptorWithDictionary:(NSDictionary *)sourceDictionary;

+ (LayoutConstraintICSType) layoutConstraintICSTypeFromString:(NSString *)string;

+ (UILayoutConstraintAxis) layoutConstraintAxisFromString:(NSString *)string;

+ (NSLayoutAttribute) layoutAttributeFromString:(NSString *)string;

+ (NSLayoutRelation) layoutRelationFromString:(NSString *)string;

+ (NSLayoutFormatOptions) layoutFormatOptionsFromString:(NSString *)string;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

@end