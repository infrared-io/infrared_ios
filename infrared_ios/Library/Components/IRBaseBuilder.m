//
// Created by Uros Milivojevic on 10/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRBaseBuilder.h"
#import "IRGlobal.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRLabelDescriptor.h"
#import "IRButtonDescriptor.h"
#import "IRTextFieldDescriptor.h"
#import "IRImageViewDescriptor.h"
#import "IRViewBuilder.h"
#import "IRButton.h"
#import "IRLabelBuilder.h"
#import "IRViewAndControlDescriptor.h"
#import "IRImageViewBuilder.h"
#import "IRScreenDescriptor.h"
#import "IRComponentInfoProtocol.h"
#import "IRButtonBuilder.h"
#import "IRTextFieldBuilder.h"
#import "IRButton.h"
#import "IRViewControllerDescriptor.h"
#import "IRDataController.h"
#import "IRBaseBuilder+AutoLayout.h"
#import "IRLayoutConstraintDescriptor.h"
#import "IRLayoutConstraintWithVFDescriptor.h"
#import "IRGestureRecognizerDescriptor.h"
#import "IRScrollViewDescriptor.h"
#import "IRScrollViewBuilder.h"
#import "IRDataBindingDescriptor.h"
#import "IRSimpleCache.h"
#import "IRUtil.h"
#import "IRViewController.h"
#import "IRImageView.h"
#import "IRBarButtonItem.h"
#import "IRActionSheet.h"
#import "IRAlertView.h"
#import "IRBaseLibrary.h"
#import <objc/runtime.h>


@implementation IRBaseBuilder

+ (NSMutableArray *) buildComponentsArrayFromDescriptorsArray:(NSArray *)descriptorsArray
                                               viewController:(IRViewController *)viewController
                                                        extra:(id)extra
{
    NSMutableArray *componentsArray = [[NSMutableArray alloc] init];
    for (IRBaseDescriptor *anDescriptor in descriptorsArray) {
        [componentsArray addObject:[IRBaseBuilder buildComponentFromDescriptor:anDescriptor
                                                                viewController:viewController extra:extra]];
    }
    return componentsArray;
}

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRView *aView = nil;
    Class aClass;
    aClass = [[descriptor class] builderClass];
    if ([aClass respondsToSelector:@selector(buildComponentFromDescriptor:viewController:extra:)]) {
        aView = [aClass buildComponentFromDescriptor:descriptor viewController:viewController extra:extra];
    }
    return aView;
}

+ (void) setUpComponent:(IRView *)irComponent
    componentDescriptor:(IRViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRBaseBuilder setUpComponentWithoutRegistration:irComponent fromDescriptor:descriptor];

    if ([descriptor isMemberOfClass:[IRViewControllerDescriptor class]]) {
        [[IRDataController sharedInstance] registerViewController:irComponent];
    } else {
        [[IRDataController sharedInstance] registerView:irComponent viewController:viewController];
    }
}

+ (void) setUpComponentWithoutRegistration:(id <IRComponentInfoProtocol>)irComponent
                            fromDescriptor:(IRBaseDescriptor *)descriptor
{
    irComponent.descriptor = descriptor;
}

+ (void) setComponentId:(NSString *)componentId
      toJSInitComponent:(id <IRComponentInfoProtocol>)irView
{
    irView.descriptor.jsInit = YES;
    irView.descriptor.componentId = componentId;
}

