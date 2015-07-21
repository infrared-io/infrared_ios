//
// Created by Uros Milivojevic on 7/21/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@protocol JSExport;

@protocol MKAnnotationViewExport <JSExport>

- (instancetype)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, readonly) NSString *reuseIdentifier;

// Classes that override must call super.
- (void)prepareForReuse;

@property (nonatomic, strong) id <MKAnnotation> annotation;

#if TARGET_OS_IPHONE
@property (nonatomic, strong) UIImage *image;
#else
@property (nonatomic, strong) NSImage *image;
#endif

// By default, the center of annotation view is placed over the coordinate of the annotation.
// centerOffset is the offset in screen points from the center of the annotion view.
@property (nonatomic) CGPoint centerOffset;

// calloutOffset is the offset in screen points from the top-middle of the annotation view, where the anchor of the callout should be shown.
@property (nonatomic) CGPoint calloutOffset;

#if !TARGET_OS_IPHONE
// leftCalloutOffset is the offset in screen points from the middle-left of the annotation view, where the anchor of the callout should be shown when oriented off the left side of the annotation view
@property (nonatomic) CGPoint leftCalloutOffset;

// rightCalloutOffset is the offset in screen points from the middle-right of the annotation view, where the anchor of the callout should be shown when oriented off the right side of the annotation view
@property (nonatomic) CGPoint rightCalloutOffset;
#endif

// Defaults to YES. If NO, ignores touch events and subclasses may draw differently.
@property (nonatomic, getter=isEnabled) BOOL enabled;

// Defaults to NO. This gets set/cleared automatically when touch enters/exits during tracking and cleared on up.
@property (nonatomic, getter=isHighlighted) BOOL highlighted;

// Defaults to NO. Becomes YES when tapped/clicked on in the map view.
@property (nonatomic, getter=isSelected) BOOL selected;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

// If YES, a standard callout bubble will be shown when the annotation is selected.
// The annotation must have a title for the callout to be shown.
@property (nonatomic) BOOL canShowCallout;

// The left accessory view to be used in the standard callout.
#if TARGET_OS_IPHONE
@property (strong, nonatomic) UIView *leftCalloutAccessoryView;
#else
@property (strong, nonatomic) NSView *leftCalloutAccessoryView;
#endif

// The right accessory view to be used in the standard callout.
#if TARGET_OS_IPHONE
@property (strong, nonatomic) UIView *rightCalloutAccessoryView;
#else
@property (strong, nonatomic) NSView *rightCalloutAccessoryView;
#endif

// If YES and the underlying id<MKAnnotation> responds to setCoordinate:,
// the user will be able to drag this annotation view around the map.
@property (nonatomic, getter=isDraggable) BOOL draggable NS_AVAILABLE(10_9, 4_0);

// Automatically set to MKAnnotationViewDragStateStarting, Canceling, and Ending when necessary.
// Implementer is responsible for transitioning to Dragging and None states as appropriate.
@property (nonatomic) MKAnnotationViewDragState dragState NS_AVAILABLE(10_9, 4_0);

// Developers targeting iOS 4.2 and after must use setDragState:animated: instead of setDragState:.
- (void)setDragState:(MKAnnotationViewDragState)newDragState animated:(BOOL)animated NS_AVAILABLE(10_9, 4_2);

@end