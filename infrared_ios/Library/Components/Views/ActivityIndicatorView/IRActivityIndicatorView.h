//
// Created by Uros Milivojevic on 12/8/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import "IRView.h"
#import "UIActivityIndicatorViewExport.h"


@protocol IRActivityIndicatorViewExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRActivityIndicatorView : UIActivityIndicatorView <IRComponentInfoProtocol, UIActivityIndicatorViewExport, IRActivityIndicatorViewExport, UIViewExport, IRViewExport>


@end