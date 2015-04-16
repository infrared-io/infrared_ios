//
// Created by Uros Milivojevic on 1/9/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRMapViewObserver.h"
#import "IRTableViewObserver.h"
#import "IRDataController.h"
#import "IRPinAnnotationView.h"
#import "IRCalloutAnnotation.h"
#import "IRCalloutAnnotationView.h"
#import "IRBaseAnnotation.h"
#import "IRViewDescriptor.h"
#import "IRPinAnnotationViewDescriptor.h"
#import "IRMapViewDescriptor.h"
#import "IRMapView.h"
#import "IRBaseBuilder.h"
#import "IRAnnotationViewDescriptor.h"
#import "IRCalloutAnnotationViewDescriptor.h"
#import "IRTableViewDescriptor.h"
#import "IRPinAnnotation.h"
#import <JavaScriptCore/JavaScriptCore.h>


@implementation IRMapViewObserver

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView
  regionWillChangeAnimated:(BOOL)animated
{

}
- (void)mapView:(MKMapView *)mapView
  regionDidChangeAnimated:(BOOL)animated
{

}

// --------------------------------------------------------------------------------------------------------------------

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
{

}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{

}
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView
                       withError:(NSError *)error
{

}

// --------------------------------------------------------------------------------------------------------------------

- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView NS_AVAILABLE(10_9, 7_0)
{

}
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView
                       fullyRendered:(BOOL)fullyRendered NS_AVAILABLE(10_9, 7_0)
{

}

// --------------------------------------------------------------------------------------------------------------------

// mapView:viewForAnnotation: provides the view for each annotation.
// This method may be called for all or some of the added mapData.
// For MapKit provided mapData (eg. MKUserLocation) return nil to use the MapKit provided annotation view.
- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation
{
    IRCalloutAnnotationView *annotationView;
    if ([annotation isKindOfClass:[IRCalloutAnnotation class]]) {
        annotationView = [self buildCalloutAnnotationViewForMapView:mapView
                                                  viewForAnnotation:(IRBaseAnnotation *) annotation];
    } else if ([annotation isKindOfClass:[IRPinAnnotation class]]) {
        annotationView = (id) [self buildPinAnnotationViewForMapView:mapView
                                                   viewForAnnotation:(IRBaseAnnotation *) annotation];
    } else if ([annotation isKindOfClass:[MKUserLocation class]]) {
        // No need to do anything
    } else {

    }

    return annotationView;
}

// --------------------------------------------------------------------------------------------------------------------

// mapView:didAddAnnotationViews: is called after the annotation views have been added and positioned in the map.
// The delegate can implement this method to animate the adding of the mapData views.
// Use the current positions of the annotation views as the destinations of the animation.
- (void)mapView:(MKMapView *)mapView
  didAddAnnotationViews:(NSArray *)views
{

}

// --------------------------------------------------------------------------------------------------------------------

// mapView:annotationView:calloutAccessoryControlTapped: is called when the user taps on left & right callout accessory UIControls.
- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)view
  calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"mapView:annotationView:calloutAccessoryControlTapped:");


}

// --------------------------------------------------------------------------------------------------------------------

