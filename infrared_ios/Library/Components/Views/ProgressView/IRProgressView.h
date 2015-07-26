//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import "IRView.h"
#import "UIProgressViewExport.h"


@protocol IRProgressViewExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRProgressView : UIProgressView <IRComponentInfoProtocol, UIProgressViewExport, IRProgressViewExport, UIViewExport, IRViewExport>


@end