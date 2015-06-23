//
// Created by Uros Milivojevic on 12/12/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRTableViewCellBuilder.h"
#import "IRComponentInfoProtocol.h"
#import "IRView.h"
#import "IRTableViewCell.h"
#import "IRViewBuilder.h"
#import "IRTableViewBuilder+AutoLayout.h"
#import "IRScreenDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRViewController.h"
#import "IRTableViewCellDescriptor.h"


@implementation IRTableViewCellBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRTableViewCell *irTableViewCell;

    // -- build cell
    irTableViewCell = [[IRTableViewCell alloc] initWithStyle:((IRTableViewCellDescriptor *)descriptor).style reuseIdentifier:descriptor.componentId];
    // -- set up cell
    [IRTableViewCellBuilder setUpComponent:irTableViewCell componentDescriptor:descriptor viewController:viewController
                                     extra:extra];
    // -- add AutoLayout constraints
    [IRTableViewBuilder addAutoLayoutConstraintsForTableViewCell:irTableViewCell];

    return irTableViewCell;
}

+ (void) setUpComponent:(IRTableViewCell *)irTableViewCell
    componentDescriptor:(IRTableViewCellDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irTableViewCell componentDescriptor:descriptor viewController:viewController
                            extra:extra];

    irTableViewCell.backgroundView = [IRBaseBuilder buildComponentFromDescriptor:descriptor.backgroundView
                                                                  viewController:viewController extra:extra];
    irTableViewCell.selectedBackgroundView = [IRBaseBuilder buildComponentFromDescriptor:descriptor.selectedBackgroundView
                                                                          viewController:viewController extra:extra];
    irTableViewCell.multipleSelectionBackgroundView = [IRBaseBuilder buildComponentFromDescriptor:descriptor.multipleSelectionBackgroundView
                                                                                   viewController:viewController
                                                                                            extra:extra];
    irTableViewCell.selectionStyle = descriptor.selectionStyle;
    irTableViewCell.selected = descriptor.selected;
    irTableViewCell.highlighted = descriptor.highlighted;
    irTableViewCell.showsReorderControl = descriptor.showsReorderControl;
    irTableViewCell.shouldIndentWhileEditing = descriptor.shouldIndentWhileEditing;
    irTableViewCell.accessoryType = descriptor.accessoryType;
    irTableViewCell.accessoryView = [IRBaseBuilder buildComponentFromDescriptor:descriptor.accessoryView
                                                                 viewController:viewController extra:extra];
    irTableViewCell.editingAccessoryType = descriptor.editingAccessoryType;
    irTableViewCell.editingAccessoryView = [IRBaseBuilder buildComponentFromDescriptor:descriptor.editingAccessoryView
                                                                        viewController:viewController extra:extra];
    irTableViewCell.indentationLevel = descriptor.indentationLevel;
    irTableViewCell.indentationWidth = descriptor.indentationWidth;
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.separatorInset, UIEdgeInsetsNull) == NO) {
        irTableViewCell.separatorInset = descriptor.separatorInset;
    }
    irTableViewCell.editing = descriptor.editing;
}

@end