//
// Created by Uros Milivojevic on 12/11/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRComponentInfoProtocol.h"
#import "IRControlExportProtocol.h"
#import "IRView.h"
#import "UIControlIRExtension.h"
#import "UIPageControlExport.h"

@protocol IRPageControlExport <JSExport>

//@property(nonatomic) NSInteger numberOfPages;          // default is 0
//@property(nonatomic) NSInteger currentPage;            // default is 0. value pinned to 0..numberOfPages-1
//
//@property(nonatomic) BOOL hidesForSinglePage;          // hide the the indicator if there is only one page. default is NO
//
//@property(nonatomic) BOOL defersCurrentPageDisplay;    // if set, clicking to a new page won't update the currently displayed page until -updateCurrentPageDisplay is called. default is NO
//- (void)updateCurrentPageDisplay;                      // update page display to match the currentPage. ignored if defersCurrentPageDisplay is NO. setting the page value directly will update immediately
//
//- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount;   // returns minimum size required to display dots for given page count. can be used to size control if page count could change
//
//@property(nonatomic,retain) UIColor *pageIndicatorTintColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
//@property(nonatomic,retain) UIColor *currentPageIndicatorTintColor NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;

@end

// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------
// --------------------------------------------------------------------------------------------------------------------

@interface IRPageControl : UIPageControl  <IRComponentInfoProtocol, UIPageControlExport, IRPageControlExport, IRControlExportProtocol, UIControlIRExtensionExport, UIViewExport, IRViewExport>

@end