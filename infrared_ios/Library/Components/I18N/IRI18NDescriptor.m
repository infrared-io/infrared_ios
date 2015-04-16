//
// Created by Uros Milivojevic on 2/24/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "IRI18NDescriptor.h"


@implementation IRI18NDescriptor

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initDescriptorWithDictionary:aDictionary];
    if (self) {
        NSString *string;
        NSDictionary *dictionary;

        // defaultLanguage
        string = aDictionary[NSStringFromSelector(@selector(defaultLanguage))];
        self.defaultLanguage = string;

        // languagesArray
        dictionary = aDictionary[appLanguagesKEY];
        self.languagesArray = dictionary;
    }
    return self;
}

@end