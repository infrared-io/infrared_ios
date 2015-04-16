//
// Created by Uros Milivojevic on 4/9/15.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol UIControlIRExtension <NSObject>

/*
Event types:
 UIControlEventTouchDown, UIControlEventTouchDownRepeat, UIControlEventTouchDragInside, UIControlEventTouchDragOutside, UIControlEventTouchDragEnter, UIControlEventTouchDragExit, UIControlEventTouchUpInside, UIControlEventTouchUpOutside, UIControlEventTouchCancel, UIControlEventValueChanged, UIControlEventEditingDidBegin, UIControlEventEditingChanged, UIControlEventEditingDidEnd, UIControlEventEditingDidEndOnExit

Controls can use 3 types of selectors to respond to actions, all of them have predefined meaning of their parameters:
1) with no parameters
    action:@selector(action)
2) with 1 parameter indicating the control that sends the message
    action:@selector(action:)
3) With 2 parameters indicating the control that sends the message and the event that triggered the message:
    action:@selector(action:withEvent:)

Example:
   -(void)action:(UIControl *)sender withEvent:(UIEvent *)event;
 */

@property(nonatomic, strong) NSString *touchDownActions;
@property(nonatomic, strong) NSString *touchDownRepeatActions;
@property(nonatomic, strong) NSString *touchDragInsideActions;
@property(nonatomic, strong) NSString *touchDragOutsideActions;
@property(nonatomic, strong) NSString *touchDragEnterActions;
@property(nonatomic, strong) NSString *touchDragExitActions;
@property(nonatomic, strong) NSString *touchUpInsideActions;
@property(nonatomic, strong) NSString *touchUpOutsideActions;
@property(nonatomic, strong) NSString *touchCancelActions;
@property(nonatomic, strong) NSString *valueChangedActions;
@property(nonatomic, strong) NSString *editingDidBeginActions;
@property(nonatomic, strong) NSString *editingChangedActions;
@property(nonatomic, strong) NSString *editingDidEndActions;
@property(nonatomic, strong) NSString *editingDidEndOnExitActions;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@protocol UIControlIRExtensionExport <JSExport>

@property(nonatomic, strong) NSString *touchDownActions;
@property(nonatomic, strong) NSString *touchDownRepeatActions;
@property(nonatomic, strong) NSString *touchDragInsideActions;
@property(nonatomic, strong) NSString *touchDragOutsideActions;
@property(nonatomic, strong) NSString *touchDragEnterActions;
@property(nonatomic, strong) NSString *touchDragExitActions;
@property(nonatomic, strong) NSString *touchUpInsideActions;
@property(nonatomic, strong) NSString *touchUpOutsideActions;
@property(nonatomic, strong) NSString *touchCancelActions;
@property(nonatomic, strong) NSString *valueChangedActions;
@property(nonatomic, strong) NSString *editingDidBeginActions;
@property(nonatomic, strong) NSString *editingChangedActions;
@property(nonatomic, strong) NSString *editingDidEndActions;
@property(nonatomic, strong) NSString *editingDidEndOnExitActions;

@end

