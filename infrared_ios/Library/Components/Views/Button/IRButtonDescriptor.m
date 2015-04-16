//
//  IRButtonDescriptor.m
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRButtonDescriptor.h"
#import "IRUtil.h"
#import "IRButtonBuilder.h"
#import "IRButton.h"

@implementation IRButtonDescriptor

+ (NSString *) componentName
{
    return typeButtonKEY;
}
+ (Class) componentClass
{
    return [IRButton class];
}

+ (Class) builderClass
{
    return [IRButtonBuilder class];
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSDictionary *dictionary;

        // buttonType
        string = aDictionary[NSStringFromSelector(@selector(buttonType))];
        self.buttonType = [IRBaseDescriptor buttonTypeFromString:string];

        // -----------------------------------------------------------------------------------

        // normalTitle
        string = aDictionary[NSStringFromSelector(@selector(normalTitle))];
        self.normalTitle = string;

        // normalTitleColor
        string = aDictionary[NSStringFromSelector(@selector(normalTitleColor))];
        self.normalTitleColor = [IRUtil transformHexColorToUIColor:string];

        // normalTitleShadowColor
        string = aDictionary[NSStringFromSelector(@selector(normalTitleShadowColor))];
        self.normalTitleShadowColor = [IRUtil transformHexColorToUIColor:string];

        // normalImage
        string = aDictionary[NSStringFromSelector(@selector(normalImage))];
        self.normalImage = string;

        // normalBackgroundImage
        string = aDictionary[NSStringFromSelector(@selector(normalBackgroundImage))];
        self.normalBackgroundImage = string;

        // -----------------------------------------------------------------------------------

        // highlightedTitle
        string = aDictionary[NSStringFromSelector(@selector(highlightedTitle))];
        self.highlightedTitle = string;

        // highlightedTitleColor
        string = aDictionary[NSStringFromSelector(@selector(highlightedTitleColor))];
        self.highlightedTitleColor = [IRUtil transformHexColorToUIColor:string];

        // highlightedTitleShadowColor
        string = aDictionary[NSStringFromSelector(@selector(highlightedTitleShadowColor))];
        self.highlightedTitleShadowColor = [IRUtil transformHexColorToUIColor:string];

        // highlightedImage
        string = aDictionary[NSStringFromSelector(@selector(highlightedImage))];
        self.highlightedImage = string;

        // highlightedBackgroundImage
        string = aDictionary[NSStringFromSelector(@selector(highlightedBackgroundImage))];
        self.highlightedBackgroundImage = string;

        // -----------------------------------------------------------------------------------

        // selectedTitle
        string = aDictionary[NSStringFromSelector(@selector(selectedTitle))];
        self.selectedTitle = string;

        // selectedTitleColor
        string = aDictionary[NSStringFromSelector(@selector(selectedTitleColor))];
        self.selectedTitleColor = [IRUtil transformHexColorToUIColor:string];

        // selectedTitleShadowColor
        string = aDictionary[NSStringFromSelector(@selector(selectedTitleShadowColor))];
        self.selectedTitleShadowColor = [IRUtil transformHexColorToUIColor:string];

        // selectedImage
        string = aDictionary[NSStringFromSelector(@selector(selectedImage))];
        self.selectedImage = string;

        // selectedBackgroundImage
        string = aDictionary[NSStringFromSelector(@selector(selectedBackgroundImage))];
        self.selectedBackgroundImage = string;

        // -----------------------------------------------------------------------------------

        // disabledTitle
        string = aDictionary[NSStringFromSelector(@selector(disabledTitle))];
        self.disabledTitle = string;

        // disabledTitleColor
        string = aDictionary[NSStringFromSelector(@selector(disabledTitleColor))];
        self.disabledTitleColor = [IRUtil transformHexColorToUIColor:string];

        // disabledTitleShadowColor
        string = aDictionary[NSStringFromSelector(@selector(disabledTitleShadowColor))];
        self.disabledTitleShadowColor = [IRUtil transformHexColorToUIColor:string];

        // disabledImage
        string = aDictionary[NSStringFromSelector(@selector(disabledImage))];
        self.disabledImage = string;

        // disabledBackgroundImage
        string = aDictionary[NSStringFromSelector(@selector(disabledBackgroundImage))];
        self.disabledBackgroundImage = string;

        // -----------------------------------------------------------------------------------

        // font
        string = aDictionary[NSStringFromSelector(@selector(font))];
        self.font = [IRBaseDescriptor fontFromString:string];

        // titleShadowOffset
        dictionary = aDictionary[NSStringFromSelector(@selector(titleShadowOffset))];
        self.titleShadowOffset = [IRBaseDescriptor sizeFromDictionary:dictionary];

        // reversesTitleShadowWhenHighlighted
        number = aDictionary[NSStringFromSelector(@selector(reversesTitleShadowWhenHighlighted))];
        if (number) {
            self.reversesTitleShadowWhenHighlighted = [number boolValue];
        } else {
            self.reversesTitleShadowWhenHighlighted = NO;
        }

        // showsTouchWhenHighlighted
        number = aDictionary[NSStringFromSelector(@selector(showsTouchWhenHighlighted))];
        if (number) {
            self.showsTouchWhenHighlighted = [number boolValue];
        } else {
            self.showsTouchWhenHighlighted = NO;
        }

        // adjustsImageWhenHighlighted
        number = aDictionary[NSStringFromSelector(@selector(adjustsImageWhenHighlighted))];
        if (number) {
            self.adjustsImageWhenHighlighted = [number boolValue];
        } else {
            self.adjustsImageWhenHighlighted = YES;
        }

        // adjustsImageWhenDisabled
        number = aDictionary[NSStringFromSelector(@selector(adjustsImageWhenDisabled))];
        if (number) {
            self.adjustsImageWhenDisabled = [number boolValue];
        } else {
            self.adjustsImageWhenDisabled = YES;
        }

        // lineBreakMode
        string = aDictionary[NSStringFromSelector(@selector(lineBreakMode))];
        self.lineBreakMode = [IRBaseDescriptor lineBreakModeFromString:string];

        // contentEdgeInsets
        dictionary = aDictionary[NSStringFromSelector(@selector(contentEdgeInsets))];
        self.contentEdgeInsets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];

        // titleEdgeInsets
        dictionary = aDictionary[NSStringFromSelector(@selector(titleEdgeInsets))];
        self.titleEdgeInsets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];

        // imageEdgeInsets
        dictionary = aDictionary[NSStringFromSelector(@selector(imageEdgeInsets))];
        self.imageEdgeInsets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    if (self.normalImage && [IRUtil isLocalFile:self.normalImage] == NO) {
        [imagePaths addObject:self.normalImage];
    }
    if (self.normalBackgroundImage && [IRUtil isLocalFile:self.normalBackgroundImage] == NO) {
        [imagePaths addObject:self.normalBackgroundImage];
    }

    if (self.highlightedImage && [IRUtil isLocalFile:self.highlightedImage] == NO) {
        [imagePaths addObject:self.highlightedImage];
    }
    if (self.highlightedBackgroundImage && [IRUtil isLocalFile:self.highlightedBackgroundImage] == NO) {
        [imagePaths addObject:self.highlightedBackgroundImage];
    }

    if (self.selectedImage && [IRUtil isLocalFile:self.selectedImage] == NO) {
        [imagePaths addObject:self.selectedImage];
    }
    if (self.selectedBackgroundImage && [IRUtil isLocalFile:self.selectedBackgroundImage] == NO) {
        [imagePaths addObject:self.selectedBackgroundImage];
    }

    if (self.disabledImage && [IRUtil isLocalFile:self.disabledImage] == NO) {
        [imagePaths addObject:self.disabledImage];
    }
    if (self.disabledBackgroundImage && [IRUtil isLocalFile:self.disabledBackgroundImage] == NO) {
        [imagePaths addObject:self.disabledBackgroundImage];
    }
}

@end
