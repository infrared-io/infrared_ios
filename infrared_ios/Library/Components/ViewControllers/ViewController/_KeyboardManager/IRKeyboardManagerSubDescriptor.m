//
// Created by Uros Milivojevic on 4/2/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRKeyboardManagerSubDescriptor.h"
#import "IRBaseDescriptor.h"
#import "IRAppDescriptor.h"


@implementation IRKeyboardManagerSubDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    NSNumber *number;
    NSString *string;
    NSDictionary *dictionary;

    self = [super init];
    if (self) {
        // enable
        number = aDictionary[NSStringFromSelector(@selector(enable))];
        if (number) {
            self.enable = [number boolValue];
        } else {
            self.enable = YES;
        }

        // keyboardDistanceFromTextField
        number = aDictionary[NSStringFromSelector(@selector(keyboardDistanceFromTextField))];
        if (number) {
            self.keyboardDistanceFromTextField = [number floatValue];
        } else {
            self.keyboardDistanceFromTextField = 10.0;
        }

        // preventShowingBottomBlankSpace
        number = aDictionary[NSStringFromSelector(@selector(preventShowingBottomBlankSpace))];
        if (number) {
            self.preventShowingBottomBlankSpace = [number boolValue];
        } else {
            self.preventShowingBottomBlankSpace = YES;
        }

        // enableAutoToolbar
        number = aDictionary[NSStringFromSelector(@selector(enableAutoToolbar))];
        if (number) {
            self.enableAutoToolbar = [number boolValue];
        } else {
            self.enableAutoToolbar = YES;
        }

#if TARGET_OS_IPHONE
        // toolbarManageBehaviour
        string = aDictionary[NSStringFromSelector(@selector(toolbarManageBehaviour))];
        if (string) {
            self.toolbarManageBehaviour = [IRKeyboardManagerSubDescriptor toolbarManageBehaviourFromString:string];
        } else {
            self.toolbarManageBehaviour = IQAutoToolbarBySubviews;
        }
#endif

        // shouldToolbarUsesTextFieldTintColor
        number = aDictionary[NSStringFromSelector(@selector(shouldToolbarUsesTextFieldTintColor))];
        if (number) {
            self.shouldToolbarUsesTextFieldTintColor = [number boolValue];
        } else {
            self.shouldToolbarUsesTextFieldTintColor = NO;
        }

        // shouldShowTextFieldPlaceholder
        number = aDictionary[NSStringFromSelector(@selector(shouldShowTextFieldPlaceholder))];
        if (number) {
            self.shouldShowTextFieldPlaceholder = [number boolValue];
        } else {
            self.shouldShowTextFieldPlaceholder = YES;
        }

#if TARGET_OS_IPHONE
        // placeholderFont
        string = aDictionary[NSStringFromSelector(@selector(placeholderFont))];
        if (string) {
            self.placeholderFont = [IRBaseDescriptor fontFromString:string];
        } else {
            self.placeholderFont = nil;
        }
#endif

        // placeholderFont
        number = aDictionary[NSStringFromSelector(@selector(canAdjustTextView))];
        if (number) {
            self.canAdjustTextView = [number boolValue];
        } else {
            self.canAdjustTextView = NO;
        }

        // shouldFixTextViewClip
        number = aDictionary[NSStringFromSelector(@selector(shouldFixTextViewClip))];
        if (number) {
            self.shouldFixTextViewClip = [number boolValue];
        } else {
            self.shouldFixTextViewClip = YES;
        }

        // overrideKeyboardAppearance
        number = aDictionary[NSStringFromSelector(@selector(overrideKeyboardAppearance))];
        if (number) {
            self.overrideKeyboardAppearance = [number boolValue];
        } else {
            self.overrideKeyboardAppearance = NO;
        }

#if TARGET_OS_IPHONE
        // keyboardAppearance
        string = aDictionary[NSStringFromSelector(@selector(keyboardAppearance))];
        if (string) {
            self.keyboardAppearance = [IRBaseDescriptor keyboardAppearanceFromString:string];
        } else {
            self.keyboardAppearance = UIKeyboardAppearanceDefault;
        }
#endif

        // shouldResignOnTouchOutside
        number = aDictionary[NSStringFromSelector(@selector(shouldResignOnTouchOutside))];
        if (number) {
            self.shouldResignOnTouchOutside = [number boolValue];
        } else {
            self.shouldResignOnTouchOutside = NO;
        }

        // shouldPlayInputClicks
        number = aDictionary[NSStringFromSelector(@selector(shouldPlayInputClicks))];
        if (number) {
            self.shouldPlayInputClicks = [number boolValue];
        } else {
            self.shouldPlayInputClicks = NO;
        }

        // shouldAdoptDefaultKeyboardAnimation
        number = aDictionary[NSStringFromSelector(@selector(shouldAdoptDefaultKeyboardAnimation))];
        if (number) {
            self.shouldAdoptDefaultKeyboardAnimation = [number boolValue];
        } else {
            self.shouldAdoptDefaultKeyboardAnimation = YES;
        }
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor
{

}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#if TARGET_OS_IPHONE
+ (IQAutoToolbarManageBehaviour) toolbarManageBehaviourFromString:(NSString *)string
{
    IQAutoToolbarManageBehaviour autoToolbarManageBehaviour;
    if ([@"IQAutoToolbarBySubviews" isEqualToString:string]) {
        autoToolbarManageBehaviour = IQAutoToolbarBySubviews;
    } else if ([@"IQAutoToolbarByTag" isEqualToString:string]) {
        autoToolbarManageBehaviour = IQAutoToolbarByTag;
    } else if ([@"IQAutoToolbarByPosition" isEqualToString:string]) {
        autoToolbarManageBehaviour = IQAutoToolbarByPosition;
    } else {
        autoToolbarManageBehaviour = IQAutoToolbarBySubviews;
    }
    return autoToolbarManageBehaviour;
}
#endif

@end