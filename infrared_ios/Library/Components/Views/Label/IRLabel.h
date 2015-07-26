//
//  IRLabel.h
//  infrared_ios
//
//  Created by Uros Milivojevic on 8/25/14.
//  Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "IRView.h"
#import "UILabelExport.h"

@protocol IRLabelExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRLabel : UILabel <IRComponentInfoProtocol, UILabelExport, IRLabelExport, UIViewExport, IRViewExport>

@end
