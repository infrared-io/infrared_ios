//
// Created by Uros Milivojevic on 10/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class IRView;
@class IRBaseDescriptor;
@class IRButton;
@class IRViewAndControlDescriptor;
@protocol IRComponentInfoProtocol;
@class IRScreenDescriptor;
@class IRLayoutConstraintWithVFDescriptor;
@class IRViewDescriptor;
@class IRViewController;


@interface IRBaseBuilder : NSObject

+ (NSMutableArray *) buildComponentsArrayFromDescriptorsArray:(NSArray *)descriptorsArray
                                               viewController:(IRViewController *)viewController
                                                        extra:(id)extra;

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra;

+ (void) setUpComponent:(IRView *)irComponent
    componentDescriptor:(IRViewDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra;

+ (void) setUpComponentWithoutRegistration:(id <IRComponentInfoProtocol>)irComponent
                            fromDescriptor:(IRBaseDescriptor *)descriptor;

+ (void) setComponentId:(NSString *)componentId
      toJSInitComponent:(id<IRComponentInfoProtocol>)irView;

+ (void) setUpUIControlInterfaceForComponent:(UIControl *)uiControl
                              fromDescriptor:(IRViewAndControlDescriptor *)descriptor;

+ (NSString *) textWithI18NCheck:(NSString *)originalText;

+ (void) bindData:(NSDictionary *)dictionary
                 toView:(IRView *)irView
withDataBindingItemName:(NSString *)name;
+ (BOOL) isPropertyWithName:(NSString *)propertyName
                   inObject:(IRView *)irView
                    ofClass:(Class)propertyClass;
+ (BOOL) isBoolPropertyWithName:(NSString *)propertyName
                       inObject:(IRView *)irView;
+ (void) downloadAndSetImageWithPathInBackground:(NSString *)imagePath
                                            view:(IRView *)irView
                                    propertyName:(NSString *)propertyName;

+ (void) executeAction:(NSString *)action
        withDictionary:(NSDictionary *)dictionary
            sourceView:(UIView *)sourceView;

+ (void) executeAction:(NSString *)action
        withDictionary:(NSDictionary *)dictionary
        viewController:(IRViewController *)irViewController;

+ (IRViewController *)parentViewController:(UIView *)view;

@end