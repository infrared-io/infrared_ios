//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewDescriptor.h"


@interface IRProgressViewDescriptor : IRViewDescriptor

#if TARGET_OS_IPHONE
@property(nonatomic) UIProgressViewStyle progressViewStyle; // default is UIProgressViewStyleDefault
#endif
@property(nonatomic) float progress;                        // 0.0 .. 1.0, default is 0.0. values outside are pinned.
#if TARGET_OS_IPHONE
@property(nonatomic, retain) UIColor* progressTintColor     NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
@property(nonatomic, retain) UIColor* trackTintColor     NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
#endif
@property(nonatomic, retain) NSString* progressImage /*NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR*/;
@property(nonatomic, retain) NSString* trackImage /*NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR*/;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end