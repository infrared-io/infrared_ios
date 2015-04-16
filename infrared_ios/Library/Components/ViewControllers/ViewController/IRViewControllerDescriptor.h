//
// Created by Uros Milivojevic on 8/27/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseDescriptor.h"

@class IRSideMenuDescriptor;
@class IRNavigationControllerSubDescriptor;
@class IRKeyboardManagerSubDescriptor;


@interface IRViewControllerDescriptor : IRBaseDescriptor

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *useExistingClass;
@property (nonatomic, strong) NSString *jsPluginPath;
@property (nonatomic) UIStatusBarStyle preferredStatusBarStyle;
@property (nonatomic) BOOL prefersStatusBarHidden;
@property (nonatomic, strong) NSArray *supportedInterfaceOrientationsArray;
@property (nonatomic, strong) IRSideMenuDescriptor * sideMenu;
@property (nonatomic, strong) IRNavigationControllerSubDescriptor * navigationController;
@property (nonatomic, strong) IRKeyboardManagerSubDescriptor *keyboardManager;
@property (nonatomic) BOOL requestWhenInUseAuthorization;
@property (nonatomic) BOOL requestAlwaysAuthorization;

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end