+ (void) setUpUIControlInterfaceForComponent:(UIControl *)uiControl
                              fromDescriptor:(IRViewAndControlDescriptor *)descriptor
{
    uiControl.contentHorizontalAlignment = descriptor.contentHorizontalAlignment;
    uiControl.contentVerticalAlignment = descriptor.contentVerticalAlignment;
    uiControl.selected = descriptor.selected;
    uiControl.enabled = descriptor.enabled;
    uiControl.highlighted = descriptor.highlighted;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

+ (NSString *) textWithI18NCheck:(NSString *)originalText
{
    NSString *finalText = nil;
    NSString *i18nKey;
    NSString *i18nJSPrefix;
    if ([originalText length] > 0) {
        i18nJSPrefix = [IRBaseBuilder i18nJSPrefix];
        if ([originalText hasPrefix:i18nJSPrefix/*@"i18n."*/]) {
            i18nKey = [originalText substringFromIndex:[i18nJSPrefix length]]; // [@"i18n." length] == 5
            finalText = [IRDataController sharedInstance].i18n[i18nKey];
        }
        if (finalText == nil) {
            finalText = originalText;
        }
    }
    return finalText;
}
+ (NSString *) i18nJSPrefix
{
    NSString *i18nJSPrefix = [NSString stringWithFormat:@"%@.%@.", IR_JS_LIBRARY_KEY, I18N_JS_DATA_KEY];
    return i18nJSPrefix;
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

+ (void) bindData:(NSDictionary *)dictionary
                 toView:(IRView *)irView
withDataBindingItemName:(NSString *)name
{
    NSArray *dataBindingsArray;
    JSContext *jsContext;
    NSString *correctedDataPath;
    JSValue *jsValue;
    NSArray *subviews;

    if ([irView conformsToProtocol:@protocol(IRComponentInfoProtocol)]) {
        dataBindingsArray = ((IRViewDescriptor *) irView.descriptor).dataBindingsArray;
        if ([dataBindingsArray count] > 0) {
            jsContext = [[IRDataController sharedInstance] globalJSContext];
            // -- set temp data
            jsContext[[IRUtil createKeyFromObjectAddress:name]] = dictionary;
            for (IRDataBindingDescriptor *anDescriptor in dataBindingsArray) {
                if (anDescriptor.property == nil || [anDescriptor.property length] == 0) {
                    break;
                }
                // -- correcting dataPath
                NSRange itemNameRange = [anDescriptor.data rangeOfString:name];
                if (itemNameRange.location != NSNotFound) {
                    correctedDataPath = [anDescriptor.data stringByReplacingCharactersInRange:itemNameRange
                                                                                   withString:[IRUtil createKeyFromObjectAddress:name]];
                } else {
                    correctedDataPath = anDescriptor.data;
                }
                // -- getting data
                jsValue = [jsContext evaluateScript:correctedDataPath];
                if ([IRBaseBuilder isPropertyWithName:anDescriptor.property inObject:irView
                                              ofClass:[UIImage class]])
                {
                    UIImage *image;
                    NSString *imagePath = [jsValue toString];
                    imagePath = [IRUtil prefixFilePathWithBaseUrlIfNeeded:imagePath];
                    if ([[IRSimpleCache sharedInstance] hasDataForURI:imagePath]) {
                        image = [[IRSimpleCache sharedInstance] imageForURI:imagePath];
                        [irView setValue:image forKeyPath:anDescriptor.property];
                    } else {
                        // -- download and set image
                        [IRBaseBuilder downloadAndSetImageWithPathInBackground:imagePath view:irView
                                                                  propertyName:anDescriptor.property];
                    }
                } else if ([IRBaseBuilder isPropertyWithName:anDescriptor.property inObject:irView
                                                     ofClass:[UIColor class]])
                {
                    NSString *colorString = [jsValue toString];
                    UIColor *color = [IRUtil transformHexColorToUIColor:colorString];
                    [irView setValue:color forKeyPath:anDescriptor.property];
                } else if ([IRBaseBuilder isPropertyWithName:anDescriptor.property inObject:irView
                                                     ofClass:[UIFont class]])
                {
                    NSString *fontString = [jsValue toString];
                    UIFont *font = [IRBaseDescriptor fontFromString:fontString];
                    [irView setValue:font forKeyPath:anDescriptor.property];
                } else {
                    if ([jsValue isString] || [jsValue isNumber]) {
                        [irView setValue:[jsValue toString] forKeyPath:anDescriptor.property];
                    } else if ([jsValue isUndefined] == NO) {
                        [irView setValue:[jsValue toObject] forKeyPath:anDescriptor.property];
                    }
                }
            }
            // - clean temp data
            jsContext[[IRUtil createKeyFromObjectAddress:name]] = nil;
            [jsContext evaluateScript:[NSString stringWithFormat:@"delete %@", [IRUtil createKeyFromObjectAddress:name]]];
        }
    }

    subviews = irView.subviews;
    for (IRView *anView in subviews) {
        [IRBaseBuilder bindData:dictionary toView:anView withDataBindingItemName:name];
    }
}

+ (BOOL) isPropertyWithName:(NSString *)propertyName
                   inObject:(IRView *)irView
                    ofClass:(Class)propertyClass
{
    BOOL propertyHasRightClass = NO;
    NSArray *propertyPathComponentsArray = [propertyName componentsSeparatedByString:@"."];
    NSObject *parentObject = irView;
    NSString *lastProperty = [propertyPathComponentsArray lastObject];
    NSString *anProperty;
    for (uint i = 0; i < [propertyPathComponentsArray count]-1; ++i) {
        anProperty = propertyPathComponentsArray[i];
        parentObject = [parentObject performSelector:NSSelectorFromString(anProperty)];
    }
    objc_property_t objc_property = class_getProperty([parentObject class], [lastProperty UTF8String]);
    const char *type;
    if (objc_property) {
        type = property_getAttributes(objc_property);
        NSString *typeString = [NSString stringWithUTF8String:type];
        NSArray *attributes = [typeString componentsSeparatedByString:@","];
        NSString *typeAttribute = [attributes firstObject];
        if ([typeAttribute hasPrefix:@"T@"] && [typeAttribute length] > 1) {
            NSString *typeClassName = [typeAttribute substringWithRange:NSMakeRange(3, [typeAttribute length] - 4)];  //turns @"NSDate" into NSDate
            Class typeClass = NSClassFromString(typeClassName);
            if (typeClass != nil && typeClass == propertyClass) {
                propertyHasRightClass = YES;
            }
        }
    }
    return propertyHasRightClass;
}

+ (BOOL) isBoolPropertyWithName:(NSString *)propertyName
                       inObject:(IRView *)irView
{
    BOOL isBoolProperty = NO;
    NSArray *propertyPathComponentsArray = [propertyName componentsSeparatedByString:@"."];
    NSObject *parentObject = irView;
    NSString *lastProperty = [propertyPathComponentsArray lastObject];
    NSString *anProperty;
    for (uint i = 0; i < [propertyPathComponentsArray count]-1; ++i) {
        anProperty = propertyPathComponentsArray[i];
        parentObject = [parentObject performSelector:NSSelectorFromString(anProperty)];
    }
    objc_property_t objc_property = class_getProperty([parentObject class], [lastProperty UTF8String]);
    const char *type;
    if (objc_property) {
        type = property_getAttributes(objc_property);
        NSString *typeString = [NSString stringWithUTF8String:type];
        NSArray *attributes = [typeString componentsSeparatedByString:@","];
        NSString *typeAttribute = [attributes firstObject];
        if ([typeAttribute isEqualToString:@"TB"] || [typeAttribute isEqualToString:@"Tc"]) {
            isBoolProperty = YES;
        }
    }
    return isBoolProperty;
}

+ (void) downloadAndSetImageWithPathInBackground:(NSString *)imagePath
                                            view:(IRView *)irView
                                    propertyName:(NSString *)propertyName
{
    // -- clear previous image (necessary for reused imageView in table/collection)
    [irView setValue:nil forKey:propertyName];

    NSDictionary *data;
    // -- cancel last image loading for view (this is done to speed up loading of image in quickly scrolling table/collection)
    data = [IRBaseBuilder imageLoadingDataForView:irView];
    if (data) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self
                                                 selector:@selector(downloadAndSetImage:)
                                                   object:data];
    }
    // -- preparing for image loading
    if (imagePath.length > 0 && irView && propertyName.length > 0) {
        data = @{
          @"imagePath" : imagePath,
          @"irView" : irView,
          @"propertyName" : propertyName
        };
        [IRBaseBuilder setImageLoadingData:data forView:irView];
        [[IRBaseBuilder class] performSelector:@selector(downloadAndSetImage:) withObject:data afterDelay:/*0.05*/0.1];
    }
}

