//
// Created by Uros Milivojevic on 12/5/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRTextViewDescriptor.h"
#import "IRUtil.h"
#if TARGET_OS_IPHONE
#import "IRTextView.h"
#import "IRTextViewBuilder.h"
#endif


@implementation IRTextViewDescriptor

+ (NSString *) componentName
{
    return typeTextViewKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRTextView class];
}

+ (Class) builderClass
{
    return [IRTextViewBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UITextView class], @protocol(UITextViewExport));
}
#endif

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;

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

        // editable
        number = aDictionary[NSStringFromSelector(@selector(editable))];
        if (number) {
            self.editable = [number boolValue];
        } else {
            self.editable = YES;
        }

        // selectable
        number = aDictionary[NSStringFromSelector(@selector(selectable))];
        if (number) {
            self.selectable = [number boolValue];
        } else {
            self.selectable = YES;
        }

#if TARGET_OS_IPHONE
        // dataDetectorTypes
        string = aDictionary[NSStringFromSelector(@selector(dataDetectorTypes))];
        self.dataDetectorTypes = [IRBaseDescriptor dataDetectorTypesFromString:string];
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
                 appDescriptor:(IRAppDescriptor *)appDescriptor
{

}

@end