- (void)mapView:(MKMapView *)mapView
  didSelectAnnotationView:(MKAnnotationView *)view NS_AVAILABLE(10_9, 4_0)
{
    NSLog(@"mapView:didSelectAnnotationView:");

    NSString *action = nil;
    NSDictionary *pinData;
    IRBaseAnnotationViewDescriptor *pinDescriptor = (IRBaseAnnotationViewDescriptor *) ((id<IRComponentInfoProtocol>)view).descriptor;
    if ([pinDescriptor.selectAnnotationAction length] > 0) {
        action = pinDescriptor.selectAnnotationAction;
    } else {
        IRMapViewDescriptor *mapViewDescriptor = (IRMapViewDescriptor *) ((IRMapView *) mapView).descriptor;
        action = mapViewDescriptor.selectAnnotationAction;
    }
    if (action) {
        pinData = ((IRBaseAnnotation *)view.annotation).annotationData;
        [IRMapViewObserver executeAction:action withData:pinData sourceView:mapView];
    }

    if([view.annotation isKindOfClass:[IRCalloutAnnotation class]] == NO) {
        IRCalloutAnnotation *calloutAnnotation = [[IRCalloutAnnotation alloc] initWithAnnotation:(IRBaseAnnotation *) view.annotation];
        [mapView addAnnotation:calloutAnnotation];
        dispatch_async(dispatch_get_main_queue(), ^{
            [mapView selectAnnotation:calloutAnnotation animated:YES];
        });
    }
}
- (void)mapView:(MKMapView *)mapView
  didDeselectAnnotationView:(MKAnnotationView *)view NS_AVAILABLE(10_9, 4_0)
{
    NSLog(@"mapView:didDeselectAnnotationView:");

    NSString *action = nil;
    NSDictionary *pinData;
    IRBaseAnnotationViewDescriptor *pinDescriptor = (IRBaseAnnotationViewDescriptor *) ((id<IRComponentInfoProtocol>)view).descriptor;
    if ([pinDescriptor.deselectAnnotationAction length] > 0) {
        action = pinDescriptor.deselectAnnotationAction;
    } else {
        IRMapViewDescriptor *mapViewDescriptor = (IRMapViewDescriptor *) ((IRMapView *) mapView).descriptor;
        action = mapViewDescriptor.deselectAnnotationAction;
    }
    if (action) {
        pinData = ((IRBaseAnnotation *)view.annotation).annotationData;
        [IRMapViewObserver executeAction:action withData:pinData sourceView:mapView];
    }

    if([view.annotation isKindOfClass:[IRCalloutAnnotation class]]) {
        [mapView removeAnnotation:view.annotation];
    }
}

// --------------------------------------------------------------------------------------------------------------------

- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView NS_AVAILABLE(10_9, 4_0)
{

}
- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView NS_AVAILABLE(10_9, 4_0)
{

}
- (void)mapView:(MKMapView *)mapView
  didUpdateUserLocation:(MKUserLocation *)userLocation NS_AVAILABLE(10_9, 4_0)
{

}
- (void)mapView:(MKMapView *)mapView
  didFailToLocateUserWithError:(NSError *)error NS_AVAILABLE(10_9, 4_0)
{

}

// --------------------------------------------------------------------------------------------------------------------

- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)view
  didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState NS_AVAILABLE(10_9, 4_0)
{

}

// --------------------------------------------------------------------------------------------------------------------

- (void)mapView:(MKMapView *)mapView
  didChangeUserTrackingMode:(MKUserTrackingMode)mode
  animated:(BOOL)animated NS_AVAILABLE(NA, 5_0)
{

}

// --------------------------------------------------------------------------------------------------------------------

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView
            rendererForOverlay:(id <MKOverlay>)overlay NS_AVAILABLE(10_9, 7_0)
{
    return nil;
}
- (void)mapView:(MKMapView *)mapView
  didAddOverlayRenderers:(NSArray *)renderers NS_AVAILABLE(10_9, 7_0)
{

}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Private Methods

- (IRPinAnnotationView *) buildPinAnnotationViewForMapView:(MKMapView *)mapView
                                         viewForAnnotation:(IRBaseAnnotation *)annotation
{
    IRPinAnnotationView *pinAnnotationView;
    IRPinAnnotationViewDescriptor *descriptor = [self pinAnnotationDescriptorForAnnotation:annotation
                                                                                 inMapView:(IRMapView *) mapView];
    if (descriptor) {
        pinAnnotationView = (IRPinAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:descriptor.componentId];
        if(pinAnnotationView == nil) {
            pinAnnotationView = (id) [IRBaseBuilder buildComponentFromDescriptor:descriptor viewController:nil extra:@{
              typeMapViewKEY : mapView,
              annotationKEY : annotation
            }];
        }
        IRMapViewDescriptor *mapDescriptor = (IRMapViewDescriptor *) ((IRMapView *)mapView).descriptor;
        [self bindData:annotation.annotationData toView:pinAnnotationView withAnnotationItemName:mapDescriptor.annotationItemName];
    } else {

    }
    return pinAnnotationView;
}

