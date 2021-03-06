//
// Created by Uros Milivojevic on 12/31/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IRAppDescriptor;


@interface IRSideMenuDescriptor : NSObject

@property (nonatomic) BOOL enable;

@property (assign, readwrite, nonatomic) NSTimeInterval animationDuration;
@property (strong, readwrite, nonatomic) /*UIImage*/NSString *backgroundImage;
@property (assign, readwrite, nonatomic) BOOL panGestureEnabled;
@property (assign, readwrite, nonatomic) BOOL panFromEdge;
@property (assign, readwrite, nonatomic) NSUInteger panMinimumOpenThreshold;
@property (assign, readwrite, nonatomic) BOOL interactivePopGestureRecognizerEnabled;
@property (assign, readwrite, nonatomic) BOOL scaleContentView;
@property (assign, readwrite, nonatomic) BOOL scaleBackgroundImageView;
@property (assign, readwrite, nonatomic) BOOL scaleMenuView;
@property (assign, readwrite, nonatomic) BOOL contentViewShadowEnabled;
#if TARGET_OS_IPHONE
@property (strong, readwrite, nonatomic) UIColor *contentViewShadowColor;
#endif
@property (assign, readwrite, nonatomic) CGSize contentViewShadowOffset;
@property (assign, readwrite, nonatomic) CGFloat contentViewShadowOpacity;
@property (assign, readwrite, nonatomic) CGFloat contentViewShadowRadius;
@property (assign, readwrite, nonatomic) CGFloat contentViewScaleValue;
@property (assign, readwrite, nonatomic) CGFloat contentViewInLandscapeOffsetCenterX;
@property (assign, readwrite, nonatomic) CGFloat contentViewInPortraitOffsetCenterX;
@property (assign, readwrite, nonatomic) CGFloat parallaxMenuMinimumRelativeValue;
@property (assign, readwrite, nonatomic) CGFloat parallaxMenuMaximumRelativeValue;
@property (assign, readwrite, nonatomic) CGFloat parallaxContentMinimumRelativeValue;
@property (assign, readwrite, nonatomic) CGFloat parallaxContentMaximumRelativeValue;
#if TARGET_OS_IPHONE
@property (assign, readwrite, nonatomic) CGAffineTransform menuViewControllerTransformation;
#endif
@property (assign, readwrite, nonatomic) BOOL parallaxEnabled;
@property (assign, readwrite, nonatomic) BOOL bouncesHorizontally;
#if TARGET_OS_IPHONE
@property (assign, readwrite, nonatomic) UIStatusBarStyle menuPreferredStatusBarStyle;
#endif
@property (assign, readwrite, nonatomic) BOOL menuPrefersStatusBarHidden;

@property (nonatomic, strong) NSString* leftMenuScreenId;
@property (nonatomic, strong) NSString* rightMenuScreenId;

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor;

@end