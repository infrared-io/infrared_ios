//
// Created by Uros Milivojevic on 10/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRLayoutConstraintDescriptor.h"
#import "IRLayoutConstraintICSPriorityDescriptor.h"
#import "IRLayoutConstraintWithVFDescriptor.h"
#import "IRLayoutConstraintWithItemDescriptor.h"

@implementation IRLayoutConstraintDescriptor

+ (IRLayoutConstraintDescriptor *) newLayoutConstraintDescriptorWithDictionary:(NSDictionary *)sourceDictionary
{
    IRLayoutConstraintDescriptor *descriptor = nil;
    LayoutConstraintDescriptorType type = [IRLayoutConstraintDescriptor layoutConstraintDescriptorTypeForDictionary:sourceDictionary];
    switch (type) {
        case LayoutConstraintDescriptorTypeICS:
            descriptor = [[IRLayoutConstraintICSPriorityDescriptor alloc] initDescriptorWithDictionary:sourceDictionary];
            break;
        case LayoutConstraintDescriptorTypeVisualFormat:
            descriptor = [[IRLayoutConstraintWithVFDescriptor alloc] initDescriptorWithDictionary:sourceDictionary];
            break;
        case LayoutConstraintDescriptorTypeWithItem:
            descriptor = [[IRLayoutConstraintWithItemDescriptor alloc] initDescriptorWithDictionary:sourceDictionary];
            break;
        case LayoutConstraintDescriptorTypeNone:break;
    }
    return descriptor;
}

