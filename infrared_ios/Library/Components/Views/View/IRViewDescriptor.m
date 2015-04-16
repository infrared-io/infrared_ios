//
//  IRViewDescriptor.m
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRViewDescriptor.h"
#import "IRUtil.h"
#import "IRLayoutConstraintDescriptor.h"
#import "IRDataBindingDescriptor.h"
#import "IRGestureRecognizerDescriptor.h"
#import "IRViewBuilder.h"
#import "IRView.h"

@implementation IRViewDescriptor

+ (NSString *) componentName
{
    return typeViewKEY;
}
+ (Class) componentClass
{
    return [IRView class];
}

+ (Class) builderClass
{
    return [IRViewBuilder class];
}

- (NSDictionary *) viewDefaults
{
    return @{
      @"userInteractionEnabled" : @(YES),
      @"multipleTouchEnabled" : @(NO),
      @"alpha" : @(1.0),
      @"backgroundColor" : [UIColor clearColor],
//      @"tintColor" : [NSNull null],
      @"opaque" : @(YES),
      @"hidden" : @(NO),
      @"clearsContextBeforeDrawing" : @(YES),
      @"clipsToBounds" : @(NO),
      @"isAccessibilityElement" : @(YES)
    };
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        UIColor *color;
        NSDictionary *dictionary;
        NSArray *array;
        IRBaseDescriptor *descriptor;

        // frame
        dictionary = aDictionary[NSStringFromSelector(@selector(frame))];
        self.frame = [IRBaseDescriptor frameFromDictionary:dictionary];

        // contentMode
        string = aDictionary[NSStringFromSelector(@selector(contentMode))];
        self.contentMode = [IRBaseDescriptor contentModeFromString:string];

        // tag
        number = aDictionary[NSStringFromSelector(@selector(tag))];
        self.tag = [number integerValue];

        // userInteractionEnabled
        number = aDictionary[NSStringFromSelector(@selector(userInteractionEnabled))];
        if (number) {
            self.userInteractionEnabled = [number boolValue];
        } else {
            self.userInteractionEnabled = [[self viewDefaults][NSStringFromSelector(@selector(userInteractionEnabled))] boolValue];
        }

        // multipleTouchEnabled
        number = aDictionary[NSStringFromSelector(@selector(multipleTouchEnabled))];
        if (number) {
            self.multipleTouchEnabled = [number boolValue];
        } else {
            self.multipleTouchEnabled = [[self viewDefaults][NSStringFromSelector(@selector(multipleTouchEnabled))] boolValue];
        }

        // alpha
        number = aDictionary[NSStringFromSelector(@selector(alpha))];
        if (number) {
            self.alpha = [number floatValue];
        } else {
            self.alpha = [[self viewDefaults][NSStringFromSelector(@selector(alpha))] floatValue];
        }

        // backgroundColor
        string = aDictionary[NSStringFromSelector(@selector(backgroundColor))];
        color = [IRUtil transformHexColorToUIColor:string];
        if (color) {
            self.backgroundColor = color;
        } else {
            self.backgroundColor = [self viewDefaults][NSStringFromSelector(@selector(backgroundColor))];
        }

        // tintColor
        string = aDictionary[NSStringFromSelector(@selector(tintColor))];
        color = [IRUtil transformHexColorToUIColor:string];
        if (color) {
            self.tintColor = color;
        }

        // opaque
        number = aDictionary[NSStringFromSelector(@selector(opaque))];
        if (number) {
            self.opaque = [number boolValue];
        } else {
            self.opaque = [[self viewDefaults][NSStringFromSelector(@selector(opaque))] boolValue];
        }

        // hidden
        number = aDictionary[NSStringFromSelector(@selector(hidden))];
        if (number) {
            self.hidden = [number boolValue];
        } else {
            self.hidden = [[self viewDefaults][NSStringFromSelector(@selector(hidden))] boolValue];
        }

        // clearsContextBeforeDrawing
        number = aDictionary[NSStringFromSelector(@selector(clearsContextBeforeDrawing))];
        if (number) {
            self.clearsContextBeforeDrawing = [number boolValue];
        } else {
            self.clearsContextBeforeDrawing = [[self viewDefaults][NSStringFromSelector(@selector(clearsContextBeforeDrawing))] boolValue];
        }

        // clipsToBounds
        number = aDictionary[NSStringFromSelector(@selector(clipsToBounds))];
        if (number) {
            self.clipsToBounds = [number boolValue];
        } else {
            self.clipsToBounds = [[self viewDefaults][NSStringFromSelector(@selector(clipsToBounds))] boolValue];
        }

        // isAccessibilityElement
        number = aDictionary[NSStringFromSelector(@selector(isAccessibilityElement))];
        if (number) {
            self.isAccessibilityElement = [number boolValue];
        } else {
            self.isAccessibilityElement = [[self viewDefaults][NSStringFromSelector(@selector(isAccessibilityElement))] boolValue];
        }

        // accessibilityLabel
        string = aDictionary[NSStringFromSelector(@selector(accessibilityLabel))];
        self.accessibilityLabel = string;

        // accessibilityHint
        string = aDictionary[NSStringFromSelector(@selector(accessibilityHint))];
        self.accessibilityHint = string;

        // accessibilityTraits
        string = aDictionary[NSStringFromSelector(@selector(accessibilityTraits))];
        self.accessibilityTraits = [IRBaseDescriptor accessibilityTraitsFromString:string
                                                                     forDescriptor:self];

        // restrictToOrientationsArray
        string = aDictionary[restrictToOrientationsKEY];
        self.restrictToOrientationsArray = [IRBaseDescriptor interfaceOrientationsFromString:string];

        // subviewsArray
        array = aDictionary[subviewsKEY];
        if (array && [array count]) {
            self.subviewsArray = [[NSMutableArray alloc] init];
            for (NSDictionary *anDictionary in array) {
                descriptor = [IRBaseDescriptor newViewDescriptorWithDictionary:anDictionary];
                if (descriptor) {
                    [self.subviewsArray addObject:descriptor];
                }
            }
        }

        // dataBindingsArray
        array = aDictionary[dataBindingKEY];
        if (array && [array count]) {
            self.dataBindingsArray = [[NSMutableArray alloc] init];
            for (NSDictionary *anDictionary in array) {
                descriptor = [IRDataBindingDescriptor newDataBindingDescriptorWithDictionary:anDictionary];
                if (descriptor) {
                    [self.dataBindingsArray addObject:descriptor];
                }
            }
        }

        // intrinsicContentSizePriorityArray
        array = aDictionary[intrinsicContentSizePriorityKEY];
        if (array && [array count]) {
            self.intrinsicContentSizePriorityArray = [[NSMutableArray alloc] init];
            for (NSDictionary *anDictionary in array) {
                descriptor = [IRLayoutConstraintDescriptor newLayoutConstraintDescriptorWithDictionary:anDictionary];
                if (descriptor) {
                    [self.intrinsicContentSizePriorityArray addObject:descriptor];
                }
            }
        }

        // layoutConstraintsArray
        array = aDictionary[constraintsKEY];
        if (array && [array count]) {
            self.layoutConstraintsArray = [[NSMutableArray alloc] init];
            for (NSDictionary *anDictionary in array) {
                descriptor = [IRLayoutConstraintDescriptor newLayoutConstraintDescriptorWithDictionary:anDictionary];
                if (descriptor) {
                    [self.layoutConstraintsArray addObject:descriptor];
                }
            }
        }

        // gestureRecognizersArray
        array = aDictionary[gestureRecognizersKEY];
        if (array && [array count]) {
            self.gestureRecognizersArray = [[NSMutableArray alloc] init];
            for (NSDictionary *anDictionary in array) {
                descriptor = [IRGestureRecognizerDescriptor newGestureRecognizerDescriptorWithDictionary:anDictionary];
                if (descriptor) {
                    [self.gestureRecognizersArray addObject:descriptor];
                }
            }
        }

        // autoLayoutKeyboardHandling
        number = aDictionary[NSStringFromSelector(@selector(autoLayoutKeyboardHandling))];
        if (number) {
            self.autoLayoutKeyboardHandling = [number boolValue];
        } else {
            self.autoLayoutKeyboardHandling = NO;
        }

        // cornerRadius
        number = aDictionary[NSStringFromSelector(@selector(cornerRadius))];
        if (number) {
            self.cornerRadius = [number floatValue];
        } else {
            self.cornerRadius = CGFLOAT_UNDEFINED;
        }

        // borderColor
        string = aDictionary[NSStringFromSelector(@selector(borderColor))];
        color = [IRUtil transformHexColorToUIColor:string];
        if (color) {
            self.borderColor = color;
        }

        // borderWidth
        number = aDictionary[NSStringFromSelector(@selector(borderWidth))];
        if (number) {
            self.borderWidth = [number floatValue];
        } else {
            self.borderWidth = CGFLOAT_UNDEFINED;
        }
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    for (IRBaseDescriptor *anDescriptor in self.subviewsArray) {
        [anDescriptor extendImagePathsArray:imagePaths];
    }
}

@end
