//
// Created by Uros Milivojevic on 12/17/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRTableAndCollectionViewBuilder.h"

@class IRView;
@class IRTableViewCell;
@class IRCollectionViewCell;

@interface IRTableAndCollectionViewBuilder (AutoLayout)

+ (void) addAutoLayoutConstraintsForTableViewCell:(IRTableViewCell *)irTableViewCell;

+ (void) addAutoLayoutConstraintsForCollectionViewCell:(IRCollectionViewCell *)irCollectionViewCell;

+ (void) addAutoLayoutConstraintsForViewsArray:(NSArray *)viewsArray inRootViews:(NSArray *)rootViewsArray;

+ (void) addAutoLayoutConstraintsForView:(IRView *)irView inRootViews:(NSArray *)rootViewsArray;

+ (void) setLayoutConstraintsForView:(UIView *)uiView fromDescriptorsArray:(NSArray *)descriptorsArray inRootViews:(NSArray *)rootViewsArray;

@end