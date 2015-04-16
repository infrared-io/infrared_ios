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

    if ([uiView.subviews count] > 0) {
        [IRBaseBuilder addDataBindingsForViewsArray:uiView.subviews viewController:viewController];
    }
}

+ (void) setDataBinding:(IRDataBindingDescriptor *)dataBinding
                forView:(UIView *)view
         viewController:(IRViewController *)viewController
{
    DataBindingMode mode = dataBinding.mode;
    if (mode == DataBindingModeTwoWay) {
        [IRBaseBuilder setDataBindingModeFromData:dataBinding toView:view];
        [IRBaseBuilder setDataBindingModeToData:dataBinding fromView:view viewController:viewController];
    } else if (mode == DataBindingModeOneWayFromData) {
        [IRBaseBuilder setDataBindingModeFromData:dataBinding toView:view];
    } else if (mode == DataBindingModeOneWayToData) {
        [IRBaseBuilder setDataBindingModeToData:dataBinding fromView:view viewController:viewController];
    }
}

+ (void) setDataBindingModeFromData:(IRDataBindingDescriptor *)dataBinding
                             toView:(UIView *)view
{
    id target;
    NSString *keyPath;
    RACChannel *modelChannel;
    RACSubscriptingAssignmentTrampoline *subscriptingAssignmentTrampoline;

    if (dataBinding.property) {
        target = [IRBaseBuilder targetOfDataPath:dataBinding.data sourceView:view];
        keyPath = [IRBaseBuilder propertyPartOfDataPath:dataBinding.data];
        modelChannel = [[RACKVOChannel alloc] initWithTarget:target keyPath:keyPath nilValue:nil];
        subscriptingAssignmentTrampoline = [[RACSubscriptingAssignmentTrampoline alloc] initWithTarget:view nilValue:nil];
        subscriptingAssignmentTrampoline[dataBinding.property] = modelChannel.followingTerminal;
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

    if (dataBinding.property) {
        target = [IRBaseBuilder targetOfDataPath:dataBinding.data sourceView:view];
        keyPath = [IRBaseBuilder propertyPartOfDataPath:dataBinding.data];
        modelChannel = [[RACKVOChannel alloc] initWithTarget:target keyPath:keyPath nilValue:nil];
        if ([dataBinding.property isEqualToString:@"text"]) {
            if ([view isKindOfClass:[UITextField class]]) {
                racSignal = ((UITextField *)view).rac_textSignal;
                [racSignal subscribe:modelChannel.followingTerminal];
                [racSignal subscribeNext:^(NSString *newValue) {
//                    NSLog(@"********** keyPath=%@, newValue=%@", keyPath, newValue);
                    [viewController keyPathUpdatedInReactiveCocoa:keyPath newStringValue:newValue];
                }];
            } else if ([view isKindOfClass:[UITextView class]]) {
                racSignal = ((UITextView *)view).rac_textSignal;
                [racSignal subscribe:modelChannel.followingTerminal];
                [racSignal subscribeNext:^(NSString *newValue) {
//                    NSLog(@"********** keyPath=%@, newValue=%@", keyPath, newValue);
                    [viewController keyPathUpdatedInReactiveCocoa:keyPath newStringValue:newValue];
                }];
            }
        }
    }
}

+ (id) targetOfDataPath:(NSString *)dataPath
             sourceView:(UIView *)sourceView
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