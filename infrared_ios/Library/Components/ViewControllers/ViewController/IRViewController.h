//
// Created by Uros Milivojevic on 8/30/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <RESideMenu/RESideMenu.h>
#import "IRComponentInfoProtocol.h"

@class IRView;
@class IRScrollView;
@class IRViewController;

@protocol IRViewControllerExport <JSExport>

@property(nonatomic,retain) UIView *view; // The getter first invokes [self loadView] if the view hasn't been set yet. Subclasses must call super if they override the setter or getter.
@property(nonatomic,copy) NSString *title;  // Localized title for use by a parent controller.

/*
  If this view controller is a child of a containing view controller (e.g. a navigation controller or tab bar
  controller,) this is the containing view controller.  Note that as of 5.0 this no longer will return the
  presenting view controller.
*/
@property(nonatomic,readonly) UIViewController *parentViewController;

// This property has been replaced by presentedViewController.
@property(nonatomic,readonly) UIViewController *modalViewController NS_DEPRECATED_IOS(2_0, 6_0);

// The view controller that was presented by this view controller or its nearest ancestor.
@property(nonatomic,readonly) UIViewController *presentedViewController  NS_AVAILABLE_IOS(5_0);

// The view controller that presented this view controller (or its farthest ancestor.)
@property(nonatomic,readonly) UIViewController *presentingViewController NS_AVAILABLE_IOS(5_0);

/*
  Determines which parent view controller's view should be presented over for presentations of type
  UIModalPresentationCurrentContext.  If no ancestor view controller has this flag set, then the presenter
  will be the root view controller.
*/
@property(nonatomic,assign) BOOL definesPresentationContext NS_AVAILABLE_IOS(5_0);

// A controller that defines the presentation context can also specify the modal transition style if this property is true.
@property(nonatomic,assign) BOOL providesPresentationContextTransitionStyle NS_AVAILABLE_IOS(5_0);

/*
  These four methods can be used in a view controller's appearance callbacks to determine if it is being
  presented, dismissed, or added or removed as a child view controller. For example, a view controller can
  check if it is disappearing because it was dismissed or popped by asking itself in its viewWillDisappear:
  method by checking the expression ([self isBeingDismissed] || [self isMovingFromParentViewController]).
*/

- (BOOL)isBeingPresented NS_AVAILABLE_IOS(5_0);
- (BOOL)isBeingDismissed NS_AVAILABLE_IOS(5_0);

- (BOOL)isMovingToParentViewController NS_AVAILABLE_IOS(5_0);
- (BOOL)isMovingFromParentViewController NS_AVAILABLE_IOS(5_0);

/*
  The next two methods are replacements for presentModalViewController:animated and
  dismissModalViewControllerAnimated: The completion handler, if provided, will be invoked after the presented
  controllers viewDidAppear: callback is invoked.
*/
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^)(void))completion NS_AVAILABLE_IOS(5_0);
// The completion handler, if provided, will be invoked after the dismissed controller's viewDidDisappear: callback is invoked.
- (void)dismissViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion NS_AVAILABLE_IOS(5_0);

// Display another view controller as a modal child. Uses a vertical sheet transition if animated.This method has been replaced by presentViewController:animated:completion:
- (void)presentModalViewController:(UIViewController *)modalViewController animated:(BOOL)animated NS_DEPRECATED_IOS(2_0, 6_0);

// Dismiss the current modal child. Uses a vertical sheet transition if animated. This method has been replaced by dismissViewControllerAnimated:completion:
- (void)dismissModalViewControllerAnimated:(BOOL)animated NS_DEPRECATED_IOS(2_0, 6_0);

/*
  Defines the transition style that will be used for this view controller when it is presented modally. Set
  this property on the view controller to be presented, not the presenter.  Defaults to
  UIModalTransitionStyleCoverVertical.
*/
@property(nonatomic,assign) UIModalTransitionStyle modalTransitionStyle NS_AVAILABLE_IOS(3_0);
@property(nonatomic,assign) UIModalPresentationStyle modalPresentationStyle NS_AVAILABLE_IOS(3_2);
// This controls whether this view controller takes over control of the status bar's appearance when presented non-full screen on another view controller. Defaults to NO.
@property(nonatomic,assign) BOOL modalPresentationCapturesStatusBarAppearance NS_AVAILABLE_IOS(7_0);

// Presentation modes may keep the keyboard visible when not required. Default implementation affects UIModalPresentationFormSheet visibility.
- (BOOL)disablesAutomaticKeyboardDismissal NS_AVAILABLE_IOS(4_3);

@property(nonatomic,assign) BOOL wantsFullScreenLayout NS_DEPRECATED_IOS(3_0, 7_0); // Deprecated in 7_0, Replaced by the following:

