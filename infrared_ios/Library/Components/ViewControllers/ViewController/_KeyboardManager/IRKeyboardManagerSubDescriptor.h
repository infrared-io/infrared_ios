//
// Created by Uros Milivojevic on 4/2/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IQKeyboardManager/IQKeyboardManagerConstants.h>


@interface IRKeyboardManagerSubDescriptor : NSObject

/*!
    @property enable

    @abstract enable/disable managing distance between keyboard and textField. Default is YES(Enabled when class loads in `+(void)load` method).
 */
@property(nonatomic, assign) BOOL enable;

/*!
    @property keyboardDistanceFromTextField

    @abstract To set keyboard distance from textField. can't be less than zero. Default is 10.0.
 */
@property(nonatomic, assign) CGFloat keyboardDistanceFromTextField;

/*!
    @property preventShowingBottomBlankSpace

    @abstract Prevent keyboard manager to slide up the rootView to more than keyboard height. Default is YES.
 */
@property(nonatomic, assign) BOOL preventShowingBottomBlankSpace;


/*******************************************/


//IQToolbar handling

/*!
    @property enableAutoToolbar

    @abstract Automatic add the IQToolbar functionality. Default is YES.
 */
@property(nonatomic, assign) BOOL enableAutoToolbar;

/*!
    @property toolbarManageStyle

    @abstract AutoToolbar managing behaviour. Default is IQAutoToolbarBySubviews.
 */
@property(nonatomic, assign) IQAutoToolbarManageBehaviour toolbarManageBehaviour;

/*!
    @property shouldToolbarUsesTextFieldTintColor

    @abstract If YES, then uses textField's tintColor property for IQToolbar, otherwise tint color is black. Default is NO.
 */
@property(nonatomic, assign) BOOL shouldToolbarUsesTextFieldTintColor   NS_AVAILABLE_IOS(7_0);

/*!
    @property shouldShowTextFieldPlaceholder

    @abstract If YES, then it add the textField's placeholder text on IQToolbar. Default is YES.
 */
@property(nonatomic, assign) BOOL shouldShowTextFieldPlaceholder;

/*!
    @property placeholderFont

    @abstract Placeholder Font. Default is nil.
 */
@property(nonatomic, strong) UIFont *placeholderFont;


/*******************************************/


//UITextView handling

/*!
    @property canAdjustTextView

    @abstract Adjust textView's frame when it is too big in height. Default is NO.
 */
@property(nonatomic, assign) BOOL canAdjustTextView;

/*!
    @property shouldFixTextViewClip

    @abstract Adjust textView's contentInset to fix fix for iOS 7.0.x - http://stackoverflow.com/questions/18966675/uitextview-in-ios7-clips-the-last-line-of-text-string Default is YES.
 */
@property(nonatomic, assign) BOOL shouldFixTextViewClip;


/*******************************************/


//UIKeyboard appearance overriding

/*!
    @property overrideKeyboardAppearance

    @abstract Override the keyboardAppearance for all textField/textView. Default is NO.
 */
@property(nonatomic, assign) BOOL overrideKeyboardAppearance;

/*!
    @property keyboardAppearance

    @abstract If overrideKeyboardAppearance is YES, then all the textField keyboardAppearance is set using this property.
 */
@property(nonatomic, assign) UIKeyboardAppearance keyboardAppearance;


/*******************************************/


//UITextField/UITextView Resign handling

/*!
    @property shouldResignOnTouchOutside

    @abstract Resigns Keyboard on touching outside of UITextField/View. Default is NO.
 */
@property(nonatomic, assign) BOOL shouldResignOnTouchOutside;


/*******************************************/


//UISound handling

/*!
    @property shouldPlayInputClicks

    @abstract If YES, then it plays inputClick sound on next/previous/done click.
 */
@property(nonatomic, assign) BOOL shouldPlayInputClicks;


/*******************************************/


//UIAnimation handling

/*!
    @property shouldAdoptDefaultKeyboardAnimation

    @abstract If YES, then uses keyboard default animation curve style to move view, otherwise uses UIViewAnimationOptionCurveEaseInOut animation style. Default is YES.

    @discussion Sometimes strange animations may be produced if uses default curve style animation in iOS 7 and changing the textFields very frequently.
 */
@property(nonatomic, assign) BOOL shouldAdoptDefaultKeyboardAnimation;


/*******************************************/


- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end