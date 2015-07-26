//
// Created by Uros Milivojevic on 12/13/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "IRView.h"
#import "MKMapViewExport.h"

@class IRMapViewObserver;


@protocol IRMapViewExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRMapView : MKMapView <IRComponentInfoProtocol, MKMapViewExport, IRMapViewExport, UIViewExport, IRViewExport>

@property (nonatomic, strong) IRMapViewObserver *observer;

- (void) setMapData:(NSArray *)mapData;

@end