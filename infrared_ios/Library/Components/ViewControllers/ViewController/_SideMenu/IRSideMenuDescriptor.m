//
// Created by Uros Milivojevic on 12/31/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <float.h>
#import "IRSideMenuDescriptor.h"
#import "IRBaseDescriptor.h"
#import "IRUtil.h"


@implementation IRSideMenuDescriptor

- (NSDictionary *) viewDefaults
{
    NSDictionary *dictionary = [NSDictionary dictionary];
    NSMutableDictionary *defaults = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [defaults setValuesForKeysWithDictionary:@{
      @"panGestureEnabled" : @(YES),
      @"panFromEdge" : @(YES),
      @"interactivePopGestureRecognizerEnabled" : @(YES),
      @"scaleContentView" : @(YES),
      @"scaleBackgroundImageView" : @(YES),
      @"scaleMenuView" : @(YES),
      @"contentViewShadowEnabled" : @(NO),
      @"parallaxEnabled" : @(YES),
      @"bouncesHorizontally" : @(YES),
      @"menuPrefersStatusBarHidden" : @(YES),
    }];
    return defaults;
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super init];
    if (self) {
        NSString *string;
        NSNumber *number;
        NSDictionary *dictionary;

        // enable
        number = aDictionary[NSStringFromSelector(@selector(enable))];
        if (number) {
            self.enable = [number boolValue];
        } else {
            self.enable = NO;
        }

        // animationDuration
        number = aDictionary[NSStringFromSelector(@selector(animationDuration))];
        if (number) {
            self.animationDuration = [number doubleValue];
        } else {
            self.animationDuration = CGDOUBLE_UNDEFINED;
        }

        // backgroundImage
        string = aDictionary[NSStringFromSelector(@selector(backgroundImage))];
        self.backgroundImage = string;

        // panGestureEnabled
        number = aDictionary[NSStringFromSelector(@selector(panGestureEnabled))];
        if (number) {
            self.panGestureEnabled = [number boolValue];
        } else {
            self.panGestureEnabled = [[self viewDefaults][NSStringFromSelector(@selector(panGestureEnabled))] boolValue];
        }

        // panFromEdge
        number = aDictionary[NSStringFromSelector(@selector(panFromEdge))];
        if (number) {
            self.panFromEdge = [number boolValue];
        } else {
            self.panFromEdge = [[self viewDefaults][NSStringFromSelector(@selector(panFromEdge))] boolValue];
        }

        // panMinimumOpenThreshold
        number = aDictionary[NSStringFromSelector(@selector(panMinimumOpenThreshold))];
        if (number) {
            self.panMinimumOpenThreshold = (NSUInteger) [number integerValue];
        } else {
            self.panMinimumOpenThreshold = NSUINTEGER_UNDEFINED;
        }

        // interactivePopGestureRecognizerEnabled
        number = aDictionary[NSStringFromSelector(@selector(interactivePopGestureRecognizerEnabled))];
        if (number) {
            self.interactivePopGestureRecognizerEnabled = [number boolValue];
        } else {
            self.interactivePopGestureRecognizerEnabled = [[self viewDefaults][NSStringFromSelector(@selector(interactivePopGestureRecognizerEnabled))] boolValue];
        }

        // scaleContentView
        number = aDictionary[NSStringFromSelector(@selector(scaleContentView))];
        if (number) {
            self.scaleContentView = [number boolValue];
        } else {
            self.scaleContentView = [[self viewDefaults][NSStringFromSelector(@selector(scaleContentView))] boolValue];
        }

        // scaleBackgroundImageView
        number = aDictionary[NSStringFromSelector(@selector(scaleBackgroundImageView))];
        if (number) {
            self.scaleBackgroundImageView = [number boolValue];
        } else {
            self.scaleBackgroundImageView = [[self viewDefaults][NSStringFromSelector(@selector(scaleBackgroundImageView))] boolValue];
        }

        // scaleBackgroundImageView
        number = aDictionary[NSStringFromSelector(@selector(scaleBackgroundImageView))];
        if (number) {
            self.scaleBackgroundImageView = [number boolValue];
        } else {
            self.scaleBackgroundImageView = [[self viewDefaults][NSStringFromSelector(@selector(scaleBackgroundImageView))] boolValue];
        }

        // scaleMenuView
        number = aDictionary[NSStringFromSelector(@selector(scaleMenuView))];
        if (number) {
            self.scaleMenuView = [number boolValue];
        } else {
            self.scaleMenuView = [[self viewDefaults][NSStringFromSelector(@selector(scaleMenuView))] boolValue];
        }

        // contentViewShadowEnabled
        number = aDictionary[NSStringFromSelector(@selector(contentViewShadowEnabled))];
        if (number) {
            self.contentViewShadowEnabled = [number boolValue];
        } else {
            self.contentViewShadowEnabled = [[self viewDefaults][NSStringFromSelector(@selector(contentViewShadowEnabled))] boolValue];
        }

        // contentViewShadowColor
        string = aDictionary[NSStringFromSelector(@selector(contentViewShadowColor))];
        self.contentViewShadowColor = [IRUtil transformHexColorToUIColor:string];;

        // contentViewShadowOffset
        dictionary = aDictionary[NSStringFromSelector(@selector(contentViewShadowOffset))];
        self.contentViewShadowOffset = [IRBaseDescriptor sizeFromDictionary:dictionary];

        // contentViewShadowOpacity
        number = aDictionary[NSStringFromSelector(@selector(contentViewShadowOpacity))];
        if (number) {
            self.contentViewShadowOpacity = [number floatValue];
        } else {
            self.contentViewShadowOpacity = CGFLOAT_UNDEFINED;
        }

        // contentViewShadowRadius
        number = aDictionary[NSStringFromSelector(@selector(contentViewShadowRadius))];
        if (number) {
            self.contentViewShadowRadius = [number floatValue];
        } else {
            self.contentViewShadowRadius = CGFLOAT_UNDEFINED;
        }

        // contentViewScaleValue
        number = aDictionary[NSStringFromSelector(@selector(contentViewScaleValue))];
        if (number) {
            self.contentViewScaleValue = [number floatValue];
        } else {
            self.contentViewScaleValue = CGFLOAT_UNDEFINED;
        }

        // contentViewInLandscapeOffsetCenterX
        number = aDictionary[NSStringFromSelector(@selector(contentViewInLandscapeOffsetCenterX))];
        if (number) {
            self.contentViewInLandscapeOffsetCenterX = [number floatValue];
        } else {
            self.contentViewInLandscapeOffsetCenterX = CGFLOAT_UNDEFINED;
        }

        // contentViewInPortraitOffsetCenterX
        number = aDictionary[NSStringFromSelector(@selector(contentViewInPortraitOffsetCenterX))];
        if (number) {
            self.contentViewInPortraitOffsetCenterX = [number floatValue];
        } else {
            self.contentViewInPortraitOffsetCenterX = CGFLOAT_UNDEFINED;
        }

        // parallaxMenuMinimumRelativeValue
        number = aDictionary[NSStringFromSelector(@selector(parallaxMenuMinimumRelativeValue))];
        if (number) {
            self.parallaxMenuMinimumRelativeValue = [number floatValue];
        } else {
            self.parallaxMenuMinimumRelativeValue = CGFLOAT_UNDEFINED;
        }

        // parallaxMenuMaximumRelativeValue
        number = aDictionary[NSStringFromSelector(@selector(parallaxMenuMaximumRelativeValue))];
        if (number) {
            self.parallaxMenuMaximumRelativeValue = [number floatValue];
        } else {
            self.parallaxMenuMaximumRelativeValue = CGFLOAT_UNDEFINED;
        }

        // parallaxContentMinimumRelativeValue
        number = aDictionary[NSStringFromSelector(@selector(parallaxContentMinimumRelativeValue))];
        if (number) {
            self.parallaxContentMinimumRelativeValue = [number floatValue];
        } else {
            self.parallaxContentMinimumRelativeValue = CGFLOAT_UNDEFINED;
        }

        // parallaxContentMaximumRelativeValue
        number = aDictionary[NSStringFromSelector(@selector(parallaxContentMaximumRelativeValue))];
        if (number) {
            self.parallaxContentMaximumRelativeValue = [number floatValue];
        } else {
            self.parallaxContentMaximumRelativeValue = CGFLOAT_UNDEFINED;
        }

        // menuViewControllerTransformation
        dictionary = aDictionary[NSStringFromSelector(@selector(menuViewControllerTransformation))];
        self.menuViewControllerTransformation = [IRBaseDescriptor affineTransformFromDictionary:dictionary];

        // parallaxEnabled
        number = aDictionary[NSStringFromSelector(@selector(parallaxEnabled))];
        if (number) {
            self.parallaxEnabled = [number boolValue];
        } else {
            self.parallaxEnabled = [[self viewDefaults][NSStringFromSelector(@selector(parallaxEnabled))] boolValue];
        }

        // bouncesHorizontally
        number = aDictionary[NSStringFromSelector(@selector(bouncesHorizontally))];
        if (number) {
            self.bouncesHorizontally = [number boolValue];
        } else {
            self.bouncesHorizontally = [[self viewDefaults][NSStringFromSelector(@selector(bouncesHorizontally))] boolValue];
        }

        // menuPreferredStatusBarStyle
        string = aDictionary[NSStringFromSelector(@selector(menuPreferredStatusBarStyle))];
        self.menuPreferredStatusBarStyle = [IRBaseDescriptor statusBarStyleFromString:string];

        // menuPrefersStatusBarHidden
        number = aDictionary[NSStringFromSelector(@selector(menuPrefersStatusBarHidden))];
        if (number) {
            self.menuPrefersStatusBarHidden = [number boolValue];
        } else {
            self.menuPrefersStatusBarHidden = [[self viewDefaults][NSStringFromSelector(@selector(menuPrefersStatusBarHidden))] boolValue];
        }

        // leftMenuScreenId
        string = aDictionary[NSStringFromSelector(@selector(leftMenuScreenId))];
        self.leftMenuScreenId = string;

        // rightMenuScreenId
        string = aDictionary[NSStringFromSelector(@selector(rightMenuScreenId))];
        self.rightMenuScreenId = string;
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    if ([self.backgroundImage length] > 0 && [IRUtil isLocalFile:self.backgroundImage] == NO) {
        [imagePaths addObject:self.backgroundImage];
    }
}

@end