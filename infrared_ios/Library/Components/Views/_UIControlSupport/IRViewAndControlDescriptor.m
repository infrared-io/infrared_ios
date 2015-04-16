//
//  IRViewAndControlDescriptor.m
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRViewAndControlDescriptor.h"

@implementation IRViewAndControlDescriptor

@synthesize touchDownActions;
@synthesize touchDownRepeatActions;
@synthesize touchDragInsideActions;
@synthesize touchDragOutsideActions;
@synthesize touchDragEnterActions;
@synthesize touchDragExitActions;
@synthesize touchUpInsideActions;
@synthesize touchUpOutsideActions;
@synthesize touchCancelActions;
@synthesize valueChangedActions;
@synthesize editingDidBeginActions;
@synthesize editingChangedActions;
@synthesize editingDidEndActions;
@synthesize editingDidEndOnExitActions;

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;

        // contentHorizontalAlignment
        string = aDictionary[NSStringFromSelector(@selector(contentHorizontalAlignment))];
        self.contentHorizontalAlignment = [IRBaseDescriptor contentHorizontalAlignmentFromString:string];

        // contentVerticalAlignment
        string = aDictionary[NSStringFromSelector(@selector(contentVerticalAlignment))];
        self.contentVerticalAlignment = [IRBaseDescriptor contentVerticalAlignmentFromString:string];

        // selected
        number = aDictionary[NSStringFromSelector(@selector(selected))];
        if (number) {
            self.selected = [number boolValue];
        } else {
            self.selected = NO;
        }

        // enabled
        number = aDictionary[NSStringFromSelector(@selector(enabled))];
        if (number) {
            self.enabled = [number boolValue];
        } else {
            self.enabled = YES;
        }

        // highlighted
        number = aDictionary[NSStringFromSelector(@selector(highlighted))];
        if (number) {
            self.highlighted = [number boolValue];
        } else {
            self.highlighted = NO;
        }

        // touchDownActions
        string = aDictionary[NSStringFromSelector(@selector(touchDownActions))];
        self.touchDownActions = string;

        // touchDownRepeatActions
        string = aDictionary[NSStringFromSelector(@selector(touchDownRepeatActions))];
        self.touchDownRepeatActions = string;

        // touchDragInsideActions
        string = aDictionary[NSStringFromSelector(@selector(touchDragInsideActions))];
        self.touchDragInsideActions = string;

        // touchDragOutsideActions
        string = aDictionary[NSStringFromSelector(@selector(touchDragOutsideActions))];
        self.touchDragOutsideActions = string;

        // touchDragEnterActions
        string = aDictionary[NSStringFromSelector(@selector(touchDragEnterActions))];
        self.touchDragEnterActions = string;

        // touchDragExitActions
        string = aDictionary[NSStringFromSelector(@selector(touchDragExitActions))];
        self.touchDragExitActions = string;

        // touchUpInsideActions
        string = aDictionary[NSStringFromSelector(@selector(touchUpInsideActions))];
        self.touchUpInsideActions = string;

        // touchUpOutsideActions
        string = aDictionary[NSStringFromSelector(@selector(touchUpOutsideActions))];
        self.touchUpOutsideActions = string;

        // touchCancelActions
        string = aDictionary[NSStringFromSelector(@selector(touchCancelActions))];
        self.touchCancelActions = string;

        // valueChangedActions
        string = aDictionary[NSStringFromSelector(@selector(valueChangedActions))];
        self.valueChangedActions = string;

        // editingDidBeginActions
        string = aDictionary[NSStringFromSelector(@selector(editingDidBeginActions))];
        self.editingDidBeginActions = string;

        // editingChangedActions
        string = aDictionary[NSStringFromSelector(@selector(editingChangedActions))];
        self.editingChangedActions = string;

        // editingDidEndActions
        string = aDictionary[NSStringFromSelector(@selector(editingDidEndActions))];
        self.editingDidEndActions = string;

        // editingDidEndOnExitActions
        string = aDictionary[NSStringFromSelector(@selector(editingDidEndOnExitActions))];
        self.editingDidEndOnExitActions = string;
    }
    return self;
}

@end
