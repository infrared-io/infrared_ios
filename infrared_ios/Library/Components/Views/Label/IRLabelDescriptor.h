//
//  IRLabelDescriptor.h
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewDescriptor.h"

@interface IRLabelDescriptor : IRViewDescriptor

@property (nonatomic, getter=isAttributedTextEnabled) BOOL attributedTextEnabled;

@property(nonatomic, strong) NSString *text;
@property(nonatomic, retain) UIColor *textColor;
/*
Types:
 1) text_styles: UIFontTextStyleHeadline, UIFontTextStyleSubheadline, UIFontTextStyleBody, UIFontTextStyleFootnote, UIFontTextStyleCaption1, UIFontTextStyleCaption2
 2) - system: System, SystemBold, SystemItalic
    - size: 16
 3) - name: Arial-BoldItalic, HelveticaNeue-Bold
    - size: 16

Examples:
 1) UIFontTextStyleHeadline
 2) SystemBold, 16
 3) Arial-BoldItalic, 16
  */
@property(nonatomic, retain) UIFont *font;
@property(nonatomic) NSTextAlignment textAlignment;

@property(nonatomic, strong) NSAttributedString *attributedText;
// TODO: Add remaining attributed text fields later

@property(nonatomic) NSInteger numberOfLines;
@property(nonatomic/*, getter=isEnabled*/) BOOL enabled;
@property(nonatomic/*, getter=isHighlighted*/) BOOL highlighted;

@property(nonatomic) BOOL adjustsFontSizeToFitWidth;
/*
 UIBaselineAdjustmentAlignBaselines = 0, UIBaselineAdjustmentAlignCenters, UIBaselineAdjustmentNone
 */
@property(nonatomic) UIBaselineAdjustment baselineAdjustment;
/*
 NSLineBreakByWordWrapping = 0, NSLineBreakByCharWrapping, NSLineBreakByClipping, NSLineBreakByTruncatingHead, NSLineBreakByTruncatingTail, NSLineBreakByTruncatingMiddle
 */
@property(nonatomic) NSLineBreakMode lineBreakMode;

@property(nonatomic) CGFloat minimumScaleFactor;

@property(nonatomic, retain) UIColor *highlightedTextColor;
@property(nonatomic, retain) UIColor *shadowColor;
@property(nonatomic) CGSize shadowOffset;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end