@property(nonatomic,assign) UIRectEdge edgesForExtendedLayout NS_AVAILABLE_IOS(7_0); // Defaults to UIRectEdgeAll
@property(nonatomic,assign) BOOL extendedLayoutIncludesOpaqueBars NS_AVAILABLE_IOS(7_0); // Defaults to NO, but bars are translucent by default on 7_0.
@property(nonatomic,assign) BOOL automaticallyAdjustsScrollViewInsets NS_AVAILABLE_IOS(7_0); // Defaults to YES

/* The preferredContentSize is used for any container laying out a child view controller.
 */
@property (nonatomic) CGSize preferredContentSize NS_AVAILABLE_IOS(7_0);

// These methods control the attributes of the status bar when this view controller is shown. They can be overridden in view controller subclasses to return the desired status bar attributes.
- (UIStatusBarStyle)preferredStatusBarStyle NS_AVAILABLE_IOS(7_0); // Defaults to UIStatusBarStyleDefault
- (BOOL)prefersStatusBarHidden NS_AVAILABLE_IOS(7_0); // Defaults to NO
// Override to return the type of animation that should be used for status bar changes for this view controller. This currently only affects changes to prefersStatusBarHidden.
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation NS_AVAILABLE_IOS(7_0); // Defaults to UIStatusBarAnimationFade

// This should be called whenever the return values for the view controller's status bar attributes have changed. If it is called from within an animation block, the changes will be animated along with the rest of the animation block.
- (void)setNeedsStatusBarAppearanceUpdate NS_AVAILABLE_IOS(7_0);

/* This method returns either itself or the nearest ancestor that responds to the action. View controllers can return NO from canPerformAction:withSender: to opt out of being a target for a given action. */
- (UIViewController *)targetViewControllerForAction:(SEL)action sender:(id)sender NS_AVAILABLE_IOS(8_0);

/* This method will show a view controller appropriately for the current size-class environment. It's implementation calls
 `[self targetViewControllerForAction:sender:]` first and redirects accordingly if the return value is not `self`, otherwise it will present the vc. */
- (void)showViewController:(UIViewController *)vc sender:(id)sender NS_AVAILABLE_IOS(8_0);

/* This method will show a view controller within the semantic "detail" UI associated with the current size-class environment. It's implementation calls  `[self targetViewControllerForAction:sender:]` first and redirects accordingly if the return value is not `self`, otherwise it will present the vc.  */
- (void)showDetailViewController:(UIViewController *)vc sender:(id)sender NS_AVAILABLE_IOS(8_0);

@property(nonatomic,getter=isEditing) BOOL editing;
- (void)setEditing:(BOOL)editing animated:(BOOL)animated; // Updates the appearance of the Edit|Done button item as necessary. Clients who override it must call super first.

- (UIBarButtonItem *)editButtonItem; // Return an Edit|Done button that can be used as a navigation item's custom view. Default action toggles the editing state with animation.

@property(nonatomic, readonly, retain) UISearchDisplayController *searchDisplayController NS_DEPRECATED_IOS(3_0,8_0);

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

#pragma mark - UIContainerViewControllerProtectedMethods

// An array of children view controllers. This array does not include any presented view controllers.
@property(nonatomic,readonly) NSArray *childViewControllers NS_AVAILABLE_IOS(5_0);

/*
  If the child controller has a different parent controller, it will first be removed from its current parent
  by calling removeFromParentViewController. If this method is overridden then the super implementation must
  be called.
*/
- (void)addChildViewController:(UIViewController *)childController NS_AVAILABLE_IOS(5_0);

/*
  Removes the the receiver from its parent's children controllers array. If this method is overridden then
  the super implementation must be called.
*/
- (void) removeFromParentViewController NS_AVAILABLE_IOS(5_0);

/*
  This method can be used to transition between sibling child view controllers. The receiver of this method is
  their common parent view controller. (Use [UIViewController addChildViewController:] to create the
  parent/child relationship.) This method will add the toViewController's view to the superview of the
  fromViewController's view and the fromViewController's view will be removed from its superview after the
  transition completes. It is important to allow this method to add and remove the views. The arguments to
  this method are the same as those defined by UIView's block animation API. This method will fail with an
  NSInvalidArgumentException if the parent view controllers are not the same as the receiver, or if the
  receiver explicitly forwards its appearance and rotation callbacks to its children. Finally, the receiver
  should not be a subclass of an iOS container view controller. Note also that it is possible to use the
  UIView APIs directly. If they are used it is important to ensure that the toViewController's view is added
  to the visible view hierarchy while the fromViewController's view is removed.
*/
- (void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion NS_AVAILABLE_IOS(5_0);

// If a custom container controller manually forwards its appearance callbacks, then rather than calling
// viewWillAppear:, viewDidAppear: viewWillDisappear:, or viewDidDisappear: on the children these methods
// should be used instead. This will ensure that descendent child controllers appearance methods will be
// invoked. It also enables more complex custom transitions to be implemented since the appearance callbacks are
// now tied to the final matching invocation of endAppearanceTransition.
- (void)beginAppearanceTransition:(BOOL)isAppearing animated:(BOOL)animated __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0);
- (void)endAppearanceTransition __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_5_0);

