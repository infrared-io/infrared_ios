//
// Created by Uros Milivojevic on 1/12/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRViewDescriptor.h"


@interface IRBaseAnnotationViewDescriptor : IRViewDescriptor

@property (nonatomic, strong) NSString *image;

// By default, the center of annotation view is placed over the coordinate of the annotation.
// centerOffset is the offset in screen points from the center of the annotion view.
@property (nonatomic) CGPoint centerOffset;

// calloutOffset is the offset in screen points from the top-middle of the annotation view, where the anchor of the callout should be shown.
@property (nonatomic) CGPoint calloutOffset;

@property (nonatomic/*, getter=isEnabled*/) BOOL enabled;

// Defaults to NO. This gets set/cleared automatically when touch enters/exits during tracking and cleared on up.
@property (nonatomic/*, getter=isHighlighted*/) BOOL highlighted;

// Defaults to NO. Becomes YES when tapped/clicked on in the map view.
@property (nonatomic/*, getter=isSelected*/) BOOL selected;

// If YES, a standard callout bubble will be shown when the annotation is selected.
// The annotation must have a title for the callout to be shown.
@property (nonatomic) BOOL canShowCallout;

// The left accessory view to be used in the standard callout.
@property (strong, nonatomic) IRViewDescriptor *leftCalloutAccessoryView;

// The right accessory view to be used in the standard callout.
@property (strong, nonatomic) IRViewDescriptor *rightCalloutAccessoryView;

// If YES and the underlying id<MKAnnotation> responds to setCoordinate:,
// the user will be able to drag this annotation view around the map.
@property (nonatomic/*, getter=isDraggable*/) BOOL draggable /*NS_AVAILABLE(10_9, 4_0)*/;

@property (nonatomic, strong) NSString *selectAnnotationAction;
@property (nonatomic, strong) NSString *deselectAnnotationAction;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths;

@end