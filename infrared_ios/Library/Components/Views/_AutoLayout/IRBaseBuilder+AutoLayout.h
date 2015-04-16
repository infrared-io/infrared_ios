//
// Created by Uros Milivojevic on 10/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseBuilder.h"

@class IRScreenDescriptor;
@class IRViewController;
@class IRView;
@class IRViewDescriptor;

@interface IRBaseBuilder (AutoLayout)

+ (void) addAutoLayoutConstraintsForViewsArray:(NSArray *)viewsArray
                                viewController:(IRViewController *)viewController;

+ (void) addAutoLayoutConstraintsForView:(UIView *)irView
                              descriptor:(IRViewDescriptor *)descriptor
                          viewController:(IRViewController *)viewController;

+ (void) setLayoutConstraintsForView:(UIView *)uiView
                fromDescriptorsArray:(NSArray *)descriptorsArray
                      viewController:(IRViewController *)viewController;

+ (NSMutableArray *) parseViewIdsFromVisualFormat:(NSString *)visualFormat;

@end