// Override to return a child view controller or nil. If non-nil, that view controller's status bar appearance attributes will be used. If nil, self is used. Whenever the return values from these methods change, -setNeedsUpdatedStatusBarAttributes should be called.
- (UIViewController *)childViewControllerForStatusBarStyle NS_AVAILABLE_IOS(7_0);
- (UIViewController *)childViewControllerForStatusBarHidden NS_AVAILABLE_IOS(7_0);

// Call to modify the trait collection for child view controllers.
- (void)setOverrideTraitCollection:(UITraitCollection *)collection forChildViewController:(UIViewController *)childViewController NS_AVAILABLE_IOS(8_0);
- (UITraitCollection *)overrideTraitCollectionForChildViewController:(UIViewController *)childViewController NS_AVAILABLE_IOS(8_0);

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

#pragma mark - UIContainerViewControllerCallbacks

/*
  This method is consulted to determine if a view controller manually forwards its containment callbacks to
  any children view controllers. Subclasses of UIViewController that implement containment logic may override
  this method. The default implementation returns YES. If it is overridden and returns NO, then the subclass is
  responsible for forwarding the following methods as appropriate - viewWillAppear: viewDidAppear: viewWillDisappear:
  viewDidDisappear: willRotateToInterfaceOrientation:duration:
  willAnimateRotationToInterfaceOrientation:duration: didRotateFromInterfaceOrientation:
*/

- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers NS_DEPRECATED_IOS(5_0,6_0);
- (BOOL)shouldAutomaticallyForwardRotationMethods NS_DEPRECATED_IOS(6_0,8_0, "Manually forward viewWillTransitionToSize:withTransitionCoordinator: if necessary");

- (BOOL)shouldAutomaticallyForwardAppearanceMethods NS_AVAILABLE_IOS(6_0);


/*
  These two methods are public for container subclasses to call when transitioning between child
  controllers. If they are overridden, the overrides should ensure to call the super. The parent argument in
  both of these methods is nil when a child is being removed from its parent; otherwise it is equal to the new
  parent view controller.

  addChildViewController: will call [child willMoveToParentViewController:self] before adding the
  child. However, it will not call didMoveToParentViewController:. It is expected that a container view
  controller subclass will make this call after a transition to the new child has completed or, in the
  case of no transition, immediately after the call to addChildViewController:. Similarly
  removeFromParentViewController: does not call [self willMoveToParentViewController:nil] before removing the
  child. This is also the responsibilty of the container subclass. Container subclasses will typically define
  a method that transitions to a new child by first calling addChildViewController:, then executing a
  transition which will add the new child's view into the view hierarchy of its parent, and finally will call
  didMoveToParentViewController:. Similarly, subclasses will typically define a method that removes a child in
  the reverse manner by first calling [child willMoveToParentViewController:nil].
*/
- (void)willMoveToParentViewController:(UIViewController *)parent NS_AVAILABLE_IOS(5_0);
- (void)didMoveToParentViewController:(UIViewController *)parent NS_AVAILABLE_IOS(5_0);

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

#pragma mark - UIConstraintBasedLayoutCoreMethods

/* Base implementation sends -updateConstraints to the view.
    When a view has a view controller, this message is sent to the view controller during
     the autolayout updateConstraints pass in lieu of sending updateConstraints directly
     to the view.
    You may override this method in a UIViewController subclass for updating custom
     constraints instead of subclassing your view and overriding -[UIView updateConstraints].
    Overrides must call super or send -updateConstraints to the view.
 */
- (void)updateViewConstraints NS_AVAILABLE_IOS(6_0);

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

#pragma mark - UIViewControllerTransitioning

@property (nonatomic,assign) id <UIViewControllerTransitioningDelegate> transitioningDelegate NS_AVAILABLE_IOS(7_0);

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

#pragma mark - UILayoutSupport

// These objects may be used as layout items in the NSLayoutConstraint API
@property(nonatomic,readonly,retain) id<UILayoutSupport> topLayoutGuide NS_AVAILABLE_IOS(7_0);
@property(nonatomic,readonly,retain) id<UILayoutSupport> bottomLayoutGuide NS_AVAILABLE_IOS(7_0);

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

#pragma mark - NSExtensionAdditions

