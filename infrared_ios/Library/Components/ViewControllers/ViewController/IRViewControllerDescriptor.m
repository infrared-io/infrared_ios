//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRViewControllerDescriptor.h"
#import "IRUtil.h"
#import "IRViewControllerBuilder.h"
#import "IRSideMenuDescriptor.h"
#import "IRNavigationControllerSubDescriptor.h"
#import "IRKeyboardManagerSubDescriptor.h"
#import "IRTabBarControllerSubDescriptor.h"


@implementation IRViewControllerDescriptor

+ (NSString *) componentName
{
    return typeViewControllerKEY;
}

+ (Class) builderClass
{
    return [IRViewControllerBuilder class];
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSString *string;
        NSNumber *number;
        NSDictionary *dictionary;

        // title
        string = aDictionary[NSStringFromSelector(@selector(title))];
        self.title = string;

        // useExistingClass
        string = aDictionary[NSStringFromSelector(@selector(useExistingClass))];
        self.useExistingClass = string;

        // jsPluginPath
        string = aDictionary[NSStringFromSelector(@selector(jsPluginPath))];
        self.jsPluginPath = string;

        // preferredStatusBarStyle
        string = aDictionary[NSStringFromSelector(@selector(preferredStatusBarStyle))];
        self.preferredStatusBarStyle = [IRBaseDescriptor statusBarStyleFromString:string];

        // prefersStatusBarHidden
        number = aDictionary[NSStringFromSelector(@selector(prefersStatusBarHidden))];
        if (number) {
            self.prefersStatusBarHidden = [number boolValue];
        } else {
            self.prefersStatusBarHidden = NO;
        }

        // supportedInterfaceOrientationsArray
        string = aDictionary[supportedInterfaceOrientationsKEY];
        self.supportedInterfaceOrientationsArray = [IRBaseDescriptor interfaceOrientationsFromString:string];

        // sideMenu
        dictionary = aDictionary[NSStringFromSelector(@selector(sideMenu))];
        if (dictionary) {
            self.sideMenu = [[IRSideMenuDescriptor alloc] initDescriptorWithDictionary:dictionary];
        }

        // tabBarController
        dictionary = aDictionary[NSStringFromSelector(@selector(tabBarController))];
        if (dictionary) {
            self.tabBarController = [[IRTabBarControllerSubDescriptor alloc] initDescriptorWithDictionary:dictionary];
        }

        // navigationController
        dictionary = aDictionary[NSStringFromSelector(@selector(navigationController))];
        if (dictionary) {
            self.navigationController = [[IRNavigationControllerSubDescriptor alloc] initDescriptorWithDictionary:dictionary];
        }

        // keyboardManager
        dictionary = aDictionary[NSStringFromSelector(@selector(keyboardManager))];
        if (dictionary) {
            self.keyboardManager = [[IRKeyboardManagerSubDescriptor alloc] initDescriptorWithDictionary:dictionary];
        }
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{
    [self.navigationController extendImagePathsArray:imagePaths];
    [self.sideMenu extendImagePathsArray:imagePaths];
}


@end