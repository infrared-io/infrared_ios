//
//  IRTextFieldDescriptor.m
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRTextFieldDescriptor.h"
#import "IRUtil.h"
#if TARGET_OS_IPHONE
#import "IRTextFieldBuilder.h"
#import "IRTextField.h"
#endif

@implementation IRTextFieldDescriptor

+ (NSString *) componentName
{
    return typeTextFieldKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRTextField class];
}

+ (Class) builderClass
{
    return [IRTextFieldBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UITextField class], @protocol(UITextFieldExport));
}
#endif

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSDictionary *dictionary;

        // text
        string = aDictionary[NSStringFromSelector(@selector(text))];
        self.text = string;

#if TARGET_OS_IPHONE
        // textColor
        string = aDictionary[NSStringFromSelector(@selector(textColor))];
        self.textColor = [IRUtil transformHexColorToUIColor:string];

        // font
        string = aDictionary[NSStringFromSelector(@selector(font))];
        self.font = [IRBaseDescriptor fontFromString:string];

        // textAlignment
        string = aDictionary[NSStringFromSelector(@selector(textAlignment))];
        self.textAlignment = [IRBaseDescriptor textAlignmentFromString:string];
#endif

        // placeholder
        string = aDictionary[NSStringFromSelector(@selector(placeholder))];
        self.placeholder = string;

#if TARGET_OS_IPHONE
        // placeholderColor
        string = aDictionary[NSStringFromSelector(@selector(placeholderColor))];
        self.placeholderColor = [IRUtil transformHexColorToUIColor:string];
#endif

        // background
        string = aDictionary[NSStringFromSelector(@selector(background))];
        self.background = string;

        // disabledBackground
        string = aDictionary[NSStringFromSelector(@selector(disabledBackground))];
        self.disabledBackground = string;

#if TARGET_OS_IPHONE
        // borderStyle
        string = aDictionary[NSStringFromSelector(@selector(borderStyle))];
        self.borderStyle = [IRBaseDescriptor borderStyleFromString:string];

        // clearButtonMode
        string = aDictionary[NSStringFromSelector(@selector(clearButtonMode))];
        self.clearButtonMode = [IRBaseDescriptor textFieldViewModeFromString:string];
#endif

        // clearsOnBeginEditing
        number = aDictionary[NSStringFromSelector(@selector(clearsOnBeginEditing))];
        if (number) {
            self.clearsOnBeginEditing = [number boolValue];
        } else {
            self.clearsOnBeginEditing = NO;
        }

        // minimumFontSize
        number = aDictionary[NSStringFromSelector(@selector(minimumFontSize))];
        if (number) {
            self.minimumFontSize = [number floatValue];
        } else {
            self.minimumFontSize = 0;
        }

        // adjustsFontSizeToFitWidth
        number = aDictionary[NSStringFromSelector(@selector(adjustsFontSizeToFitWidth))];
        if (number) {
            self.adjustsFontSizeToFitWidth = [number boolValue];
        } else {
            self.adjustsFontSizeToFitWidth = NO;
        }

        // leftView
        dictionary = aDictionary[NSStringFromSelector(@selector(leftView))];
        self.leftView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

#if TARGET_OS_IPHONE
        // leftViewMode
        string = aDictionary[NSStringFromSelector(@selector(leftViewMode))];
        self.leftViewMode = [IRBaseDescriptor textFieldViewModeFromString:string];
#endif

        // rightView
        dictionary = aDictionary[NSStringFromSelector(@selector(rightView))];
        self.rightView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

#if TARGET_OS_IPHONE
        // rightViewMode
        string = aDictionary[NSStringFromSelector(@selector(rightViewMode))];
        self.rightViewMode = [IRBaseDescriptor textFieldViewModeFromString:string];
#endif

        // clearsOnInsertion
        number = aDictionary[NSStringFromSelector(@selector(clearsOnInsertion))];
        if (number) {
            self.clearsOnInsertion = [number boolValue];
        } else {
            self.clearsOnInsertion = NO;
        }

#if TARGET_OS_IPHONE
        // autocapitalizationType
        string = aDictionary[NSStringFromSelector(@selector(autocapitalizationType))];
        self.autocapitalizationType = [IRBaseDescriptor textAutocapitalizationTypeFromString:string];

        // autocorrectionType
        string = aDictionary[NSStringFromSelector(@selector(autocorrectionType))];
        self.autocorrectionType = [IRBaseDescriptor autocorrectionTypeFromString:string];

        // spellCheckingType
        string = aDictionary[NSStringFromSelector(@selector(spellCheckingType))];
        self.spellCheckingType = [IRBaseDescriptor spellCheckingTypeFromString:string];

        // keyboardType
        string = aDictionary[NSStringFromSelector(@selector(keyboardType))];
        self.keyboardType = [IRBaseDescriptor keyboardTypeFromString:string];

        // keyboardAppearance
        string = aDictionary[NSStringFromSelector(@selector(keyboardAppearance))];
        self.keyboardAppearance = [IRBaseDescriptor keyboardAppearanceFromString:string];

        // returnKeyType
        string = aDictionary[NSStringFromSelector(@selector(returnKeyType))];
        self.returnKeyType = [IRBaseDescriptor returnKeyTypeFromString:string];
#endif

        // enablesReturnKeyAutomatically
        number = aDictionary[NSStringFromSelector(@selector(enablesReturnKeyAutomatically))];
        if (number) {
            self.enablesReturnKeyAutomatically = [number boolValue];
        } else {
            self.enablesReturnKeyAutomatically = NO;
        }

        // secureTextEntry
        number = aDictionary[NSStringFromSelector(@selector(secureTextEntry))];
        if (number) {
            self.secureTextEntry = [number boolValue];
        } else {
            self.secureTextEntry = NO;
        }
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    [self.leftView extendImagePathsArray:imagePaths];
    [self.rightView extendImagePathsArray:imagePaths];
    if (self.background && [IRUtil isFileForDownload:self.background]) {
        [imagePaths addObject:self.background];
    }
    if (self.disabledBackground && [IRUtil isFileForDownload:self.disabledBackground]) {
        [imagePaths addObject:self.disabledBackground];
    }
}

@end
