//
//  IRViewDescriptor.h
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseDescriptor.h"

@interface IRViewDescriptor : IRBaseDescriptor

@property(nonatomic) CGRect frame;

#if TARGET_OS_IPHONE
/*
 UIViewContentModeScaleToFill, UIViewContentModeScaleAspectFit, UIViewContentModeScaleAspectFill, UIViewContentModeRedraw, UIViewContentModeCenter, UIViewContentModeTop, UIViewContentModeBottom, UIViewContentModeLeft, UIViewContentModeRight, UIViewContentModeTopLeft, UIViewContentModeTopRight, UIViewContentModeBottomLeft, UIViewContentModeBottomRight
 */
@property(nonatomic) UIViewContentMode contentMode;
#endif

@property(nonatomic) NSInteger tag;

@property(nonatomic/*, getter=isUserInteractionEnabled*/) BOOL userInteractionEnabled;
@property(nonatomic/*, getter=isMultipleTouchEnabled*/) BOOL multipleTouchEnabled;

@property(nonatomic) CGFloat alpha;
#if TARGET_OS_IPHONE
@property(nonatomic, strong) UIColor *backgroundColor;
@property(nonatomic, strong) UIColor *tintColor;
#endif

@property(nonatomic/*, getter=isOpaque*/) BOOL opaque;
@property(nonatomic/*, getter=isHidden*/) BOOL hidden;
@property(nonatomic) BOOL clearsContextBeforeDrawing;
@property(nonatomic) BOOL clipsToBounds;

@property(nonatomic, strong) NSMutableArray *gestureRecognizersArray;

// Accessability
//    - preset default values for each component (View, Label, Image, Button, etc.)

@property(nonatomic) BOOL isAccessibilityElement;
@property(nonatomic, strong) NSString *accessibilityLabel;
@property(nonatomic, strong) NSString *accessibilityHint;
#if TARGET_OS_IPHONE
/*
 UIAccessibilityTraitNone, UIAccessibilityTraitButton, UIAccessibilityTraitLink, UIAccessibilityTraitImage, UIAccessibilityTraitSelected, UIAccessibilityTraitStaticText, UIAccessibilityTraitSearchField, UIAccessibilityTraitPlaysSound, UIAccessibilityTraitKeyboardKey, UIAccessibilityTraitSummaryElement, UIAccessibilityTraitUpdatesFrequently, UIAccessibilityTraitAllowsDirectInteraction
 */
@property(nonatomic, assign) UIAccessibilityTraits accessibilityTraits;
#endif

// --------------------------------------------------------------------------------------------------------------------

#if TARGET_OS_IPHONE
@property (nonatomic, strong) NSArray *restrictToOrientationsArray;
#endif

@property (nonatomic, strong) NSMutableArray *subviewsArray;

#if TARGET_OS_IPHONE
@property (nonatomic, strong) NSMutableArray *dataBindingsArray;

@property (nonatomic, strong) NSMutableArray *intrinsicContentSizePriorityArray;
@property (nonatomic, strong) NSMutableArray *layoutConstraintsArray;

@property (nonatomic) BOOL autoLayoutKeyboardHandling;
@property (nonatomic) CGFloat cornerRadius;

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic) CGFloat borderWidth;
#endif


- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end
