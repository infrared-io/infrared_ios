//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRView.h"
#import "UIToolbarExport.h"


@protocol IRToolbarExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRToolbar : UIToolbar <IRComponentInfoProtocol, IRAutoLayoutSubComponentsProtocol, UIToolbarExport, IRToolbarExport, UIViewExport, IRViewExport>
@end