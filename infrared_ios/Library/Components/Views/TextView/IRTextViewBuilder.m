//
// Created by Uros Milivojevic on 12/5/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRTextViewBuilder.h"
#import "IRTextView.h"
#import "IRTextViewDescriptor.h"
#import "IRScrollViewBuilder.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRScreenDescriptor.h"
#import "IRViewController.h"
#import "IRViewDescriptor.h"


@implementation IRTextViewBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRTextView *irTextView;

    irTextView = [[IRTextView alloc] init];
    [IRTextViewBuilder setUpComponent:irTextView componentDescriptor:descriptor viewController:viewController
                                extra:extra];

    return irTextView;
}

+ (void) setUpComponent:(IRTextView *)irTextView
    componentDescriptor:(IRTextViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRScrollViewBuilder setUpComponent:irTextView componentDescriptor:descriptor viewController:viewController
                                  extra:extra];

    irTextView.text = descriptor.text;
    irTextView.textColor = descriptor.textColor;
    irTextView.font = descriptor.font;
    irTextView.textAlignment = descriptor.textAlignment;
    irTextView.editable = descriptor.editable;
    irTextView.selectable = descriptor.selectable;
    if (descriptor.dataDetectorTypes != UIDataDetectorTypeUnDefined) {
        irTextView.dataDetectorTypes = descriptor.dataDetectorTypes;
    }

    irTextView.clearsOnInsertion = descriptor.clearsOnInsertion;
    irTextView.autocapitalizationType = descriptor.autocapitalizationType;
    irTextView.autocorrectionType = descriptor.autocorrectionType;
    irTextView.spellCheckingType = descriptor.spellCheckingType;
    irTextView.keyboardType = descriptor.keyboardType;
    irTextView.keyboardAppearance = descriptor.keyboardAppearance;
    irTextView.returnKeyType = descriptor.returnKeyType;
    irTextView.enablesReturnKeyAutomatically = descriptor.enablesReturnKeyAutomatically;
    irTextView.secureTextEntry = descriptor.secureTextEntry;
}

@end