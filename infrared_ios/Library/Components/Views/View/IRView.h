//
//  IRView.h
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "IRComponentInfoProtocol.h"
#import "IRAutoLayoutSubComponentsProtocol.h"
#import "UIViewExport.h"

@protocol IRViewExport <JSExport>

@property(nonatomic, strong) id componentInfo;

+ (id) createWithComponentId:(NSString *)componentId;

- (NSString *) componentId;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRView : UIView <IRComponentInfoProtocol, IRAutoLayoutSubComponentsProtocol, UIViewExport, IRViewExport>


@end
