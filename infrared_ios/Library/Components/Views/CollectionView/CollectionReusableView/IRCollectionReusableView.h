//
// Created by Uros Milivojevic on 6/23/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRView.h"


@protocol IRCollectionReusableViewExport <JSExport>

@property (nonatomic, readonly, copy) NSString *reuseIdentifier;

// Override point.
// Called by the collection view before the instance is returned from the reuse queue.
// Subclassers must call super.
- (void)prepareForReuse;

// Classes that want to support custom layout attributes specific to a given UICollectionViewLayout subclass can apply them here.
// This allows the view to work in conjunction with a layout class that returns a custom subclass of UICollectionViewLayoutAttributes from -layoutAttributesForItem: or the corresponding layoutAttributesForHeader/Footer methods.
// -applyLayoutAttributes: is then called after the view is added to the collection view and just before the view is returned from the reuse queue.
// Note that -applyLayoutAttributes: is only called when attributes change, as defined by -isEqual:.
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes;

// Override these methods to provide custom UI for specific layouts.
- (void)willTransitionFromLayout:(UICollectionViewLayout *)oldLayout toLayout:(UICollectionViewLayout *)newLayout;
- (void)didTransitionFromLayout:(UICollectionViewLayout *)oldLayout toLayout:(UICollectionViewLayout *)newLayout;

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes NS_AVAILABLE_IOS(8_0);

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRCollectionReusableView : UICollectionReusableView <IRComponentInfoProtocol, IRCollectionReusableViewExport, IRViewExport>

@property (nonatomic) BOOL setUpDone;

@end