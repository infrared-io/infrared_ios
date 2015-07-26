//
// Created by Uros Milivojevic on 12/12/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import "IRView.h"
#import "UISearchBarExport.h"


@protocol IRSearchBarExport <JSExport>

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRSearchBar : UISearchBar <IRComponentInfoProtocol, UISearchBarExport, IRSearchBarExport, UIViewExport, IRViewExport>

@end