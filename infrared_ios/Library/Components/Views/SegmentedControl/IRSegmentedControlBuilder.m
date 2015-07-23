//
// Created by Uros Milivojevic on 12/6/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRSegmentedControlBuilder.h"
#import "IRSegmentedControl.h"
#import "IRSegmentedControlDescriptor.h"
#import "IRViewBuilder.h"
#import "IRSegment.h"
#import "IRSimpleCache.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRScreenDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRViewController.h"
#import "IRUtil.h"


@implementation IRSegmentedControlBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRSegmentedControl *irSegmentedControl;

    irSegmentedControl = [[IRSegmentedControl alloc] init];
    [IRSegmentedControlBuilder setUpComponent:irSegmentedControl componentDescriptor:descriptor
                               viewController:viewController extra:extra];

    return irSegmentedControl;
}

+ (void) setUpComponent:(IRSegmentedControl *)irSegmentedControl
    componentDescriptor:(IRSegmentedControlDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irSegmentedControl componentDescriptor:descriptor viewController:viewController
                            extra:extra];
    [IRBaseBuilder setUpUIControlInterfaceForComponent:irSegmentedControl fromDescriptor:descriptor];

    irSegmentedControl.momentary = descriptor.momentary;
    IRSegment *anSegment;
    BOOL segmentInserted;
    NSUInteger segmentIndex = 0;
    for (NSUInteger i = 0; i < [descriptor.segmentsArray count]; i++) {
        anSegment = descriptor.segmentsArray[i];
        segmentInserted = NO;
        if ([anSegment.title length] > 0) {
            segmentInserted = YES;
            [irSegmentedControl insertSegmentWithTitle:[IRBaseBuilder textWithI18NCheck:anSegment.title]
                                               atIndex:segmentIndex animated:NO];
        } else if ([anSegment.image length] > 0) {
            segmentInserted = YES;
            [irSegmentedControl insertSegmentWithImage:[IRUtil imagePrefixedWithBaseUrlIfNeeded:anSegment.image]
                                               atIndex:segmentIndex animated:NO];
        }
        if (segmentInserted) {
            [irSegmentedControl setEnabled:anSegment.enabled forSegmentAtIndex:segmentIndex];
            if (anSegment.selected) {
                [irSegmentedControl setSelectedSegmentIndex:segmentIndex];
            }
            [irSegmentedControl setContentOffset:anSegment.contentOffset forSegmentAtIndex:segmentIndex];
            segmentIndex++;
        }
    }
}

@end