- (IRCalloutAnnotationView *) buildCalloutAnnotationViewForMapView:(MKMapView *)mapView
                                          viewForAnnotation:(IRBaseAnnotation *)annotation
{
    IRCalloutAnnotationView *calloutAnnotationView;
    IRCalloutAnnotationViewDescriptor *descriptor = [self calloutAnnotationDescriptorForAnnotation:annotation
                                                                                         inMapView:(IRMapView *) mapView];
    if (descriptor) {
        calloutAnnotationView = (IRCalloutAnnotationView *) [mapView dequeueReusableAnnotationViewWithIdentifier:descriptor.componentId];
        if(calloutAnnotationView == nil) {
            calloutAnnotationView = (id) [IRBaseBuilder buildComponentFromDescriptor:descriptor viewController:nil
                                                                               extra:@{
                                                                                 typeMapViewKEY : mapView,
                                                                                 annotationKEY : annotation
                                                                               }];
        }
        IRMapViewDescriptor *mapDescriptor = (IRMapViewDescriptor *) ((IRMapView *)mapView).descriptor;
        [self bindData:annotation.annotationData toView:calloutAnnotationView withAnnotationItemName:mapDescriptor.annotationItemName];
    } else {

    }
    return calloutAnnotationView;
}

- (IRPinAnnotationViewDescriptor *) pinAnnotationDescriptorForAnnotation:(IRBaseAnnotation *)annotation
                                                               inMapView:(IRMapView *)mapView
{
    IRPinAnnotationViewDescriptor *pinAnnotationDescriptor = nil;
    IRAnnotationViewDescriptor *annotationDescriptor = [self annotationDescriptorForAnnotation:annotation
                                                                                     inMapView:mapView];
    pinAnnotationDescriptor = annotationDescriptor.pinAnnotationViewDescriptor;
    return pinAnnotationDescriptor;
}

- (IRCalloutAnnotationViewDescriptor *) calloutAnnotationDescriptorForAnnotation:(IRBaseAnnotation *)annotation
                                                                       inMapView:(IRMapView *)mapView
{
    IRCalloutAnnotationViewDescriptor *calloutAnnotationDescriptor = nil;
    IRAnnotationViewDescriptor *annotationDescriptor = [self annotationDescriptorForAnnotation:annotation
                                                                                     inMapView:mapView];
    calloutAnnotationDescriptor = annotationDescriptor.calloutAnnotationViewDescriptor;
    return calloutAnnotationDescriptor;
}

- (IRAnnotationViewDescriptor *) annotationDescriptorForAnnotation:(IRBaseAnnotation *)annotation
                                                         inMapView:(IRMapView *)mapView
{
    IRAnnotationViewDescriptor *annotationDescriptor = nil;
    IRMapViewDescriptor *mapDescriptor = (IRMapViewDescriptor *) mapView.descriptor;
    NSArray *annotationDescriptorsArray = mapDescriptor.annotationsArray;
    NSString *annotationId = annotation.annotationData[annotationIdKEY];
    if (annotationId) {
        for (IRAnnotationViewDescriptor *anAnnotationDescriptor in annotationDescriptorsArray) {
            if ([anAnnotationDescriptor.componentId isEqualToString:annotationId]) {
                annotationDescriptor = anAnnotationDescriptor;
                break;
            }
        }
    } else {
        if ([annotationDescriptorsArray count] > 0) {
            annotationDescriptor = annotationDescriptorsArray[0];
        }
    }
    return annotationDescriptor;
}

- (void) bindData:(NSDictionary *)dictionary
                toView:(IRView *)view
withAnnotationItemName:(NSString *)name
{
    [IRBaseBuilder bindData:dictionary toView:view withDataBindingItemName:name];
}

+ (void) executeAction:(NSString *)action
              withData:(id)data
            sourceView:(MKMapView *)mapView
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    if (mapView) {
        dictionary[@"mapView"] = mapView;
    }
    if (data) {
        dictionary[@"data"] = data;
    }
    [IRBaseBuilder executeAction:action withDictionary:dictionary sourceView:mapView];
}

@end