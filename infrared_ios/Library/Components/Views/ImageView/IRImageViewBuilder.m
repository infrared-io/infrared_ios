//
// Created by Uros Milivojevic on 10/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRImageViewBuilder.h"
#import "IRImageViewDescriptor.h"
#import "IRImageView.h"
#import "IRViewBuilder.h"
#import "IRSimpleCache.h"
#import "IRScreenDescriptor.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRViewController.h"


@implementation IRImageViewBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRImageView *irImageView;

    irImageView = [[IRImageView alloc] init];
    [IRImageViewBuilder setUpComponent:irImageView componentDescriptor:descriptor viewController:viewController
                                 extra:extra];

    return irImageView;
}

+ (void) setUpComponent:(IRImageView *)irImageView
    componentDescriptor:(IRImageViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    UIImage *image;

    [IRViewBuilder setUpComponent:irImageView componentDescriptor:descriptor viewController:viewController extra:extra];

    // -- image
    image = [[IRSimpleCache sharedInstance] imageForURI:descriptor.image];
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.imageCapInsets, UIEdgeInsetsNull) == NO) {
        irImageView.image = [image resizableImageWithCapInsets:descriptor.imageCapInsets];
    } else {
        irImageView.image = image;
    }

    // -- highlighted image
    image = [[IRSimpleCache sharedInstance] imageForURI:descriptor.highlightedImage];
    if (UIEdgeInsetsEqualToEdgeInsets(descriptor.highlightedImageCapInsets, UIEdgeInsetsNull) == NO) {
        irImageView.highlightedImage = [image resizableImageWithCapInsets:descriptor.highlightedImageCapInsets];
    } else {
        irImageView.highlightedImage = image;
    }

    // -- highlighted
    irImageView.highlighted = descriptor.highlighted;

    // -- preserveAspectRatio
    if (descriptor.preserveAspectRatio) {
        // TODO: set width and height based on image size
        //  - implement as static method so other parts of project could use it (best in IRBaseBuilder or *Util)
    }
}

@end