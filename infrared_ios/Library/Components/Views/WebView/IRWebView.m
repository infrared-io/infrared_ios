//
// Created by Uros Milivojevic on 6/25/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRWebView.h"
#import "IRWebViewDescriptor.h"
#import "IRBaseBuilder.h"
#import "IRBaseDescriptor.h"
#import "IRDataController.h"
#import "IRWebViewObserver.h"


@interface IRWebView ()

@property (nonatomic, strong) NSString *internalHtmlString;
@property (nonatomic, strong) IRWebViewObserver *observer;

@end

@implementation IRWebView

@synthesize componentInfo;
@synthesize descriptor;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        self.observer = [[IRWebViewObserver alloc] init];
        self.delegate = self.observer;
    }
    return self;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

- (void) setHtmlString:(NSString *)htmlString
{
    if (/*[htmlString length] > 0
        &&*/ [self.internalHtmlString isEqualToString:htmlString] == NO)
    {
        self.internalHtmlString = htmlString;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadHTMLString:htmlString baseURL:nil];
        });
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
    IRWebView *irWebView = [[IRWebView alloc] init];
    irWebView.descriptor = [[IRWebViewDescriptor alloc] init];
    [IRBaseBuilder setComponentId:componentId toJSInitComponent:irWebView];
    return irWebView;
}

- (NSString *) componentId
{
    return self.descriptor.componentId;
}

@end