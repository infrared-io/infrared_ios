//
// Created by Uros Milivojevic on 12/12/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRSearchBarBuilder.h"
#import "IRSearchBar.h"
#import "IRSearchBarDescriptor.h"
#import "IRScreenDescriptor.h"
#import "IRViewBuilder.h"
#import "IRSimpleCache.h"
#import "IRView.h"
#import "IRBaseDescriptor.h"
#import "IRViewDescriptor.h"
#import "IRViewController.h"


@implementation IRSearchBarBuilder

+ (IRView *) buildComponentFromDescriptor:(IRBaseDescriptor *)descriptor
                           viewController:(IRViewController *)viewController
                                    extra:(id)extra
{
    IRSearchBar *irSearchBar;

    irSearchBar = [[IRSearchBar alloc] init];
    [IRSearchBarBuilder setUpComponent:irSearchBar componentDescriptor:descriptor viewController:viewController
                                 extra:extra];

    return irSearchBar;
}

+ (void) setUpComponent:(IRSearchBar *)irSearchBar
    componentDescriptor:(IRSearchBarDescriptor *)descriptor
         viewController:(IRViewController *)viewController
                  extra:(id)extra
{
    [IRViewBuilder setUpComponent:irSearchBar componentDescriptor:descriptor viewController:viewController extra:extra];

    irSearchBar.barStyle = descriptor.barStyle;
    irSearchBar.text = [IRBaseBuilder textWithI18NCheck:descriptor.text];
    irSearchBar.prompt = [IRBaseBuilder textWithI18NCheck:descriptor.prompt];
    irSearchBar.placeholder = [IRBaseBuilder textWithI18NCheck:descriptor.placeholder];
    irSearchBar.showsBookmarkButton = descriptor.showsBookmarkButton;
    irSearchBar.showsCancelButton = descriptor.showsCancelButton;
    irSearchBar.showsSearchResultsButton = descriptor.showsSearchResultsButton;
    irSearchBar.searchResultsButtonSelected = descriptor.searchResultsButtonSelected;
    irSearchBar.barTintColor = descriptor.barTintColor;
    irSearchBar.searchBarStyle = descriptor.searchBarStyle;
    irSearchBar.translucent = descriptor.translucent;
    irSearchBar.scopeButtonTitles = descriptor.scopeButtonTitles;
    irSearchBar.selectedScopeButtonIndex = descriptor.selectedScopeButtonIndex;
    irSearchBar.showsScopeBar = descriptor.showsScopeBar;
    irSearchBar.inputAccessoryView = [IRBaseBuilder buildComponentFromDescriptor:descriptor.inputAccessoryView
                                                                  viewController:viewController extra:extra];
    irSearchBar.backgroundImage = [[IRSimpleCache sharedInstance] imageForURI:descriptor.backgroundImage];
    irSearchBar.scopeBarBackgroundImage = [[IRSimpleCache sharedInstance] imageForURI:descriptor.scopeBarBackgroundImage];
}

@end