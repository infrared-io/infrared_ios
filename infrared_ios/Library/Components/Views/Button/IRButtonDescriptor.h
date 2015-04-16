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

/*
 UIButtonTypeCustom = 0, UIButtonTypeSystem, UIButtonTypeDetailDisclosure, UIButtonTypeInfoLight, UIButtonTypeInfoDark, UIButtonTypeContactAdd
 */
@property(nonatomic) UIButtonType buttonType;

// UIControlStateNormal
@property(nonatomic, strong) NSString *normalTitle;
@property(nonatomic, retain) UIColor *normalTitleColor;
@property(nonatomic, retain) UIColor *normalTitleShadowColor;
@property(nonatomic, strong) /*UIImage*/ NSString *normalImage;
@property(nonatomic, strong) /*UIImage*/ NSString *normalBackgroundImage;

// UIControlStateHighlighted
@property(nonatomic, strong) NSString *highlightedTitle;
@property(nonatomic, retain) UIColor *highlightedTitleColor;
@property(nonatomic, retain) UIColor *highlightedTitleShadowColor;
@property(nonatomic, strong) /*UIImage*/ NSString *highlightedImage;
@property(nonatomic, strong) /*UIImage*/ NSString *highlightedBackgroundImage;

// UIControlStateSelected
@property(nonatomic, strong) NSString *selectedTitle;
@property(nonatomic, retain) UIColor *selectedTitleColor;
@property(nonatomic, retain) UIColor *selectedTitleShadowColor;
@property(nonatomic, strong) /*UIImage*/ NSString *selectedImage;
@property(nonatomic, strong) /*UIImage*/ NSString *selectedBackgroundImage;

// UIControlStateDisabled
@property(nonatomic, strong) NSString *disabledTitle;
@property(nonatomic, retain) UIColor *disabledTitleColor;
@property(nonatomic, retain) UIColor *disabledTitleShadowColor;
@property(nonatomic, strong) /*UIImage*/ NSString *disabledImage;
@property(nonatomic, strong) /*UIImage*/ NSString *disabledBackgroundImage;

@property(nonatomic, retain) UIFont *font;

@property(nonatomic) CGSize titleShadowOffset;
@property(nonatomic) BOOL reversesTitleShadowWhenHighlighted;
@property(nonatomic) BOOL showsTouchWhenHighlighted;
@property(nonatomic) BOOL adjustsImageWhenHighlighted;
@property(nonatomic) BOOL adjustsImageWhenDisabled;
/*
 NSLineBreakByWordWrapping = 0, NSLineBreakByCharWrapping, NSLineBreakByClipping, NSLineBreakByTruncatingHead, NSLineBreakByTruncatingTail, NSLineBreakByTruncatingMiddle
 */
@property(nonatomic) NSLineBreakMode lineBreakMode;

@property(nonatomic) UIEdgeInsets contentEdgeInsets;
@property(nonatomic) UIEdgeInsets titleEdgeInsets;
@property(nonatomic) UIEdgeInsets imageEdgeInsets;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end
