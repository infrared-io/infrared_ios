//
// Created by Uros Milivojevic on 12/17/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRTableAndCollectionViewBuilder+AutoLayout.h"
#import "IRComponentInfoProtocol.h"
#import "IRView.h"
#import "IRTableViewCell.h"
#import "IRViewDescriptor.h"
#import "IRTableViewCellDescriptor.h"
#import "IRLayoutConstraintICSPriorityDescriptor.h"
#import "IRLayoutConstraintWithVFDescriptor.h"
#import "IRLayoutConstraintWithItemDescriptor.h"
#import "IRCollectionViewCell.h"
#import "IRLayoutConstraintMetricsDescriptor.h"
#import "IRBaseBuilder+AutoLayout.h"
#import "IRCollectionViewCell.h"
#import "IRTableAndCollectionViewBuilder.h"


@implementation IRTableAndCollectionViewBuilder (AutoLayout)

+ (void) addAutoLayoutConstraintsForTableViewCell:(IRTableViewCell *)irTableViewCell
{
    // -- layoutConstraintsArray
    [IRTableAndCollectionViewBuilder setLayoutConstraintsForView:irTableViewCell.contentView
                                            fromDescriptorsArray:((IRViewDescriptor *) irTableViewCell.descriptor).layoutConstraintsArray
                                                     inRootViews:irTableViewCell.contentView.subviews];
    // -- intrinsicContentSizePriorityArray
    [IRTableAndCollectionViewBuilder setLayoutConstraintsForView:irTableViewCell.contentView
                                            fromDescriptorsArray:((IRViewDescriptor *) irTableViewCell.descriptor).intrinsicContentSizePriorityArray
                                                     inRootViews:irTableViewCell.contentView.subviews];
    [IRTableAndCollectionViewBuilder addAutoLayoutConstraintsForView:(IRView *) irTableViewCell.backgroundView
                                                         inRootViews:@[irTableViewCell]];
    [IRTableAndCollectionViewBuilder addAutoLayoutConstraintsForView:(IRView *) irTableViewCell.selectedBackgroundView
                                                         inRootViews:@[irTableViewCell]];
    [IRTableAndCollectionViewBuilder addAutoLayoutConstraintsForView:(IRView *) irTableViewCell.multipleSelectionBackgroundView
                                                         inRootViews:@[irTableViewCell]];
    [IRTableAndCollectionViewBuilder addAutoLayoutConstraintsForView:(IRView *) irTableViewCell.accessoryView
                                                         inRootViews:@[irTableViewCell]];
    [IRTableAndCollectionViewBuilder addAutoLayoutConstraintsForView:(IRView *) irTableViewCell.editingAccessoryView
                                                         inRootViews:@[irTableViewCell]];
}

+ (void) addAutoLayoutConstraintsForCollectionViewCell:(IRCollectionViewCell *)irCollectionViewCell
{
    // -- layoutConstraintsArray
    [IRTableAndCollectionViewBuilder setLayoutConstraintsForView:irCollectionViewCell.contentView
                                            fromDescriptorsArray:((IRViewDescriptor *) irCollectionViewCell.descriptor).layoutConstraintsArray
                                                     inRootViews:irCollectionViewCell.contentView.subviews];
    // -- intrinsicContentSizePriorityArray
    [IRTableAndCollectionViewBuilder setLayoutConstraintsForView:irCollectionViewCell.contentView
                                            fromDescriptorsArray:((IRViewDescriptor *) irCollectionViewCell.descriptor).intrinsicContentSizePriorityArray
                                                     inRootViews:irCollectionViewCell.contentView.subviews];
    [IRTableAndCollectionViewBuilder addAutoLayoutConstraintsForView:(IRView *) irCollectionViewCell.backgroundView
                                                         inRootViews:@[irCollectionViewCell]];
    [IRTableAndCollectionViewBuilder addAutoLayoutConstraintsForView:(IRView *) irCollectionViewCell.selectedBackgroundView
                                                         inRootViews:@[irCollectionViewCell]];
}

+ (void) addAutoLayoutConstraintsForViewsArray:(NSArray *)viewsArray
                                   inRootViews:(NSArray *)rootViewsArray
{
    for (IRView *anIRView in viewsArray) {
        if ([anIRView conformsToProtocol:@protocol(IRComponentInfoProtocol)]) {
            [IRTableAndCollectionViewBuilder addAutoLayoutConstraintsForView:anIRView inRootViews:rootViewsArray];
        }
    }
}

+ (void) addAutoLayoutConstraintsForView:(IRView *)irView
                             inRootViews:(NSArray *)rootViewsArray
{
    if ([irView conformsToProtocol:@protocol(IRComponentInfoProtocol)]) {
        [IRTableAndCollectionViewBuilder setLayoutConstraintsForView:irView
                                                fromDescriptorsArray:((IRViewDescriptor *) irView.descriptor).layoutConstraintsArray
                                                         inRootViews:rootViewsArray];
        [IRTableAndCollectionViewBuilder setLayoutConstraintsForView:irView
                                                fromDescriptorsArray:((IRViewDescriptor *) irView.descriptor).intrinsicContentSizePriorityArray
                                                         inRootViews:rootViewsArray];
    }
}

