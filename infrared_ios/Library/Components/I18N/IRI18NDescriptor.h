//
// Created by Uros Milivojevic on 2/24/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseDescriptor.h"


@interface IRI18NDescriptor : IRBaseDescriptor

@property (nonatomic, strong) NSString *defaultLanguage;
@property (nonatomic, strong) NSDictionary *languagesArray;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

@end