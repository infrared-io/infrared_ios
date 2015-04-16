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
    NSLog(@"For creating Button use 'createWithTypeComponentId' instead of 'createWithComponentId:'");
    return nil;
}

- (NSString *) componentId
{
    return self.descriptor.componentId;
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
