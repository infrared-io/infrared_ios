//
// Created by Uros Milivojevic on 10/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRLabelBuilder.h"
#import "IRLabelDescriptor.h"
#import "IRLabel.h"
#import "IRViewBuilder.h"
#import "IRScreenDescriptor.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRViewController.h"
#import "IRViewDescriptor.h"


@implementation IRLabelBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRLabel *irLabel;

    irLabel = [[IRLabel alloc] init];
    [IRLabelBuilder setUpComponent:irLabel componentDescriptor:descriptor viewController:viewController extra:extra];

    return irLabel;
}

+ (void) setUpComponent:(IRLabel *)irLabel
    componentDescriptor:(IRLabelDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irLabel componentDescriptor:descriptor viewController:viewController extra:extra];

    irLabel.text = [IRBaseBuilder textWithI18NCheck:descriptor.text];
    irLabel.textColor = descriptor.textColor;
    irLabel.font = descriptor.font;
    irLabel.textAlignment = descriptor.textAlignment;
    irLabel.numberOfLines = descriptor.numberOfLines;
    irLabel.highlighted = descriptor.highlighted;
    irLabel.adjustsFontSizeToFitWidth = descriptor.adjustsFontSizeToFitWidth;
    irLabel.baselineAdjustment = descriptor.baselineAdjustment;
    irLabel.lineBreakMode = descriptor.lineBreakMode;
    irLabel.minimumScaleFactor = descriptor.minimumScaleFactor;
    irLabel.highlightedTextColor = descriptor.highlightedTextColor;
    irLabel.shadowColor = descriptor.shadowColor;
    irLabel.shadowOffset = descriptor.shadowOffset;
    if (descriptor.preferredMaxLayoutWidth != CGFLOAT_UNDEFINED) {
        irLabel.preferredMaxLayoutWidth = descriptor.preferredMaxLayoutWidth;
    }
}

@end