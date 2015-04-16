//
// Created by Uros Milivojevic on 12/5/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRTextViewDescriptor.h"
#import "IRTextViewBuilder.h"
#import "IRUtil.h"
#import "IRTextView.h"


@implementation IRTextViewDescriptor

+ (NSString *) componentName
{
    return typeTextViewKEY;
}
+ (Class) componentClass
{
    return [IRTextView class];
}

+ (Class) builderClass
{
    return [IRTextViewBuilder class];
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;

        // text
        string = aDictionary[NSStringFromSelector(@selector(text))];
        self.text = string;

        // textColor
        string = aDictionary[NSStringFromSelector(@selector(textColor))];
        self.textColor = [IRUtil transformHexColorToUIColor:string];

        // font
        string = aDictionary[NSStringFromSelector(@selector(font))];
        self.font = [IRBaseDescriptor fontFromString:string];

        // textAlignment
        string = aDictionary[NSStringFromSelector(@selector(textAlignment))];
        self.textAlignment = [IRBaseDescriptor textAlignmentFromString:string];

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

        // dataDetectorTypes
        string = aDictionary[NSStringFromSelector(@selector(dataDetectorTypes))];
        self.dataDetectorTypes = [IRBaseDescriptor dataDetectorTypesFromString:string];

        // clearsOnInsertion
        number = aDictionary[NSStringFromSelector(@selector(clearsOnInsertion))];
        if (number) {
            self.clearsOnInsertion = [number boolValue];
        } else {
            self.clearsOnInsertion = NO;
        }

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

}

@end