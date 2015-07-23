//
// Created by Uros Milivojevic on 10/5/14.
// Copyright (c) 2014 infrared.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRBaseDescriptor.h"

@class IRScreenDescriptor;
@class IRI18NDescriptor;


@interface IRAppDescriptor : IRBaseDescriptor

@property (nonatomic, readonly) NSString *app;
@property (nonatomic) NSInteger version;
@property (nonatomic) BOOL silentUpdate;
@property (nonatomic, strong) NSString *baseUrl;
@property (nonatomic, strong) NSArray *screensArray;
@property (nonatomic, strong) NSArray *fontsArray;
@property (nonatomic, strong) NSString *mainScreenId;
@property (nonatomic, strong) NSArray *jsLibrariesArray;
@property (nonatomic, strong) IRI18NDescriptor *i18n;

// --------------------------------------------------------------------------------------------------------------------

- (id) initDescriptorWithDictionary:(NSDictionary *)aDictionary;

- (id) initDescriptorForVersionWithDictionary:(NSDictionary *)aDictionary;
- (id) initDescriptorForFontsWithDictionary:(NSDictionary *)aDictionary;

- (IRScreenDescriptor *) mainScreenDescriptor;

@end