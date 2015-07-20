//
// Created by Uros Milivojevic on 12/4/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import "IRView.h"
#import "UIScrollViewExport.h"

@protocol IRScrollViewExport <JSExport>

//@property(nonatomic)         CGPoint                      contentOffset;                  // default CGPointZero
//@property(nonatomic)         CGSize                       contentSize;                    // default CGSizeZero
//@property(nonatomic)         UIEdgeInsets                 contentInset;                   // default UIEdgeInsetsZero. add additional scroll area around content
//@property(nonatomic,assign) id<UIScrollViewDelegate>      delegate;                       // default nil. weak reference
//@property(nonatomic,getter=isDirectionalLockEnabled) BOOL directionalLockEnabled;         // default NO. if YES, try to lock vertical or horizontal scrolling while dragging
//@property(nonatomic)         BOOL                         bounces;                        // default YES. if YES, bounces past edge of content and back again
//@property(nonatomic)         BOOL                         alwaysBounceVertical;           // default NO. if YES and bounces is YES, even if content is smaller than bounds, allow drag vertically
//@property(nonatomic)         BOOL                         alwaysBounceHorizontal;         // default NO. if YES and bounces is YES, even if content is smaller than bounds, allow drag horizontally
//@property(nonatomic,getter=isPagingEnabled) BOOL          pagingEnabled;                  // default NO. if YES, stop on multiples of view bounds
//@property(nonatomic,getter=isScrollEnabled) BOOL          scrollEnabled;                  // default YES. turn off any dragging temporarily
//@property(nonatomic)         BOOL                         showsHorizontalScrollIndicator; // default YES. show indicator while we are tracking. fades out after tracking
//@property(nonatomic)         BOOL                         showsVerticalScrollIndicator;   // default YES. show indicator while we are tracking. fades out after tracking
//@property(nonatomic)         UIEdgeInsets                 scrollIndicatorInsets;          // default is UIEdgeInsetsZero. adjust indicators inside of insets
//@property(nonatomic)         UIScrollViewIndicatorStyle   indicatorStyle;                 // default is UIScrollViewIndicatorStyleDefault
//@property(nonatomic)         CGFloat                      decelerationRate NS_AVAILABLE_IOS(3_0);
//
//- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated;  // animate at constant velocity to new offset
//- (void)scrollRectToVisible:(CGRect)rect animated:(BOOL)animated;         // scroll so rect is just visible (nearest edges). nothing if rect completely visible
//
//- (void)flashScrollIndicators;             // displays the scroll indicators for a short time. This should be done whenever you bring the scroll view to front.
//
///*
// Scrolling with no scroll bars is a bit complex. on touch down, we don't know if the user will want to scroll or track a subview like a control.
// on touch down, we start a timer and also look at any movement. if the time elapses without sufficient change in position, we start sending events to
// the hit view in the content subview. if the user then drags far enough, we switch back to dragging and cancel any tracking in the subview.
// the methods below are called by the scroll view and give subclasses override points to add in custom behaviour.
// you can remove the delay in delivery of touchesBegan:withEvent: to subviews by setting delaysContentTouches to NO.
// */
//
//@property(nonatomic,readonly,getter=isTracking)     BOOL tracking;        // returns YES if user has touched. may not yet have started dragging
//@property(nonatomic,readonly,getter=isDragging)     BOOL dragging;        // returns YES if user has started scrolling. this may require some time and or distance to move to initiate dragging
//@property(nonatomic,readonly,getter=isDecelerating) BOOL decelerating;    // returns YES if user isn't dragging (touch up) but scroll view is still moving
//
//@property(nonatomic) BOOL delaysContentTouches;       // default is YES. if NO, we immediately call -touchesShouldBegin:withEvent:inContentView:
//@property(nonatomic) BOOL canCancelContentTouches;    // default is YES. if NO, then once we start tracking, we don't try to drag if the touch moves
//
//// override points for subclasses to control delivery of touch events to subviews of the scroll view
//// called before touches are delivered to a subview of the scroll view. if it returns NO the touches will not be delivered to the subview
//// default returns YES
//- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view;
//// called before scrolling begins if touches have already been delivered to a subview of the scroll view. if it returns NO the touches will continue to be delivered to the subview and scrolling will not occur
//// not called if canCancelContentTouches is NO. default returns YES if view isn't a UIControl
//- (BOOL)touchesShouldCancelInContentView:(UIView *)view;
//
///*
// the following properties and methods are for zooming. as the user tracks with two fingers, we adjust the offset and the scale of the content. When the gesture ends, you should update the content
// as necessary. Note that the gesture can end and a finger could still be down. While the gesture is in progress, we do not send any tracking calls to the subview.
// the delegate must implement both viewForZoomingInScrollView: and scrollViewDidEndZooming:withView:atScale: in order for zooming to work and the max/min zoom scale must be different
// note that we are not scaling the actual scroll view but the 'content view' returned by the delegate. the delegate must return a subview, not the scroll view itself, from viewForZoomingInScrollview:
// */
//
//@property(nonatomic) CGFloat minimumZoomScale;     // default is 1.0
//@property(nonatomic) CGFloat maximumZoomScale;     // default is 1.0. must be > minimum zoom scale to enable zooming
//
//@property(nonatomic) CGFloat zoomScale NS_AVAILABLE_IOS(3_0);            // default is 1.0
//- (void)setZoomScale:(CGFloat)scale animated:(BOOL)animated NS_AVAILABLE_IOS(3_0);
//- (void)zoomToRect:(CGRect)rect animated:(BOOL)animated NS_AVAILABLE_IOS(3_0);
//
//@property(nonatomic) BOOL  bouncesZoom;          // default is YES. if set, user can go past min/max zoom while gesturing and the zoom will animate to the min/max value at gesture end
//
//@property(nonatomic,readonly,getter=isZooming)       BOOL zooming;       // returns YES if user in zoom gesture
//@property(nonatomic,readonly,getter=isZoomBouncing)  BOOL zoomBouncing;  // returns YES if we are in the middle of zooming back to the min/max value
//
//// When the user taps the status bar, the scroll view beneath the touch which is closest to the status bar will be scrolled to top, but only if its `scrollsToTop` property is YES, its delegate does not return NO from `shouldScrollViewScrollToTop`, and it is not already at the top.
//// On iPhone, we execute this gesture only if there's one on-screen scroll view with `scrollsToTop` == YES. If more than one is found, none will be scrolled.
//@property(nonatomic) BOOL  scrollsToTop;          // default is YES.
//
//// Use these accessors to configure the scroll view's built-in gesture recognizers.
//// Do not change the gestures' delegates or override the getters for these properties.
//@property(nonatomic, readonly) UIPanGestureRecognizer *panGestureRecognizer NS_AVAILABLE_IOS(5_0);
//// `pinchGestureRecognizer` will return nil when zooming is disabled.
//@property(nonatomic, readonly) UIPinchGestureRecognizer *pinchGestureRecognizer NS_AVAILABLE_IOS(5_0);
//
//@property(nonatomic) UIScrollViewKeyboardDismissMode keyboardDismissMode NS_AVAILABLE_IOS(7_0); // default is UIScrollViewKeyboardDismissModeNone

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRScrollView : UIScrollView <IRComponentInfoProtocol, UIScrollViewExport, IRScrollViewExport, IRViewExport>

@end