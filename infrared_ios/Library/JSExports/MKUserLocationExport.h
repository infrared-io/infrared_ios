//
// Created by Uros Milivojevic on 3/13/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <MapKit/MapKit.h>

@protocol MKUserLocationExport <JSExport>

// Returns YES if the user's location is being updated.
@property (readonly, nonatomic, getter=isUpdating) BOOL updating;

// Returns nil if the owning MKMapView's showsUserLocation is NO or the user's location has yet to be determined.
@property (readonly, nonatomic) CLLocation *location;

// Returns nil if not in MKUserTrackingModeFollowWithHeading
@property (readonly, nonatomic) CLHeading *heading NS_AVAILABLE(10_9, 5_0);

// The title to be displayed for the user location annotation.
@property (nonatomic, copy) NSString *title;

// The subtitle to be displayed for the user location annotation.
@property (nonatomic, copy) NSString *subtitle;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@protocol CLLocationExport <JSExport>

/*
 *  coordinate
 *
 *  Discussion:
 *    Returns the coordinate of the current location.
 */
@property(readonly, nonatomic) CLLocationCoordinate2D coordinate;

/*
 *  altitude
 *
 *  Discussion:
 *    Returns the altitude of the location. Can be positive (above sea level) or negative (below sea level).
 */
@property(readonly, nonatomic) CLLocationDistance altitude;

/*
 *  horizontalAccuracy
 *
 *  Discussion:
 *    Returns the horizontal accuracy of the location. Negative if the lateral location is invalid.
 */
@property(readonly, nonatomic) CLLocationAccuracy horizontalAccuracy;

/*
 *  verticalAccuracy
 *
 *  Discussion:
 *    Returns the vertical accuracy of the location. Negative if the altitude is invalid.
 */
@property(readonly, nonatomic) CLLocationAccuracy verticalAccuracy;

/*
 *  course
 *
 *  Discussion:
 *    Returns the course of the location in degrees true North. Negative if course is invalid.
 *
 *  Range:
 *    0.0 - 359.9 degrees, 0 being true North
 */
@property(readonly, nonatomic) CLLocationDirection course __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_2_2);

/*
 *  speed
 *
 *  Discussion:
 *    Returns the speed of the location in m/s. Negative if speed is invalid.
 */
@property(readonly, nonatomic) CLLocationSpeed speed __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_2_2);

/*
 *  timestamp
 *
 *  Discussion:
 *    Returns the timestamp when this location was determined.
 */
@property(readonly, nonatomic, copy) NSDate *timestamp;

/*
 *  floor
 *
 *  Discussion:
 *    Contains information about the logical floor that you are on
 *    in the current building if you are inside a supported venue.
 *    This will be nil if the floor is unavailable.
 */
@property(readonly, nonatomic, copy) CLFloor *floor __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_8_0);

/*
 *  description
 *
 *  Discussion:
 *    Returns a string representation of the location.
 */
@property (nonatomic, readonly, copy) NSString *description;

/*
 *  getDistanceFrom:
 *
 *  Discussion:
 *    Deprecated. Use -distanceFromLocation: instead.
 */
- (CLLocationDistance)getDistanceFrom:(const CLLocation *)location __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_3_2);

/*
 *  distanceFromLocation:
 *
 *  Discussion:
 *    Returns the lateral distance between two locations.
 */
- (CLLocationDistance)distanceFromLocation:(const CLLocation *)location __OSX_AVAILABLE_STARTING(__MAC_10_6,__IPHONE_3_2);

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@protocol CLHeadingExport <JSExport>

/*
 *  magneticHeading
 *
 *  Discussion:
 *    Represents the direction in degrees, where 0 degrees is magnetic North. The direction is referenced from the top of the device regardless of device orientation as well as the orientation of the user interface.
 *
 *  Range:
 *    0.0 - 359.9 degrees, 0 being magnetic North
 */
@property(readonly, nonatomic) CLLocationDirection magneticHeading;

/*
 *  trueHeading
 *
 *  Discussion:
 *    Represents the direction in degrees, where 0 degrees is true North. The direction is referenced
 *    from the top of the device regardless of device orientation as well as the orientation of the
 *    user interface.
 *
 *  Range:
 *    0.0 - 359.9 degrees, 0 being true North
 */
@property(readonly, nonatomic) CLLocationDirection trueHeading;

/*
 *  headingAccuracy
 *
 *  Discussion:
 *    Represents the maximum deviation of where the magnetic heading may differ from the actual geomagnetic heading in degrees. A negative value indicates an invalid heading.
 */
@property(readonly, nonatomic) CLLocationDirection headingAccuracy;

/*
 *  x
 *
 *  Discussion:
 *    Returns a raw value for the geomagnetism measured in the x-axis.
 *
 */
@property(readonly, nonatomic) CLHeadingComponentValue x;

/*
 *  y
 *
 *  Discussion:
 *    Returns a raw value for the geomagnetism measured in the y-axis.
 *
 */
@property(readonly, nonatomic) CLHeadingComponentValue y;

/*
 *  z
 *
 *  Discussion:
 *    Returns a raw value for the geomagnetism measured in the z-axis.
 *
 */
@property(readonly, nonatomic) CLHeadingComponentValue z;

/*
 *  timestamp
 *
 *  Discussion:
 *    Returns a timestamp for when the magnetic heading was determined.
 */
@property(readonly, nonatomic, copy) NSDate *timestamp;

/*
 *  description
 *
 *  Discussion:
 *    Returns a string representation of the heading.
 */
@property (nonatomic, readonly, copy) NSString *description;

@end