//
//  IRButtonDescriptor.h
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewAndControlDescriptor.h"

@interface IRButtonDescriptor : IRViewAndControlDescriptor

#if TARGET_OS_IPHONE
/*
 UIButtonTypeCustom = 0, UIButtonTypeSystem, UIButtonTypeDetailDisclosure, UIButtonTypeInfoLight, UIButtonTypeInfoDark, UIButtonTypeContactAdd
 */
@property(nonatomic) UIButtonType buttonType;
#endif

// UIControlStateNormal
@property(nonatomic, strong) NSString *normalTitle;
#if TARGET_OS_IPHONE
@property(nonatomic, retain) UIColor *normalTitleColor;
@property(nonatomic, retain) UIColor *normalTitleShadowColor;
#endif
@property(nonatomic, strong) /*UIImage*/ NSString *normalImage;
@property(nonatomic, strong) /*UIImage*/ NSString *normalBackgroundImage;
#if TARGET_OS_IPHONE
@property(nonatomic) UIEdgeInsets normalImageCapInsets;
@property(nonatomic) UIEdgeInsets normalBackgroundImageCapInsets;
#endif

// UIControlStateHighlighted
@property(nonatomic, strong) NSString *highlightedTitle;
#if TARGET_OS_IPHONE
@property(nonatomic, retain) UIColor *highlightedTitleColor;
@property(nonatomic, retain) UIColor *highlightedTitleShadowColor;
#endif
@property(nonatomic, strong) /*UIImage*/ NSString *highlightedImage;
@property(nonatomic, strong) /*UIImage*/ NSString *highlightedBackgroundImage;
#if TARGET_OS_IPHONE
@property(nonatomic) UIEdgeInsets highlightedImageCapInsets;
@property(nonatomic) UIEdgeInsets highlightedBackgroundImageCapInsets;
#endif

// UIControlStateSelected
@property(nonatomic, strong) NSString *selectedTitle;
#if TARGET_OS_IPHONE
@property(nonatomic, retain) UIColor *selectedTitleColor;
@property(nonatomic, retain) UIColor *selectedTitleShadowColor;
#endif
@property(nonatomic, strong) /*UIImage*/ NSString *selectedImage;
@property(nonatomic, strong) /*UIImage*/ NSString *selectedBackgroundImage;
#if TARGET_OS_IPHONE
@property(nonatomic) UIEdgeInsets selectedImageCapInsets;
@property(nonatomic) UIEdgeInsets selectedBackgroundImageCapInsets;
#endif

// UIControlStateDisabled
@property(nonatomic, strong) NSString *disabledTitle;
#if TARGET_OS_IPHONE
@property(nonatomic, retain) UIColor *disabledTitleColor;
@property(nonatomic, retain) UIColor *disabledTitleShadowColor;
#endif
@property(nonatomic, strong) /*UIImage*/ NSString *disabledImage;
@property(nonatomic, strong) /*UIImage*/ NSString *disabledBackgroundImage;
#if TARGET_OS_IPHONE
@property(nonatomic) UIEdgeInsets disabledImageCapInsets;
@property(nonatomic) UIEdgeInsets disabledBackgroundImageCapInsets;
#endif

#if TARGET_OS_IPHONE
@property(nonatomic, retain) UIFont *font;
#endif

@property(nonatomic) CGSize titleShadowOffset;
@property(nonatomic) BOOL reversesTitleShadowWhenHighlighted;
@property(nonatomic) BOOL showsTouchWhenHighlighted;
@property(nonatomic) BOOL adjustsImageWhenHighlighted;
@property(nonatomic) BOOL adjustsImageWhenDisabled;
#if TARGET_OS_IPHONE
/*
 NSLineBreakByWordWrapping = 0, NSLineBreakByCharWrapping, NSLineBreakByClipping, NSLineBreakByTruncatingHead, NSLineBreakByTruncatingTail, NSLineBreakByTruncatingMiddle
 */
@property(nonatomic) NSLineBreakMode lineBreakMode;

@property(nonatomic) UIEdgeInsets contentEdgeInsets;
@property(nonatomic) UIEdgeInsets titleEdgeInsets;
@property(nonatomic) UIEdgeInsets imageEdgeInsets;
#endif

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor;

@end