+ (NSDictionary *) imageLoadingDataForView:(IRView *)irView
{
    NSDictionary *data = nil;
    IRViewController *viewController = [IRBaseBuilder parentViewController:irView];
    NSString *mapKey = [IRUtil createKeyFromObjectAddress:irView];
    data = viewController.imageLoadingDataDictionary[mapKey];
    return data;
}

+ (void) setImageLoadingData:(NSDictionary *)data
                     forView:(IRView *)irView
{
    IRViewController *viewController = [IRBaseBuilder parentViewController:irView];
    NSString *mapKey = [IRUtil createKeyFromObjectAddress:irView];
    viewController.imageLoadingDataDictionary[mapKey] = data;
}

+ (void) downloadAndSetImage:(NSDictionary *)imageLoadingData
{
    NSString *imagePath = imageLoadingData[@"imagePath"];
    IRView *irView = imageLoadingData[@"irView"];
    __weak IRView *weakView = irView;
    NSString *propertyName = imageLoadingData[@"propertyName"];
//    NSLog(@"downloadAndSetImage: --imagePath=%@, --irView=%p, --propertyName=%@", imagePath, irView, propertyName);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *aURL;
        NSData *data;
        UIImage *downloadedImage;

        if (imagePath && [imagePath length] > 0) {
            aURL = [NSURL URLWithString:imagePath];
            data = [NSData dataWithContentsOfURL:aURL];

            [[IRSimpleCache sharedInstance] setData:data forURI:imagePath];

            downloadedImage = [UIImage imageWithData:data];

            dispatch_async(dispatch_get_main_queue(), ^{
                [weakView setValue:downloadedImage forKey:propertyName];
            });
        }
    });
}

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

/*

    var ActionExecution = function () {
        this.first = null;
        this.second = null;
        this.third = null;
        ...
        this.last = null;
        this.actionFunction = function (first, second, third, ... last) {
            this.switchAppsList(first, second, third);
        };
    };

    var actionExecution = new ActionExecution();
    actionExecution.first = ...;
    actionExecution.second = ...;
    actionExecution.third = ...;
    ...
    actionExecution.last = ...;

  */

