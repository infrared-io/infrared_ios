//
// Created by Uros Milivojevic on 12/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "IRMapViewBuilder.h"
#import "IRMapViewDescriptor.h"
#import "IRMapView.h"
#import "IRScreenDescriptor.h"
#import "IRBaseDescriptor.h"
#import "IRViewBuilder.h"
#import "IRPinAnnotation.h"
#import "IRView.h"
#import "IRViewDescriptor.h"
#import "IRViewController.h"


@implementation IRMapViewBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRMapView *irMapView;

    irMapView = [[IRMapView alloc] init];
    [IRMapViewBuilder setUpComponent:irMapView componentDescriptor:descriptor viewController:viewController extra:extra];

    return irMapView;
}

+ (void) setUpComponent:(IRMapView *)irMapView
    componentDescriptor:(IRMapViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irMapView componentDescriptor:descriptor viewController:viewController extra:extra];

    irMapView.mapType = descriptor.mapType;
    if (CLLocationCoordinate2DIsValid(descriptor.region.center)) {
        irMapView.region = descriptor.region;
    }
    if (CLLocationCoordinate2DIsValid(descriptor.centerCoordinate)) {
        irMapView.centerCoordinate = descriptor.centerCoordinate;
    }
    if (MKMapRectIsNull(descriptor.visibleMapRect) == NO) {
        irMapView.visibleMapRect = descriptor.visibleMapRect;
    }
    irMapView.zoomEnabled = descriptor.zoomEnabled;
    irMapView.scrollEnabled = descriptor.scrollEnabled;
    irMapView.rotateEnabled = descriptor.rotateEnabled;
    irMapView.pitchEnabled = descriptor.pitchEnabled;
    irMapView.showsPointsOfInterest = descriptor.showsPointsOfInterest;
    irMapView.showsBuildings = descriptor.showsBuildings;
    irMapView.showsUserLocation = descriptor.showsUserLocation;
    [irMapView setMapData:descriptor.mapData];
}


+ (NSArray *) mapDataFromArray:(NSArray *)array
{
    NSMutableArray *annotationsArray = [NSMutableArray array];
    IRPinAnnotation *anPointAnnotation;
    for (NSDictionary *anDictionary in array) {
        anPointAnnotation = [[IRPinAnnotation alloc] initWithData:anDictionary];
        if (CLLocationCoordinate2DIsValid(anPointAnnotation.coordinate)) {
            [annotationsArray addObject:anPointAnnotation];
        }
    }
    return annotationsArray;
}

@end