// Returns the extension context. Also acts as a convenience method for a view controller to check if it participating in an extension request.
@property (nonatomic,readonly,retain) NSExtensionContext *extensionContext NS_AVAILABLE_IOS(8_0);

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

#pragma mark - UIAdaptivePresentations

@property (nonatomic,readonly) UIPresentationController *presentationController NS_AVAILABLE_IOS(8_0);
@property (nonatomic,readonly) UIPopoverPresentationController *popoverPresentationController NS_AVAILABLE_IOS(8_0);

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

#pragma mark - UINavigationControllerItem

@property(nonatomic,readonly,retain) UINavigationItem *navigationItem; // Created on-demand so that a view controller may customize its navigation appearance.
@property(nonatomic) BOOL hidesBottomBarWhenPushed; // If YES, then when this view controller is pushed into a controller hierarchy with a bottom bar (like a tab bar), the bottom bar will slide out. Default is NO.
@property(nonatomic,readonly,retain) UINavigationController *navigationController; // If this view controller has been pushed onto a navigation controller, return it.

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

#pragma mark - UINavigationControllerContextualToolbarItems

@property (nonatomic, retain) NSArray *toolbarItems NS_AVAILABLE_IOS(3_0);
- (void)setToolbarItems:(NSArray *)toolbarItems animated:(BOOL)animated NS_AVAILABLE_IOS(3_0);

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

@property (nonatomic, strong) IRView *rootView;

@property (nonatomic, strong) NSString *jsPlugin;

- (void) pushViewControllerWithScreenId:(NSString *)screenId animated:(BOOL)animated;
- (void) pushViewControllerWithScreenId:(NSString *)screenId animated:(BOOL)animated withData:(id)data;
- (void) pushViewControllerWithId:(NSString *)viewControllerId animated:(BOOL)animated;
- (void) pushViewControllerWithId:(NSString *)viewControllerId animated:(BOOL)animated withData:(id)data;

- (void) presentViewControllerWithScreenId:(NSString *)screenId animated:(BOOL)animated;
- (void) presentViewControllerWithScreenId:(NSString *)screenId animated:(BOOL)animated withData:(id)data;
- (void) presentViewControllerWithId:(NSString *)viewControllerId animated:(BOOL)animated;
- (void) presentViewControllerWithId:(NSString *)viewControllerId animated:(BOOL)animated withData:(id)data;
- (void) dismissViewControllerAnimated:(BOOL)animated;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (void) buildAndSetRootViewControllerWithScreenId:(NSString *)screenId andData:(id)data;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (void) showAlertViewWithTitle:(NSString *)title
                        message:(NSString *)message
                         action:(NSString *)action
                         cancel:(NSString *)cancelTitle
                   otherButtons:(NSArray *)otherTitlesArray
                           data:(id)data;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (void) showActionSheetWithTitle:(NSString *)title
                           action:(NSString *)action
                           cancel:(NSString *)cancelTitle
                      destructive:(NSString *)destructiveTitle
                     otherButtons:(NSArray *)otherTitlesArray
                            data:(id)data;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (IRView *) viewWithId:(NSString *)viewId;
- (void)showComponentWithId:(NSString *)componentId;
- (void)hideComponentWithId:(NSString *)componentId;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (NSArray *) controllersWithId:(NSString *)controllerId;
- (NSArray *) controllersWithScreenId:(NSString *)screenId;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (void) updateComponentsWithDataBindingKey:(NSString *)dataBindingKey;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (NSString *) key;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

- (void) watchJSCallbackToObjC:(id)prop :(id)action :(id)newValue :(id)oldValue;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

#pragma mark - RESideMenu

- (void)presentLeftMenuViewController:(id)sender;
- (void)presentRightMenuViewController:(id)sender;

- (void)hideMenuViewController;
- (void)setContentViewControllerWithScreenId:(NSString *)screenId animated:(BOOL)animated;

// -----------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------

@property (nonatomic, strong) id data;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRViewController : UIViewController <IRComponentInfoProtocol, IRViewControllerExport, RESideMenuDelegate, UIActionSheetDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray *viewsArrayForOrientationRestriction;
@property (nonatomic, strong) NSMutableArray *viewsArrayForKeyboardResize;
@property (nonatomic, strong) NSMutableDictionary *imageLoadingDataDictionary;

@property (nonatomic) BOOL shouldUnregisterVC;
@property (nonatomic) BOOL shouldUnregisterVCStack;

- (void) keyPathUpdatedInReactiveCocoa:(NSString *)keyPath
                        newStringValue:(NSString *)newStringValue;

- (void) addViewForOrientationRestriction:(IRView *)irView;

- (void) addViewForKeyboardResize:(IRView *)aView
                 bottomConstraint:(NSLayoutConstraint *)constraint;

- (void) cleanWatchJSObserversAndVC;

@end