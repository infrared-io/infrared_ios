//
// Created by Uros Milivojevic on 1/2/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IRBarButtonItemDescriptor;


@interface IRNavigationControllerSubDescriptor : NSObject

@property (nonatomic) BOOL autoAddIfNeeded;
@property (nonatomic) BOOL hideNavigationBar;
@property (nonatomic) BOOL navigationBarTranslucent;
@property (nonatomic, strong) UIColor* navigationBarTintColor;
@property (nonatomic, strong) UIColor* navigationTintColor;
@property (nonatomic, strong) UIColor* navigationTitleColor;
@property (nonatomic, strong) UIFont* navigationTitleFont;
@property (nonatomic, strong) NSString* backIndicatorImage;
@property (nonatomic) BOOL backIndicatorNoText;
@property (nonatomic, strong) IRBarButtonItemDescriptor *leftBarButtonItem;
@property (nonatomic, strong) IRBarButtonItemDescriptor *rightBarButtonItem;

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end