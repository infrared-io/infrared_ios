//
// Created by Uros Milivojevic on 10/17/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRViewController.h"
#import "IRBaseBuilder+DataBinding.h"
#import "IRView.h"
#import "IRViewDescriptor.h"
#import "IRDataBindingDescriptor.h"
#import "RACKVOChannel.h"
#import "RACChannel.h"
#import "RACSubscriptingAssignmentTrampoline.h"
#import "IRDataController.h"
#import "UITextField+RACSignalSupport.h"
#import "UITextView+RACSignalSupport.h"
#import "IRViewController.h"
#import "IRSimpleCache.h"
#import "IRUtil.h"
#import "RACScheduler.h"
#import "RACSignal+Operations.h"


@implementation IRBaseBuilder (DataBinding)

+ (void) addDataBindingsForViewsArray:(NSArray *)viewsArray
                       viewController:(IRViewController *)viewController
{
    for (IRView *anIRView in viewsArray) {
        if ([anIRView conformsToProtocol:@protocol(IRComponentInfoProtocol)]) {
            [IRBaseBuilder addDataBindingsForView:anIRView
                                   viewController:viewController
                                     dataBindings:((IRViewDescriptor *) anIRView.descriptor).dataBindingsArray];
        }
    }
}

+ (void) addDataBindingsForView:(UIView *)uiView
                 viewController:(IRViewController *)viewController
                   dataBindings:(NSArray *)dataBindingsArray
{
    for (IRDataBindingDescriptor *anDataBindingDescriptor in dataBindingsArray) {
        [IRBaseBuilder setDataBinding:anDataBindingDescriptor forView:uiView viewController:viewController];
    }

    if ([uiView respondsToSelector:@selector(subviews)] && [uiView.subviews count] > 0) {
        [IRBaseBuilder addDataBindingsForViewsArray:uiView.subviews viewController:viewController];
    }
}

+ (void) setDataBinding:(IRDataBindingDescriptor *)dataBinding
                forView:(UIView *)view
         viewController:(IRViewController *)viewController
{
    DataBindingMode mode = dataBinding.mode;
    if (mode == DataBindingModeTwoWay) {
        [IRBaseBuilder setDataBindingModeFromData:dataBinding toView:view viewController:viewController];
        [IRBaseBuilder setDataBindingModeToData:dataBinding fromView:view viewController:viewController];
    } else if (mode == DataBindingModeOneWayFromData) {
        [IRBaseBuilder setDataBindingModeFromData:dataBinding toView:view viewController:viewController];
    } else if (mode == DataBindingModeOneWayToData) {
        [IRBaseBuilder setDataBindingModeToData:dataBinding fromView:view viewController:viewController];
    }
}

+ (void) setDataBindingModeFromData:(IRDataBindingDescriptor *)dataBinding
                             toView:(UIView *)view
                     viewController:(IRViewController *)viewController
{
    id target;
    NSString *keyPath;
    RACChannel *modelChannel;
    RACSubscriptingAssignmentTrampoline *subscriptingAssignmentTrampoline;

    if (dataBinding.property) {
        target = [IRBaseBuilder targetOfDataPath:dataBinding.data sourceView:view viewController:viewController];
        keyPath = [IRBaseBuilder propertyPartOfDataPath:dataBinding.data];
        modelChannel = [[RACKVOChannel alloc] initWithTarget:target keyPath:keyPath nilValue:nil];
        subscriptingAssignmentTrampoline = [[RACSubscriptingAssignmentTrampoline alloc] initWithTarget:view nilValue:nil];
//        subscriptingAssignmentTrampoline[dataBinding.property] = modelChannel.followingTerminal;
        __weak IRDataBindingDescriptor *weakDataBinding = dataBinding;
        __weak UIView *weakView = view;
        subscriptingAssignmentTrampoline[dataBinding.property] = [[modelChannel.followingTerminal
          map: ^id(id value)
          {
              id finalValue = value;
              if ([IRBaseBuilder isPropertyWithName:weakDataBinding.property inObject:weakView
                                            ofClass:[UIImage class]])
              {
                  UIImage *image;
                  NSString *imagePath = value;
                  imagePath = [IRUtil prefixFilePathWithBaseUrlIfNeeded:imagePath];
                  if ([[IRSimpleCache sharedInstance] hasDataForURI:imagePath]) {
                      image = [[IRSimpleCache sharedInstance] imageForURI:imagePath];
                      finalValue = image;
                  } else {
                      finalValue = nil;
                      // -- download and set image
                      [IRBaseBuilder downloadAndSetImageWithPathInBackground:imagePath view:weakView
                                                                propertyName:weakDataBinding.property];
                  }
              } else if ([IRBaseBuilder isPropertyWithName:weakDataBinding.property inObject:weakView
                                                   ofClass:[UIColor class]])
              {
                  NSString *colorString = value;
                  UIColor *color = [IRUtil transformHexColorToUIColor:colorString];
                  finalValue = color;
              } else if ([IRBaseBuilder isPropertyWithName:weakDataBinding.property inObject:weakView
                                                   ofClass:[UIFont class]])
              {
                  NSString *fontString = value;
                  UIFont *font = [IRBaseDescriptor fontFromString:fontString];
                  finalValue = font;
              } else if ([IRBaseBuilder isPropertyWithName:weakDataBinding.property inObject:weakView
                                                   ofClass:[NSString class]])
              {
                  if ([value isKindOfClass:[NSNumber class]]) {
                      finalValue = [value stringValue];
                  }
              } else if ([IRBaseBuilder isBoolPropertyWithName:weakDataBinding.property
                                                      inObject:weakView])
              {
                  if (value == nil) {
                      finalValue = @(NO);
                  }
              }
              if ([finalValue isKindOfClass:[NSNull class]]) {
                  finalValue = nil;
              }
              return finalValue;
          }]
          deliverOn:[RACScheduler mainThreadScheduler]];
    }
}

