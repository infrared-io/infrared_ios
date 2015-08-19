//
// Created by Uros Milivojevic on 10/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRBaseBuilder+AutoLayout.h"
#import "IRLayoutConstraintDescriptor.h"
#import "IRLayoutConstraintICSPriorityDescriptor.h"
#import "IRLayoutConstraintWithVFDescriptor.h"
#import "IRLayoutConstraintWithItemDescriptor.h"
#import "IRScreenDescriptor.h"
#import "Infrared.h"
#import "IRDataController.h"
#import "IRLayoutConstraintMetricsDescriptor.h"
#import "IRViewController.h"
#import "IRView.h"
#import "IRViewDescriptor.h"
#import "IRTableViewCell.h"
#import "IRTableView.h"
#import "IRScreenDescriptor.h"
#import "IRViewController.h"


@implementation IRBaseBuilder (AutoLayout)

+ (void) addAutoLayoutConstraintsForViewsArray:(NSArray *)viewsArray
                                viewController:(IRViewController *)viewController
{
    for (IRView *anIRView in viewsArray) {
        if ([anIRView conformsToProtocol:@protocol(IRComponentInfoProtocol)]) {
            [IRBaseBuilder addAutoLayoutConstraintsForView:anIRView
                                                descriptor:anIRView.descriptor
                                            viewController:viewController];
        }
    }
}

+ (void) addAutoLayoutConstraintsForView:(UIView *)irView
                              descriptor:(IRViewDescriptor *)descriptor
                          viewController:(IRViewController *)viewController
{
    NSMutableArray *constrainsArray = [NSMutableArray array];
    // -- layoutConstraintsArray
    if ([descriptor.layoutConstraintsArray count] > 0) {
        [constrainsArray addObjectsFromArray:descriptor.layoutConstraintsArray];
    }
//    [IRBaseBuilder setLayoutConstraintsForView:irView
//                          fromDescriptorsArray:descriptor.layoutConstraintsArray
//                                viewController:viewController];
    // -- intrinsicContentSizePriorityArray
    if ([descriptor.intrinsicContentSizePriorityArray count] > 0) {
        [constrainsArray addObjectsFromArray:descriptor.intrinsicContentSizePriorityArray];
    }
//    [IRBaseBuilder setLayoutConstraintsForView:irView
//                          fromDescriptorsArray:descriptor.intrinsicContentSizePriorityArray
//                                viewController:viewController];

    [IRBaseBuilder setLayoutConstraintsForView:irView
                          fromDescriptorsArray:constrainsArray
                                viewController:viewController];
}

+ (void) setLayoutConstraintsForView:(UIView *)uiView
                fromDescriptorsArray:(NSArray *)descriptorsArray
                      viewController:(IRViewController *)viewController
{
    NSLayoutConstraint *constraint;
    NSArray *constraintsArray;
    for (IRLayoutConstraintDescriptor *descriptor in descriptorsArray) {
        constraintsArray = nil;
        if ([descriptor isKindOfClass:[IRLayoutConstraintICSPriorityDescriptor class]]) {
            if (((IRLayoutConstraintICSPriorityDescriptor *) descriptor).contentRelationType == LayoutConstraintICSTypeCompressionResistance) {
                [uiView setContentCompressionResistancePriority:[descriptor.priority floatValue]
                                                        forAxis:((IRLayoutConstraintICSPriorityDescriptor *) descriptor).forAxis];
                uiView.translatesAutoresizingMaskIntoConstraints = NO;
            }
            if (((IRLayoutConstraintICSPriorityDescriptor *) descriptor).contentRelationType == LayoutConstraintICSTypeHugging) {
                [uiView setContentHuggingPriority:[descriptor.priority floatValue]
                                          forAxis:((IRLayoutConstraintICSPriorityDescriptor *) descriptor).forAxis];
                uiView.translatesAutoresizingMaskIntoConstraints = NO;
            }
        } else if ([descriptor isKindOfClass:[IRLayoutConstraintWithVFDescriptor class]]) {
            constraintsArray = [IRBaseBuilder buildLayoutConstraintsWithVisualFormat:(IRLayoutConstraintWithVFDescriptor *) descriptor
                                                                      viewController:viewController];
        } else if ([descriptor isKindOfClass:[IRLayoutConstraintWithItemDescriptor class]]) {
            constraint = [IRBaseBuilder buildLayoutConstraintsWithItem:(IRLayoutConstraintWithItemDescriptor *) descriptor
                                                        viewController:viewController];
            if (constraint) {
                constraintsArray = @[constraint];
            }
        }

        if (constraintsArray) {
            if (CGRectIsEmpty(uiView.frame)) {
                uiView.translatesAutoresizingMaskIntoConstraints = NO;
            }
            if ([uiView conformsToProtocol:@protocol(IRAutoLayoutSubComponentsProtocol)]) {
                id <IRAutoLayoutSubComponentsProtocol> component = (id <IRAutoLayoutSubComponentsProtocol>) uiView;
                if (component.translatesAutoresizingMaskIntoConstraintsValue) {
                    uiView.translatesAutoresizingMaskIntoConstraints = [component.translatesAutoresizingMaskIntoConstraintsValue boolValue];
                }
            }
            [uiView addConstraints:constraintsArray];
            for (NSLayoutConstraint *anConstraint in constraintsArray) {
                if (anConstraint.firstAttribute == NSLayoutAttributeBottom || anConstraint.secondAttribute == NSLayoutAttributeBottom) {
                    IRView *secondView = anConstraint.secondItem;
                    IRViewDescriptor *secondViewDescriptor;
                    if ([secondView conformsToProtocol:@protocol(IRComponentInfoProtocol)]) {
                        secondViewDescriptor = (IRViewDescriptor *) secondView.descriptor;
                        if (secondViewDescriptor.autoLayoutKeyboardHandling) {
                            [viewController addViewForKeyboardResize:secondView
                                                    bottomConstraint:anConstraint];
                        }
                    }
                }
            }
        }
    }

    if ([uiView conformsToProtocol:@protocol(IRAutoLayoutSubComponentsProtocol)]) {
        id <IRAutoLayoutSubComponentsProtocol> component = (id <IRAutoLayoutSubComponentsProtocol>) uiView;
        NSArray *subComponentsArray = [component subComponentsArray];
        for (id anComponent in subComponentsArray) {
            if ([anComponent isKindOfClass:[NSArray class]]) {
                [IRBaseBuilder addAutoLayoutConstraintsForViewsArray:anComponent viewController:viewController];
            } else {
                [IRBaseBuilder addAutoLayoutConstraintsForView:anComponent
                                                    descriptor:((IRView *)anComponent).descriptor
                                                viewController:viewController];
            }
        }
    } else {
        if ([uiView.subviews count] > 0) {
            [IRBaseBuilder addAutoLayoutConstraintsForViewsArray:uiView.subviews viewController:viewController];
        }
    }
}

