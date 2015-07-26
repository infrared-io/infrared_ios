//
// Created by Uros Milivojevic on 6/19/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol UIGestureRecognizerExport <JSExport>

@property(nonatomic,readonly) UIGestureRecognizerState state;  // the current state of the gesture recognizer

@property(nonatomic, getter=isEnabled) BOOL enabled;  // default is YES. disabled gesture recognizers will not receive touches. when changed to NO the gesture recognizer will be cancelled if it's currently recognizing a gesture

// a UIGestureRecognizer receives touches hit-tested to its view and any of that view's subviews
@property(nonatomic,readonly) UIView *view;           // the view the gesture is attached to. set by adding the recognizer to a UIView using the addGestureRecognizer: method

@property(nonatomic) BOOL cancelsTouchesInView;       // default is YES. causes touchesCancelled:withEvent: to be sent to the view for all touches recognized as part of this gesture immediately before the action method is called
@property(nonatomic) BOOL delaysTouchesBegan;         // default is NO.  causes all touch events to be delivered to the target view only after this gesture has failed recognition. set to YES to prevent views from processing any touches that may be recognized as part of this gesture
@property(nonatomic) BOOL delaysTouchesEnded;         // default is YES. causes touchesEnded events to be delivered to the target view only after this gesture has failed recognition. this ensures that a touch that is part of the gesture can be cancelled if the gesture is recognized

// create a relationship with another gesture recognizer that will prevent this gesture's actions from being called until otherGestureRecognizer transitions to UIGestureRecognizerStateFailed
// if otherGestureRecognizer transitions to UIGestureRecognizerStateRecognized or UIGestureRecognizerStateBegan then this recognizer will instead transition to UIGestureRecognizerStateFailed
// example usage: a single tap may require a double tap to fail
- (void)requireGestureRecognizerToFail:(UIGestureRecognizer *)otherGestureRecognizer;

// individual UIGestureRecognizer subclasses may provide subclass-specific location information. see individual subclasses for details
- (CGPoint)locationInView:(UIView*)view;                                // a generic single-point location for the gesture. usually the centroid of the touches involved

- (NSUInteger)numberOfTouches;                                          // number of touches involved for which locations can be queried
- (CGPoint)locationOfTouch:(NSUInteger)touchIndex inView:(UIView*)view; // the location of a particular touch

@end