+ (void) setDataBindingModeToData:(IRDataBindingDescriptor *)dataBinding
                         fromView:(UIView *)view
                   viewController:(IRViewController *)viewController
{
    id target;
    NSString *keyPath;
    RACChannel *modelChannel;
    RACSignal *racSignal;
    RACChannelTerminal *channelTerminal;

    if (dataBinding.property) {
        target = [IRBaseBuilder targetOfDataPath:dataBinding.data sourceView:view viewController:viewController];
        keyPath = [IRBaseBuilder propertyPartOfDataPath:dataBinding.data];
        modelChannel = [[RACKVOChannel alloc] initWithTarget:target keyPath:keyPath nilValue:nil];
        if ([dataBinding.property isEqualToString:@"text"]) {
            __weak IRViewController *weakViewController = viewController;
            if ([view isKindOfClass:[UITextField class]]) {
                channelTerminal = ((UITextField *) view).rac_newTextChannel;
                [channelTerminal subscribe:modelChannel.followingTerminal];
                [channelTerminal subscribeNext:^(NSString *newValue) {
//                    NSLog(@"********** keyPath=%@, newValue=%@", keyPath, newValue);
                    [weakViewController keyPathUpdatedInReactiveCocoa:keyPath newStringValue:newValue];
                }];

                /*
                racSignal = ((UITextField *) view).rac_textSignal;
                [racSignal subscribe:modelChannel.followingTerminal];
                [racSignal subscribeNext:^(NSString *newValue) {
//                    NSLog(@"********** keyPath=%@, newValue=%@", keyPath, newValue);
                    [viewController keyPathUpdatedInReactiveCocoa:keyPath newStringValue:newValue];
                }];
                */
            } else if ([view isKindOfClass:[UITextView class]]) {
//                channelTerminal = ((UITextView *) view).rac_textSignal;
//                [channelTerminal subscribe:modelChannel.followingTerminal];
//                [channelTerminal subscribeNext:^(NSString *newValue) {
////                    NSLog(@"********** keyPath=%@, newValue=%@", keyPath, newValue);
//                    [viewController keyPathUpdatedInReactiveCocoa:keyPath newStringValue:newValue];
//                }];


                racSignal = ((UITextView *)view).rac_textSignal;
                [racSignal subscribe:modelChannel.followingTerminal];
                [racSignal subscribeNext:^(NSString *newValue) {
//                    NSLog(@"********** keyPath=%@, newValue=%@", keyPath, newValue);
                    [weakViewController keyPathUpdatedInReactiveCocoa:keyPath newStringValue:newValue];
                }];
            }
        }
    }
}

+ (id) targetOfDataPath:(NSString *)dataPath
             sourceView:(UIView *)sourceView
         viewController:(IRViewController *)viewController
{
    id target = nil;
    NSString *targetString = nil;
    JSContext *jsContext;
    NSRange range;
    if ([dataPath length] > 0) {
        range = [dataPath rangeOfString:@"."];
        targetString = [dataPath substringToIndex:range.location];
        if ([targetString isEqualToString:@"this"]) {
            target = [IRBaseBuilder parentViewController:sourceView];
            if (target == nil) {
                target = viewController;
            }
        } else if ([targetString length] > 0) {
            jsContext = [IRDataController sharedInstance].globalJSContext;
            target = [jsContext[targetString] toObject];
        }
    }
    return target;
}

+ (NSString *) propertyPartOfDataPath:(NSString *)dataPath
{
    NSString *property = nil;
    NSRange range;
    if ([dataPath length] > 0) {
        range = [dataPath rangeOfString:@"."];
        property = [dataPath substringFromIndex:range.location+range.length];
    }
    return property;
}

@end