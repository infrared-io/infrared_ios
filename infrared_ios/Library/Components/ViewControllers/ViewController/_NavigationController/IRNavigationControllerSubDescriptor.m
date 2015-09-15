//
// Created by Uros Milivojevic on 1/2/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRNavigationControllerSubDescriptor.h"
#import "IRUtil.h"
#import "IRBaseDescriptor.h"
#import "IRBarButtonItemDescriptor.h"
#import "IRViewDescriptor.h"


@implementation IRNavigationControllerSubDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super init];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSDictionary *dictionary;

        // autoAddIfNeeded
        number = aDictionary[NSStringFromSelector(@selector(autoAddIfNeeded))];
        if (number) {
            self.autoAddIfNeeded = [number boolValue];
        } else {
            self.autoAddIfNeeded = NO;
        }

        // hideNavigationBar
        number = aDictionary[NSStringFromSelector(@selector(hideNavigationBar))];
        if (number) {
            self.hideNavigationBar = [number boolValue];
        } else {
            self.hideNavigationBar = NO;
        }

        // navigationBarTranslucent
        number = aDictionary[NSStringFromSelector(@selector(navigationBarTranslucent))];
        if (number) {
            self.navigationBarTranslucent = [number boolValue];
        } else {
            self.navigationBarTranslucent = NO;
        }

#if TARGET_OS_IPHONE
        // navigationBarTintColor
        string = aDictionary[NSStringFromSelector(@selector(navigationBarTintColor))];
        self.navigationBarTintColor = [IRUtil transformHexColorToUIColor:string];

        // navigationTintColor
        string = aDictionary[NSStringFromSelector(@selector(navigationTintColor))];
        self.navigationTintColor = [IRUtil transformHexColorToUIColor:string];

        // navigationTitleColor
        string = aDictionary[NSStringFromSelector(@selector(navigationTitleColor))];
        self.navigationTitleColor = [IRUtil transformHexColorToUIColor:string];

        // navigationTitleFont
        string = aDictionary[NSStringFromSelector(@selector(navigationTitleFont))];
        self.navigationTitleFont = [IRBaseDescriptor fontFromString:string];
#endif

        // backIndicatorImage
        string = aDictionary[NSStringFromSelector(@selector(backIndicatorImage))];
        self.backIndicatorImage = string;

        // backIndicatorNoText
        number = aDictionary[NSStringFromSelector(@selector(backIndicatorNoText))];
        self.backIndicatorNoText = [number boolValue];

        // titleView
        dictionary = aDictionary[NSStringFromSelector(@selector(titleView))];
        self.titleView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // leftBarButtonItem
        dictionary = aDictionary[NSStringFromSelector(@selector(leftBarButtonItem))];
        self.leftBarButtonItem = (IRBarButtonItemDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // rightBarButtonItem
        dictionary = aDictionary[NSStringFromSelector(@selector(rightBarButtonItem))];
        self.rightBarButtonItem = (IRBarButtonItemDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    if (self.backIndicatorImage && [IRUtil isFileForDownload:self.backIndicatorImage]) {
        [imagePaths addObject:self.backIndicatorImage];
    }
}



@end