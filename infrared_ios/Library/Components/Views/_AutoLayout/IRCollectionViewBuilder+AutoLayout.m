//
// Created by Uros Milivojevic on 6/23/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRCollectionViewBuilder+AutoLayout.h"
#import "IRCollectionViewCell.h"
#import "IRTableViewBuilder.h"
#import "IRViewDescriptor.h"
#import "IRTableViewBuilder+AutoLayout.h"


@implementation IRCollectionViewBuilder (AutoLayout)

+ (void) addAutoLayoutConstraintsForCollectionViewCell:(IRCollectionViewCell *)irCollectionViewCell
{
    // -- layoutConstraintsArray
    [IRTableViewBuilder setLayoutConstraintsForView:irCollectionViewCell.contentView
                               fromDescriptorsArray:((IRViewDescriptor *) irCollectionViewCell.descriptor).layoutConstraintsArray
                                        inRootViews:irCollectionViewCell.contentView.subviews];
    // -- intrinsicContentSizePriorityArray
    [IRTableViewBuilder setLayoutConstraintsForView:irCollectionViewCell.contentView
                               fromDescriptorsArray:((IRViewDescriptor *) irCollectionViewCell.descriptor).intrinsicContentSizePriorityArray
                                        inRootViews:irCollectionViewCell.contentView.subviews];
    [IRTableViewBuilder addAutoLayoutConstraintsForView:(IRView *) irCollectionViewCell.backgroundView
                                            inRootViews:@[irCollectionViewCell]];
    [IRTableViewBuilder addAutoLayoutConstraintsForView:(IRView *) irCollectionViewCell.selectedBackgroundView
                                            inRootViews:@[irCollectionViewCell]];
}

@end