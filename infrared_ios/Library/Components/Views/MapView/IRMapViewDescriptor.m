//
// Created by Uros Milivojevic on 12/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRMapViewDescriptor.h"
#import "IRMapViewBuilder.h"
#import "IRBaseAnnotation.h"
#import "IRMapView.h"


@implementation IRMapViewDescriptor

+ (NSString *) componentName
{
    return typeMapViewKEY;
}
+ (Class) componentClass
{
    return [IRMapView class];
}

+ (Class) builderClass
{
    return [IRMapViewBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([MKMapView class], @protocol(MKMapViewExport));
}

- (NSDictionary *) viewDefaults
{
    NSDictionary *dictionary = [super viewDefaults];
    NSMutableDictionary *defaults = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [defaults setValuesForKeysWithDictionary:@{
      @"zoomEnabled" : @(YES),
      @"scrollEnabled" : @(YES),
      @"rotateEnabled" : @(YES),
      @"pitchEnabled" : @(YES),
      @"showsPointsOfInterest" : @(YES),
      @"showsBuildings" : @(YES),
      @"showsUserLocation" : @(NO),
    }];
    return defaults;
}

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSDictionary *dictionary;
        NSArray *array;

        // mapType
        string = aDictionary[NSStringFromSelector(@selector(mapType))];
        self.mapType = [IRMapViewDescriptor mapTypeFromString:string];

        // region
        dictionary = aDictionary[NSStringFromSelector(@selector(region))];
        self.region = [IRMapViewDescriptor MKCoordinateRegionFromDictionary:dictionary];

        // centerCoordinate
        dictionary = aDictionary[NSStringFromSelector(@selector(centerCoordinate))];
        self.centerCoordinate = [IRMapViewDescriptor CLLocationCoordinate2DFromDictionary:dictionary];

        // visibleMapRect
        dictionary = aDictionary[NSStringFromSelector(@selector(visibleMapRect))];
        self.visibleMapRect = [IRMapViewDescriptor MKMapRectFromDictionary:dictionary];

        // zoomEnabled
        number = aDictionary[NSStringFromSelector(@selector(zoomEnabled))];
        if (number) {
            self.zoomEnabled = [number boolValue];
        } else {
            self.zoomEnabled = [[self viewDefaults][NSStringFromSelector(@selector(zoomEnabled))] boolValue];
        }

        // scrollEnabled
        number = aDictionary[NSStringFromSelector(@selector(scrollEnabled))];
        if (number) {
            self.scrollEnabled = [number boolValue];
        } else {
            self.scrollEnabled = [[self viewDefaults][NSStringFromSelector(@selector(scrollEnabled))] boolValue];
        }

        // rotateEnabled
        number = aDictionary[NSStringFromSelector(@selector(rotateEnabled))];
        if (number) {
            self.rotateEnabled = [number boolValue];
        } else {
            self.rotateEnabled = [[self viewDefaults][NSStringFromSelector(@selector(rotateEnabled))] boolValue];
        }

        // pitchEnabled
        number = aDictionary[NSStringFromSelector(@selector(pitchEnabled))];
        if (number) {
            self.pitchEnabled = [number boolValue];
        } else {
            self.pitchEnabled = [[self viewDefaults][NSStringFromSelector(@selector(pitchEnabled))] boolValue];
        }

        // showsPointsOfInterest
        number = aDictionary[NSStringFromSelector(@selector(showsPointsOfInterest))];
        if (number) {
            self.showsPointsOfInterest = [number boolValue];
        } else {
            self.showsPointsOfInterest = [[self viewDefaults][NSStringFromSelector(@selector(showsPointsOfInterest))] boolValue];
        }

        // showsBuildings
        number = aDictionary[NSStringFromSelector(@selector(showsBuildings))];
        if (number) {
            self.showsBuildings = [number boolValue];
        } else {
            self.showsBuildings = [[self viewDefaults][NSStringFromSelector(@selector(showsBuildings))] boolValue];
        }

        // showsUserLocation
        number = aDictionary[NSStringFromSelector(@selector(showsUserLocation))];
        if (number) {
            self.showsUserLocation = [number boolValue];
        } else {
            self.showsUserLocation = [[self viewDefaults][NSStringFromSelector(@selector(showsUserLocation))] boolValue];
        }

        // selectAnnotationAction
        string = aDictionary[NSStringFromSelector(@selector(selectAnnotationAction))];
        self.selectAnnotationAction = string;

        // deselectAnnotationAction
        string = aDictionary[NSStringFromSelector(@selector(deselectAnnotationAction))];
        self.deselectAnnotationAction = string;

        // annotationsArray
        array = aDictionary[annotationsKEY];
        self.annotationsArray = [IRBaseDescriptor viewDescriptorsHierarchyFromArray:array];

        // annotationItemName
        string = aDictionary[NSStringFromSelector(@selector(annotationItemName))];
        if (string) {
            self.annotationItemName = string;
        } else {
            self.annotationItemName = annotationKEY;
        }

        // mapData
        array = aDictionary[NSStringFromSelector(@selector(mapData))];
        self.mapData = array;
    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
{

}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

+ (MKMapType) mapTypeFromString:(NSString *)string
{
    MKMapType mapType;
    if ([@"MKMapTypeStandard" isEqualToString:string]) {
        mapType = MKMapTypeStandard;
    } else if ([@"MKMapTypeSatellite" isEqualToString:string]) {
        mapType = MKMapTypeSatellite;
    } else if ([@"MKMapTypeHybrid" isEqualToString:string]) {
        mapType = MKMapTypeHybrid;
    } else {
        mapType = MKMapTypeStandard;
    }
    return mapType;
}
+ (MKCoordinateRegion) MKCoordinateRegionFromDictionary:(NSDictionary *)dictionary
{
    NSNumber *latitude = dictionary[centerKEY][latitudeKEY];
    NSNumber *longitude = dictionary[centerKEY][longitudeKEY];
    NSNumber *latitudeDelta = dictionary[spanKEY][latitudeDeltaKEY];
    NSNumber *longitudeDelta = dictionary[spanKEY][longitudeDeltaKEY];
    MKCoordinateRegion region;
    if (latitude && longitude && latitudeDelta && longitudeDelta) {
        region = MKCoordinateRegionMake(CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]),
          MKCoordinateSpanMake([latitudeDelta doubleValue], [longitudeDelta doubleValue]));
    } else {
        region = MKCoordinateRegionMake(kCLLocationCoordinate2DInvalid, MKCoordinateSpanMake(0, 0));
    }
    return region;
}
+ (CLLocationCoordinate2D) CLLocationCoordinate2DFromDictionary:(NSDictionary *)dictionary
{
    NSNumber *latitude = dictionary[latitudeKEY];
    NSNumber *longitude = dictionary[longitudeKEY];
    CLLocationCoordinate2D locationCoordinate2D;
    if (latitude && longitude) {
        locationCoordinate2D = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    } else {
        locationCoordinate2D = kCLLocationCoordinate2DInvalid;
    }
    return locationCoordinate2D;
}
+ (MKMapRect) MKMapRectFromDictionary:(NSDictionary *)dictionary
{
    NSNumber *x = dictionary[xKEY];
    NSNumber *y = dictionary[yKEY];
    NSNumber *width = dictionary[widthKEY];
    NSNumber *height = dictionary[heightKEY];
    MKMapRect mapRect;
    if (x && y && width && height) {
        mapRect = MKMapRectMake([x doubleValue], [y doubleValue], [width doubleValue], [height doubleValue]);
    } else {
        mapRect = MKMapRectNull;
    }
    return mapRect;
}
+ (MKPinAnnotationColor) pinColorFromString:(NSString *)string
{
    MKPinAnnotationColor pinAnnotationColor;
    if ([@"MKPinAnnotationColorRed" isEqualToString:string]) {
        pinAnnotationColor = MKPinAnnotationColorRed;
    } else if ([@"MKMapTypeSatellite" isEqualToString:string]) {
        pinAnnotationColor = MKPinAnnotationColorGreen;
    } else if ([@"MKMapTypeHybrid" isEqualToString:string]) {
        pinAnnotationColor = MKPinAnnotationColorPurple;
    } else {
        pinAnnotationColor = MKPinAnnotationColorRed;
    }
    return pinAnnotationColor;
}

@end