//
// Created by Uros Milivojevic on 1/11/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "IRComponentInfoProtocol.h"
#import "IRView.h"
#import "MKPinAnnotationViewExport.h"


@protocol IRPinAnnotationViewExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRPinAnnotationView : MKPinAnnotationView <IRComponentInfoProtocol, MKPinAnnotationViewExport, IRPinAnnotationViewExport, UIViewExport, IRViewExport>



@end