//
// Created by Uros Milivojevic on 6/23/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRCollectionViewBuilder.h"

@class IRCollectionViewCell;

@interface IRCollectionViewBuilder (AutoLayout)

+ (void) addAutoLayoutConstraintsForCollectionViewCell:(IRCollectionViewCell *)irCollectionViewCell;

@end