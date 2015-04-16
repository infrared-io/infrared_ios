//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import "IRView.h"


@protocol IRProgressViewExport <JSExport>

@property(nonatomic) UIProgressViewStyle progressViewStyle; // default is UIProgressViewStyleDefault
@property(nonatomic) float progress;                        // 0.0 .. 1.0, default is 0.0. values outside are pinned.
@property(nonatomic, retain) UIColor* progressTintColor     NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property(nonatomic, retain) UIColor* trackTintColor     NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property(nonatomic, retain) UIImage* progressImage NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property(nonatomic, retain) UIImage* trackImage NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;

- (void)setProgress:(float)progress animated:(BOOL)animated NS_AVAILABLE_IOS(5_0);

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRProgressView : UIProgressView <IRComponentInfoProtocol, IRProgressViewExport, IRViewExport>


@end