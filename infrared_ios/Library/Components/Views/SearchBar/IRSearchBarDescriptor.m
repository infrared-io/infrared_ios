//
// Created by Uros Milivojevic on 12/12/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <objc/runtime.h>
#import "IRSearchBarDescriptor.h"
#import "IRUtil.h"
#if TARGET_OS_IPHONE
#import "IRSearchBarBuilder.h"
#import "IRSearchBar.h"
#endif


@implementation IRSearchBarDescriptor

+ (NSString *) componentName
{
    return typeSearchBarKEY;
}
#if TARGET_OS_IPHONE
+ (Class) componentClass
{
    return [IRSearchBar class];
}

+ (Class) builderClass
{
    return [IRSearchBarBuilder class];
}

+ (void) addJSExportProtocol
{
    class_addProtocol([UISearchBar class], @protocol(UISearchBarExport));
}
#endif

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;
        NSString *string;
        NSArray *array;
        NSDictionary *dictionary;

#if TARGET_OS_IPHONE
        // barStyle
        string = aDictionary[NSStringFromSelector(@selector(barStyle))];
        self.barStyle = [IRBaseDescriptor barStyleFromString:string];
#endif

        // text
        string = aDictionary[NSStringFromSelector(@selector(text))];
        self.text = string;

        // prompt
        string = aDictionary[NSStringFromSelector(@selector(prompt))];
        self.prompt = string;

        // placeholder
        string = aDictionary[NSStringFromSelector(@selector(placeholder))];
        self.placeholder = string;

        // showsBookmarkButton
        number = aDictionary[NSStringFromSelector(@selector(showsBookmarkButton))];
        if (number) {
            self.showsBookmarkButton = [number boolValue];
        } else {
            self.showsBookmarkButton = NO;
        }

        // showsCancelButton
        number = aDictionary[NSStringFromSelector(@selector(showsCancelButton))];
        if (number) {
            self.showsCancelButton = [number boolValue];
        } else {
            self.showsCancelButton = NO;
        }

        // showsSearchResultsButton
        number = aDictionary[NSStringFromSelector(@selector(showsSearchResultsButton))];
        if (number) {
            self.showsSearchResultsButton = [number boolValue];
        } else {
            self.showsSearchResultsButton = NO;
        }

        // searchResultsButtonSelected
        number = aDictionary[NSStringFromSelector(@selector(searchResultsButtonSelected))];
        if (number) {
            self.searchResultsButtonSelected = [number boolValue];
        } else {
            self.searchResultsButtonSelected = NO;
        }

#if TARGET_OS_IPHONE
        // barTintColor
        string = aDictionary[NSStringFromSelector(@selector(barTintColor))];
        self.barTintColor = [IRUtil transformHexColorToUIColor:string];

        // searchBarStyle
        string = aDictionary[NSStringFromSelector(@selector(searchBarStyle))];
        self.searchBarStyle = [IRBaseDescriptor searchBarStyleFromString:string];
#endif

        // translucent
        number = aDictionary[NSStringFromSelector(@selector(translucent))];
        if (number) {
            self.translucent = [number boolValue];
        } else {
            self.translucent = YES;
        }

        // scopeButtonTitles
        array = aDictionary[NSStringFromSelector(@selector(scopeButtonTitles))];
        self.scopeButtonTitles = array;

        // selectedScopeButtonIndex
        number = aDictionary[NSStringFromSelector(@selector(selectedScopeButtonIndex))];
        if (number) {
            self.selectedScopeButtonIndex = [number integerValue];
        } else {
            self.selectedScopeButtonIndex = 0;
        }

        // showsScopeBar
        number = aDictionary[NSStringFromSelector(@selector(showsScopeBar))];
        if (number) {
            self.showsScopeBar = [number boolValue];
        } else {
            self.showsScopeBar = NO;
        }

        // inputAccessoryView
        dictionary = aDictionary[NSStringFromSelector(@selector(inputAccessoryView))];
        self.inputAccessoryView = (IRViewDescriptor *) [IRBaseDescriptor newViewDescriptorWithDictionary:dictionary];

        // backgroundImage
        string = aDictionary[NSStringFromSelector(@selector(backgroundImage))];
        self.backgroundImage = string;

        // scopeBarBackgroundImage
        string = aDictionary[NSStringFromSelector(@selector(scopeBarBackgroundImage))];
        self.scopeBarBackgroundImage = string;

    }
    return self;
}

- (void) extendImagePathsArray:(NSMutableArray *)imagePaths
                 appDescriptor:(IRAppDescriptor *)appDescriptor
{
    if (self.backgroundImage && [IRUtil isFileForDownload:self.backgroundImage appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.backgroundImage];
    }
    if (self.scopeBarBackgroundImage && [IRUtil isFileForDownload:self.scopeBarBackgroundImage appDescriptor:appDescriptor]) {
        [imagePaths addObject:self.scopeBarBackgroundImage];
    }
}

@end