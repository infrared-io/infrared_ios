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
    UIImage *image;

    [IRViewBuilder setUpComponent:irButton componentDescriptor:descriptor viewController:viewController extra:extra];
    [IRBaseBuilder setUpUIControlInterfaceForComponent:irButton fromDescriptor:descriptor];

    [irButton setTitle:[IRBaseBuilder textWithI18NCheck:descriptor.normalTitle] forState:UIControlStateNormal];
    if (descriptor.normalTitleColor) {
        [irButton setTitleColor:descriptor.normalTitleColor forState:UIControlStateNormal];
    }
    if (descriptor.normalTitleShadowColor) {
        [irButton setTitleShadowColor:descriptor.normalTitleShadowColor forState:UIControlStateNormal];
    }
    image = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.normalImage];
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.normalImageCapInsets, UIEdgeInsetsNull) == NO) {
        image = [image resizableImageWithCapInsets:descriptor.normalImageCapInsets];
    }
    [irButton setImage:image forState:UIControlStateNormal];
    image = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.normalBackgroundImage];
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.normalBackgroundImageCapInsets, UIEdgeInsetsNull) == NO) {
        image = [image resizableImageWithCapInsets:descriptor.normalBackgroundImageCapInsets];
    }
    [irButton setBackgroundImage:image forState:UIControlStateNormal];

    [irButton setTitle:[IRBaseBuilder textWithI18NCheck:descriptor.highlightedTitle] forState:UIControlStateHighlighted];
    if (descriptor.highlightedTitleColor) {
        [irButton setTitleColor:descriptor.highlightedTitleColor forState:UIControlStateHighlighted];
    }
    if (descriptor.highlightedTitleShadowColor) {
        [irButton setTitleShadowColor:descriptor.highlightedTitleShadowColor forState:UIControlStateHighlighted];
    }
    image = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.highlightedImage];
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.highlightedImageCapInsets, UIEdgeInsetsNull) == NO) {
        image = [image resizableImageWithCapInsets:descriptor.highlightedImageCapInsets];
    }
    [irButton setImage:image forState:UIControlStateHighlighted];
    image = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.highlightedBackgroundImage];
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.highlightedBackgroundImageCapInsets, UIEdgeInsetsNull) == NO) {
        image = [image resizableImageWithCapInsets:descriptor.highlightedBackgroundImageCapInsets];
    }
    [irButton setBackgroundImage:image forState:UIControlStateHighlighted];

    [irButton setTitle:[IRBaseBuilder textWithI18NCheck:descriptor.selectedTitle] forState:UIControlStateSelected];
    if (descriptor.selectedTitleColor) {
        [irButton setTitleColor:descriptor.selectedTitleColor forState:UIControlStateSelected];
    }
    if (descriptor.selectedTitleShadowColor) {
        [irButton setTitleShadowColor:descriptor.selectedTitleShadowColor forState:UIControlStateSelected];
    }
    image = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.selectedImage];
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.selectedImageCapInsets, UIEdgeInsetsNull) == NO) {
        image = [image resizableImageWithCapInsets:descriptor.selectedImageCapInsets];
    }
    [irButton setImage:image forState:UIControlStateSelected];
    image = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.selectedBackgroundImage];
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.selectedBackgroundImageCapInsets, UIEdgeInsetsNull) == NO) {
        image = [image resizableImageWithCapInsets:descriptor.selectedBackgroundImageCapInsets];
    }
    [irButton setBackgroundImage:image forState:UIControlStateSelected];

    [irButton setTitle:[IRBaseBuilder textWithI18NCheck:descriptor.disabledTitle] forState:UIControlStateDisabled];
    if (descriptor.disabledTitleColor) {
        [irButton setTitleColor:descriptor.disabledTitleColor forState:UIControlStateDisabled];
    }
    if (descriptor.disabledTitleShadowColor) {
        [irButton setTitleShadowColor:descriptor.disabledTitleShadowColor forState:UIControlStateDisabled];
    }
    image = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.disabledImage];
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.disabledImageCapInsets, UIEdgeInsetsNull) == NO) {
        image = [image resizableImageWithCapInsets:descriptor.disabledImageCapInsets];
    }
    [irButton setImage:image forState:UIControlStateDisabled];
    image = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.disabledBackgroundImage];
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.disabledBackgroundImageCapInsets, UIEdgeInsetsNull) == NO) {
        image = [image resizableImageWithCapInsets:descriptor.disabledBackgroundImageCapInsets];
    }
    [irButton setBackgroundImage:image forState:UIControlStateDisabled];

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