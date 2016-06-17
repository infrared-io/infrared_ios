//
//  IRButtonDescriptor.m
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRViewDescriptor.h"
#import "IRButtonDescriptor.h"
#import "IRUtil.h"
#if TARGET_OS_IPHONE
#import "IRButtonBuilder.h"
#import "IRButton.h"
#endif

@implementation IRButtonDescriptor

+ (NSString *) componentName
{
    return typeButtonKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRButton class];
}

+ (Class) builderClass
{
    return [IRButtonBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UIButton class], @protocol(UIButtonExport));
}
#endif

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSDictionary *dictionary;

#if TARGET_OS_IPHONE
        // buttonType
        string = aDictionary[NSStringFromSelector(@selector(buttonType))];
        self.buttonType = [IRBaseDescriptor buttonTypeFromString:string];
#endif

        // -----------------------------------------------------------------------------------

        // normalTitle
        string = aDictionary[NSStringFromSelector(@selector(normalTitle))];
        self.normalTitle = string;

#if TARGET_OS_IPHONE
        // normalTitleColor
        string = aDictionary[NSStringFromSelector(@selector(normalTitleColor))];
        self.normalTitleColor = [IRUtil transformHexColorToUIColor:string];

        // normalTitleShadowColor
        string = aDictionary[NSStringFromSelector(@selector(normalTitleShadowColor))];
        self.normalTitleShadowColor = [IRUtil transformHexColorToUIColor:string];
#endif

        // normalImage
        string = aDictionary[NSStringFromSelector(@selector(normalImage))];
        self.normalImage = string;

        // normalBackgroundImage
        string = aDictionary[NSStringFromSelector(@selector(normalBackgroundImage))];
        self.normalBackgroundImage = string;

#if TARGET_OS_IPHONE
        // normalImageCapInsets
        dictionary = aDictionary[NSStringFromSelector(@selector(normalImageCapInsets))];
        self.normalImageCapInsets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];

        // normalBackgroundImageCapInsets
        dictionary = aDictionary[NSStringFromSelector(@selector(normalBackgroundImageCapInsets))];
        self.normalBackgroundImageCapInsets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];
#endif

        // -----------------------------------------------------------------------------------

        // highlightedTitle
        string = aDictionary[NSStringFromSelector(@selector(highlightedTitle))];
        self.highlightedTitle = string;

#if TARGET_OS_IPHONE
        // highlightedTitleColor
        string = aDictionary[NSStringFromSelector(@selector(highlightedTitleColor))];
        self.highlightedTitleColor = [IRUtil transformHexColorToUIColor:string];

        // highlightedTitleShadowColor
        string = aDictionary[NSStringFromSelector(@selector(highlightedTitleShadowColor))];
        self.highlightedTitleShadowColor = [IRUtil transformHexColorToUIColor:string];
#endif

        // highlightedImage
        string = aDictionary[NSStringFromSelector(@selector(highlightedImage))];
        self.highlightedImage = string;

        // highlightedBackgroundImage
        string = aDictionary[NSStringFromSelector(@selector(highlightedBackgroundImage))];
        self.highlightedBackgroundImage = string;

#if TARGET_OS_IPHONE
        // highlightedImageCapInsets
        dictionary = aDictionary[NSStringFromSelector(@selector(highlightedImageCapInsets))];
        self.highlightedImageCapInsets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];

        // highlightedBackgroundImageCapInsets
        dictionary = aDictionary[NSStringFromSelector(@selector(highlightedBackgroundImageCapInsets))];
        self.highlightedBackgroundImageCapInsets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];
#endif

        // -----------------------------------------------------------------------------------

        // selectedTitle
        string = aDictionary[NSStringFromSelector(@selector(selectedTitle))];
        self.selectedTitle = string;

#if TARGET_OS_IPHONE
        // selectedTitleColor
        string = aDictionary[NSStringFromSelector(@selector(selectedTitleColor))];
        self.selectedTitleColor = [IRUtil transformHexColorToUIColor:string];

        // selectedTitleShadowColor
        string = aDictionary[NSStringFromSelector(@selector(selectedTitleShadowColor))];
        self.selectedTitleShadowColor = [IRUtil transformHexColorToUIColor:string];
#endif

        // selectedImage
        string = aDictionary[NSStringFromSelector(@selector(selectedImage))];
        self.selectedImage = string;

        // selectedBackgroundImage
        string = aDictionary[NSStringFromSelector(@selector(selectedBackgroundImage))];
        self.selectedBackgroundImage = string;

#if TARGET_OS_IPHONE
        // selectedImageCapInsets
        dictionary = aDictionary[NSStringFromSelector(@selector(selectedImageCapInsets))];
        self.selectedImageCapInsets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];

        // selectedBackgroundImageCapInsets
        dictionary = aDictionary[NSStringFromSelector(@selector(selectedBackgroundImageCapInsets))];
        self.selectedBackgroundImageCapInsets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];
#endif

        // -----------------------------------------------------------------------------------

        // disabledTitle
        string = aDictionary[NSStringFromSelector(@selector(disabledTitle))];
        self.disabledTitle = string;

#if TARGET_OS_IPHONE
        // disabledTitleColor
        string = aDictionary[NSStringFromSelector(@selector(disabledTitleColor))];
        self.disabledTitleColor = [IRUtil transformHexColorToUIColor:string];

        // disabledTitleShadowColor
        string = aDictionary[NSStringFromSelector(@selector(disabledTitleShadowColor))];
        self.disabledTitleShadowColor = [IRUtil transformHexColorToUIColor:string];
#endif

        // disabledImage
        string = aDictionary[NSStringFromSelector(@selector(disabledImage))];
        self.disabledImage = string;

        // disabledBackgroundImage
        string = aDictionary[NSStringFromSelector(@selector(disabledBackgroundImage))];
        self.disabledBackgroundImage = string;

#if TARGET_OS_IPHONE
        // disabledImageCapInsets
        dictionary = aDictionary[NSStringFromSelector(@selector(disabledImageCapInsets))];
        self.disabledImageCapInsets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];

        // disabledBackgroundImageCapInsets
        dictionary = aDictionary[NSStringFromSelector(@selector(disabledBackgroundImageCapInsets))];
        self.disabledBackgroundImageCapInsets = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];
#endif

        // -----------------------------------------------------------------------------------

#if TARGET_OS_IPHONE
        // font
        string = aDictionary[NSStringFromSelector(@selector(font))];
        self.font = [IRBaseDescriptor fontFromString:string];
#endif

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

#if TARGET_OS_IPHONE
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
#endif
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor
{
    if (self.normalImage && [IRUtil isFileForDownload:self.normalImage appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.normalImage];
    }
    if (self.normalBackgroundImage && [IRUtil isFileForDownload:self.normalBackgroundImage appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.normalBackgroundImage];
    }

    if (self.highlightedImage && [IRUtil isFileForDownload:self.highlightedImage appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.highlightedImage];
    }
    if (self.highlightedBackgroundImage && [IRUtil isFileForDownload:self.highlightedBackgroundImage appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.highlightedBackgroundImage];
    }

    if (self.selectedImage && [IRUtil isFileForDownload:self.selectedImage appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.selectedImage];
    }
    if (self.selectedBackgroundImage && [IRUtil isFileForDownload:self.selectedBackgroundImage appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.selectedBackgroundImage];
    }

    if (self.disabledImage && [IRUtil isFileForDownload:self.disabledImage appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.disabledImage];
    }
    if (self.disabledBackgroundImage && [IRUtil isFileForDownload:self.disabledBackgroundImage appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.disabledBackgroundImage];
    }
}

@end