+ (LayoutConstraintDescriptorType) layoutConstraintDescriptorTypeForDictionary:(NSDictionary *)dictionary
{
    LayoutConstraintDescriptorType layoutConstraintDescriptorType;
    NSString *forAxis = dictionary[NSStringFromSelector(@selector(forAxis))];
    NSString *visualFormat = dictionary[NSStringFromSelector(@selector(visualFormat))];
    NSString *withItem = dictionary[NSStringFromSelector(@selector(withItem))];
    if (forAxis) {
        layoutConstraintDescriptorType = LayoutConstraintDescriptorTypeICS;
    } else if (visualFormat) {
        layoutConstraintDescriptorType = LayoutConstraintDescriptorTypeVisualFormat;
    } else if (withItem) {
        layoutConstraintDescriptorType = LayoutConstraintDescriptorTypeWithItem;
    } else {
        layoutConstraintDescriptorType = LayoutConstraintDescriptorTypeNone;
    }
    return layoutConstraintDescriptorType;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

+ (LayoutConstraintICSType) layoutConstraintICSTypeFromString:(NSString *)string
{
    LayoutConstraintICSType layoutConstraintICSType;
    if ([@"compressionResistance" isEqualToString:string]) {
        layoutConstraintICSType = LayoutConstraintICSTypeCompressionResistance;
    } else if ([@"hugging" isEqualToString:string]) {
        layoutConstraintICSType = LayoutConstraintICSTypeHugging;
    } else {
        layoutConstraintICSType = LayoutConstraintICSTypeNone;
    }
    return layoutConstraintICSType;
}

+ (UILayoutConstraintAxis) layoutConstraintAxisFromString:(NSString *)string
{
    UILayoutConstraintAxis layoutConstraintAxis;
    if ([@"UILayoutConstraintAxisHorizontal" isEqualToString:string]) {
        layoutConstraintAxis = UILayoutConstraintAxisHorizontal;
    } else if ([@"UILayoutConstraintAxisVertical" isEqualToString:string]) {
        layoutConstraintAxis = UILayoutConstraintAxisVertical;
    } else {
        layoutConstraintAxis = UILayoutConstraintAxisHorizontal;
    }
    return layoutConstraintAxis;
}

+ (NSLayoutAttribute) layoutAttributeFromString:(NSString *)string
{
    NSLayoutAttribute layoutAttribute;
    if ([@"NSLayoutAttributeLeft" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeLeft;
    } else if ([@"NSLayoutAttributeRight" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeRight;
    } else if ([@"NSLayoutAttributeTop" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeTop;
    } else if ([@"NSLayoutAttributeBottom" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeBottom;
    } else if ([@"NSLayoutAttributeLeading" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeLeading;
    } else if ([@"NSLayoutAttributeTrailing" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeTrailing;
    } else if ([@"NSLayoutAttributeWidth" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeWidth;
    } else if ([@"NSLayoutAttributeHeight" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeHeight;
    } else if ([@"NSLayoutAttributeCenterX" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeCenterX;
    } else if ([@"NSLayoutAttributeCenterY" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeCenterY;
    } else if ([@"NSLayoutAttributeBaseline" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeBaseline;
    } else if ([@"NSLayoutAttributeLastBaseline" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeLastBaseline;
    } else if ([@"NSLayoutAttributeFirstBaseline" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeFirstBaseline;
    } else if ([@"NSLayoutAttributeLeftMargin" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeLeftMargin;
    } else if ([@"NSLayoutAttributeRightMargin" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeRightMargin;
    } else if ([@"NSLayoutAttributeTopMargin" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeTopMargin;
    } else if ([@"NSLayoutAttributeBottomMargin" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeBottomMargin;
    } else if ([@"NSLayoutAttributeLeadingMargin" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeLeadingMargin;
    } else if ([@"NSLayoutAttributeTrailingMargin" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeTrailingMargin;
    } else if ([@"NSLayoutAttributeCenterXWithinMargins" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeCenterXWithinMargins;
    } else if ([@"NSLayoutAttributeCenterYWithinMargins" isEqualToString:string]) {
        layoutAttribute = NSLayoutAttributeCenterYWithinMargins;
    } else {
        layoutAttribute = NSLayoutAttributeNotAnAttribute;
    }
    return layoutAttribute;
}

+ (NSLayoutRelation) layoutRelationFromString:(NSString *)string
{
    NSLayoutRelation layoutRelation;
    if ([@"NSLayoutRelationLessThanOrEqual" isEqualToString:string]) {
        layoutRelation = NSLayoutRelationLessThanOrEqual;
    } else if ([@"NSLayoutRelationEqual" isEqualToString:string]) {
        layoutRelation = NSLayoutRelationEqual;
    } else if ([@"NSLayoutRelationGreaterThanOrEqual" isEqualToString:string]) {
        layoutRelation = NSLayoutRelationGreaterThanOrEqual;
    } else {
        layoutRelation = NSLayoutRelationEqual;
    }
    return layoutRelation;
}

+ (NSLayoutFormatOptions) layoutFormatOptionsFromString:(NSString *)string
{
    NSLayoutFormatOptions layoutFormatOptions;
    NSString *anOption;
    NSLayoutFormatOptions anLayoutFormatOptions;
    NSArray *optionsArray;
    NSString *anTrimmedOption;
    if ([string length] > 0) {
        optionsArray = [IRBaseDescriptor componentsArrayFromString:string];
        for (NSUInteger i=0; i < [optionsArray count]; i++) {
            anOption = optionsArray[i];
            anTrimmedOption = [anOption stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if ([@"NSLayoutFormatAlignAllLeft" isEqualToString:anTrimmedOption]) {
                anLayoutFormatOptions = NSLayoutFormatAlignAllLeft;
            } else if ([@"NSLayoutFormatAlignAllRight" isEqualToString:anTrimmedOption]) {
                anLayoutFormatOptions = NSLayoutFormatAlignAllRight;
            } else if ([@"NSLayoutFormatAlignAllTop" isEqualToString:anTrimmedOption]) {
                anLayoutFormatOptions = NSLayoutFormatAlignAllTop;
            } else if ([@"NSLayoutFormatAlignAllBottom" isEqualToString:anTrimmedOption]) {
                anLayoutFormatOptions = NSLayoutFormatAlignAllBottom;
            } else if ([@"NSLayoutFormatAlignAllLeading" isEqualToString:anTrimmedOption]) {
                anLayoutFormatOptions = NSLayoutFormatAlignAllLeading;
            } else if ([@"NSLayoutFormatAlignAllTrailing" isEqualToString:anTrimmedOption]) {
                anLayoutFormatOptions = NSLayoutFormatAlignAllTrailing;
            } else if ([@"NSLayoutFormatAlignAllCenterX" isEqualToString:anTrimmedOption]) {
                anLayoutFormatOptions = NSLayoutFormatAlignAllCenterX;
            } else if ([@"NSLayoutFormatAlignAllCenterY" isEqualToString:anTrimmedOption]) {
                anLayoutFormatOptions = NSLayoutFormatAlignAllCenterY;
            } else if ([@"NSLayoutFormatAlignAllBaseline" isEqualToString:anTrimmedOption]) {
                anLayoutFormatOptions = NSLayoutFormatAlignAllBaseline;
            } else if ([@"NSLayoutFormatAlignAllLastBaseline" isEqualToString:anTrimmedOption]) {
                anLayoutFormatOptions = NSLayoutFormatAlignAllLastBaseline;
            } else if ([@"NSLayoutFormatAlignmentMask" isEqualToString:anTrimmedOption]) {
                anLayoutFormatOptions = NSLayoutFormatAlignmentMask;
            } else if ([@"NSLayoutFormatDirectionLeadingToTrailing" isEqualToString:anTrimmedOption]) {
                anLayoutFormatOptions = NSLayoutFormatDirectionLeadingToTrailing;
            } else if ([@"NSLayoutFormatDirectionLeftToRight" isEqualToString:anTrimmedOption]) {
                anLayoutFormatOptions = NSLayoutFormatDirectionLeftToRight;
            } else if ([@"NSLayoutFormatDirectionRightToLeft" isEqualToString:anTrimmedOption]) {
                anLayoutFormatOptions = NSLayoutFormatDirectionRightToLeft;
            } else if ([@"NSLayoutFormatDirectionMask" isEqualToString:anTrimmedOption]) {
                anLayoutFormatOptions = NSLayoutFormatDirectionMask;
            } else {
                anLayoutFormatOptions = NSLayoutFormatDirectionLeadingToTrailing;
            }

            if (i == 0) {
                layoutFormatOptions = anLayoutFormatOptions;
            } else {
                layoutFormatOptions |= anLayoutFormatOptions;
            }
        }
    } else {
        layoutFormatOptions = NSLayoutFormatDirectionLeadingToTrailing;
    }
    return layoutFormatOptions;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;

        // priority
        number = aDictionary[NSStringFromSelector(@selector(priority))];
        self.priority = number;
    }
    return self;
}

@end