+ (void) executeAction:(NSString *)action
        withDictionary:(NSDictionary *)dictionary
            sourceView:(UIView *)sourceView
{
    IRViewController *irViewController = nil;
    NSString *vcKey;
    if ([action length] > 0) {
        if ([sourceView isKindOfClass:[IRBarButtonItem class]]
            || [sourceView isKindOfClass:[IRActionSheet class]]
            || [sourceView isKindOfClass:[IRAlertView class]])
        {
            vcKey = ((id <IRComponentInfoProtocol>) sourceView).componentInfo;
            irViewController = [[IRDataController sharedInstance] controllerWithKey:vcKey];
        } else {
            irViewController = [IRBaseBuilder parentViewController:sourceView];
        }

        if ([irViewController isKindOfClass:[UINavigationController class]]) {
            irViewController = ((UINavigationController *) irViewController).visibleViewController;
        }

        [IRBaseBuilder executeAction:action
                      withDictionary:dictionary
                      viewController:irViewController];
    }
}
+ (void) executeAction:(NSString *)action
        withDictionary:(NSDictionary *)dictionary
        viewController:(IRViewController *)irViewController
{
    NSString *internalVariables = @"";
    NSString *internalVariablesCall = @"";
    NSString *jsInternalMethodParams = nil;
    NSString *actionEnclosing;
    JSContext *jsContext;
    if ([action length] > 0 && irViewController) {
        for (NSString *anKey in dictionary) {
            // -- jsInternalMethodParams
            if (jsInternalMethodParams == nil) {
                jsInternalMethodParams = [NSString stringWithFormat:@"%@", anKey];
            } else {
                jsInternalMethodParams = [jsInternalMethodParams stringByAppendingFormat:@", %@", anKey];
            }
            // -- internalVariables
            internalVariables = [internalVariables stringByAppendingFormat:@"    this.%@ = null; \n", anKey];
            // -- internalVariablesCall
            internalVariablesCall = [internalVariablesCall stringByAppendingFormat:@", this.%@", anKey];
        }

        actionEnclosing = [NSString stringWithFormat:@
                                                       "var ActionEnclosing_%@ = function () { \n"
                                                       "%@ \n"
                                                       "    this.actionFunction = function () { \n"
#if ENABLE_SAFARI_DEBUGGING == 1
                                                       "        setZeroTimeout(  \n"
                                                       "        (this.actionFunctionTimeout).bind(%@%@) "
#else
                                                       "        (this.actionFunctionTimeout).call(%@%@); \n"
#endif
#if ENABLE_SAFARI_DEBUGGING == 1
                                                       "        ); \n"
#endif
                                                       "    }; \n"
                                                       "    this.actionFunctionTimeout = function (%@) {         \n"
                                                       "        %@; \n"
                                                       "        delete ActionEnclosing_%@; \n"
                                                       "        delete actionEnclosing_%@; \n"
                                                       "    }; \n"
                                                       "}; \n"
                                                       "var actionEnclosing_%@ = new ActionEnclosing_%@();",
                                                     [IRUtil createKeyFromObjectAddress:action],
                                                     internalVariables, irViewController.key, internalVariablesCall,
                                                     jsInternalMethodParams, action,
                                                     [IRUtil createKeyFromObjectAddress:action], [IRUtil createKeyFromObjectAddress:action],
                                                     [IRUtil createKeyFromObjectAddress:action], [IRUtil createKeyFromObjectAddress:action]];
        jsContext = [[IRDataController sharedInstance] globalJSContext];
        [jsContext evaluateScript:actionEnclosing];

        @try {
            for (NSString *anKey in dictionary) {
                jsContext[[@"actionEnclosing" stringByAppendingFormat:@"_%@", [IRUtil createKeyFromObjectAddress:action]]][anKey] = dictionary[anKey];
            }
//            NSLog(@"executeAction:withDictionary:viewController:=%@ [pre]---->", action);
            [jsContext evaluateScript:[NSString stringWithFormat:@"actionEnclosing_%@.actionFunction();", [IRUtil createKeyFromObjectAddress:action]]];
//            NSLog(@"executeAction:withDictionary:viewController:=%@ [post]---->", action);
        }
        @catch (NSException *exception) {
            NSLog(@"Exception occurred: %@, %@", exception, [exception userInfo]);
        }
    }
}
// --------------------------------------------------------------------------------------------------------------------
+ (IRViewController *) parentViewController:(UIView *)view
{
    UIResponder *responder = view;
    while ([responder isKindOfClass:[UIView class]]) {
        responder = [responder nextResponder];
    }
    return responder;
}

@end