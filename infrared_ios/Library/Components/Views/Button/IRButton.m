//
//  IRButton.m
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRButton.h"
#import "IRBaseBuilder+UIControl.h"
#import "IRBaseDescriptor.h"
#import "IRDataController.h"
#import "IRButtonDescriptor.h"

@implementation IRButton

@synthesize componentInfo;
@synthesize descriptor;

+ (id) buttonWithType:(UIButtonType)buttonType
{
    UIButton *button = [super buttonWithType:buttonType];
    if (button) {
        [IRBaseBuilder setUIControlTargetInterceptor:button];
    }
    return button;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Subview methods

- (void)removeFromSuperview
{
    [[IRDataController sharedInstance] unregisterView:self];

    [super removeFromSuperview];
}
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
    [super insertSubview:view atIndex:index];

    if ([view conformsToProtocol:@protocol(IRComponentInfoProtocol)] && ((IRView *)view).descriptor.jsInit) {
        [[IRDataController sharedInstance] registerView:(IRView *) view inSameScreenAsParentView:self];
    }
}
- (void)addSubview:(UIView *)view
{
    [super addSubview:view];

    if ([view conformsToProtocol:@protocol(IRComponentInfoProtocol)] && ((IRView *)view).descriptor.jsInit) {
        [[IRDataController sharedInstance] registerView:(IRView *) view inSameScreenAsParentView:self];
    }
}
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview
{
    [super insertSubview:view belowSubview:siblingSubview];

    if ([view conformsToProtocol:@protocol(IRComponentInfoProtocol)] && ((IRView *)view).descriptor.jsInit) {
        [[IRDataController sharedInstance] registerView:(IRView *) view inSameScreenAsParentView:self];
    }
}
- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview
{
    [super insertSubview:view aboveSubview:siblingSubview];

    if ([view conformsToProtocol:@protocol(IRComponentInfoProtocol)] && ((IRView *)view).descriptor.jsInit) {
        [[IRDataController sharedInstance] registerView:(IRView *) view inSameScreenAsParentView:self];
    }
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Create

+ (id) createWithType:(UIButtonType)buttonType componentId:(NSString *)componentId
{
    IRButton *irButton = [IRButton buttonWithType:buttonType];
    irButton.descriptor = [[IRButtonDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irButton];
    return irButton;
}

+ (id) createWithComponentId:(NSString *)componentId
{
    return [IRButton createWithType:UIButtonTypeCustom componentId:componentId];
}

- (NSString *) componentId
{
    return self.descriptor.componentId;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Additional properties from Descriptor

- (NSString *) normalTitle
{
    return [self titleForState:UIControlStateNormal];
}
- (void) setNormalTitle:(NSString *)normalTitle
{
    [self setTitle:normalTitle forState:UIControlStateNormal];
}
- (UIColor *) normalTitleColor
{
    return [self titleColorForState:UIControlStateNormal];
}
- (void) setNormalTitleColor:(UIColor *)normalTitleColor
{
    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
}
- (UIColor *) normalTitleShadowColor
{
    return [self titleShadowColorForState:UIControlStateNormal];
}
- (void) setNormalTitleShadowColor:(UIColor *)normalTitleShadowColor
{
    [self setTitleShadowColor:normalTitleShadowColor forState:UIControlStateNormal];
}
- (UIImage *) normalImage
{
    return [self imageForState:UIControlStateNormal];
}
- (void) setNormalImage:(UIImage *)normalImage
{
    [self setImage:normalImage forState:UIControlStateNormal];
}
- (UIImage *) normalBackgroundImage
{
    return [self backgroundImageForState:UIControlStateNormal];
}
- (void) setNormalBackgroundImage:(UIImage *)normalBackgroundImage
{
    [self setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
}
// --------------------------------------------------------------------------------------------------------------------
- (NSString *) highlightedTitle
{
    return [self titleForState:UIControlStateHighlighted];
}
- (void) setHighlightedTitle:(NSString *)highlightedTitle
{
    [self setTitle:highlightedTitle forState:UIControlStateHighlighted];
}
- (UIColor *) highlightedTitleColor
{
    return [self titleColorForState:UIControlStateHighlighted];
}
- (void) setHighlightedTitleColor:(UIColor *)highlightedTitleColor
{
    [self setTitleColor:highlightedTitleColor forState:UIControlStateHighlighted];
}
- (UIColor *) highlightedTitleShadowColor
{
    return [self titleShadowColorForState:UIControlStateHighlighted];
}
- (void) setHighlightedTitleShadowColor:(UIColor *)highlightedTitleShadowColor
{
    [self setTitleShadowColor:highlightedTitleShadowColor forState:UIControlStateHighlighted];
}
- (UIImage *) highlightedImage
{
    return [self imageForState:UIControlStateHighlighted];
}
- (void) setHighlightedImage:(UIImage *)highlightedImage
{
    [self setImage:highlightedImage forState:UIControlStateHighlighted];
}
- (UIImage *) highlightedBackgroundImage
{
    return [self backgroundImageForState:UIControlStateHighlighted];
}
- (void) setHighlightedBackgroundImage:(UIImage *)highlightedBackgroundImage
{
    [self setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];
}
// --------------------------------------------------------------------------------------------------------------------
- (NSString *) selectedTitle
{
    return [self titleForState:UIControlStateSelected];
}
- (void) setSelectedTitle:(NSString *)selectedTitle
{
    [self setTitle:selectedTitle forState:UIControlStateSelected];
}
- (UIColor *) selectedTitleColor
{
    return [self titleColorForState:UIControlStateSelected];
}
- (void) setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
}
- (UIColor *) selectedTitleShadowColor
{
    return [self titleShadowColorForState:UIControlStateSelected];
}
- (void) setSelectedTitleShadowColor:(UIColor *)selectedTitleShadowColor
{
    [self setTitleShadowColor:selectedTitleShadowColor forState:UIControlStateSelected];
}
- (UIImage *) selectedImage
{
    return [self imageForState:UIControlStateSelected];
}
- (void) setSelectedImage:(UIImage *)selectedImage
{
    [self setImage:selectedImage forState:UIControlStateSelected];
}
- (UIImage *) selectedBackgroundImage
{
    return [self backgroundImageForState:UIControlStateSelected];
}
- (void) setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage
{
    [self setBackgroundImage:selectedBackgroundImage forState:UIControlStateSelected];
}
// --------------------------------------------------------------------------------------------------------------------
- (NSString *) disabledTitle
{
    return [self titleForState:UIControlStateDisabled];
}
- (void) setDisabledTitle:(NSString *)disabledTitle
{
    [self setTitle:disabledTitle forState:UIControlStateDisabled];
}
- (UIColor *) disabledTitleColor
{
    return [self titleColorForState:UIControlStateDisabled];
}
- (void) setDisabledTitleColor:(UIColor *)disabledTitleColor
{
    [self setTitleColor:disabledTitleColor forState:UIControlStateDisabled];
}
- (UIColor *) disabledTitleShadowColor
{
    return [self titleShadowColorForState:UIControlStateDisabled];
}
- (void) setDisabledTitleShadowColor:(UIColor *)disabledTitleShadowColor
{
    [self setTitleShadowColor:disabledTitleShadowColor forState:UIControlStateDisabled];
}
- (UIImage *) disabledImage
{
    return [self imageForState:UIControlStateDisabled];
}
- (void) setDisabledImage:(UIImage *)disabledImage
{
    [self setImage:disabledImage forState:UIControlStateDisabled];
}
- (UIImage *) disabledBackgroundImage
{
    return [self backgroundImageForState:UIControlStateDisabled];
}
- (void) setDisabledBackgroundImage:(UIImage *)disabledBackgroundImage
{
    [self setBackgroundImage:disabledBackgroundImage forState:UIControlStateDisabled];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (CGSize) titleShadowOffset
{
    return self.titleLabel.shadowOffset;
}
- (void) setTitleShadowOffset:(CGSize)titleShadowOffset
{
    self.titleLabel.shadowOffset = titleShadowOffset;
}
// --------------------------------------------------------------------------------------------------------------------
- (NSLineBreakMode) lineBreakMode
{
    return self.titleLabel.lineBreakMode;
}
- (void) setLineBreakMode:(NSLineBreakMode)lineBreakMode
{
    self.titleLabel.lineBreakMode = lineBreakMode;
}
// --------------------------------------------------------------------------------------------------------------------
- (UIFont *) font
{
    return self.titleLabel.font;
}
- (void) setFont:(UIFont *)font
{
    self.titleLabel.font = font;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - UIControlIRExtension

- (NSString *) touchDownActions
{
    return ((id <UIControlIRExtension>)self.descriptor).touchDownActions;
}
- (void) setTouchDownActions:(NSString *)touchDownActions
{
    ((id <UIControlIRExtension>)self.descriptor).touchDownActions = touchDownActions;
}

- (NSString *) touchDownRepeatActions
{
    return ((id <UIControlIRExtension>)self.descriptor).touchDownRepeatActions;
}
- (void) setTouchDownRepeatActions:(NSString *)touchDownRepeatActions
{
    ((id <UIControlIRExtension>)self.descriptor).touchDownRepeatActions = touchDownRepeatActions;
}

- (NSString *) touchDragInsideActions
{
    return ((id <UIControlIRExtension>)self.descriptor).touchDragInsideActions;
}
- (void) setTouchDragInsideActions:(NSString *)touchDragInsideActions
{
    ((id <UIControlIRExtension>)self.descriptor).touchDragInsideActions = touchDragInsideActions;
}

- (NSString *) touchDragOutsideActions
{
    return ((id <UIControlIRExtension>)self.descriptor).touchDragOutsideActions;
}
- (void) setTouchDragOutsideActions:(NSString *)touchDragOutsideActions
{
    ((id <UIControlIRExtension>)self.descriptor).touchDragOutsideActions = touchDragOutsideActions;
}

- (NSString *) touchDragEnterActions
{
    return ((id <UIControlIRExtension>)self.descriptor).touchDragEnterActions;
}
- (void) setTouchDragEnterActions:(NSString *)touchDragEnterActions
{
    ((id <UIControlIRExtension>)self.descriptor).touchDragEnterActions = touchDragEnterActions;
}

- (NSString *) touchDragExitActions
{
    return ((id <UIControlIRExtension>)self.descriptor).touchDragExitActions;
}
- (void) setTouchDragExitActions:(NSString *)touchDragExitActions
{
    ((id <UIControlIRExtension>)self.descriptor).touchDragExitActions = touchDragExitActions;
}

- (NSString *) touchUpInsideActions
{
    return ((id <UIControlIRExtension>)self.descriptor).touchUpInsideActions;
}
- (void) setTouchUpInsideActions:(NSString *)touchUpInsideActions
{
    ((id <UIControlIRExtension>)self.descriptor).touchUpInsideActions = touchUpInsideActions;
}

- (NSString *) touchUpOutsideActions
{
    return ((id <UIControlIRExtension>)self.descriptor).touchUpOutsideActions;
}
- (void) setTouchUpOutsideActions:(NSString *)touchUpOutsideActions
{
    ((id <UIControlIRExtension>)self.descriptor).touchUpOutsideActions = touchUpOutsideActions;
}

- (NSString *) touchCancelActions
{
    return ((id <UIControlIRExtension>)self.descriptor).touchCancelActions;
}
- (void) setTouchCancelActions:(NSString *)touchCancelActions
{
    ((id <UIControlIRExtension>)self.descriptor).touchCancelActions = touchCancelActions;
}

- (NSString *) valueChangedActions
{
    return ((id <UIControlIRExtension>)self.descriptor).valueChangedActions;
}
- (void) setValueChangedActions:(NSString *)valueChangedActions
{
    ((id <UIControlIRExtension>)self.descriptor).valueChangedActions = valueChangedActions;
}

- (NSString *) editingDidBeginActions
{
    return ((id <UIControlIRExtension>)self.descriptor).editingDidBeginActions;
}
- (void) setEditingDidBeginActions:(NSString *)editingDidBeginActions
{
    ((id <UIControlIRExtension>)self.descriptor).editingDidBeginActions = editingDidBeginActions;
}

- (NSString *) editingChangedActions
{
    return ((id <UIControlIRExtension>)self.descriptor).editingChangedActions;
}
- (void) setEditingChangedActions:(NSString *)editingChangedActions
{
    ((id <UIControlIRExtension>)self.descriptor).editingChangedActions = editingChangedActions;
}

- (NSString *) editingDidEndActions
{
    return ((id <UIControlIRExtension>)self.descriptor).editingDidEndActions;
}
- (void) setEditingDidEndActions:(NSString *)editingDidEndActions
{
    ((id <UIControlIRExtension>)self.descriptor).editingDidEndActions = editingDidEndActions;
}

- (NSString *) editingDidEndOnExitActions
{
    return ((id <UIControlIRExtension>)self.descriptor).editingDidEndOnExitActions;
}
- (void) setEditingDidEndOnExitActions:(NSString *)editingDidEndOnExitActions
{
    ((id <UIControlIRExtension>)self.descriptor).editingDidEndOnExitActions = editingDidEndOnExitActions;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
