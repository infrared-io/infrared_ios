//
// Created by Uros Milivojevic on 10/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRTextFieldBuilder.h"
#import "IRTextFieldDescriptor.h"
#import "IRTextField.h"
#import "IRViewBuilder.h"
#import "IRSimpleCache.h"
#import "IRScreenDescriptor.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRViewController.h"
#import "IRViewDescriptor.h"
#import "IRUtil.h"


@implementation IRTextFieldBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRTextField *irTextField;

    irTextField = [[IRTextField alloc] init];
    [IRTextFieldBuilder setUpComponent:irTextField componentDescriptor:descriptor viewController:viewController
                                 extra:extra];

    return irTextField;
}

+ (void) setUpComponent:(IRTextField *)irTextField
    componentDescriptor:(IRTextFieldDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irTextField componentDescriptor:descriptor viewController:viewController extra:extra];
    [IRBaseBuilder setUpUIControlInterfaceForComponent:irTextField fromDescriptor:descriptor];

    irTextField.text = descriptor.text;
    irTextField.textColor = descriptor.textColor;
    irTextField.font = descriptor.font;
    irTextField.textAlignment = descriptor.textAlignment;
    irTextField.placeholder = [IRBaseBuilder textWithI18NCheck:descriptor.placeholder];
    if (descriptor.placeholderColor) {
        [irTextField setValue:descriptor.placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    irTextField.background = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.background];
    irTextField.disabledBackground = [IRUtil imagePrefixedWithBaseUrlIfNeeded:descriptor.disabledBackground];
    irTextField.borderStyle = descriptor.borderStyle;
    irTextField.clearButtonMode = descriptor.clearButtonMode;
    irTextField.clearsOnBeginEditing = descriptor.clearsOnBeginEditing;
    irTextField.minimumFontSize = descriptor.minimumFontSize;
    irTextField.adjustsFontSizeToFitWidth = descriptor.adjustsFontSizeToFitWidth;

    irTextField.leftView = [IRBaseBuilder buildComponentFromDescriptor:descriptor.leftView viewController:viewController
                                                                 extra:extra];
    irTextField.leftViewMode = descriptor.leftViewMode;

    irTextField.rightView = [IRBaseBuilder buildComponentFromDescriptor:descriptor.rightView
                                                         viewController:viewController extra:extra];
    irTextField.rightViewMode = descriptor.rightViewMode;

    irTextField.clearsOnInsertion = descriptor.clearsOnInsertion;
    irTextField.autocapitalizationType = descriptor.autocapitalizationType;
    irTextField.autocorrectionType = descriptor.autocorrectionType;
    irTextField.spellCheckingType = descriptor.spellCheckingType;
    irTextField.keyboardType = descriptor.keyboardType;
    irTextField.keyboardAppearance = descriptor.keyboardAppearance;
    irTextField.returnKeyType = descriptor.returnKeyType;
    irTextField.enablesReturnKeyAutomatically = descriptor.enablesReturnKeyAutomatically;
    irTextField.secureTextEntry = descriptor.secureTextEntry;
}

@end