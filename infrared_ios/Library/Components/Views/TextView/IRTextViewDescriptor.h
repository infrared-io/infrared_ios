//
// Created by Uros Milivojevic on 12/5/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRScrollViewDescriptor.h"


@interface IRTextViewDescriptor : IRScrollViewDescriptor

@property (nonatomic/*, getter=isAttributedTextEnabled*/) BOOL attributedTextEnabled;

@property(nonatomic, strong) NSString *text;
@property(nonatomic, retain) UIColor *textColor;
@property(nonatomic, retain) UIFont *font;
@property(nonatomic) NSTextAlignment textAlignment;

// --------------------------------------------------------------------------------------------------------------------

@property(nonatomic/*, getter=isEditable*/) BOOL editable;                // default is YES
@property(nonatomic/*, getter=isSelectable*/) BOOL selectable;            // default is YES

@property(nonatomic) UIDataDetectorTypes dataDetectorTypes;

// --------------------------------------------------------------------------------------------------------------------

@property(nonatomic) BOOL clearsOnInsertion; // defaults to NO. if YES, the selection UI is hidden, and inserting text will replace the contents of the field. changing the selection will automatically set this to NO.
@property(nonatomic) UITextAutocapitalizationType autocapitalizationType; // default is UITextAutocapitalizationTypeSentences
@property(nonatomic) UITextAutocorrectionType autocorrectionType;         // default is UITextAutocorrectionTypeDefault
@property(nonatomic) UITextSpellCheckingType spellCheckingType NS_AVAILABLE_IOS(5_0); // default is UITextSpellCheckingTypeDefault;
@property(nonatomic) UIKeyboardType keyboardType;                         // default is UIKeyboardTypeDefault
@property(nonatomic) UIKeyboardAppearance keyboardAppearance;             // default is UIKeyboardAppearanceDefault
@property(nonatomic) UIReturnKeyType returnKeyType;                       // default is UIReturnKeyDefault (See note under UIReturnKeyType enum)
@property(nonatomic) BOOL enablesReturnKeyAutomatically;                  // default is NO (when YES, will automatically disable return key when text widget has zero-length contents, and will automatically enable when text widget has non-zero-length contents)
@property(nonatomic/*,getter=isSecureTextEntry*/) BOOL secureTextEntry;       // default is NO

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end