+ (void) setLayoutConstraintsForView:(UIView *)uiView
                fromDescriptorsArray:(NSArray *)descriptorsArray
                         inRootViews:(NSArray *)rootViewsArray
{
    NSLayoutConstraint *constraint;
    NSArray *constraintsArray;
    for (IRLayoutConstraintDescriptor *descriptor in descriptorsArray) {
        constraintsArray = nil;
        if ([descriptor isKindOfClass:[IRLayoutConstraintICSPriorityDescriptor class]]) {
            if (((IRLayoutConstraintICSPriorityDescriptor *)descriptor).contentRelationType == LayoutConstraintICSTypeCompressionResistance) {
                [uiView setContentCompressionResistancePriority:[descriptor.priority floatValue]
                                                        forAxis:((IRLayoutConstraintICSPriorityDescriptor *)descriptor).forAxis];
                uiView.translatesAutoresizingMaskIntoConstraints = NO;
            }
            if (((IRLayoutConstraintICSPriorityDescriptor *)descriptor).contentRelationType == LayoutConstraintICSTypeHugging) {
                [uiView setContentHuggingPriority:[descriptor.priority floatValue]
                                          forAxis:((IRLayoutConstraintICSPriorityDescriptor *)descriptor).forAxis];
                uiView.translatesAutoresizingMaskIntoConstraints = NO;
            }
        } else if ([descriptor isKindOfClass:[IRLayoutConstraintWithVFDescriptor class]]) {
            constraintsArray = [IRTableAndCollectionViewBuilder buildLayoutConstraintsWithVisualFormat:(IRLayoutConstraintWithVFDescriptor *) descriptor
                                                                                           inRootViews:rootViewsArray];
        } else if ([descriptor isKindOfClass:[IRLayoutConstraintWithItemDescriptor class]]) {
            constraint = [IRTableAndCollectionViewBuilder buildLayoutConstraintsWithItem:(IRLayoutConstraintWithItemDescriptor *) descriptor
                                                                             inRootViews:rootViewsArray];
            if (constraint) {
                constraintsArray = @[constraint];
            }
        }

        if (constraintsArray) {
            if (CGRectIsEmpty(uiView.frame)) {
                uiView.translatesAutoresizingMaskIntoConstraints = NO;
            }
            [uiView addConstraints:constraintsArray];
        }
    }

    if ([uiView.subviews count] > 0) {
        [IRTableAndCollectionViewBuilder addAutoLayoutConstraintsForViewsArray:uiView.subviews inRootViews:nil];
    }
}

+ (NSArray *) buildLayoutConstraintsWithVisualFormat:(IRLayoutConstraintWithVFDescriptor *)descriptor
                                         inRootViews:(NSArray *)rootViewsArray
{
    NSArray *constraintsArray = nil;
    NSMutableArray *parsedViewIdsArray;
    NSMutableDictionary *viewDictionary;
    IRView *irView;

    if ([descriptor.visualFormat length] > 0) {
        viewDictionary = [NSMutableDictionary dictionary];
        parsedViewIdsArray = [IRBaseBuilder parseViewIdsFromVisualFormat:descriptor.visualFormat];
//        for (NSString *anViewId in descriptor.views) {
        for (NSString *anViewId in parsedViewIdsArray) {
            irView = [IRTableAndCollectionViewBuilder cellSubviewWithId:anViewId inRootViews:rootViewsArray];
            if (irView) {
                viewDictionary[anViewId] = irView;
                irView.translatesAutoresizingMaskIntoConstraints = NO;
            }
        }
        constraintsArray = [NSLayoutConstraint constraintsWithVisualFormat:descriptor.visualFormat
                                                                   options:descriptor.options
                                                                   metrics:descriptor.metrics.values
                                                                     views:viewDictionary];
        if (descriptor.priority) {
            for (NSLayoutConstraint *anConstraint in constraintsArray) {
                anConstraint.priority = [descriptor.priority floatValue];
            }
        }
    }
    return constraintsArray;
}

+ (NSLayoutConstraint *) buildLayoutConstraintsWithItem:(IRLayoutConstraintWithItemDescriptor *)descriptor
                                            inRootViews:(NSArray *)rootViewsArray
{
    NSLayoutConstraint *constraint = nil;
    IRView *withItem = [IRTableAndCollectionViewBuilder cellSubviewWithId:descriptor.withItem inRootViews:rootViewsArray];
    IRView *toItem = [IRTableAndCollectionViewBuilder cellSubviewWithId:descriptor.toItem inRootViews:rootViewsArray];
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

+ (IRView *) cellSubviewWithId:(NSString *)viewId
                   inRootViews:(NSArray *)rootViewsArray
{
    IRView *irView = nil;
    IRView *returnedView;
    for (IRView *anIRView in rootViewsArray) {
        if ([anIRView conformsToProtocol:@protocol(IRComponentInfoProtocol)]) {
            if ([anIRView.descriptor.componentId isEqualToString:viewId]) {
                irView = anIRView;
                break;
            } else {
                returnedView = [IRTableAndCollectionViewBuilder cellSubviewWithId:viewId inRootViews:anIRView.subviews];
                if (returnedView) {
                    irView = returnedView;
                    break;
                }
            }
        }
    }
    return irView;
}

@end