//
// Created by Uros Milivojevic on 10/5/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import "IRAppDescriptor.h"
#import "IRScreenDescriptor.h"
#import "IRI18NDescriptor.h"


@implementation IRAppDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSString *string;
        NSNumber *number;
        NSArray *array;
        NSDictionary *dictionary;

        // version
        number = aDictionary[appVersionKEY];
        if ([number integerValue] >= 0) {
            self.version = [number integerValue];
        } else {
            self.version = 0;
        }

        // silentUpdate
        number = aDictionary[silentUpdateKEY];
        if (number) {
            self.silentUpdate = [number boolValue];
        } else {
            self.silentUpdate = NO;
        }

        // baseUrl
        string = aDictionary[NSStringFromSelector(@selector(baseUrl))];
        if ([string length] > 0) {
            self.baseUrl = string;
        }

        // screensArray
        array = aDictionary[screensKEY];
        self.screensArray = [IRBaseDescriptor newScreenDescriptorsArrayFromDictionariesArray:array
                                                                                         app:self.app
                                                                                     version:self.version
                                                                                     baseUrl:self.baseUrl];

        // fontsArray
        array = aDictionary[fontsKEY];
        self.fontsArray = array;

        // mainScreenId
        string = aDictionary[NSStringFromSelector(@selector(mainScreenId))];
        self.mainScreenId = string;

        // jsLibrariesArray
        array = aDictionary[jsLibrariesKEY];
        if (array) {
            self.jsLibrariesArray = array;
        }

        // i18n
        dictionary = aDictionary[NSStringFromSelector(@selector(i18n))];
        self.i18n = [[IRI18NDescriptor alloc] initDescriptorWithDictionary:dictionary];
    }
    return self;
}

- (id) initDescriptorForVersionWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSNumber *number;

        // version
        number = aDictionary[appVersionKEY];
        if ([number integerValue] >= 0) {
            self.version = [number integerValue];
        } else {
            self.version = 0;
        }

        // silentUpdate
        number = aDictionary[silentUpdateKEY];
        if (number) {
            self.silentUpdate = [number boolValue];
        } else {
            self.silentUpdate = NO;
        }
    }
    return self;
}

- (id) initDescriptorForFontsAndScreensWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSString *string;
        NSNumber *number;
        NSArray *array;

        // version
        number = aDictionary[appVersionKEY];
        if ([number integerValue] >= 0) {
            self.version = [number integerValue];
        } else {
            self.version = 0;
        }

        // silentUpdate
        number = aDictionary[silentUpdateKEY];
        if (number) {
            self.silentUpdate = [number boolValue];
        } else {
            self.silentUpdate = NO;
        }

        // baseUrl
        string = aDictionary[NSStringFromSelector(@selector(baseUrl))];
        if ([string length] > 0) {
            self.baseUrl = string;
        }

        // fontsArray
        array = aDictionary[fontsKEY];
        self.fontsArray = array;

        // screensArray
        array = aDictionary[screensKEY];
        self.screensArray = array;
    }
    return self;
}

- (IRScreenDescriptor *) mainScreenDescriptor
{
    IRScreenDescriptor *mainScreenDescriptor = nil;
    for (IRScreenDescriptor *anDescriptor in self.screensArray) {
        if ([anDescriptor.componentId isEqualToString:self.mainScreenId]) {
            mainScreenDescriptor = anDescriptor;
            break;
        }
    }
    return mainScreenDescriptor;
}

- (NSString *) app {
    return self.componentId;
}

@end