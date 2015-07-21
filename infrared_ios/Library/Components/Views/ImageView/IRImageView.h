//
//  IRImageView.h
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "IRComponentInfoProtocol.h"
#import "IRView.h"
#import "UIImageViewExport.h"

@protocol IRImageViewExport <JSExport>

//@property(nonatomic,retain) UIImage *image;                                                     // default is nil
//@property(nonatomic,retain) UIImage *highlightedImage NS_AVAILABLE_IOS(3_0);      // default is nil
//@property(nonatomic,getter=isUserInteractionEnabled) BOOL userInteractionEnabled;               // default is NO
//
//@property(nonatomic,getter=isHighlighted) BOOL highlighted NS_AVAILABLE_IOS(3_0); // default is NO
//
//// these allow a set of images to be animated. the array may contain multiple copies of the same
//
//@property(nonatomic,copy) NSArray *animationImages;            // The array must contain UIImages. Setting hides the single image. default is nil
//@property(nonatomic,copy) NSArray *highlightedAnimationImages NS_AVAILABLE_IOS(3_0);            // The array must contain UIImages. Setting hides the single image. default is nil
//
//@property(nonatomic) NSTimeInterval animationDuration;         // for one cycle of images. default is number of images * 1/30th of a second (i.e. 30 fps)
//@property(nonatomic) NSInteger      animationRepeatCount;      // 0 means infinite (default is 0)
//
//// When tintColor is non-nil, any template images set on the image view will be colorized with that color.
//// The tintColor is inherited through the superview hierarchy. See UIView for more information.
//@property (nonatomic, retain) UIColor *tintColor NS_AVAILABLE_IOS(7_0);
//
//- (void)startAnimating;
//- (void)stopAnimating;
//- (BOOL)isAnimating;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRImageView : UIImageView <IRComponentInfoProtocol, UIImageViewExport, IRImageViewExport, UIViewExport, IRViewExport>

@end
