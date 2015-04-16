//
// Created by Uros Milivojevic on 1/9/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface IRMapViewObserver : NSObject <MKMapViewDelegate>

@property (nonatomic, strong) NSArray *mapDataArray;

@end