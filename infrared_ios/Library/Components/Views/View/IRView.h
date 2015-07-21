//
//  IRView.h
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "IRComponentInfoProtocol.h"
#import "IRAutoLayoutSubComponentsProtocol.h"
#import "UIViewExport.h"

@protocol IRViewExport <JSExport>

//- (UIResponder*)nextResponder;
//
//- (BOOL)canBecomeFirstResponder;    // default is NO
//- (BOOL)becomeFirstResponder;
//
//- (BOOL)canResignFirstResponder;    // default is YES
//- (BOOL)resignFirstResponder;
//
//- (BOOL)isFirstResponder;
//
//// Generally, all responders which do custom touch handling should override all four of these methods.
//// Your responder will receive either touchesEnded:withEvent: or touchesCancelled:withEvent: for each
//// touch it is handling (those touches it received in touchesBegan:withEvent:).
//// *** You must handle cancelled touches to ensure correct behavior in your application.  Failure to
//// do so is very likely to lead to incorrect behavior or crashes.
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
//
//- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event NS_AVAILABLE_IOS(3_0);
//- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event NS_AVAILABLE_IOS(3_0);
//- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event NS_AVAILABLE_IOS(3_0);
//
//- (void)remoteControlReceivedWithEvent:(UIEvent *)event NS_AVAILABLE_IOS(4_0);
//
//- (BOOL)canPerformAction:(SEL)action withSender:(id)sender NS_AVAILABLE_IOS(3_0);
//// Allows an action to be forwarded to another target. By default checks -canPerformAction:withSender: to either return self, or go up the responder chain.
//- (id)targetForAction:(SEL)action withSender:(id)sender NS_AVAILABLE_IOS(7_0);
//
//@property(nonatomic,readonly) NSUndoManager *undoManager NS_AVAILABLE_IOS(3_0);
//
//// -----------------------------------------------------------------------------------
//
////- (void)encodeWithCoder:(NSCoder *)aCoder;
////- (id)initWithCoder:(NSCoder *)aDecoder; // NS_DESIGNATED_INITIALIZER
//
//// -----------------------------------------------------------------------------------
//
///* To customize the appearance of all instances of a class, send the relevant appearance modification messages to the appearance proxy for the class. For example, to modify the bar tint color for all UINavigationBar instances:
//    [[UINavigationBar appearance] setBarTintColor:myColor];
//
//    Note for iOS7: On iOS7 the tintColor property has moved to UIView, and now has special inherited behavior described in UIView.h.
//    This inherited behavior can conflict with the appearance proxy, and therefore tintColor is now disallowed with the appearance proxy.
//  */
//+ (instancetype)appearance;
//
///* To customize the appearances for instances of a class contained within an instance of a container class, or instances in a hierarchy, use +appearanceWhenContainedIn: for the appropriate appearance proxy. For example:
//
// [[UINavigationBar appearanceWhenContainedIn:[UISplitViewController class], nil] setBarTintColor:myColor];
// [[UINavigationBar appearanceWhenContainedIn:[UITabBarController class], [UISplitViewController class], nil] setBarTintColor:myTabbedNavBarColor];
//
// In any given view hierarchy the outermost appearance proxy wins. Specificity (depth of the chain) is the tie-breaker.
//
// In other words, the containment statement is treated as a partial ordering. Given a concrete ordering (actual subview hierarchy), we select the partial ordering that is the first unique match when reading the actual hierarchy from the window down.
//
// This method will throw an exception for anything in the var-args list that is not a Class <UIAppearanceContainer>.
//*/
//+ (instancetype)appearanceWhenContainedIn:(Class <UIAppearanceContainer>)ContainerClass, ... NS_REQUIRES_NIL_TERMINATION;
//
//+ (instancetype)appearanceForTraitCollection:(UITraitCollection *)trait NS_AVAILABLE_IOS(8_0);
//+ (instancetype)appearanceForTraitCollection:(UITraitCollection *)trait whenContainedIn:(Class <UIAppearanceContainer>)ContainerClass, ... NS_REQUIRES_NIL_TERMINATION NS_AVAILABLE_IOS(8_0);
//
//// -----------------------------------------------------------------------------------
//
////@property (nonatomic, readwrite) CGPoint center;
////@property (nonatomic, readonly) CGRect bounds;
////@property (nonatomic, readwrite) CGAffineTransform transform;
//
//// -----------------------------------------------------------------------------------
//
//@property (nonatomic, readonly) UITraitCollection *traitCollection;
//
///*! To be overridden as needed to provide custom behavior when the environment's traits change. */
//- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection;
//
//// -----------------------------------------------------------------------------------
//
//- (CGPoint)convertPoint:(CGPoint)point toCoordinateSpace:(id <UICoordinateSpace>)coordinateSpace NS_AVAILABLE_IOS(8_0);
//- (CGPoint)convertPoint:(CGPoint)point fromCoordinateSpace:(id <UICoordinateSpace>)coordinateSpace NS_AVAILABLE_IOS(8_0);
//- (CGRect)convertRect:(CGRect)rect toCoordinateSpace:(id <UICoordinateSpace>)coordinateSpace NS_AVAILABLE_IOS(8_0);
//- (CGRect)convertRect:(CGRect)rect fromCoordinateSpace:(id <UICoordinateSpace>)coordinateSpace NS_AVAILABLE_IOS(8_0);
//
////@property (readonly, nonatomic) CGRect bounds NS_AVAILABLE_IOS(8_0);
//
//// -----------------------------------------------------------------------------------
//// -----------------------------------------------------------------------------------
//
//@property(nonatomic,getter=isUserInteractionEnabled) BOOL userInteractionEnabled;  // default is YES. if set to NO, user events (touch, keys) are ignored and removed from the event queue.
//@property(nonatomic)                                 NSInteger tag;                // default is 0
//@property(nonatomic,readonly,retain)                 CALayer  *layer;              // returns view's layer. Will always return a non-nil value. view is layer's delegate
//
//// -----------------------------------------------------------------------------------
//
//// animatable. do not use frame if view is transformed since it will not correctly reflect the actual location of the view. use bounds + center instead.
//@property(nonatomic) CGRect            frame;
//
//// use bounds/center and not frame if non-identity transform. if bounds dimension is odd, center may be have fractional part
//@property(nonatomic) CGRect            bounds;      // default bounds is zero origin, frame size. animatable
//@property(nonatomic) CGPoint           center;      // center is center of frame. animatable
//@property(nonatomic) CGAffineTransform transform;   // default is CGAffineTransformIdentity. animatable
//@property(nonatomic) CGFloat           contentScaleFactor NS_AVAILABLE_IOS(4_0);
//
//@property(nonatomic,getter=isMultipleTouchEnabled) BOOL multipleTouchEnabled;   // default is NO
//@property(nonatomic,getter=isExclusiveTouch) BOOL       exclusiveTouch;         // default is NO
//
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event;   // recursively calls -pointInside:withEvent:. point is in the receiver's coordinate system
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event;   // default returns YES if point is in bounds
//
//- (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
//- (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;
//- (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
//- (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;
//
//@property(nonatomic) BOOL               autoresizesSubviews; // default is YES. if set, subviews are adjusted according to their autoresizingMask if self.bounds changes
//@property(nonatomic) UIViewAutoresizing autoresizingMask;    // simple resize. default is UIViewAutoresizingNone
//
//- (CGSize)sizeThatFits:(CGSize)size;     // return 'best' size to fit given size. does not actually resize view. Default is return existing view size
//- (void)sizeToFit;                       // calls sizeThatFits: with current view bounds and changes bounds size.
//
//// -----------------------------------------------------------------------------------
//
//@property(nonatomic,readonly) UIView       *superview;
//@property(nonatomic,readonly,copy) NSArray *subviews;
//@property(nonatomic,readonly) UIWindow     *window;
//
//- (void)removeFromSuperview;
//- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index;
//- (void)exchangeSubviewAtIndex:(NSInteger)index1 withSubviewAtIndex:(NSInteger)index2;
//
//- (void)addSubview:(UIView *)view;
//- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview;
//- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview;
//
//- (void)bringSubviewToFront:(UIView *)view;
//- (void)sendSubviewToBack:(UIView *)view;
//
//- (void)didAddSubview:(UIView *)subview;
//- (void)willRemoveSubview:(UIView *)subview;
//
//- (void)willMoveToSuperview:(UIView *)newSuperview;
//- (void)didMoveToSuperview;
//- (void)willMoveToWindow:(UIWindow *)newWindow;
//- (void)didMoveToWindow;
//
//- (BOOL)isDescendantOfView:(UIView *)view;  // returns YES for self.
//- (UIView *)viewWithTag:(NSInteger)tag;     // recursive search. includes self
//
//// Allows you to perform layout before the drawing cycle happens. -layoutIfNeeded forces layout early
//- (void)setNeedsLayout;
//- (void)layoutIfNeeded;
//
//- (void)layoutSubviews;    // override point. called by layoutIfNeeded automatically. As of iOS 6.0, when constraints-based layout is used the base implementation applies the constraints-based layout, otherwise it does nothing.
//
///*
// -layoutMargins returns a set of insets from the edge of the view's bounds that denote a default spacing for laying out content.
// If preservesSuperviewLayoutMargins is YES, margins cascade down the view tree, adjusting for geometry offsets, so that setting the left value of layoutMargins on a superview will affect the left value of layoutMargins for subviews positioned close to the left edge of their superview's bounds
// If your view subclass uses layoutMargins in its layout or drawing, override -layoutMarginsDidChange in order to refresh your view if the margins change.
// */
//@property (nonatomic) UIEdgeInsets layoutMargins NS_AVAILABLE_IOS(8_0);
//@property (nonatomic) BOOL preservesSuperviewLayoutMargins NS_AVAILABLE_IOS(8_0); // default is NO - set to enable pass-through or cascading behavior of margins from this view’s parent to its children
//- (void)layoutMarginsDidChange NS_AVAILABLE_IOS(8_0);
//
//// -----------------------------------------------------------------------------------
//
//- (void)drawRect:(CGRect)rect;
//
//- (void)setNeedsDisplay;
//- (void)setNeedsDisplayInRect:(CGRect)rect;
//
//@property(nonatomic)                 BOOL              clipsToBounds;              // When YES, content and subviews are clipped to the bounds of the view. Default is NO.
//@property(nonatomic,copy)            UIColor          *backgroundColor UI_APPEARANCE_SELECTOR; // default is nil. Can be useful with the appearance proxy on custom UIView subclasses.
//@property(nonatomic)                 CGFloat           alpha;                      // animatable. default is 1.0
//@property(nonatomic,getter=isOpaque) BOOL              opaque;                     // default is YES. opaque views must fill their entire bounds or the results are undefined. the active CGContext in drawRect: will not have been cleared and may have non-zeroed pixels
//@property(nonatomic)                 BOOL              clearsContextBeforeDrawing; // default is YES. ignored for opaque views. for non-opaque views causes the active CGContext in drawRect: to be pre-filled with transparent pixels
//@property(nonatomic,getter=isHidden) BOOL              hidden;                     // default is NO. doesn't check superviews
//@property(nonatomic)                 UIViewContentMode contentMode;                // default is UIViewContentModeScaleToFill
//@property(nonatomic)                 CGRect            contentStretch NS_DEPRECATED_IOS(3_0,6_0); // animatable. default is unit rectangle {{0,0} {1,1}}. Now deprecated: please use -[UIImage resizableImageWithCapInsets:] to achieve the same effect.
//
//@property(nonatomic,retain)          UIView           *maskView NS_AVAILABLE_IOS(8_0);
//
///*
// -tintColor always returns a color. The color returned is the first non-default value in the receiver's superview chain (starting with itself).
// If no non-default value is found, a system-defined color is returned.
// If this view's -tintAdjustmentMode returns Dimmed, then the color that is returned for -tintColor will automatically be dimmed.
// If your view subclass uses tintColor in its rendering, override -tintColorDidChange in order to refresh the rendering if the color changes.
// */
//@property(nonatomic,retain) UIColor *tintColor NS_AVAILABLE_IOS(7_0);
//
///*
// -tintAdjustmentMode always returns either UIViewTintAdjustmentModeNormal or UIViewTintAdjustmentModeDimmed. The value returned is the first non-default value in the receiver's superview chain (starting with itself).
// If no non-default value is found, UIViewTintAdjustmentModeNormal is returned.
// When tintAdjustmentMode has a value of UIViewTintAdjustmentModeDimmed for a view, the color it returns from tintColor will be modified to give a dimmed appearance.
// When the tintAdjustmentMode of a view changes (either the view's value changing or by one of its superview's values changing), -tintColorDidChange will be called to allow the view to refresh its rendering.
// */
//@property(nonatomic) UIViewTintAdjustmentMode tintAdjustmentMode NS_AVAILABLE_IOS(7_0);
//
///*
// The -tintColorDidChange message is sent to appropriate subviews of a view when its tintColor is changed by client code or to subviews in the view hierarchy of a view whose tintColor is implicitly changed when its superview or tintAdjustmentMode changes.
// */
//- (void)tintColorDidChange NS_AVAILABLE_IOS(7_0);
//
//// -----------------------------------------------------------------------------------
//
//+ (void)beginAnimations:(NSString *)animationID context:(void *)context;  // additional context info passed to will start/did stop selectors. begin/commit can be nested
//+ (void)commitAnimations;                                                 // starts up any animations when the top level animation is commited
//
//// no getters. if called outside animation block, these setters have no effect.
//+ (void)setAnimationDelegate:(id)delegate;                          // default = nil
//+ (void)setAnimationWillStartSelector:(SEL)selector;                // default = NULL. -animationWillStart:(NSString *)animationID context:(void *)context
//+ (void)setAnimationDidStopSelector:(SEL)selector;                  // default = NULL. -animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
//+ (void)setAnimationDuration:(NSTimeInterval)duration;              // default = 0.2
//+ (void)setAnimationDelay:(NSTimeInterval)delay;                    // default = 0.0
//+ (void)setAnimationStartDate:(NSDate *)startDate;                  // default = now ([NSDate date])
//+ (void)setAnimationCurve:(UIViewAnimationCurve)curve;              // default = UIViewAnimationCurveEaseInOut
//+ (void)setAnimationRepeatCount:(float)repeatCount;                 // default = 0.0.  May be fractional
//+ (void)setAnimationRepeatAutoreverses:(BOOL)repeatAutoreverses;    // default = NO. used if repeat count is non-zero
//+ (void)setAnimationBeginsFromCurrentState:(BOOL)fromCurrentState;  // default = NO. If YES, the current view position is always used for new animations -- allowing animations to "pile up" on each other. Otherwise, the last end state is used for the animation (the default).
//
//+ (void)setAnimationTransition:(UIViewAnimationTransition)transition forView:(UIView *)view cache:(BOOL)cache;  // current limitation - only one per begin/commit block
//
//+ (void)setAnimationsEnabled:(BOOL)enabled;                         // ignore any attribute changes while set.
//+ (BOOL)areAnimationsEnabled;
//+ (void)performWithoutAnimation:(void (^)(void))actionsWithoutAnimation NS_AVAILABLE_IOS(7_0);
//
//// -----------------------------------------------------------------------------------
//
//+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion NS_AVAILABLE_IOS(4_0);
//
//+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion NS_AVAILABLE_IOS(4_0); // delay = 0.0, options = 0
//
//+ (void)animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations NS_AVAILABLE_IOS(4_0); // delay = 0.0, options = 0, completion = NULL
//
///* Performs `animations` using a timing curve described by the motion of a spring. When `dampingRatio` is 1, the animation will smoothly decelerate to its final model values without oscillating. Damping ratios less than 1 will oscillate more and more before coming to a complete stop. You can use the initial spring velocity to specify how fast the object at the end of the simulated spring was moving before it was attached. It's a unit coordinate system, where 1 is defined as travelling the total animation distance in a second. So if you're changing an object's position by 200pt in this animation, and you want the animation to behave as if the object was moving at 100pt/s before the animation started, you'd pass 0.5. You'll typically want to pass 0 for the velocity. */
//+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay usingSpringWithDamping:(CGFloat)dampingRatio initialSpringVelocity:(CGFloat)velocity options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);
//
//+ (void)transitionWithView:(UIView *)view duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion NS_AVAILABLE_IOS(4_0);
//
//+ (void)transitionFromView:(UIView *)fromView toView:(UIView *)toView duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion NS_AVAILABLE_IOS(4_0); // toView added to fromView.superview, fromView removed from its superview
//
///* Performs the requested system-provided animation on one or more views. Specify addtional animations in the parallelAnimations block. These additional animations will run alongside the system animation with the same timing and duration that the system animation defines/inherits. Additional animations should not modify properties of the view on which the system animation is being performed. Not all system animations honor all available options.
// */
//+ (void)performSystemAnimation:(UISystemAnimation)animation onViews:(NSArray *)views options:(UIViewAnimationOptions)options animations:(void (^)(void))parallelAnimations completion:(void (^)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);
//
//// -----------------------------------------------------------------------------------
//
//+ (void)animateKeyframesWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewKeyframeAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion NS_AVAILABLE_IOS(7_0);
//+ (void)addKeyframeWithRelativeStartTime:(double)frameStartTime relativeDuration:(double)frameDuration animations:(void (^)(void))animations NS_AVAILABLE_IOS(7_0); // start time and duration are values between 0.0 and 1.0 specifying time and duration relative to the overall time of the keyframe animation
//
//// -----------------------------------------------------------------------------------
//
//@property(nonatomic,copy) NSArray *gestureRecognizers NS_AVAILABLE_IOS(3_2);
//
//- (void)addGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer NS_AVAILABLE_IOS(3_2);
//- (void)removeGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer NS_AVAILABLE_IOS(3_2);
//
//// called when the recognizer attempts to transition out of UIGestureRecognizerStatePossible if a touch hit-tested to this view will be cancelled as a result of gesture recognition
//// returns YES by default. return NO to cause the gesture recognizer to transition to UIGestureRecognizerStateFailed
//// subclasses may override to prevent recognition of particular gestures. for example, UISlider prevents swipes parallel to the slider that start in the thumb
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer NS_AVAILABLE_IOS(6_0);
//
//// -----------------------------------------------------------------------------------
//
///*! Begins applying `effect` to the receiver. The effect's emitted keyPath/value pairs will be
//    applied to the view's presentation layer.
//
//    Animates the transition to the motion effect's values using the present UIView animation
//    context. */
//- (void)addMotionEffect:(UIMotionEffect *)effect NS_AVAILABLE_IOS(7_0);
//
///*! Stops applying `effect` to the receiver. Any affected presentation values will animate to
//    their post-removal values using the present UIView animation context. */
//- (void)removeMotionEffect:(UIMotionEffect *)effect NS_AVAILABLE_IOS(7_0);
//
//@property (copy, nonatomic) NSArray *motionEffects NS_AVAILABLE_IOS(7_0);
//
//// -----------------------------------------------------------------------------------
//
//- (NSArray *)constraints NS_AVAILABLE_IOS(6_0);
//
//
//- (void)addConstraint:(NSLayoutConstraint *)constraint NS_AVAILABLE_IOS(6_0); // This method will be deprecated in a future release and should be avoided.  Instead, set NSLayoutConstraint's active property to YES.
//- (void)addConstraints:(NSArray *)constraints NS_AVAILABLE_IOS(6_0); // This method will be deprecated in a future release and should be avoided.  Instead use +[NSLayoutConstraint activateConstraints:].
//- (void)removeConstraint:(NSLayoutConstraint *)constraint NS_AVAILABLE_IOS(6_0); // This method will be deprecated in a future release and should be avoided.  Instead set NSLayoutConstraint's active property to NO.
//- (void)removeConstraints:(NSArray *)constraints NS_AVAILABLE_IOS(6_0); // This method will be deprecated in a future release and should be avoided.  Instead use +[NSLayoutConstraint deactivateConstraints:].
//
//// -----------------------------------------------------------------------------------
//
//- (void)updateConstraintsIfNeeded NS_AVAILABLE_IOS(6_0); // Updates the constraints from the bottom up for the view hierarchy rooted at the receiver. UIWindow's implementation creates a layout engine if necessary first.
//- (void)updateConstraints NS_AVAILABLE_IOS(6_0); // Override this to adjust your special constraints during a constraints update pass
//- (BOOL)needsUpdateConstraints NS_AVAILABLE_IOS(6_0);
//- (void)setNeedsUpdateConstraints NS_AVAILABLE_IOS(6_0);
//
//// -----------------------------------------------------------------------------------
//
///* by default, the autoresizing mask on a view gives rise to constraints that fully determine the view's position.  Any constraints you set on the view are likely to conflict with autoresizing constraints, so you must turn off this property first. IB will turn it off for you.
// */
//- (BOOL)translatesAutoresizingMaskIntoConstraints NS_AVAILABLE_IOS(6_0); // Default YES
//- (void)setTranslatesAutoresizingMaskIntoConstraints:(BOOL)flag NS_AVAILABLE_IOS(6_0);
//
///* constraint-based layout engages lazily when someone tries to use it (e.g., adds a constraint to a view).  If you do all of your constraint set up in -updateConstraints, you might never even receive updateConstraints if no one makes a constraint.  To fix this chicken and egg problem, override this method to return YES if your view needs the window to use constraint-based layout.
// */
//+ (BOOL)requiresConstraintBasedLayout NS_AVAILABLE_IOS(6_0);
//
//// -----------------------------------------------------------------------------------
//
///* Constraints do not actually relate the frames of the views, rather they relate the "alignment rects" of views.  This is the same as the frame unless overridden by a subclass of UIView.  Alignment rects are the same as the "layout rects" shown in Interface Builder 3.  Typically the alignment rect of a view is what the end user would think of as the bounding rect around a control, omitting ornamentation like shadows and engraving lines.  The edges of the alignment rect are what is interesting to align, not the shadows and such.
// */
//
///* These two methods should be inverses of each other.  UIKit will call both as part of layout computation.
// They may be overridden to provide arbitrary transforms between frame and alignment rect, though the two methods must be inverses of each other.
// However, the default implementation uses -alignmentRectInsets, so just override that if it's applicable.  It's easier to get right.
// A view that displayed an image with some ornament would typically override these, because the ornamental part of an image would scale up with the size of the frame.
// Set the NSUserDefault UIViewShowAlignmentRects to YES to see alignment rects drawn.
// */
//- (CGRect)alignmentRectForFrame:(CGRect)frame NS_AVAILABLE_IOS(6_0);
//- (CGRect)frameForAlignmentRect:(CGRect)alignmentRect NS_AVAILABLE_IOS(6_0);
//
///* override this if the alignment rect is obtained from the frame by insetting each edge by a fixed amount.  This is only called by alignmentRectForFrame: and frameForAlignmentRect:.
// */
//- (UIEdgeInsets)alignmentRectInsets NS_AVAILABLE_IOS(6_0);
//
///* When you make a constraint on the NSLayoutAttributeBaseline of a view, the system aligns with the bottom of the view returned from this method. A nil return is interpreted as the receiver, and a non-nil return must be in the receiver's subtree.  UIView's implementation returns self.
// */
//- (UIView *)viewForBaselineLayout NS_AVAILABLE_IOS(6_0);
//
//
///* Override this method to tell the layout system that there is something it doesn't natively understand in this view, and this is how large it intrinsically is.  A typical example would be a single line text field.  The layout system does not understand text - it must just be told that there's something in the view, and that that something will take a certain amount of space if not clipped.
//
// In response, UIKit will set up constraints that specify (1) that the opaque content should not be compressed or clipped, (2) that the view prefers to hug tightly to its content.
//
// A user of a view may need to specify the priority of these constraints.  For example, by default, a push button
// -strongly wants to hug its content in the vertical direction (buttons really ought to be their natural height)
// -weakly hugs its content horizontally (extra side padding between the title and the edge of the bezel is acceptable)
// -strongly resists compressing or clipping content in both directions.
//
// However, you might have a case where you'd prefer to show all the available buttons with truncated text rather than losing some of the buttons. The truncation might only happen in portrait orientation but not in landscape, for example. In that case you'd want to setContentCompressionResistancePriority:forAxis: to (say) UILayoutPriorityDefaultLow for the horizontal axis.
//
// The default 'strong' and 'weak' priorities referred to above are UILayoutPriorityDefaultHigh and UILayoutPriorityDefaultLow.
//
// Note that not all views have an intrinsicContentSize.  UIView's default implementation is to return (UIViewNoIntrinsicMetric, UIViewNoIntrinsicMetric).  The _intrinsic_ content size is concerned only with data that is in the view itself, not in other views. Remember that you can also set constant width or height constraints on any view, and you don't need to override instrinsicContentSize if these dimensions won't be changing with changing view content.
// */
//UIKIT_EXTERN const CGFloat UIViewNoIntrinsicMetric NS_AVAILABLE_IOS(6_0); // -1
//- (CGSize)intrinsicContentSize NS_AVAILABLE_IOS(6_0);
//- (void)invalidateIntrinsicContentSize NS_AVAILABLE_IOS(6_0); // call this when something changes that affects the intrinsicContentSize.  Otherwise UIKit won't notice that it changed.
//
//- (UILayoutPriority)contentHuggingPriorityForAxis:(UILayoutConstraintAxis)axis NS_AVAILABLE_IOS(6_0);
//- (void)setContentHuggingPriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis NS_AVAILABLE_IOS(6_0);
//
//- (UILayoutPriority)contentCompressionResistancePriorityForAxis:(UILayoutConstraintAxis)axis NS_AVAILABLE_IOS(6_0);
//- (void)setContentCompressionResistancePriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis NS_AVAILABLE_IOS(6_0);
//
//// -----------------------------------------------------------------------------------
//
///* The size fitting most closely to targetSize in which the receiver's subtree can be laid out while optimally satisfying the constraints. If you want the smallest possible size, pass UILayoutFittingCompressedSize; for the largest possible size, pass UILayoutFittingExpandedSize.
// Also see the comment for UILayoutPriorityFittingSizeLevel.
// */
//- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize NS_AVAILABLE_IOS(6_0); // Equivalent to sending -systemLayoutSizeFittingSize:withHorizontalFittingPriority:verticalFittingPriority: with UILayoutPriorityFittingSizeLevel for both priorities.
//- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority NS_AVAILABLE_IOS(8_0);
//
//// -----------------------------------------------------------------------------------
//
///* This returns a list of all the constraints that are affecting the current location of the receiver.  The constraints do not necessarily involve the receiver, they may affect the frame indirectly.
// Pass UILayoutConstraintAxisHorizontal for the constraints affecting [self center].x and CGRectGetWidth([self bounds]), and UILayoutConstraintAxisVertical for the constraints affecting[self center].y and CGRectGetHeight([self bounds]).
// */
//- (NSArray *)constraintsAffectingLayoutForAxis:(UILayoutConstraintAxis)axis NS_AVAILABLE_IOS(6_0);
//
///* If there aren't enough constraints in the system to uniquely determine layout, we say the layout is ambiguous.  For example, if the only constraint in the system was x = y + 100, then there are lots of different possible values for x and y.  This situation is not automatically detected by UIKit, due to performance considerations and details of the algorithm used for layout.
// The symptom of ambiguity is that views sometimes jump from place to place, or possibly are just in the wrong place.
// -hasAmbiguousLayout runs a check for whether there is another center and bounds the receiver could have that could also satisfy the constraints.
// -exerciseAmbiguousLayout does more.  It randomly changes the view layout to a different valid layout.  Making the UI jump back and forth can be helpful for figuring out where you're missing a constraint.
// */
//- (BOOL)hasAmbiguousLayout NS_AVAILABLE_IOS(6_0);
//- (void)exerciseAmbiguityInLayout NS_AVAILABLE_IOS(6_0);
//
//// -----------------------------------------------------------------------------------
//
//@property (nonatomic, copy) NSString *restorationIdentifier NS_AVAILABLE_IOS(6_0);
//- (void) encodeRestorableStateWithCoder:(NSCoder *)coder NS_AVAILABLE_IOS(6_0);
//- (void) decodeRestorableStateWithCoder:(NSCoder *)coder NS_AVAILABLE_IOS(6_0);
//
//// -----------------------------------------------------------------------------------
//
///*
//* When requesting a snapshot, 'afterUpdates' defines whether the snapshot is representative of what's currently on screen or if you wish to include any recent changes before taking the snapshot.
//
// If called during layout from a committing transaction, snapshots occurring after the screen updates will include all changes made, regardless of when the snapshot is taken and the changes are made. For example:
//
//     - (void)layoutSubviews {
//         UIView *snapshot = [self snapshotViewAfterScreenUpdates:YES];
//         self.alpha = 0.0;
//     }
//
// The snapshot will appear to be empty since the change in alpha will be captured by the snapshot. If you need to animate the view during layout, animate the snapshot instead.
//
//* Creating snapshots from existing snapshots (as a method to duplicate, crop or create a resizable label) is supported. In cases where many snapshots are needed, creating a snapshot from a common superview and making subsequent snapshots from it can be more performant. Please keep in mind that if 'afterUpdates' is YES, the original snapshot is committed and any changes made to it, not the view originally snapshotted, will be included.
// */
//- (UIView *)snapshotViewAfterScreenUpdates:(BOOL)afterUpdates NS_AVAILABLE_IOS(7_0);
//- (UIView *)resizableSnapshotViewFromRect:(CGRect)rect afterScreenUpdates:(BOOL)afterUpdates withCapInsets:(UIEdgeInsets)capInsets NS_AVAILABLE_IOS(7_0);  // Resizable snapshots will default to stretching the center
//// Use this method to render a snapshot of the view hierarchy into the current context. Returns NO if the snapshot is missing image data, YES if the snapshot is complete. Calling this method from layoutSubviews while the current transaction is committing will capture what is currently displayed regardless if afterUpdates is YES.
//- (BOOL)drawViewHierarchyInRect:(CGRect)rect afterScreenUpdates:(BOOL)afterUpdates NS_AVAILABLE_IOS(7_0);
//
//// -----------------------------------------------------------------------------------
//// -----------------------------------------------------------------------------------
//
//#pragma mark - UIView (UITextField)
//
//- (BOOL)endEditing:(BOOL)force;    // use to make the view or any subview that is the first responder resign (optionally force)

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

+ (id) createWithComponentId:(NSString *)componentId;

@property(nonatomic, strong) id componentInfo;

- (NSString *) componentId;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRView : UIView <IRComponentInfoProtocol, IRAutoLayoutSubComponentsProtocol, UIViewExport, IRViewExport>


@end
