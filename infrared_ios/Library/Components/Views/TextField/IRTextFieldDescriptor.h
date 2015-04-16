//
//  IRTextFieldDescriptor.h
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRViewAndControlDescriptor.h"

@interface IRTextFieldDescriptor : IRViewAndControlDescriptor

@property (nonatomic, getter=isAttributedTextEnabled) BOOL attributedTextEnabled;

@property(nonatomic, strong) NSString *text;
@property(nonatomic, retain) UIColor *textColor;
@property(nonatomic, retain) UIFont *font;
@property(nonatomic) NSTextAlignment textAlignment;

@property(nonatomic, strong) NSString *placeholder;
@property(nonatomic, retain) UIColor *placeholderColor;

@property(nonatomic, strong) /*UIImage*/ NSString *background;
@property(nonatomic, strong) /*UIImage*/ NSString *disabledBackground;

/*
 UITextBorderStyleNone, UITextBorderStyleLine, UITextBorderStyleBezel, UITextBorderStyleRoundedRect
 */
@property(nonatomic) UITextBorderStyle borderStyle;

/*
 UITextFieldViewModeNever, UITextFieldViewModeWhileEditing, UITextFieldViewModeUnlessEditing, UITextFieldViewModeAlways
 */
@property(nonatomic) UITextFieldViewMode clearButtonMode;

@property(nonatomic) BOOL clearsOnBeginEditing;

@property(nonatomic) CGFloat minimumFontSize;
@property(nonatomic) BOOL adjustsFontSizeToFitWidth;

@property(nonatomic,retain) /*UIView*/ IRViewDescriptor *leftView; // e.g. magnifying glass
/*
 UITextFieldViewModeNever, UITextFieldViewModeWhileEditing, UITextFieldViewModeUnlessEditing, UITextFieldViewModeAlways
 */
@property(nonatomic) UITextFieldViewMode leftViewMode; // sets when the left view shows up. default is UITextFieldViewModeNever

@property(nonatomic,retain) /*UIView*/ IRViewDescriptor *rightView; // e.g. bookmarks button
/*
 UITextFieldViewModeNever, UITextFieldViewModeWhileEditing, UITextFieldViewModeUnlessEditing, UITextFieldViewModeAlways
 */
@property(nonatomic) UITextFieldViewMode rightViewMode; // sets when the right view shows up. default is UITextFieldViewModeNever

@property(nonatomic) BOOL clearsOnInsertion; // defaults to NO. if YES, the selection UI is hidden, and inserting text will replace the contents of the field. changing the selection will automatically set this to NO.

// UITextInputTraits Protocol
/*
UITextAutocapitalizationTypeNone, UITextAutocapitalizationTypeWords, UITextAutocapitalizationTypeSentences, UITextAutocapitalizationTypeAllCharacters,
 */
@property(nonatomic) UITextAutocapitalizationType autocapitalizationType;
/*
UITextAutocorrectionTypeDefault, UITextAutocorrectionTypeNo, UITextAutocorrectionTypeYes
 */
@property(nonatomic) UITextAutocorrectionType autocorrectionType;
/*
UITextSpellCheckingTypeDefault, UITextSpellCheckingTypeNo, UITextSpellCheckingTypeYes
 */
@property(nonatomic) UITextSpellCheckingType spellCheckingType;
/*
UIKeyboardTypeDefault, UIKeyboardTypeASCIICapable, UIKeyboardTypeNumbersAndPunctuation, UIKeyboardTypeURL, UIKeyboardTypeNumberPad, UIKeyboardTypePhonePad, UIKeyboardTypeNamePhonePad, UIKeyboardTypeEmailAddress, UIKeyboardTypeDecimalPad, UIKeyboardTypeTwitter, UIKeyboardTypeWebSearch
 */
@property(nonatomic) UIKeyboardType keyboardType;
/*
UIKeyboardAppearanceDefault, UIKeyboardAppearanceDark, UIKeyboardAppearanceLight
 */
@property(nonatomic) UIKeyboardAppearance keyboardAppearance;
/*
UIReturnKeyDefault, UIReturnKeyGo, UIReturnKeyGoogle, UIReturnKeyJoin, UIReturnKeyNext, UIReturnKeyRoute, UIReturnKeySearch, UIReturnKeySend, UIReturnKeyYahoo, UIReturnKeyDone, UIReturnKeyEmergencyCall
 */
@property(nonatomic) UIReturnKeyType returnKeyType;
@property(nonatomic) BOOL enablesReturnKeyAutomatically;                  // default is NO (when YES, will automatically disable return key when text widget has zero-length contents, and will automatically enable when text widget has non-zero-length contents)
@property(nonatomic/*,getter=isSecureTextEntry*/) BOOL secureTextEntry;       // default is NO

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end
