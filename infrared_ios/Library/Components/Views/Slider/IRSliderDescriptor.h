//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewAndControlDescriptor.h"


@interface IRSliderDescriptor : IRViewAndControlDescriptor

@property(nonatomic) float value;                                 // default 0.0. this value will be pinned to min/max
@property(nonatomic) float minimumValue;                          // default 0.0. the current value may change if outside new min value
@property(nonatomic) float maximumValue;                          // default 1.0. the current value may change if outside new max value

@property(nonatomic,retain) NSString *minimumValueImage;          // default is nil. image that appears to left of control (e.g. speaker off)
@property(nonatomic,retain) NSString *maximumValueImage;          // default is nil. image that appears to right of control (e.g. speaker max)

@property(nonatomic/*,getter=isContinuous*/) BOOL continuous;        // if set, value change events are generated any time the value changes due to dragging. default = YES

#if TARGET_OS_IPHONE
@property(nonatomic,retain) UIColor *minimumTrackTintColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property(nonatomic,retain) UIColor *maximumTrackTintColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property(nonatomic,retain) UIColor *thumbTintColor NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
#endif

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end