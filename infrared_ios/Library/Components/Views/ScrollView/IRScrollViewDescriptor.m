//
// Created by Uros Milivojevic on 12/4/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRScrollViewDescriptor.h"
#import "IRScrollViewBuilder.h"
#import "IRScrollView.h"


@implementation IRScrollViewDescriptor

+ (NSString *) componentName
{
    return typeScrollViewKEY;
}
+ (Class) componentClass
{
    return [IRScrollView class];
}

+ (Class) builderClass
{
    return [IRScrollViewBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UIScrollView class], @protocol(UIScrollViewExport));
}

- (NSDictionary *) viewDefaults
{
    NSDictionary *dictionary = [super viewDefaults];
    NSMutableDictionary *defaults = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [defaults setValuesForKeysWithDictionary:@{
      @"clipsToBounds" : @(YES)
    }];
    return defaults;
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSDictionary *dictionary;

        // contentSize
        dictionary = aDictionary[NSStringFromSelector(@selector(contentSize))];
        self.contentSize = [IRBaseDescriptor sizeFromDictionary:dictionary];

        // contentInset
        dictionary = aDictionary[NSStringFromSelector(@selector(contentInset))];
        self.contentInset = [IRBaseDescriptor edgeInsetsFromDictionary:dictionary];

        // indicatorStyle
        string = aDictionary[NSStringFromSelector(@selector(indicatorStyle))];
        self.indicatorStyle = [IRBaseDescriptor scrollViewIndicatorStyleFromString:string];

        // showsHorizontalScrollIndicator
        number = aDictionary[NSStringFromSelector(@selector(showsHorizontalScrollIndicator))];
        if (number) {
            self.showsHorizontalScrollIndicator = [number boolValue];
        } else {
            self.showsHorizontalScrollIndicator = YES;
        }

        // showsVerticalScrollIndicator
        number = aDictionary[NSStringFromSelector(@selector(showsVerticalScrollIndicator))];
        if (number) {
            self.showsVerticalScrollIndicator = [number boolValue];
        } else {
            self.showsVerticalScrollIndicator = YES;
        }

        // scrollEnabled
        number = aDictionary[NSStringFromSelector(@selector(scrollEnabled))];
        if (number) {
            self.scrollEnabled = [number boolValue];
        } else {
            self.scrollEnabled = YES;
        }

        // pagingEnabled
        number = aDictionary[NSStringFromSelector(@selector(pagingEnabled))];
        if (number) {
            self.pagingEnabled = [number boolValue];
        } else {
            self.pagingEnabled = NO;
        }

        // directionalLockEnabled
        number = aDictionary[NSStringFromSelector(@selector(directionalLockEnabled))];
        if (number) {
            self.directionalLockEnabled = [number boolValue];
        } else {
            self.directionalLockEnabled = NO;
        }

        // bounces
        number = aDictionary[NSStringFromSelector(@selector(bounces))];
        if (number) {
            self.bounces = [number boolValue];
        } else {
            self.bounces = YES;
        }

        // alwaysBounceVertical
        number = aDictionary[NSStringFromSelector(@selector(alwaysBounceVertical))];
        if (number) {
            self.alwaysBounceVertical = [number boolValue];
        } else {
            self.alwaysBounceVertical = NO;
        }

        // alwaysBounceHorizontal
        number = aDictionary[NSStringFromSelector(@selector(alwaysBounceHorizontal))];
        if (number) {
            self.alwaysBounceHorizontal = [number boolValue];
        } else {
            self.alwaysBounceHorizontal = NO;
        }

        // minimumZoomScale
        number = aDictionary[NSStringFromSelector(@selector(minimumZoomScale))];
        if (number) {
            self.minimumZoomScale = [number floatValue];
        } else {
            self.minimumZoomScale = 1.0;
        }

        // maximumZoomScale
        number = aDictionary[NSStringFromSelector(@selector(maximumZoomScale))];
        if (number) {
            self.maximumZoomScale = [number floatValue];
        } else {
            self.maximumZoomScale = 1.0;
        }

        // bouncesZoom
        number = aDictionary[NSStringFromSelector(@selector(bouncesZoom))];
        if (number) {
            self.bouncesZoom = [number boolValue];
        } else {
            self.bouncesZoom = YES;
        }

        // delaysContentTouches
        number = aDictionary[NSStringFromSelector(@selector(delaysContentTouches))];
        if (number) {
            self.delaysContentTouches = [number boolValue];
        } else {
            self.delaysContentTouches = YES;
        }

        // canCancelContentTouches
        number = aDictionary[NSStringFromSelector(@selector(canCancelContentTouches))];
        if (number) {
            self.canCancelContentTouches = [number boolValue];
        } else {
            self.canCancelContentTouches = YES;
        }

        // keyboardDismissMode
        string = aDictionary[NSStringFromSelector(@selector(keyboardDismissMode))];
        self.keyboardDismissMode = [IRBaseDescriptor scrollViewKeyboardDismissModeFromString:string];
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{

}

@end