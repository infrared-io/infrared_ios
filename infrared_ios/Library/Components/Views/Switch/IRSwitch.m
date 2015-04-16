//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRSwitch.h"
#import "IRBaseBuilder.h"
#import "IRBaseBuilder+UIControl.h"
#import "IRBaseDescriptor.h"
#import "IRDataController.h"
#import "IRSwitchDescriptor.h"


@implementation IRSwitch

@synthesize componentInfo;
@synthesize descriptor;

- (id)init
{
    self = [super init];
    if (self) {
        [IRBaseBuilder setUIControlTargetInterceptor:self];
    }
    return self;
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

+ (id) createWithComponentId:(NSString *)componentId
{
    IRSwitch *irSwitch = [[IRSwitch alloc] init];
    irSwitch.descriptor = [[IRSwitchDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irSwitch];
    return irSwitch;
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

@end