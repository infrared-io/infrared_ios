//
//  IRImageView.m
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRImageView.h"
#import "IRBaseBuilder.h"
#import "IRBaseDescriptor.h"
#import "IRDataController.h"
#import "IRImageViewDescriptor.h"
#import "IRSimpleCache.h"

@implementation IRImageView

@synthesize componentInfo;
@synthesize descriptor;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
    }
    return self;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark -

- (void) setImage:(UIImage *)image
{
    if ([image isKindOfClass:[NSString class]]) {
        UIImage *aImage;
        aImage = [[IRSimpleCache sharedInstance] imageForURI:image];
        if (UIEdgeInsetsEqualToEdgeInsets(((IRImageViewDescriptor *)self.descriptor).imageCapInsets, UIEdgeInsetsNull) == NO) {
            aImage = [aImage resizableImageWithCapInsets:((IRImageViewDescriptor *)self.descriptor).imageCapInsets];
        }
        [super setImage:aImage];
    } else {
        [super setImage:image];
    }
}

- (void) setHighlightedImage:(UIImage *)highlightedImage
{
    if ([highlightedImage isKindOfClass:[NSString class]]) {
        UIImage *aImage;
        aImage = [[IRSimpleCache sharedInstance] imageForURI:highlightedImage];
        if (UIEdgeInsetsEqualToEdgeInsets(((IRImageViewDescriptor *)self.descriptor).highlightedImageCapInsets, UIEdgeInsetsNull) == NO) {
            aImage = [aImage resizableImageWithCapInsets:((IRImageViewDescriptor *)self.descriptor).highlightedImageCapInsets];
        }
        [super setHighlightedImage:aImage];
    } else {
        [super setHighlightedImage:highlightedImage];
    }
}


// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Subview methods

- (void)removeFromSuperview
{
    [[IRDataController sharedInstance] unregisterView:self];

    [super removeFromSuperview];
}
- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
    [super insertSubview:view atIndex:index];

    if ([view conformsToProtocol:@protocol(IRComponentInfoProtocol)] && ((IRView *)view).descriptor.jsInit) {
        [[IRDataController sharedInstance] registerView:(IRView *) view inSameScreenAsParentView:self];
    }
}
- (void)addSubview:(UIView *)view
{
    [super addSubview:view];

    if ([view conformsToProtocol:@protocol(IRComponentInfoProtocol)] && ((IRView *)view).descriptor.jsInit) {
        [[IRDataController sharedInstance] registerView:(IRView *) view inSameScreenAsParentView:self];
    }
}
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview
{
    [super insertSubview:view belowSubview:siblingSubview];

    if ([view conformsToProtocol:@protocol(IRComponentInfoProtocol)] && ((IRView *)view).descriptor.jsInit) {
        [[IRDataController sharedInstance] registerView:(IRView *) view inSameScreenAsParentView:self];
    }
}
- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview
{
    [super insertSubview:view aboveSubview:siblingSubview];

    if ([view conformsToProtocol:@protocol(IRComponentInfoProtocol)] && ((IRView *)view).descriptor.jsInit) {
        [[IRDataController sharedInstance] registerView:(IRView *) view inSameScreenAsParentView:self];
    }
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

#pragma mark - Create

+ (id) createWithComponentId:(NSString *)componentId
{
    IRImageView *irImageView = [[IRImageView alloc] init];
    irImageView.descriptor = [[IRImageViewDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irImageView];
    return irImageView;
}

- (NSString *) componentId
{
    return self.descriptor.componentId;
}

@end
