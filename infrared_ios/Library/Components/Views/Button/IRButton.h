//
//  IRButton.h
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "IRComponentInfoProtocol.h"
#import "IRView.h"
#import "IRControlExportProtocol.h"
#import "UIControlIRExtension.h"
#import "UIButtonExport.h"

@protocol IRButtonExport <JSExport>

+ (id) createWithType:(UIButtonType)buttonType
          componentId:(NSString *)componentId;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

// UIControlStateNormal
@property(nonatomic, strong) NSString *normalTitle;
@property(nonatomic, retain) UIColor *normalTitleColor;
@property(nonatomic, retain) UIColor *normalTitleShadowColor;
@property(nonatomic, strong) UIImage *normalImage;
@property(nonatomic, strong) UIImage *normalBackgroundImage;

// UIControlStateHighlighted
@property(nonatomic, strong) NSString *highlightedTitle;
@property(nonatomic, retain) UIColor *highlightedTitleColor;
@property(nonatomic, retain) UIColor *highlightedTitleShadowColor;
@property(nonatomic, strong) UIImage *highlightedImage;
@property(nonatomic, strong) UIImage *highlightedBackgroundImage;

// UIControlStateSelected
@property(nonatomic, strong) NSString *selectedTitle;
@property(nonatomic, retain) UIColor *selectedTitleColor;
@property(nonatomic, retain) UIColor *selectedTitleShadowColor;
@property(nonatomic, strong) UIImage *selectedImage;
@property(nonatomic, strong) UIImage *selectedBackgroundImage;

// UIControlStateDisabled
@property(nonatomic, strong) NSString *disabledTitle;
@property(nonatomic, retain) UIColor *disabledTitleColor;
@property(nonatomic, retain) UIColor *disabledTitleShadowColor;
@property(nonatomic, strong) UIImage *disabledImage;
@property(nonatomic, strong) UIImage *disabledBackgroundImage;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRButton : UIButton <IRComponentInfoProtocol, UIButtonExport, IRButtonExport, IRControlExportProtocol, UIControlIRExtensionExport, UIViewExport, IRViewExport>

@end
