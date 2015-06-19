//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRBaseDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRLabelDescriptor.h"
#import "IRViewControllerDescriptor.h"
#import "IRNavigationControllerSubDescriptor.h"
#import "IRButtonDescriptor.h"
#import "IRImageViewDescriptor.h"
#import "IRTextFieldDescriptor.h"
#import "IRAppDescriptor.h"
#import "IRScreenDescriptor.h"
#import "IRUtil.h"
#import "IRDataController.h"
#import "IRScrollViewDescriptor.h"

@implementation IRBaseDescriptor

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.jsInit = NO;
    }
    return self;
}


+ (IRBaseDescriptor *) newAppDescriptorWithDictionary:(NSDictionary *)sourceDictionary
{
    IRAppDescriptor *appDescriptor = [[IRAppDescriptor alloc] initDescriptorWithDictionary:sourceDictionary];
    return appDescriptor;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (NSArray *) newScreenDescriptorsArrayFromDictionariesArray:(NSArray *)aArray
                                                         app:(NSString *)app
                                                       label:(NSString *)label
                                                     version:(NSInteger)version
{
    NSMutableArray *screenDescriptorsArray = [[NSMutableArray alloc] init];
    NSDictionary *dictionary;
    NSString *anDeviceType;
    NSString *anScreenPath;
    for (NSDictionary *anScreenDictionary in aArray) {
        anDeviceType = anScreenDictionary[deviceTypeKEY];
        if ([IRBaseDescriptor isDeviceTypeMatchingDevice:anDeviceType]) {
            anScreenPath = anScreenDictionary[pathKEY];
            dictionary = [IRUtil screenDictionaryFromPath:anScreenPath app:app label:label version:version];
            if (dictionary) {
                [screenDescriptorsArray addObject:[[IRScreenDescriptor alloc] initDescriptorWithDictionary:dictionary]];
            } else {
                NSLog(@" ########## newScreenDescriptorsArrayFromDictionariesArray:app:label:version: - MISSING or INVALID json with path '%@'", anScreenPath);
            }
        }
    }
    return screenDescriptorsArray;
}
+ (BOOL) isDeviceTypeMatchingDevice:(NSString *)deviceType
{
    BOOL isDeviceTypeMatchingDevice = NO;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone
        && [IRBaseDescriptor isDeviceTypePhone:deviceType])
    {
        isDeviceTypeMatchingDevice = YES;
    }
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad
        && [IRBaseDescriptor isDeviceTypeTablet:deviceType])
    {
        isDeviceTypeMatchingDevice = YES;
    }
    return isDeviceTypeMatchingDevice;
}
+ (BOOL) isDeviceTypePhone:(NSString *)deviceType
{
    BOOL isDeviceTypePhone = NO;
    if ([deviceTypePhoneKEY isEqualToString:deviceType]) {
        isDeviceTypePhone = YES;
    }
    return isDeviceTypePhone;
}
+ (BOOL) isDeviceTypeTablet:(NSString *)deviceType
{
    BOOL isDeviceTypeTablet = NO;
    if ([deviceTypeTabletKEY isEqualToString:deviceType]) {
        isDeviceTypeTablet = YES;
    }
    return isDeviceTypeTablet;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (NSMutableArray *) viewDescriptorsHierarchyFromArray:(NSArray *)aArray
{
    NSMutableArray *viewHierarchyArray = [[NSMutableArray alloc] init];
    IRBaseDescriptor *baseDescriptor;
    for (NSDictionary *anDictionary in aArray) {
        baseDescriptor = [IRBaseDescriptor newViewDescriptorWithDictionary:anDictionary];
        if (baseDescriptor) {
            [viewHierarchyArray addObject:baseDescriptor];
        }
    }
    return viewHierarchyArray;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (IRBaseDescriptor *) newViewDescriptorWithDictionary:(NSDictionary *)sourceDictionary
{
    IRBaseDescriptor *descriptor = nil;
    NSString *componentName;
    Class aClass;
    componentName = sourceDictionary[typeKEY];
    aClass = [[IRDataController sharedInstance] componentDescriptorClassByName:componentName];
    if (aClass) {
        descriptor = [(IRBaseDescriptor *) [aClass alloc] initDescriptorWithDictionary:sourceDictionary];
    }
    return descriptor;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (IRBaseDescriptor *) newControllerDescriptorWithDictionary:(NSDictionary *)sourceDictionary
{
    IRBaseDescriptor *descriptor = nil;
    ControllerDescriptorType type = [IRBaseDescriptor controllerDescriptorTypeForString:[sourceDictionary valueForKey:controllerTypeKEY]];
    switch (type) {
        case ControllerDescriptorTypeViewController: {
            descriptor = [[IRViewControllerDescriptor alloc] initDescriptorWithDictionary:sourceDictionary];
        }
            break;
//        case ControllerDescriptorTypeNavigationController: {
//            descriptor = [[IRNavigationControllerDescriptor alloc] initDescriptorWithDictionary:sourceDictionary];
//        }
            break;
        case ControllerDescriptorTypeTabBarController: {
            // TODO: to be implemented
        }
            break;
        default:
            break;
    }
    return descriptor;
}
+ (ControllerDescriptorType) controllerDescriptorTypeForString:(NSString *)descriptorTypeString
{
    ControllerDescriptorType descriptorType;
    if ([descriptorTypeString isEqualToString:controllerTypeViewControllerKEY]) {
        descriptorType = ControllerDescriptorTypeViewController;
    } else if ([descriptorTypeString isEqualToString:controllerTypeNavigationControllerKEY]) {
        descriptorType = ControllerDescriptorTypeNavigationController;
    } else if ([descriptorTypeString isEqualToString:controllerTypeTabBarControllerKEY]) {
        descriptorType = ControllerDescriptorTypeTabBarController;
    } else {
        descriptorType = ControllerDescriptorTypeViewController;
    }
    return descriptorType;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (UIViewContentMode) contentModeFromString:(NSString *)string
{
    UIViewContentMode contentMode;
    if ([@"UIViewContentModeScaleToFill" isEqualToString:string]) {
        contentMode = UIViewContentModeScaleToFill;
    } else if ([@"UIViewContentModeScaleAspectFit" isEqualToString:string]) {
        contentMode = UIViewContentModeScaleAspectFit;
    } else if ([@"UIViewContentModeScaleAspectFill" isEqualToString:string]) {
        contentMode = UIViewContentModeScaleAspectFill;
    } else if ([@"UIViewContentModeRedraw" isEqualToString:string]) {
        contentMode = UIViewContentModeRedraw;
    } else if ([@"UIViewContentModeCenter" isEqualToString:string]) {
        contentMode = UIViewContentModeCenter;
    } else if ([@"UIViewContentModeTop" isEqualToString:string]) {
        contentMode = UIViewContentModeTop;
    } else if ([@"UIViewContentModeBottom" isEqualToString:string]) {
        contentMode = UIViewContentModeBottom;
    } else if ([@"UIViewContentModeLeft" isEqualToString:string]) {
        contentMode = UIViewContentModeLeft;
    } else if ([@"UIViewContentModeRight" isEqualToString:string]) {
        contentMode = UIViewContentModeRight;
    } else if ([@"UIViewContentModeTopLeft" isEqualToString:string]) {
        contentMode = UIViewContentModeTopLeft;
    } else if ([@"UIViewContentModeTopRight" isEqualToString:string]) {
        contentMode = UIViewContentModeTopRight;
    } else if ([@"UIViewContentModeBottomLeft" isEqualToString:string]) {
        contentMode = UIViewContentModeBottomLeft;
    } else if ([@"UIViewContentModeBottomRight" isEqualToString:string]) {
        contentMode = UIViewContentModeBottomRight;
    } else {
        contentMode = UIViewContentModeScaleToFill;
    }
    return contentMode;
}
// --------------------------------------------------------------------------------------------------------------------
/*
 UIAccessibilityTraitNone, UIAccessibilityTraitButton, UIAccessibilityTraitLink, UIAccessibilityTraitImage, UIAccessibilityTraitSelected, UIAccessibilityTraitStaticText, UIAccessibilityTraitSearchField, UIAccessibilityTraitPlaysSound, UIAccessibilityTraitKeyboardKey, UIAccessibilityTraitSummaryElement, UIAccessibilityTraitUpdatesFrequently, UIAccessibilityTraitAllowsDirectInteraction
 */
+ (UIAccessibilityTraits) accessibilityTraitsFromString:(NSString *)string
                                          forDescriptor:(IRBaseDescriptor *)descriptor
{
    UIAccessibilityTraits contentMode = 0;
    NSArray *traitsArray;
    NSString *anTrimmedTrait;
    if ([string length] > 0) {
        traitsArray = [IRBaseDescriptor componentsArrayFromString:string];
        for (NSString *anTrait in traitsArray) {
            anTrimmedTrait = [anTrait stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if ([@"UIAccessibilityTraitNone" isEqualToString:anTrimmedTrait]) {
                contentMode = contentMode | UIAccessibilityTraitNone;
            } else if ([@"UIAccessibilityTraitButton" isEqualToString:anTrimmedTrait]) {
                contentMode = contentMode | UIAccessibilityTraitButton;
            } else if ([@"UIAccessibilityTraitLink" isEqualToString:anTrimmedTrait]) {
                contentMode = contentMode | UIAccessibilityTraitLink;
            } else if ([@"UIAccessibilityTraitImage" isEqualToString:anTrimmedTrait]) {
                contentMode = contentMode | UIAccessibilityTraitImage;
            } else if ([@"UIAccessibilityTraitSelected" isEqualToString:anTrimmedTrait]) {
                contentMode = contentMode | UIAccessibilityTraitSelected;
            } else if ([@"UIAccessibilityTraitStaticText" isEqualToString:anTrimmedTrait]) {
                contentMode = contentMode | UIAccessibilityTraitStaticText;
            } else if ([@"UIAccessibilityTraitSearchField" isEqualToString:anTrimmedTrait]) {
                contentMode = contentMode | UIAccessibilityTraitSearchField;
            } else if ([@"UIAccessibilityTraitPlaysSound" isEqualToString:anTrimmedTrait]) {
                contentMode = contentMode | UIAccessibilityTraitPlaysSound;
            } else if ([@"UIAccessibilityTraitKeyboardKey" isEqualToString:anTrimmedTrait]) {
                contentMode = contentMode | UIAccessibilityTraitKeyboardKey;
            } else if ([@"UIAccessibilityTraitSummaryElement" isEqualToString:anTrimmedTrait]) {
                contentMode = contentMode | UIAccessibilityTraitSummaryElement;
            } else if ([@"UIAccessibilityTraitUpdatesFrequently" isEqualToString:anTrimmedTrait]) {
                contentMode = contentMode | UIAccessibilityTraitUpdatesFrequently;
            } else if ([@"UIAccessibilityTraitAllowsDirectInteraction" isEqualToString:anTrimmedTrait]) {
                contentMode = contentMode | UIAccessibilityTraitAllowsDirectInteraction;
            }
        }
    } else {
        if ([descriptor isKindOfClass:[IRViewDescriptor class]]) {
            contentMode = UIAccessibilityTraitAllowsDirectInteraction;
        } else if ([descriptor isKindOfClass:[IRLabelDescriptor class]]) {
            contentMode = UIAccessibilityTraitAllowsDirectInteraction | UIAccessibilityTraitStaticText;
        } else if ([descriptor isKindOfClass:[IRButtonDescriptor class]]) {
            contentMode = UIAccessibilityTraitAllowsDirectInteraction | UIAccessibilityTraitButton;
        } else if ([descriptor isKindOfClass:[IRImageViewDescriptor class]]) {
            contentMode = UIAccessibilityTraitAllowsDirectInteraction | UIAccessibilityTraitImage;
        } else if ([descriptor isKindOfClass:[IRTextFieldDescriptor class]]) {
            contentMode = UIAccessibilityTraitAllowsDirectInteraction;
        } else {
            contentMode = UIAccessibilityTraitNone;
        }
    }
    return contentMode;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (NSArray *) interfaceOrientationsFromString:(NSString *)string
{
    NSMutableArray *interfaceOrientationsArray = [NSMutableArray array];
    NSArray *traitsArray;
    NSString *anTrimmedTrait;
    NSNumber *number;
    if ([string length] > 0) {
        traitsArray = [IRBaseDescriptor componentsArrayFromString:string];
        for (NSString *anTrait in traitsArray) {
            anTrimmedTrait = [anTrait stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if ([@"UIInterfaceOrientationPortrait" isEqualToString:anTrimmedTrait]) {
                number = @(UIInterfaceOrientationPortrait);
            } else if ([@"UIInterfaceOrientationPortraitUpsideDown" isEqualToString:anTrimmedTrait]) {
                number = @(UIInterfaceOrientationPortraitUpsideDown);
            } else if ([@"UIInterfaceOrientationLandscapeLeft" isEqualToString:anTrimmedTrait]) {
                number = @(UIInterfaceOrientationLandscapeLeft);
            } else if ([@"UIInterfaceOrientationLandscapeRight" isEqualToString:anTrimmedTrait]) {
                number = @(UIInterfaceOrientationLandscapeRight);
            } else {
                number = nil;
            }
            if (number) {
                [interfaceOrientationsArray addObject:number];
            }
        }
    }
    return interfaceOrientationsArray;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (UIFont *) fontFromString:(NSString *)fontString
{
    UIFont *font = nil;
    NSArray *stringPartsArray;
    NSString *stringPart;
    NSString *numberPart;
    if ([fontString length] > 0) {
        stringPartsArray = [IRBaseDescriptor componentsArrayFromString:fontString];
        if ([stringPartsArray count] == 2) {
            stringPart = [stringPartsArray[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if ([IRBaseDescriptor isSystemFamilyFontString:stringPart]) {
                numberPart = [stringPartsArray[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                if ([IRBaseDescriptor isSystemRegularFontString:stringPart]) {
                    font = [UIFont systemFontOfSize:[numberPart floatValue]];
                } else if ([IRBaseDescriptor isSystemBoldFontString:stringPart]) {
                    font = [UIFont boldSystemFontOfSize:[numberPart floatValue]];
                } else if ([IRBaseDescriptor isSystemItalicFontString:stringPart]) {
                    font = [UIFont italicSystemFontOfSize:[numberPart floatValue]];
                }
            } else {
                numberPart = stringPartsArray[1];
                font = [UIFont fontWithName:stringPart size:[numberPart floatValue]];
            }
        }
    } else {
        if ([IRBaseDescriptor isFontTextStyle:fontString]) {
            font = [UIFont preferredFontForTextStyle:fontString];
        }
    }
    return font;
}
// --------------------------------------------------------------------------------------------------------------------
+ (BOOL) isSystemFamilyFontString:(NSString *)string
{
    BOOL isSystemFamilyFontString = NO;
    if ([IRBaseDescriptor isSystemRegularFontString:string]
        || [IRBaseDescriptor isSystemBoldFontString:string]
        || [IRBaseDescriptor isSystemItalicFontString:string])
    {
        isSystemFamilyFontString = YES;
    }
    return isSystemFamilyFontString;
}
+ (BOOL) isSystemRegularFontString:(NSString *)string
{
    BOOL isSystemFontString = NO;
    if ([@"System" isEqualToString:string]) {
        isSystemFontString = YES;
    }
    return isSystemFontString;
}
+ (BOOL) isSystemBoldFontString:(NSString *)string
{
    BOOL isSystemBoldFontString = NO;
    if ([@"SystemBold" isEqualToString:string]) {
        isSystemBoldFontString = YES;
    }
    return isSystemBoldFontString;
}
+ (BOOL) isSystemItalicFontString:(NSString *)string
{
    BOOL isSystemItalicFontString = NO;
    if ([@"SystemItalic" isEqualToString:string]) {
        isSystemItalicFontString = YES;
    }
    return isSystemItalicFontString;
}
// --------------------------------------------------------------------------------------------------------------------
+ (BOOL) isFontTextStyle:(NSString *)fontString
{
    BOOL isFontTextStyle = NO;
    NSArray *textStylesArray = @[UIFontTextStyleHeadline,
                                 UIFontTextStyleSubheadline,
                                 UIFontTextStyleBody,
                                 UIFontTextStyleFootnote,
                                 UIFontTextStyleCaption1,
                                 UIFontTextStyleCaption2];
    if ([textStylesArray containsObject:fontString]) {
        isFontTextStyle = YES;
    }
    return isFontTextStyle;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (NSTextAlignment) textAlignmentFromString:(NSString *)string
{
    NSTextAlignment textAlignment;
    if ([@"NSTextAlignmentLeft" isEqualToString:string]) {
        textAlignment = NSTextAlignmentLeft;
    } else if ([@"NSTextAlignmentCenter" isEqualToString:string]) {
        textAlignment = NSTextAlignmentCenter;
    } else if ([@"NSTextAlignmentRight" isEqualToString:string]) {
        textAlignment = NSTextAlignmentRight;
    } else if ([@"NSTextAlignmentNatural" isEqualToString:string]) {
        textAlignment = NSTextAlignmentNatural;
    } else if ([@"NSTextAlignmentJustified" isEqualToString:string]) {
        textAlignment = NSTextAlignmentJustified;
    } else {
        textAlignment = NSTextAlignmentLeft;
    }
    return textAlignment;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UIBaselineAdjustment) baselineAdjustmentFromString:(NSString *)string
{
    UIBaselineAdjustment baselineAdjustment = UIBaselineAdjustmentNone;
    if ([@"UIBaselineAdjustmentAlignBaselines" isEqualToString:string]) {
        baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
    } else if ([@"UIBaselineAdjustmentAlignBaselines" isEqualToString:string]) {
        baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    }
    return baselineAdjustment;
}
// --------------------------------------------------------------------------------------------------------------------
+ (NSLineBreakMode) lineBreakModeFromString:(NSString *)string
{
    NSLineBreakMode lineBreakMode;
    if ([@"NSLineBreakByWordWrapping" isEqualToString:string]) {
        lineBreakMode = NSLineBreakByWordWrapping;
    } else if ([@"NSLineBreakByCharWrapping" isEqualToString:string]) {
        lineBreakMode = NSLineBreakByCharWrapping;
    } else if ([@"NSLineBreakByClipping" isEqualToString:string]) {
        lineBreakMode = NSLineBreakByClipping;
    } else if ([@"NSLineBreakByTruncatingHead" isEqualToString:string]) {
        lineBreakMode = NSLineBreakByTruncatingHead;
    } else if ([@"NSLineBreakByTruncatingTail" isEqualToString:string]) {
        lineBreakMode = NSLineBreakByTruncatingTail;
    } else if ([@"NSLineBreakByTruncatingMiddle" isEqualToString:string]) {
        lineBreakMode = NSLineBreakByTruncatingMiddle;
    } else {
        lineBreakMode = NSLineBreakByWordWrapping;
    }
    return lineBreakMode;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (CGRect) frameFromDictionary:(NSDictionary *)dictionary
{
    CGRect aFrame;
    NSNumber *x = dictionary[xKEY];
    NSNumber *y = dictionary[yKEY];
    NSNumber *width = dictionary[widthKEY];
    NSNumber *height = dictionary[heightKEY];
    if (x && y && width && height) {
        aFrame = CGRectMake([x floatValue], [y floatValue], [width floatValue], [height floatValue]);
    } else {
        aFrame = CGRectNull;
    }
    return aFrame;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (CGSize) sizeFromDictionary:(NSDictionary *)dictionary
{
    CGSize aSize;
    NSNumber *width = dictionary[widthKEY];
    NSNumber *height = dictionary[heightKEY];
    if (width && height) {
        aSize = CGSizeMake([width floatValue], [height floatValue]);
    } else {
        aSize = CGSizeNull;
    }
    return aSize;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (CGPoint) pointFromDictionary:(NSDictionary *)dictionary
{
    CGPoint aPoint;
    NSNumber *x = dictionary[xKEY];
    NSNumber *y = dictionary[yKEY];
    if (x && y) {
        aPoint = CGPointMake([x floatValue], [y floatValue]);
    } else {
        aPoint = CGPointNull;
    }
    return aPoint;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (UIEdgeInsets) edgeInsetsFromDictionary:(NSDictionary *)dictionary
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    NSNumber *top = dictionary[topKEY];
    NSNumber *left = dictionary[leftKEY];
    NSNumber *bottom = dictionary[bottomKEY];
    NSNumber *right = dictionary[rightKEY];
    if (top && left && bottom && right) {
        edgeInsets = UIEdgeInsetsMake([top floatValue], [left floatValue], [bottom floatValue], [right floatValue]);
    } else {
        edgeInsets = UIEdgeInsetsNull;
    }
    return edgeInsets;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (UIControlContentHorizontalAlignment) contentHorizontalAlignmentFromString:(NSString *)string
{
    UIControlContentHorizontalAlignment horizontalAlignment;
    if ([@"UIControlContentHorizontalAlignmentCenter" isEqualToString:string]) {
        horizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    } else if ([@"UIControlContentHorizontalAlignmentLeft" isEqualToString:string]) {
        horizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    } else if ([@"UIControlContentHorizontalAlignmentRight" isEqualToString:string]) {
        horizontalAlignment = UIControlContentHorizontalAlignmentRight;
    } else if ([@"UIControlContentHorizontalAlignmentFill" isEqualToString:string]) {
        horizontalAlignment = UIControlContentHorizontalAlignmentFill;
    } else {
        horizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return horizontalAlignment;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UIControlContentVerticalAlignment) contentVerticalAlignmentFromString:(NSString *)string
{
    UIControlContentVerticalAlignment verticalAlignment;
    if ([@"UIControlContentVerticalAlignmentCenter" isEqualToString:string]) {
        verticalAlignment = UIControlContentVerticalAlignmentCenter;
    } else if ([@"UIControlContentVerticalAlignmentTop" isEqualToString:string]) {
        verticalAlignment = UIControlContentVerticalAlignmentTop;
    } else if ([@"UIControlContentVerticalAlignmentBottom" isEqualToString:string]) {
        verticalAlignment = UIControlContentVerticalAlignmentBottom;
    } else if ([@"UIControlContentVerticalAlignmentFill" isEqualToString:string]) {
        verticalAlignment = UIControlContentVerticalAlignmentFill;
    } else {
        verticalAlignment = UIControlContentVerticalAlignmentCenter;
    }
    return verticalAlignment;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (UIButtonType) buttonTypeFromString:(NSString *)string
{
    UIButtonType buttonType;
    if ([@"UIButtonTypeCustom" isEqualToString:string]) {
        buttonType = UIButtonTypeCustom;
    } else if ([@"UIButtonTypeSystem" isEqualToString:string]) {
        buttonType = UIButtonTypeSystem;
    } else if ([@"UIButtonTypeDetailDisclosure" isEqualToString:string]) {
        buttonType = UIButtonTypeDetailDisclosure;
    } else if ([@"UIButtonTypeInfoLight" isEqualToString:string]) {
        buttonType = UIButtonTypeInfoLight;
    } else if ([@"UIButtonTypeInfoDark" isEqualToString:string]) {
        buttonType = UIButtonTypeInfoDark;
    } else if ([@"UIButtonTypeContactAdd" isEqualToString:string]) {
        buttonType = UIButtonTypeContactAdd;
    } else {
        buttonType = UIButtonTypeCustom;
    }
    return buttonType;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (UITextBorderStyle) borderStyleFromString:(NSString *)string
{
    UITextBorderStyle borderStyle;
    if ([@"UITextBorderStyleNone" isEqualToString:string]) {
        borderStyle = UITextBorderStyleNone;
    } else if ([@"UITextBorderStyleLine" isEqualToString:string]) {
        borderStyle = UITextBorderStyleLine;
    } else if ([@"UITextBorderStyleBezel" isEqualToString:string]) {
        borderStyle = UITextBorderStyleBezel;
    } else if ([@"UITextBorderStyleRoundedRect" isEqualToString:string]) {
        borderStyle = UITextBorderStyleRoundedRect;
    } else {
        borderStyle = UITextBorderStyleNone;
    }
    return borderStyle;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UITextFieldViewMode) textFieldViewModeFromString:(NSString *)string
{
    UITextFieldViewMode textFieldViewMode;
    if ([@"UITextFieldViewModeNever" isEqualToString:string]) {
        textFieldViewMode = UITextFieldViewModeNever;
    } else if ([@"UITextFieldViewModeWhileEditing" isEqualToString:string]) {
        textFieldViewMode = UITextFieldViewModeWhileEditing;
    } else if ([@"UITextFieldViewModeUnlessEditing" isEqualToString:string]) {
        textFieldViewMode = UITextFieldViewModeUnlessEditing;
    } else if ([@"UITextFieldViewModeAlways" isEqualToString:string]) {
        textFieldViewMode = UITextFieldViewModeAlways;
    } else {
        textFieldViewMode = UITextFieldViewModeNever;
    }
    return textFieldViewMode;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UIDataDetectorTypes) dataDetectorTypesFromString:(NSString *)string
{
    UIDataDetectorTypes dataDetectorTypes = UIDataDetectorTypeNone;
    NSArray *dataDetectorTypesArray;
    NSString *dataDetectorType;
    if ([string length] > 0) {
        dataDetectorTypesArray = [IRBaseDescriptor componentsArrayFromString:string];
        for (NSString *anTrait in dataDetectorTypesArray) {
            dataDetectorType = [anTrait stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if ([@"UIDataDetectorTypePhoneNumber" isEqualToString:dataDetectorType]) {
                dataDetectorTypes = dataDetectorTypes | UIDataDetectorTypePhoneNumber;
            } else if ([@"UIDataDetectorTypeLink" isEqualToString:dataDetectorType]) {
                dataDetectorTypes = dataDetectorTypes | UIDataDetectorTypeLink;
            } else if ([@"UIDataDetectorTypeAddress" isEqualToString:dataDetectorType]) {
                dataDetectorTypes = dataDetectorTypes | UIDataDetectorTypeAddress;
            } else if ([@"UIDataDetectorTypeCalendarEvent" isEqualToString:dataDetectorType]) {
                dataDetectorTypes = dataDetectorTypes | UIDataDetectorTypeCalendarEvent;
            } else if ([@"UIDataDetectorTypeAll" isEqualToString:dataDetectorType]) {
                dataDetectorTypes = dataDetectorTypes | UIDataDetectorTypeAll;
            }
        }
    }
    return dataDetectorTypes;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UITextAutocapitalizationType) textAutocapitalizationTypeFromString:(NSString *)string
{
    UITextAutocapitalizationType textAutocapitalizationType;
    if ([@"UITextAutocapitalizationTypeNone" isEqualToString:string]) {
        textAutocapitalizationType = UITextAutocapitalizationTypeNone;
    } else if ([@"UITextAutocapitalizationTypeWords" isEqualToString:string]) {
        textAutocapitalizationType = UITextAutocapitalizationTypeWords;
    } else if ([@"UITextAutocapitalizationTypeSentences" isEqualToString:string]) {
        textAutocapitalizationType = UITextAutocapitalizationTypeSentences;
    } else if ([@"UITextAutocapitalizationTypeAllCharacters" isEqualToString:string]) {
        textAutocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
    } else {
        textAutocapitalizationType = UITextAutocapitalizationTypeSentences;
    }
    return textAutocapitalizationType;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UITextSpellCheckingType) spellCheckingTypeFromString:(NSString *)string
{
    UITextSpellCheckingType spellCheckingType;
    if ([@"UITextSpellCheckingTypeDefault" isEqualToString:string]) {
        spellCheckingType = UITextSpellCheckingTypeDefault;
    } else if ([@"UITextSpellCheckingTypeNo" isEqualToString:string]) {
        spellCheckingType = UITextSpellCheckingTypeNo;
    } else if ([@"UITextSpellCheckingTypeYes" isEqualToString:string]) {
        spellCheckingType = UITextSpellCheckingTypeYes;
    } else {
        spellCheckingType = UITextSpellCheckingTypeDefault;
    }
    return spellCheckingType;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UITextAutocorrectionType) autocorrectionTypeFromString:(NSString *)string
{
    UITextAutocorrectionType autocorrectionType;
    if ([@"UITextAutocorrectionTypeDefault" isEqualToString:string]) {
        autocorrectionType = UITextAutocorrectionTypeDefault;
    } else if ([@"UITextAutocorrectionTypeNo" isEqualToString:string]) {
        autocorrectionType = UITextAutocorrectionTypeNo;
    } else if ([@"UITextAutocorrectionTypeYes" isEqualToString:string]) {
        autocorrectionType = UITextAutocorrectionTypeYes;
    } else {
        autocorrectionType = UITextAutocorrectionTypeDefault;
    }
    return autocorrectionType;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UIKeyboardType) keyboardTypeFromString:(NSString *)string
{
    UIKeyboardType keyboardType;
    if ([@"UIKeyboardTypeDefault" isEqualToString:string]) {
        keyboardType = UIKeyboardTypeDefault;
    } else if ([@"UIKeyboardTypeASCIICapable" isEqualToString:string]) {
        keyboardType = UIKeyboardTypeASCIICapable;
    } else if ([@"UIKeyboardTypeNumbersAndPunctuation" isEqualToString:string]) {
        keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    } else if ([@"UIKeyboardTypeURL" isEqualToString:string]) {
        keyboardType = UIKeyboardTypeURL;
    } else if ([@"UIKeyboardTypeNumberPad" isEqualToString:string]) {
        keyboardType = UIKeyboardTypeNumberPad;
    } else if ([@"UIKeyboardTypePhonePad" isEqualToString:string]) {
        keyboardType = UIKeyboardTypePhonePad;
    } else if ([@"UIKeyboardTypeNamePhonePad" isEqualToString:string]) {
        keyboardType = UIKeyboardTypeNamePhonePad;
    } else if ([@"UIKeyboardTypeEmailAddress" isEqualToString:string]) {
        keyboardType = UIKeyboardTypeEmailAddress;
    } else if ([@"UIKeyboardTypeDecimalPad" isEqualToString:string]) {
        keyboardType = UIKeyboardTypeDecimalPad;
    } else if ([@"UIKeyboardTypeTwitter" isEqualToString:string]) {
        keyboardType = UIKeyboardTypeTwitter;
    } else if ([@"UIKeyboardTypeWebSearch" isEqualToString:string]) {
        keyboardType = UIKeyboardTypeWebSearch;
    } else {
        keyboardType = UIKeyboardTypeDefault;
    }
    return keyboardType;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UIKeyboardAppearance) keyboardAppearanceFromString:(NSString *)string
{
    UIKeyboardAppearance keyboardAppearance;
    if ([@"UIKeyboardAppearanceDefault" isEqualToString:string]) {
        keyboardAppearance = UIKeyboardAppearanceDefault;
    } else if ([@"UIKeyboardAppearanceDark" isEqualToString:string]) {
        keyboardAppearance = UIKeyboardAppearanceDark;
    } else if ([@"UIKeyboardAppearanceLight" isEqualToString:string]) {
        keyboardAppearance = UIKeyboardAppearanceLight;
    } else if ([@"UIKeyboardAppearanceAlert" isEqualToString:string]) {
        keyboardAppearance = UIKeyboardAppearanceAlert;
    } else {
        keyboardAppearance = UIKeyboardAppearanceDefault;
    }
    return keyboardAppearance;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UIReturnKeyType) returnKeyTypeFromString:(NSString *)string
{
    UIReturnKeyType returnKeyType;
    if ([@"UIReturnKeyDefault" isEqualToString:string]) {
        returnKeyType = UIReturnKeyDefault;
    } else if ([@"UIReturnKeyGo" isEqualToString:string]) {
        returnKeyType = UIReturnKeyGo;
    } else if ([@"UIReturnKeyGoogle" isEqualToString:string]) {
        returnKeyType = UIReturnKeyGoogle;
    } else if ([@"UIReturnKeyJoin" isEqualToString:string]) {
        returnKeyType = UIReturnKeyJoin;
    } else if ([@"UIReturnKeyNext" isEqualToString:string]) {
        returnKeyType = UIReturnKeyNext;
    } else if ([@"UIReturnKeyRoute" isEqualToString:string]) {
        returnKeyType = UIReturnKeyRoute;
    } else if ([@"UIReturnKeySearch" isEqualToString:string]) {
        returnKeyType = UIReturnKeySearch;
    } else if ([@"UIReturnKeySend" isEqualToString:string]) {
        returnKeyType = UIReturnKeySend;
    } else if ([@"UIReturnKeyYahoo" isEqualToString:string]) {
        returnKeyType = UIReturnKeyYahoo;
    } else if ([@"UIReturnKeyDone" isEqualToString:string]) {
        returnKeyType = UIReturnKeyDone;
    } else if ([@"UIKeyboardTypeWebSearch" isEqualToString:string]) {
        returnKeyType = UIReturnKeyEmergencyCall;
    } else {
        returnKeyType = UIReturnKeyDefault;
    }
    return returnKeyType;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UIScrollViewIndicatorStyle) scrollViewIndicatorStyleFromString:(NSString *)string
{
    UIScrollViewIndicatorStyle scrollViewIndicatorStyle;
    if ([@"UIScrollViewIndicatorStyleDefault" isEqualToString:string]) {
        scrollViewIndicatorStyle = UIScrollViewIndicatorStyleDefault;
    } else if ([@"UIScrollViewIndicatorStyleBlack" isEqualToString:string]) {
        scrollViewIndicatorStyle = UIScrollViewIndicatorStyleBlack;
    } else if ([@"UIScrollViewIndicatorStyleWhite" isEqualToString:string]) {
        scrollViewIndicatorStyle = UIScrollViewIndicatorStyleWhite;
    } else {
        scrollViewIndicatorStyle = UIScrollViewIndicatorStyleDefault;
    }
    return scrollViewIndicatorStyle;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UIScrollViewKeyboardDismissMode) scrollViewKeyboardDismissModeFromString:(NSString *)string
{
    UIScrollViewKeyboardDismissMode scrollViewKeyboardDismissMode;
    if ([@"UIScrollViewKeyboardDismissModeNone" isEqualToString:string]) {
        scrollViewKeyboardDismissMode = UIScrollViewKeyboardDismissModeNone;
    } else if ([@"UIScrollViewKeyboardDismissModeOnDrag" isEqualToString:string]) {
        scrollViewKeyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    } else if ([@"UIScrollViewKeyboardDismissModeInteractive" isEqualToString:string]) {
        scrollViewKeyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    } else {
        scrollViewKeyboardDismissMode = UIScrollViewKeyboardDismissModeNone;
    }
    return scrollViewKeyboardDismissMode;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UIProgressViewStyle) progressViewStyleFromString:(NSString *)string
{
    UIProgressViewStyle progressViewStyle;
    if ([@"UIProgressViewStyleDefault" isEqualToString:string]) {
        progressViewStyle = UIProgressViewStyleDefault;
    } else if ([@"UIProgressViewStyleBar" isEqualToString:string]) {
        progressViewStyle = UIProgressViewStyleBar;
    } else {
        progressViewStyle = UIProgressViewStyleDefault;
    }
    return progressViewStyle;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UIActivityIndicatorViewStyle) activityIndicatorViewStyleFromString:(NSString *)string
{
    UIActivityIndicatorViewStyle activityIndicatorViewStyle;
    if ([@"UIActivityIndicatorViewStyleWhiteLarge" isEqualToString:string]) {
        activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    } else if ([@"UIActivityIndicatorViewStyleWhite" isEqualToString:string]) {
        activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    } else if ([@"UIActivityIndicatorViewStyleGray" isEqualToString:string]) {
        activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    } else {
        activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    }
    return activityIndicatorViewStyle;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UITableViewCellSeparatorStyle) separatorStyleFromString:(NSString *)string
{
    UITableViewCellSeparatorStyle separatorStyle;
    if ([@"UITableViewCellSeparatorStyleNone" isEqualToString:string]) {
        separatorStyle = UITableViewCellSeparatorStyleNone;
    } else if ([@"UITableViewCellSeparatorStyleSingleLine" isEqualToString:string]) {
        separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    } else if ([@"UITableViewCellSeparatorStyleSingleLineEtched" isEqualToString:string]) {
        separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    } else {
        separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return separatorStyle;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UIDatePickerMode) datePickerModeFromString:(NSString *)string
{
    UIDatePickerMode datePickerMode;
    if ([@"UIDatePickerModeTime" isEqualToString:string]) {
        datePickerMode = UIDatePickerModeTime;
    } else if ([@"UIDatePickerModeDate" isEqualToString:string]) {
        datePickerMode = UIDatePickerModeDate;
    } else if ([@"UIDatePickerModeDateAndTime" isEqualToString:string]) {
        datePickerMode = UIDatePickerModeDateAndTime;
    } else if ([@"UIDatePickerModeCountDownTimer" isEqualToString:string]) {
        datePickerMode = UIDatePickerModeCountDownTimer;
    } else {
        datePickerMode = UIDatePickerModeDateAndTime;
    }
    return datePickerMode;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UIBarStyle) barStyleFromString:(NSString *)string
{
    UIBarStyle barStyle;
    if ([@"UIBarStyleDefault" isEqualToString:string]) {
        barStyle = UIBarStyleDefault;
    } else if ([@"UIBarStyleBlack" isEqualToString:string]) {
        barStyle = UIBarStyleBlack;
    } else if ([@"UIBarStyleBlackOpaque" isEqualToString:string]) {
        barStyle = UIBarStyleBlackOpaque;
    } else if ([@"UIBarStyleBlackTranslucent" isEqualToString:string]) {
        barStyle = UIBarStyleBlackTranslucent;
    } else {
        barStyle = UIBarStyleDefault;
    }
    return barStyle;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UIBarButtonSystemItem) barButtonSystemItemFromString:(NSString *)string
{
    UIBarButtonSystemItem barButtonSystemItem;
    if ([@"UIBarButtonSystemItemDone" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemDone;
    } else if ([@"UIBarButtonSystemItemCancel" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemCancel;
    } else if ([@"UIBarButtonSystemItemEdit" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemEdit;
    } else if ([@"UIBarButtonSystemItemSave" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemSave;
    } else if ([@"UIBarButtonSystemItemAdd" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemAdd;
    } else if ([@"UIBarButtonSystemItemFlexibleSpace" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemFlexibleSpace;
    } else if ([@"UIBarButtonSystemItemFixedSpace" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemFixedSpace;
    } else if ([@"UIBarButtonSystemItemCompose" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemCompose;
    } else if ([@"UIBarButtonSystemItemReply" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemReply;
    } else if ([@"UIBarButtonSystemItemAction" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemAction;
    } else if ([@"UIBarButtonSystemItemOrganize" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemOrganize;
    } else if ([@"UIBarButtonSystemItemBookmarks" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemBookmarks;
    } else if ([@"UIBarButtonSystemItemSearch" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemSearch;
    } else if ([@"UIBarButtonSystemItemRefresh" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemRefresh;
    } else if ([@"UIBarButtonSystemItemStop" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemStop;
    } else if ([@"UIBarButtonSystemItemCamera" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemCamera;
    } else if ([@"UIBarButtonSystemItemTrash" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemTrash;
    } else if ([@"UIBarButtonSystemItemPlay" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemPlay;
    } else if ([@"UIBarButtonSystemItemPause" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemPause;
    } else if ([@"UIBarButtonSystemItemRewind" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemRewind;
    } else if ([@"UIBarButtonSystemItemFastForward" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemFastForward;
    } else if ([@"UIBarButtonSystemItemUndo" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemUndo;
    } else if ([@"UIBarButtonSystemItemRedo" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemRedo;
    } else if ([@"UIBarButtonSystemItemPageCurl" isEqualToString:string]) {
        barButtonSystemItem = UIBarButtonSystemItemPageCurl;
    } else {
        barButtonSystemItem = UIBarButtonSystemItemNone;
    }
    return barButtonSystemItem;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UIBarButtonItemStyle) barButtonItemStyleFromString:(NSString *)string
{
    UIBarButtonItemStyle barButtonItemStyle;
    if ([@"UIBarButtonItemStylePlain" isEqualToString:string]) {
        barButtonItemStyle = UIBarButtonItemStylePlain;
    } else if ([@"UIBarButtonItemStyleBordered" isEqualToString:string]) {
        barButtonItemStyle = UIBarButtonItemStyleBordered;
    } else if ([@"UIBarButtonItemStyleDone" isEqualToString:string]) {
        barButtonItemStyle = UIBarButtonItemStyleDone;
    } else {
        barButtonItemStyle = UIBarButtonItemStylePlain;
    }
    return barButtonItemStyle;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UISearchBarStyle) searchBarStyleFromString:(NSString *)string
{
    UISearchBarStyle searchBarStyle;
    if ([@"UISearchBarStyleDefault" isEqualToString:string]) {
        searchBarStyle = UISearchBarStyleDefault;
    } else if ([@"UISearchBarStyleProminent" isEqualToString:string]) {
        searchBarStyle = UISearchBarStyleProminent;
    } else if ([@"UISearchBarStyleMinimal" isEqualToString:string]) {
        searchBarStyle = UISearchBarStyleMinimal;
    } else {
        searchBarStyle = UISearchBarStyleDefault;
    }
    return searchBarStyle;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UITableViewStyle) tableViewStyleFromString:(NSString *)string
{
    UITableViewStyle tableViewStyle;
    if ([@"UITableViewStylePlain" isEqualToString:string]) {
        tableViewStyle = UITableViewStylePlain;
    } else if ([@"UITableViewStyleGrouped" isEqualToString:string]) {
        tableViewStyle = UITableViewStyleGrouped;
    } else {
        tableViewStyle = UITableViewStylePlain;
    }
    return tableViewStyle;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UITableViewCellStyle) tableViewCellStyleFromString:(NSString *)string
{
    UITableViewCellStyle tableViewCellStyle;
    if ([@"UITableViewCellStyleDefault" isEqualToString:string]) {
        tableViewCellStyle = UITableViewCellStyleDefault;
    } else if ([@"UITableViewCellStyleValue1" isEqualToString:string]) {
        tableViewCellStyle = UITableViewCellStyleValue1;
    } else if ([@"UITableViewCellStyleValue2" isEqualToString:string]) {
        tableViewCellStyle = UITableViewCellStyleValue2;
    } else if ([@"UITableViewCellStyleSubtitle" isEqualToString:string]) {
        tableViewCellStyle = UITableViewCellStyleSubtitle;
    } else {
        tableViewCellStyle = UITableViewCellStyleDefault;
    }
    return tableViewCellStyle;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UITableViewCellSelectionStyle) tableViewCellSelectionStyleFromString:(NSString *)string
{
    UITableViewCellSelectionStyle tableViewCellSelectionStyle;
    if ([@"UITableViewCellSelectionStyleNone" isEqualToString:string]) {
        tableViewCellSelectionStyle = UITableViewCellSelectionStyleNone;
    } else if ([@"UITableViewCellSelectionStyleBlue" isEqualToString:string]) {
        tableViewCellSelectionStyle = UITableViewCellSelectionStyleBlue;
    } else if ([@"UITableViewCellSelectionStyleGray" isEqualToString:string]) {
        tableViewCellSelectionStyle = UITableViewCellSelectionStyleGray;
    } else {
        tableViewCellSelectionStyle = UITableViewCellSelectionStyleDefault;
    }
    return tableViewCellSelectionStyle;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UITableViewCellAccessoryType) tableViewCellAccessoryTypeFromString:(NSString *)string
{
    UITableViewCellAccessoryType tableViewCellAccessoryType;
    if ([@"UITableViewCellAccessoryNone" isEqualToString:string]) {
        tableViewCellAccessoryType = UITableViewCellAccessoryNone;
    } else if ([@"UITableViewCellAccessoryDisclosureIndicator" isEqualToString:string]) {
        tableViewCellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if ([@"UITableViewCellAccessoryDetailDisclosureButton" isEqualToString:string]) {
        tableViewCellAccessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    } else if ([@"UITableViewCellAccessoryCheckmark" isEqualToString:string]) {
        tableViewCellAccessoryType = UITableViewCellAccessoryCheckmark;
    } else if ([@"UITableViewCellAccessoryDetailButton" isEqualToString:string]) {
        tableViewCellAccessoryType = UITableViewCellAccessoryDetailButton;
    } else {
        tableViewCellAccessoryType = UITableViewCellAccessoryNone;
    }
    return tableViewCellAccessoryType;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UITableViewCellEditingStyle) tableViewCellEditingStyleFromString:(NSString *)string;
{
    UITableViewCellEditingStyle tableViewCellEditingStyle;
    if ([@"UITableViewCellEditingStyleNone" isEqualToString:string]) {
        tableViewCellEditingStyle = UITableViewCellEditingStyleNone;
    } else if ([@"UITableViewCellEditingStyleDelete" isEqualToString:string]) {
        tableViewCellEditingStyle = UITableViewCellEditingStyleDelete;
    } else if ([@"UITableViewCellEditingStyleInsert" isEqualToString:string]) {
        tableViewCellEditingStyle = UITableViewCellEditingStyleInsert;
    } else {
        tableViewCellEditingStyle = UITableViewCellEditingStyleNone;
    }
    return tableViewCellEditingStyle;
}
// --------------------------------------------------------------------------------------------------------------------
+ (CGAffineTransform) affineTransformFromDictionary:(NSDictionary *)dictionary;
{
    CGAffineTransform affineTransform;
    NSNumber *a = dictionary[aKEY];
    NSNumber *b = dictionary[bKEY];
    NSNumber *c = dictionary[cKEY];
    NSNumber *d = dictionary[dKEY];
    NSNumber *tx = dictionary[txKEY];
    NSNumber *ty = dictionary[tyKEY];
    if (a && b && c && d && tx && ty) {
        affineTransform = CGAffineTransformMake([a floatValue], [b floatValue], [c floatValue], [d floatValue],
                                                [tx floatValue], [ty floatValue]);
    } else {
        affineTransform = CGAffineTransformIdentity;
    }
    return affineTransform;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UIStatusBarStyle) statusBarStyleFromString:(NSString *)string;
{
    UIStatusBarStyle statusBarStyle;
    if ([@"UIStatusBarStyleDefault" isEqualToString:string]) {
        statusBarStyle = UIStatusBarStyleDefault;
    } else if ([@"UIStatusBarStyleLightContent" isEqualToString:string]) {
        statusBarStyle = UIStatusBarStyleLightContent;
    } else {
        statusBarStyle = UIStatusBarStyleDefault;
    }
    return statusBarStyle;
}
// --------------------------------------------------------------------------------------------------------------------
+ (NSDate *)dateWithISO8601String:(NSString *)dateString
{
    if (!dateString) return nil;
    if ([dateString hasSuffix:@"Z"]) {
        dateString = [[dateString substringToIndex:(dateString.length-1)] stringByAppendingString:@"-0000"];
    }
    return [self dateFromString:dateString
                     withFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
}
+ (NSDate *)dateFromString:(NSString *)dateString
                withFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];

    NSLocale *locale = [[NSLocale alloc]
      initWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:locale];

    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}
// --------------------------------------------------------------------------------------------------------------------
+ (NSArray *) componentsArrayFromString:(NSString *)string
{
    NSArray *componentsArray = nil;
    if ([string rangeOfString:@","].location != NSNotFound) {
        componentsArray = [string componentsSeparatedByString:@","];
    } else if ([string rangeOfString:@"|"].location != NSNotFound) {
        componentsArray = [string componentsSeparatedByString:@"|"];
    } else {
        componentsArray = @[string];
    }
    return componentsArray;
}
// --------------------------------------------------------------------------------------------------------------------
+ (DataBindingMode) dataBindingModeForString:(NSString *)string
{
    DataBindingMode dataBindingMode;
    if ([@"twoWay" isEqualToString:string]) {
        dataBindingMode = DataBindingModeTwoWay;
    } else if ([@"oneWayFromData" isEqualToString:string]) {
        dataBindingMode = DataBindingModeOneWayFromData;
    } else if ([@"oneWayToData" isEqualToString:string]) {
        dataBindingMode = DataBindingModeOneWayToData;
    } else {
        dataBindingMode = DataBindingModeOneWayFromData;
    }
    return dataBindingMode;
}
// --------------------------------------------------------------------------------------------------------------------
+ (UIRectEdge) rectEdgeForString:(NSString *)string
{
    UIRectEdge rectEdge;
    if ([@"UIRectEdgeTop" isEqualToString:string]) {
        rectEdge = UIRectEdgeTop;
    } else if ([@"UIRectEdgeLeft" isEqualToString:string]) {
        rectEdge = UIRectEdgeLeft;
    } else if ([@"UIRectEdgeBottom" isEqualToString:string]) {
        rectEdge = UIRectEdgeBottom;
    } else if ([@"UIRectEdgeRight" isEqualToString:string]) {
        rectEdge = UIRectEdgeRight;
    } else if ([@"UIRectEdgeAll" isEqualToString:string]) {
        rectEdge = UIRectEdgeAll;
    } else {
        rectEdge = UIRectEdgeNone;
    }
//    NSArray *rectEdgeArray;
//    NSString *anRectEdge;
//    if ([string length] > 0) {
//        rectEdgeArray = [IRBaseDescriptor componentsArrayFromString:string];
//        for (NSString *anTrait in rectEdgeArray) {
//            anRectEdge = [anTrait stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//            if ([@"UIRectEdgeTop" isEqualToString:anRectEdge]) {
//                rectEdge = rectEdge | UIRectEdgeTop;
//            } else if ([@"UIRectEdgeLeft" isEqualToString:anRectEdge]) {
//                rectEdge = rectEdge | UIRectEdgeLeft;
//            } else if ([@"UIRectEdgeBottom" isEqualToString:anRectEdge]) {
//                rectEdge = rectEdge | UIRectEdgeBottom;
//            } else if ([@"UIRectEdgeRight" isEqualToString:anRectEdge]) {
//                rectEdge = rectEdge | UIRectEdgeRight;
//            } else if ([@"UIRectEdgeAll" isEqualToString:anRectEdge]) {
//                rectEdge = rectEdge | UIRectEdgeAll;
//            }
//        }
//    }
    return rectEdge;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (NSArray *) allImagePaths
{
    NSMutableArray *allImagePaths = [NSMutableArray array];
    IRAppDescriptor *appDescriptor = [IRDataController sharedInstance].appDescriptor;
    NSArray *screenArrays = appDescriptor.screensArray;
    for (IRScreenDescriptor *anScreenDescriptor in screenArrays) {
        [IRBaseDescriptor extendImagePathsArray:allImagePaths withPathsFromScreenDescriptor:anScreenDescriptor];
    }
    return allImagePaths;
}
+ (void) extendImagePathsArray:(NSMutableArray *)imagePaths withPathsFromScreenDescriptor:(IRScreenDescriptor *)irScreenDescriptor
{
    [irScreenDescriptor.viewControllerDescriptor extendImagePathsArray:imagePaths];
    for (IRViewDescriptor *viewDescriptor in irScreenDescriptor.rootViewDescriptor.subviewsArray) {
        [viewDescriptor extendImagePathsArray:imagePaths];
    }
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
+ (NSArray *) allJSFilesPaths
{
    NSMutableArray *allJSFilesPaths = [NSMutableArray array];
    IRAppDescriptor *appDescriptor = [IRDataController sharedInstance].appDescriptor;
    NSArray *screenArrays = appDescriptor.screensArray;
    for (IRScreenDescriptor *anScreenDescriptor in screenArrays) {
        if ([anScreenDescriptor.viewControllerDescriptor.jsPluginPath length] > 0) {
            [allJSFilesPaths addObject:anScreenDescriptor.viewControllerDescriptor.jsPluginPath];
        }
    }
    return allJSFilesPaths;
}
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

+ (NSString *) componentName
{
    return nil;
}
+ (Class) componentClass
{
    return NULL;
}

+ (Class) builderClass
{
    return NULL;
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super init];
    if (self) {
        NSString *string;

        // componentId
        string = aDictionary[idKEY];
        self.componentId = string;
    }
    return self;
}

- (NSDictionary *) viewDefaults
{
    return @{

    };
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{

}

@end