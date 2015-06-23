//
// Created by Uros Milivojevic on 12/17/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRTableViewBuilder.h"

@class IRView;
@class IRTableViewCell;
@class IRCollectionViewCell;

@interface IRTableViewBuilder (AutoLayout)

+ (void) addAutoLayoutConstraintsForTableViewCell:(IRTableViewCell *)irTableViewCell;

+ (void) addAutoLayoutConstraintsForViewsArray:(NSArray *)viewsArray inRootViews:(NSArray *)rootViewsArray;

+ (void) addAutoLayoutConstraintsForView:(IRView *)irView inRootViews:(NSArray *)rootViewsArray;

+ (void) setLayoutConstraintsForView:(UIView *)uiView fromDescriptorsArray:(NSArray *)descriptorsArray inRootViews:(NSArray *)rootViewsArray;

@end