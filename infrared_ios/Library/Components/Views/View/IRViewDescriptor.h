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

/*
 UIViewContentModeScaleToFill, UIViewContentModeScaleAspectFit, UIViewContentModeScaleAspectFill, UIViewContentModeRedraw, UIViewContentModeCenter, UIViewContentModeTop, UIViewContentModeBottom, UIViewContentModeLeft, UIViewContentModeRight, UIViewContentModeTopLeft, UIViewContentModeTopRight, UIViewContentModeBottomLeft, UIViewContentModeBottomRight
 */
@property(nonatomic) UIViewContentMode contentMode;

@property(nonatomic) NSInteger tag;

@property(nonatomic/*, getter=isUserInteractionEnabled*/) BOOL userInteractionEnabled;
@property(nonatomic/*, getter=isMultipleTouchEnabled*/) BOOL multipleTouchEnabled;

@property(nonatomic) CGFloat alpha;
@property(nonatomic, strong) UIColor *backgroundColor;
@property(nonatomic, strong) UIColor *tintColor;

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
/*
 UIAccessibilityTraitNone, UIAccessibilityTraitButton, UIAccessibilityTraitLink, UIAccessibilityTraitImage, UIAccessibilityTraitSelected, UIAccessibilityTraitStaticText, UIAccessibilityTraitSearchField, UIAccessibilityTraitPlaysSound, UIAccessibilityTraitKeyboardKey, UIAccessibilityTraitSummaryElement, UIAccessibilityTraitUpdatesFrequently, UIAccessibilityTraitAllowsDirectInteraction
 */
@property(nonatomic, assign) UIAccessibilityTraits accessibilityTraits;

// --------------------------------------------------------------------------------------------------------------------

@property (nonatomic, strong) NSArray *restrictToOrientationsArray;

@property (nonatomic, strong) NSMutableArray *subviewsArray;

@property (nonatomic, strong) NSMutableArray *dataBindingsArray;

@property (nonatomic, strong) NSMutableArray *intrinsicContentSizePriorityArray;
@property (nonatomic, strong) NSMutableArray *layoutConstraintsArray;

@property (nonatomic) BOOL autoLayoutKeyboardHandling;
@property (nonatomic) CGFloat cornerRadius;

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic) CGFloat borderWidth;

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end
