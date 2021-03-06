//
// Created by Uros Milivojevic on 6/22/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewDescriptor.h"


@interface IRCollectionViewCellDescriptor : IRViewDescriptor

// Cells become highlighted when the user touches them.
// The selected state is toggled when the user lifts up from a highlighted cell.
// Override these methods to provide custom UI for a selected or highlighted state.
// The collection view may call the setters inside an animation block.
@property (nonatomic, getter=isSelected) BOOL selected;
@property (nonatomic, getter=isHighlighted) BOOL highlighted;

// The background view is a subview behind all other views.
// If selectedBackgroundView is different than backgroundView, it will be placed above the background view and animated in on selection.
@property (nonatomic, retain) IRViewDescriptor *backgroundView;
@property (nonatomic, retain) IRViewDescriptor *selectedBackgroundView;

// --------------------------------------------------------------------------------------------------------------------

@property (nonatomic, strong) NSString *selectItemAction;

@property (nonatomic) CGSize cellSize;
#if TARGET_OS_IPHONE
@property (nonatomic) UIEdgeInsets insets;
#endif

@end