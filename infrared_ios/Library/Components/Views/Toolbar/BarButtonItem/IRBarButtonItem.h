//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "IRComponentInfoProtocol.h"
#import "IRBarItem.h"
#import "UIBarButtonItemExport.h"

@protocol IRBarButtonItemExport <JSExport>

@property (nonatomic, strong) NSString *actions;

+ (id) createWithType:(UIButtonType)buttonType componentId:(NSString *)componentId;
+ (id) createWithTitle:(NSString *)title componentId:(NSString *)componentId;
+ (id) createWithImagePath:(NSString *)imagePath componentId:(NSString *)componentId;
+ (id) createWithComponentId:(NSString *)componentId;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRBarButtonItem : UIBarButtonItem <IRComponentInfoProtocol, UIBarButtonItemExport, IRBarButtonItemExport, UIBarItemExport, IRBarItemExport>

@end