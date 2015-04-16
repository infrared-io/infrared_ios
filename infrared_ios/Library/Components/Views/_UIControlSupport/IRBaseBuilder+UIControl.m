//
// Created by Uros Milivojevic on 10/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRBaseBuilder+UIControl.h"
#import "IRViewAndControlDescriptor.h"
#import "IRView.h"
#import "IRDataController.h"

@implementation IRBaseBuilder (UIControl)

+ (void)setUIControlTargetInterceptor:(UIControl *)uiControl
{
    [uiControl addTarget:[IRBaseBuilder class] action:@selector(TouchDownAction:withEvent:) forControlEvents:UIControlEventTouchDown];
    [uiControl addTarget:[IRBaseBuilder class] action:@selector(TouchDownRepeatAction:withEvent:) forControlEvents:UIControlEventTouchDownRepeat];
    [uiControl addTarget:[IRBaseBuilder class] action:@selector(TouchDragInsideAction:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [uiControl addTarget:[IRBaseBuilder class] action:@selector(TouchDragOutsideAction:withEvent:) forControlEvents:UIControlEventTouchDragOutside];
    [uiControl addTarget:[IRBaseBuilder class] action:@selector(TouchDragEnterAction:withEvent:) forControlEvents:UIControlEventTouchDragEnter];
    [uiControl addTarget:[IRBaseBuilder class] action:@selector(TouchDragExitAction:withEvent:) forControlEvents:UIControlEventTouchDragExit];
    [uiControl addTarget:[IRBaseBuilder class] action:@selector(TouchUpInsideAction:withEvent:) forControlEvents:UIControlEventTouchUpInside];
    [uiControl addTarget:[IRBaseBuilder class] action:@selector(TouchUpOutsideAction:withEvent:) forControlEvents:UIControlEventTouchUpOutside];
    [uiControl addTarget:[IRBaseBuilder class] action:@selector(TouchCancelAction:withEvent:) forControlEvents:UIControlEventTouchCancel];
    [uiControl addTarget:[IRBaseBuilder class] action:@selector(ValueChangedAction:withEvent:) forControlEvents:UIControlEventValueChanged];
    [uiControl addTarget:[IRBaseBuilder class] action:@selector(EditingDidBeginAction:withEvent:) forControlEvents:UIControlEventEditingDidBegin];
    [uiControl addTarget:[IRBaseBuilder class] action:@selector(EditingChangedAction:withEvent:) forControlEvents:UIControlEventEditingChanged];
    [uiControl addTarget:[IRBaseBuilder class] action:@selector(EditingDidEndAction:withEvent:) forControlEvents:UIControlEventEditingDidEnd];
    [uiControl addTarget:[IRBaseBuilder class] action:@selector(EditingDidEndOnExitAction:withEvent:) forControlEvents:UIControlEventEditingDidEndOnExit];
}
// --------------------------------------------------------------------------------------------------------------------
+ (void)TouchDownAction:(UIControl *)uiControl withEvent:(UIEvent *)uiEvent
{
    IRViewAndControlDescriptor *descriptor = (IRViewAndControlDescriptor *) ((id<IRComponentInfoProtocol>)uiControl).descriptor;
    NSString *action = descriptor.touchDownActions;
    [IRBaseBuilder executeAction:action withControl:uiControl andEvent:uiEvent];
}
+ (void)TouchDownRepeatAction:(UIControl *)uiControl withEvent:(UIEvent *)uiEvent
{
    IRViewAndControlDescriptor *descriptor = (IRViewAndControlDescriptor *) ((id<IRComponentInfoProtocol>)uiControl).descriptor;
    NSString *action = descriptor.touchDownRepeatActions;
    [IRBaseBuilder executeAction:action withControl:uiControl andEvent:uiEvent];
}
+ (void)TouchDragInsideAction:(UIControl *)uiControl withEvent:(UIEvent *)uiEvent
{
    IRViewAndControlDescriptor *descriptor = (IRViewAndControlDescriptor *) ((id<IRComponentInfoProtocol>)uiControl).descriptor;
    NSString *action = descriptor.touchDragInsideActions;
    [IRBaseBuilder executeAction:action withControl:uiControl andEvent:uiEvent];
}
+ (void)TouchDragOutsideAction:(UIControl *)uiControl withEvent:(UIEvent *)uiEvent
{
    IRViewAndControlDescriptor *descriptor = (IRViewAndControlDescriptor *) ((id<IRComponentInfoProtocol>)uiControl).descriptor;
    NSString *action = descriptor.touchDragOutsideActions;
    [IRBaseBuilder executeAction:action withControl:uiControl andEvent:uiEvent];
}
+ (void)TouchDragEnterAction:(UIControl *)uiControl withEvent:(UIEvent *)uiEvent
{
    IRViewAndControlDescriptor *descriptor = (IRViewAndControlDescriptor *) ((id<IRComponentInfoProtocol>)uiControl).descriptor;
    NSString *action = descriptor.touchDragEnterActions;
    [IRBaseBuilder executeAction:action withControl:uiControl andEvent:uiEvent];
}
+ (void)TouchDragExitAction:(UIControl *)uiControl withEvent:(UIEvent *)uiEvent
{
    IRViewAndControlDescriptor *descriptor = (IRViewAndControlDescriptor *) ((id<IRComponentInfoProtocol>)uiControl).descriptor;
    NSString *action = descriptor.touchDragExitActions;
    [IRBaseBuilder executeAction:action withControl:uiControl andEvent:uiEvent];
}
+ (void)TouchUpInsideAction:(UIControl *)uiControl withEvent:(UIEvent *)uiEvent
{
    IRViewAndControlDescriptor *descriptor = (IRViewAndControlDescriptor *) ((id<IRComponentInfoProtocol>)uiControl).descriptor;
    NSString *action = descriptor.touchUpInsideActions;
    [IRBaseBuilder executeAction:action withControl:uiControl andEvent:uiEvent];
}
+ (void)TouchUpOutsideAction:(UIControl *)uiControl withEvent:(UIEvent *)uiEvent
{
    IRViewAndControlDescriptor *descriptor = (IRViewAndControlDescriptor *) ((id<IRComponentInfoProtocol>)uiControl).descriptor;
    NSString *action = descriptor.touchUpOutsideActions;
    [IRBaseBuilder executeAction:action withControl:uiControl andEvent:uiEvent];
}
+ (void)TouchCancelAction:(UIControl *)uiControl withEvent:(UIEvent *)uiEvent
{
    IRViewAndControlDescriptor *descriptor = (IRViewAndControlDescriptor *) ((id<IRComponentInfoProtocol>)uiControl).descriptor;
    NSString *action = descriptor.touchCancelActions;
    [IRBaseBuilder executeAction:action withControl:uiControl andEvent:uiEvent];
}
+ (void)ValueChangedAction:(UIControl *)uiControl withEvent:(UIEvent *)uiEvent
{
    IRViewAndControlDescriptor *descriptor = (IRViewAndControlDescriptor *) ((id<IRComponentInfoProtocol>)uiControl).descriptor;
    NSString *action = descriptor.valueChangedActions;
    [IRBaseBuilder executeAction:action withControl:uiControl andEvent:uiEvent];
}
+ (void)EditingDidBeginAction:(UIControl *)uiControl withEvent:(UIEvent *)uiEvent
{
    IRViewAndControlDescriptor *descriptor = (IRViewAndControlDescriptor *) ((id<IRComponentInfoProtocol>)uiControl).descriptor;
    NSString *action = descriptor.editingDidBeginActions;
    [IRBaseBuilder executeAction:action withControl:uiControl andEvent:uiEvent];
}
+ (void)EditingChangedAction:(UIControl *)uiControl withEvent:(UIEvent *)uiEvent
{
    IRViewAndControlDescriptor *descriptor = (IRViewAndControlDescriptor *) ((id<IRComponentInfoProtocol>)uiControl).descriptor;
    NSString *action = descriptor.editingChangedActions;
    [IRBaseBuilder executeAction:action withControl:uiControl andEvent:uiEvent];
}
+ (void)EditingDidEndAction:(UIControl *)uiControl withEvent:(UIEvent *)uiEvent
{
    IRViewAndControlDescriptor *descriptor = (IRViewAndControlDescriptor *) ((id<IRComponentInfoProtocol>)uiControl).descriptor;
    NSString *action = descriptor.editingDidEndActions;
    [IRBaseBuilder executeAction:action withControl:uiControl andEvent:uiEvent];
}
+ (void)EditingDidEndOnExitAction:(UIControl *)uiControl withEvent:(UIEvent *)uiEvent
{
    IRViewAndControlDescriptor *descriptor = (IRViewAndControlDescriptor *) ((id<IRComponentInfoProtocol>)uiControl).descriptor;
    NSString *action = descriptor.editingDidEndOnExitActions;
    [IRBaseBuilder executeAction:action withControl:uiControl andEvent:uiEvent];
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

+ (void)executeAction:(NSString *)action withControl:(UIControl *)uiControl andEvent:(UIEvent *)uiEvent
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (uiControl) {
        dictionary[@"control"] = uiControl;
    }
    if (uiEvent) {
        dictionary[@"event"] = uiEvent;
    }
    if ([uiControl conformsToProtocol:@protocol(IRComponentInfoProtocol)]) {
        NSDictionary *componentInfo = ((id<IRComponentInfoProtocol>)uiControl).componentInfo;
        if (componentInfo[typeTableViewKEY]) {
            dictionary[@"tableView"] = componentInfo[typeTableViewKEY];
        }
        if (componentInfo[indexPathKEY]) {
            dictionary[@"indexPath"] = componentInfo[indexPathKEY];
        }
        if (componentInfo[@"data"]) {
            dictionary[@"data"] = componentInfo[@"data"];
        }
        if (componentInfo) {
            dictionary[@"extra"] = componentInfo;
        }
    }
    [IRBaseBuilder executeAction:action withDictionary:dictionary sourceView:uiControl];
}

@end