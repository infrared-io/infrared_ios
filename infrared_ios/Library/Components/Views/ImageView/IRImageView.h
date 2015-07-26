//
//  IRImageView.h
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "IRComponentInfoProtocol.h"
#import "IRView.h"
#import "UIImageViewExport.h"

@protocol IRImageViewExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRImageView : UIImageView <IRComponentInfoProtocol, UIImageViewExport, IRImageViewExport, UIViewExport, IRViewExport>

@end
