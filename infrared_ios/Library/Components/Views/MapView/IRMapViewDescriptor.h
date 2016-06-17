//
// Created by Uros Milivojevic on 12/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "IRViewDescriptor.h"


@interface IRMapViewDescriptor : IRViewDescriptor

// Changing the map type or region can cause the map to start loading map content.
// The loading delegate methods will be called as map content is loaded.
@property (nonatomic) MKMapType mapType;

// Region is the coordinate and span of the map.
// Region may be modified to fit the aspect ratio of the view using regionThatFits:.
@property (nonatomic) MKCoordinateRegion region;

// centerCoordinate allows the coordinate of the region to be changed without changing the zoom level.
@property (nonatomic) CLLocationCoordinate2D centerCoordinate;

// Access the visible region of the map in projected coordinates.
@property (nonatomic) MKMapRect visibleMapRect;

// Control the types of user interaction available
// Zoom and scroll are enabled by default.
@property (nonatomic/*, getter=isZoomEnabled*/) BOOL zoomEnabled;
@property (nonatomic/*, getter=isScrollEnabled*/) BOOL scrollEnabled;
// Rotate and pitch are enabled by default on Mac OS X and on iOS 7.0 and later.
@property (nonatomic/*, getter=isRotateEnabled*/) BOOL rotateEnabled /*NS_AVAILABLE(10_9, 7_0)*/;
@property (nonatomic/*, getter=isPitchEnabled*/) BOOL pitchEnabled /*NS_AVAILABLE(10_9, 7_0)*/;

@property (nonatomic) BOOL showsPointsOfInterest /*NS_AVAILABLE(10_9, 7_0)*/; // Affects MKMapTypeStandard and MKMapTypeHybrid
@property (nonatomic) BOOL showsBuildings /*NS_AVAILABLE(10_9, 7_0)*/; // Affects MKMapTypeStandard

// Set to YES to add the user location annotation to the map and start updating its location
@property (nonatomic) BOOL showsUserLocation;

@property (nonatomic, strong) NSString *selectAnnotationAction;
@property (nonatomic, strong) NSString *deselectAnnotationAction;

@property (nonatomic, strong) NSArray *annotationsArray;

@property (nonatomic, /*readonly*/strong) NSArray *mapData;

@property (nonatomic, strong) NSString *annotationItemName;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor;

+ (CLLocationCoordinate2D) CLLocationCoordinate2DFromDictionary:(NSDictionary *)dictionary;

+ (MKPinAnnotationColor) pinColorFromString:(NSString *)string;

@end