+ (NSArray *) buildLayoutConstraintsWithVisualFormat:(IRLayoutConstraintWithVFDescriptor *)descriptor
                                      viewController:(IRViewController *)viewController
{
    NSArray *constraintsArray = nil;
    NSMutableDictionary *viewDictionary;
    NSMutableArray *parsedViewIdsArray;
    UIView *uiView;

    if ([descriptor.visualFormat length] > 0) {
        parsedViewIdsArray = [IRBaseBuilder parseViewIdsFromVisualFormat:descriptor.visualFormat];
        viewDictionary = [NSMutableDictionary dictionary];
//        for (NSString *anViewId in descriptor.views) {
        for (NSString *anViewId in parsedViewIdsArray) {
            uiView = [[IRDataController sharedInstance] viewWithId:anViewId viewController:viewController];
            if (uiView) {
                viewDictionary[anViewId] = uiView;
                uiView.translatesAutoresizingMaskIntoConstraints = NO;
            }
        }
        @try {
            constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:descriptor.visualFormat
                                                                       options:descriptor.options
                                                                       metrics:descriptor.metrics.values
                                                                         views:viewDictionary];
        }
        @catch (NSException *exception) {
            NSLog(@"'buildLayoutConstraintsWithVisualFormat:viewController:' - Exception: %@, %@", exception, [exception userInfo]);
        }
        if (descriptor.priority) {
            for (NSLayoutConstraint *anConstraint in constraintsArray) {
                anConstraint.priority = [descriptor.priority floatValue];
            }
        }
    }
    return constraintsArray;
}
+ (NSMutableArray *) parseViewIdsFromVisualFormat:(NSString *)visualFormat
{
    NSMutableArray *parsedViewIdsArray = [NSMutableArray array];
    NSRegularExpression *regex;

    if ([visualFormat length] > 0) {
        regex = [NSRegularExpression regularExpressionWithPattern:@"(?<=\\[)(.*?)(?=\\]|\\()"
                                                          options:NSRegularExpressionCaseInsensitive
                                                            error:nil];
        [regex enumerateMatchesInString:visualFormat options:0
                                  range:NSMakeRange(0, [visualFormat length])
                             usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop)
                             {
                                 for (int i = 1; i< [result numberOfRanges] ; i++) {
                                     NSString *match = [visualFormat substringWithRange:[result rangeAtIndex:i]];
                                     [parsedViewIdsArray addObject:match];
                                 }
                             }];
    }

    return parsedViewIdsArray;
}

+ (NSLayoutConstraint *) buildLayoutConstraintsWithItem:(IRLayoutConstraintWithItemDescriptor *)descriptor
                                         viewController:(IRViewController *)viewController
{
    NSLayoutConstraint *constraint = nil;
    UIView *withItem = [[IRDataController sharedInstance] viewWithId:descriptor.withItem viewController:viewController];
    UIView *toItem = [[IRDataController sharedInstance] viewWithId:descriptor.toItem viewController:viewController];
    if (withItem /*&& toItem*/) {
        withItem.translatesAutoresizingMaskIntoConstraints = NO;
        toItem.translatesAutoresizingMaskIntoConstraints = NO;
        constraint = [NSLayoutConstraint constraintWithItem:withItem
                                                  attribute:descriptor.withItemAttribute
                                                  relatedBy:descriptor.relatedBy
                                                     toItem:toItem
                                                  attribute:descriptor.toItemAttribute
                                                 multiplier:[descriptor.multiplier floatValue]
                                                   constant:[descriptor.constant floatValue]];
        if (descriptor.priority) {
            constraint.priority = [descriptor.priority floatValue];
        }
    }
    return constraint;
}

@end