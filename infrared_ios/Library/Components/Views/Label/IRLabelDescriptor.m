//
//  IRLabelDescriptor.m
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRLabelDescriptor.h"
#import "IRUtil.h"
#import "IRLabelBuilder.h"
#import "IRLabel.h"

@implementation IRLabelDescriptor

+ (NSString *) componentName
{
    return typeLabelKEY;
}
+ (Class) componentClass
{
    return [IRLabel class];
}

+ (Class) builderClass
{
    return [IRLabelBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UILabel class], @protocol(UILabelExport));
}

- (NSDictionary *) viewDefaults
{
    NSDictionary *dictionary = [super viewDefaults];
    NSMutableDictionary *defaults = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [defaults setValuesForKeysWithDictionary:@{
      @"numberOfLines" : @(1),
      @"enabled" : @(YES),
      @"highlighted" : @(NO),
      @"adjustsFontSizeToFitWidth" : @(NO),
      @"minimumScaleFactor" : @(0),
//      @"highlightedTextColor" : [NSNull null],
//      @"shadowColor" : [NSNull null],
      @"clipsToBounds" : @(NO)
    }];
    return defaults;
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        UIColor *color;
        NSDictionary *dictionary;

        // text
        string = aDictionary[NSStringFromSelector(@selector(text))];
        self.text = string;

        // textColor
        string = aDictionary[NSStringFromSelector(@selector(textColor))];
        color = [IRUtil transformHexColorToUIColor:string];
        if (color) {
            self.textColor = color;
        } else {
            self.textColor = nil;
        }

        // font
        string = aDictionary[NSStringFromSelector(@selector(font))];
        self.font = [IRBaseDescriptor fontFromString:string];

        // textAlignment
        string = aDictionary[NSStringFromSelector(@selector(textAlignment))];
        self.textAlignment = [IRBaseDescriptor textAlignmentFromString:string];

        // attributedText
        // TODO: to be implemented

        // numberOfLines
        number = aDictionary[NSStringFromSelector(@selector(numberOfLines))];
        if (number) {
            self.numberOfLines = [number integerValue];
        } else {
            self.numberOfLines = [[self viewDefaults][NSStringFromSelector(@selector(numberOfLines))] integerValue];
        }

        // enabled
        number = aDictionary[NSStringFromSelector(@selector(enabled))];
        if (number) {
            self.enabled = [number boolValue];
        } else {
            self.enabled = [[self viewDefaults][NSStringFromSelector(@selector(enabled))] boolValue];
        }

        // highlighted
        number = aDictionary[NSStringFromSelector(@selector(highlighted))];
        if (number) {
            self.highlighted = [number boolValue];
        } else {
            self.highlighted = [[self viewDefaults][NSStringFromSelector(@selector(highlighted))] boolValue];
        }

        // adjustsFontSizeToFitWidth
        number = aDictionary[NSStringFromSelector(@selector(adjustsFontSizeToFitWidth))];
        if (number) {
            self.adjustsFontSizeToFitWidth = [number boolValue];
        } else {
            self.adjustsFontSizeToFitWidth = [[self viewDefaults][NSStringFromSelector(@selector(adjustsFontSizeToFitWidth))] boolValue];
        }

        // baselineAdjustment
        string = aDictionary[NSStringFromSelector(@selector(baselineAdjustment))];
        self.baselineAdjustment = [IRBaseDescriptor baselineAdjustmentFromString:string];

        // lineBreakMode
        string = aDictionary[NSStringFromSelector(@selector(lineBreakMode))];
        self.lineBreakMode = [IRBaseDescriptor lineBreakModeFromString:string];

        // minimumScaleFactor
        number = aDictionary[NSStringFromSelector(@selector(minimumScaleFactor))];
        if (number) {
            self.minimumScaleFactor = [number floatValue];
        } else {
            self.minimumScaleFactor = [[self viewDefaults][NSStringFromSelector(@selector(minimumScaleFactor))] floatValue];
        }

        // highlightedTextColor
        string = aDictionary[NSStringFromSelector(@selector(highlightedTextColor))];
        color = [IRUtil transformHexColorToUIColor:string];
        if (color) {
            self.highlightedTextColor = color;
        }

        // shadowColor
        string = aDictionary[NSStringFromSelector(@selector(shadowColor))];
        color = [IRUtil transformHexColorToUIColor:string];
        if (color) {
            self.shadowColor = color;
        }

        // shadowOffset
        dictionary = aDictionary[NSStringFromSelector(@selector(shadowOffset))];
        self.shadowOffset = [IRBaseDescriptor sizeFromDictionary:dictionary];

        // preferredMaxLayoutWidth
        number = aDictionary[NSStringFromSelector(@selector(preferredMaxLayoutWidth))];
        if (number) {
            self.preferredMaxLayoutWidth = [number floatValue];
        } else {
            self.preferredMaxLayoutWidth = CGFLOAT_UNDEFINED;
        }
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{

}

@end
