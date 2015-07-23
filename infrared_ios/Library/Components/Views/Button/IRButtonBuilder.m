//
// Created by Uros Milivojevic on 10/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRButtonBuilder.h"
#import "IRViewDescriptor.h"
#import "IRButtonDescriptor.h"
#import "IRView.h"
#import "IRButton.h"
#import "IRViewBuilder.h"
#import "IRSimpleCache.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRScreenDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRViewController.h"
#import "IRUtil.h"


@implementation IRButtonBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRButton *irButton;

    irButton = [IRButton buttonWithType:((IRButtonDescriptor *)descriptor).buttonType];
    [IRButtonBuilder setUpComponent:irButton componentDescriptor:descriptor viewController:viewController extra:extra];

    return irButton;
}

+ (void) setUpComponent:(IRButton *)irButton
    componentDescriptor:(IRButtonDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irButton componentDescriptor:descriptor viewController:viewController extra:extra];
    [IRBaseBuilder setUpUIControlInterfaceForComponent:irButton fromDescriptor:descriptor];

    [irButton setTitle:[IRBaseBuilder textWithI18NCheck:descriptor.normalTitle] forState:UIControlStateNormal];
    if (descriptor.normalTitleColor) {
        [irButton setTitleColor:descriptor.normalTitleColor forState:UIControlStateNormal];
    }
    if (descriptor.normalTitleShadowColor) {
        [irButton setTitleShadowColor:descriptor.normalTitleShadowColor forState:UIControlStateNormal];
    }
    [irButton setImage:[IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.normalImage]
              forState:UIControlStateNormal];
    [irButton setBackgroundImage:[IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.normalBackgroundImage]
                        forState:UIControlStateNormal];

    [irButton setTitle:[IRBaseBuilder textWithI18NCheck:descriptor.highlightedTitle] forState:UIControlStateHighlighted];
    if (descriptor.highlightedTitleColor) {
        [irButton setTitleColor:descriptor.highlightedTitleColor forState:UIControlStateHighlighted];
    }
    if (descriptor.highlightedTitleShadowColor) {
        [irButton setTitleShadowColor:descriptor.highlightedTitleShadowColor forState:UIControlStateHighlighted];
    }
    [irButton setImage:[IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.highlightedImage]
              forState:UIControlStateHighlighted];
    [irButton setBackgroundImage:[IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.highlightedBackgroundImage]
                        forState:UIControlStateHighlighted];

    [irButton setTitle:[IRBaseBuilder textWithI18NCheck:descriptor.selectedTitle] forState:UIControlStateSelected];
    if (descriptor.selectedTitleColor) {
        [irButton setTitleColor:descriptor.selectedTitleColor forState:UIControlStateSelected];
    }
    if (descriptor.selectedTitleShadowColor) {
        [irButton setTitleShadowColor:descriptor.selectedTitleShadowColor forState:UIControlStateSelected];
    }
    [irButton setImage:[IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.selectedImage]
              forState:UIControlStateSelected];
    [irButton setBackgroundImage:[IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.selectedBackgroundImage]
                        forState:UIControlStateSelected];

    [irButton setTitle:[IRBaseBuilder textWithI18NCheck:descriptor.disabledTitle] forState:UIControlStateDisabled];
    if (descriptor.disabledTitleColor) {
        [irButton setTitleColor:descriptor.disabledTitleColor forState:UIControlStateDisabled];
    }
    if (descriptor.disabledTitleShadowColor) {
        [irButton setTitleShadowColor:descriptor.disabledTitleShadowColor forState:UIControlStateDisabled];
    }
    [irButton setImage:[IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.disabledImage]
              forState:UIControlStateDisabled];
    [irButton setBackgroundImage:[IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.disabledBackgroundImage]
                        forState:UIControlStateDisabled];

    irButton.titleLabel.font = descriptor.font;
    irButton.titleLabel.shadowOffset = descriptor.titleShadowOffset;
    irButton.reversesTitleShadowWhenHighlighted = descriptor.reversesTitleShadowWhenHighlighted;
    irButton.showsTouchWhenHighlighted = descriptor.showsTouchWhenHighlighted;
    irButton.adjustsImageWhenHighlighted = descriptor.adjustsImageWhenHighlighted;
    irButton.adjustsImageWhenDisabled = descriptor.adjustsImageWhenDisabled;
    irButton.titleLabel.lineBreakMode = descriptor.lineBreakMode;
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.contentEdgeInsets, UIEdgeInsetsNull) == NO) {
        irButton.contentEdgeInsets = descriptor.contentEdgeInsets;
    }
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.titleEdgeInsets, UIEdgeInsetsNull) == NO) {
        irButton.titleEdgeInsets = descriptor.titleEdgeInsets;
    }
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.imageEdgeInsets, UIEdgeInsetsNull) == NO) {
        irButton.imageEdgeInsets = descriptor.imageEdgeInsets;
    }
}

@end