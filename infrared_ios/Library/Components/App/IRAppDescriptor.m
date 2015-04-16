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

        // label
        string = aDictionary[appLabelKEY];
        self.label = string;

        // version
        number = aDictionary[appVersionKEY];
        if ([number integerValue] >= 0) {
            self.version = [number integerValue];
        } else {
            self.version = 0;
        }

        // screensArray
        array = aDictionary[screensKEY];
        self.screensArray = [IRBaseDescriptor newScreenDescriptorsArrayFromDictionariesArray:array
                                                                                       label:self.label
                                                                                     version:self.version];

        // fontsArray
        array = aDictionary[fontsKEY];
        self.fontsArray = array;

        // mainScreenId
        string = aDictionary[NSStringFromSelector(@selector(mainScreenId))];
        self.mainScreenId = string;

        // baseUrl
        string = aDictionary[NSStringFromSelector(@selector(baseUrl))];
        if ([string length] > 0) {
            self.baseUrl = string;
        }

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

- (id) initDescriptorForLabelAndVariantWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSString *string;
        NSNumber *number;

        // label
        string = aDictionary[NSStringFromSelector(@selector(label))];
        self.label = string;

        // version
        number = aDictionary[NSStringFromSelector(@selector(version))];
        self.version = [number integerValue];
    }
    return self;
}

- (id) initDescriptorForFontsWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSString *string;
        NSNumber *number;
        NSArray *array;

        // label
        string = aDictionary[NSStringFromSelector(@selector(label))];
        self.label = string;

        // version
        number = aDictionary[NSStringFromSelector(@selector(version))];
        self.version = [number integerValue];

        // baseUrl
        string = aDictionary[NSStringFromSelector(@selector(baseUrl))];
        if ([string length] > 0) {
            self.baseUrl = string;
        }

        // fontsArray
        array = aDictionary[fontsKEY];
        self.fontsArray = array;
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


@end