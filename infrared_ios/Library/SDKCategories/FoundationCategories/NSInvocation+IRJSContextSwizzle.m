//
// Created by Uros Milivojevic on 7/31/15.
// Copyright (c) 2015 infrared.io. All rights reserved.
//

#import "NSInvocation+IRJSContextSwizzle.h"
#import "JRSwizzle.h"


@implementation NSInvocation (IRJSContextSwizzle)

//+ (void)load
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSError *error;
//        BOOL result = [[self class] jr_swizzleMethod:@selector(invoke)
//                                          withMethod:@selector(IRJSContext_invoke)
//                                               error:&error];
//        if (!result || error) {
//            NSLog(@"Can't swizzle methods - %@", [error description]);
//        }
//    });
//}

- (void)IRJSContext_invoke
{
    NSString *sourceString = [[NSThread callStackSymbols] objectAtIndex:1];
    // Example: 1   UIKit                               0x00540c89 -[UIApplication _callInitializationDelegatesForURL:payload:suspended:] + 1163
    NSCharacterSet *separatorSet = [NSCharacterSet characterSetWithCharactersInString:@" -[]+?.,"];
    NSMutableArray *array = [NSMutableArray arrayWithArray:[sourceString  componentsSeparatedByCharactersInSet:separatorSet]];
    [array removeObject:@""];

    NSString *framework = [array objectAtIndex:1];

    if ([framework isEqualToString:@"JavaScriptCore"]) {
//        __weak NSInvocation *weakSelf = self;
        if ([NSThread isMainThread]) {
            [self IRJSContext_invoke];
        } else {
            NSString *stack = [array objectAtIndex:0];
            NSString *memoryAddress = [array objectAtIndex:2];
            NSString *classCaller = [array objectAtIndex:3];
            NSString *functionCaller = [array objectAtIndex:4];
            NSLog(@"Stack = %@", stack);
            NSLog(@"Framework = %@", framework);
            NSLog(@"Memory address = %@", memoryAddress);
            NSLog(@"Class caller = %@", classCaller);
            NSLog(@"Function caller = %@\n", functionCaller);
            NSLog(@"*** Selector caller = %@\n", NSStringFromSelector(self.selector));
//            NSLog(@"JavaScriptCore executed on Main Thread");
//            [self performSelectorOnMainThread:@selector(IRJSContext_invoke) withObject:nil waitUntilDone:NO];
            [self retainArguments];
//            @autoreleasepool {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"JavaScriptCore executing on Main Thread");
                    [/*weakSelf*/self IRJSContext_invoke];
                });
//            }
        }

    } else {
        [self IRJSContext_invoke]; // this will call invoke implementation, because we have exchanged them.
    }
}

@end