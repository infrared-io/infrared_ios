//
// Created by Uros Milivojevic on 7/21/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSExport;

@protocol UISwitchExport <JSExport>

@property(nonatomic, retain) UIColor *onTintColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property(nonatomic, retain) UIColor *tintColor NS_AVAILABLE_IOS(6_0);
@property(nonatomic, retain) UIColor *thumbTintColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;

@property(nonatomic, retain) UIImage *onImage NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
@property(nonatomic, retain) UIImage *offImage NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;

@property(nonatomic,getter=isOn) BOOL on;

- (void)setOn:(BOOL)on animated:(BOOL)animated; // does not send action

@end