//
// Created by Uros Milivojevic on 1/12/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol IRBaseAnnotationExport <JSExport>

@property (nonatomic, strong) NSDictionary *annotationData;

- (CLLocationCoordinate2D) coordinate;
- (NSString *) title;
- (NSString *) subtitle;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRBaseAnnotation : MKPointAnnotation <IRBaseAnnotationExport>
{
    NSString *title;
    NSString *subtitle;
    CLLocationCoordinate2D coordinate;
}

- (instancetype) initWithData:(NSDictionary *)annotationData;

@end