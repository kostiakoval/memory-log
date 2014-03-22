//
//  NSObject+MemoryLog.m
//  RetainCycle
//
//  Created by Konstantin Koval on 22/03/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

#import "NSObject+MemoryLog.h"
#import <JRSwizzle.h>

@implementation NSObject (MemoryLog)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSError *error;
        [NSObject jr_swizzleMethod:NSSelectorFromString(@"dealloc") withMethod:@selector(kkk_dealloc) error:&error];
        [NSObject jr_swizzleClassMethod:NSSelectorFromString(@"alloc") withClassMethod:@selector(kkk_alloc) error:&error];
    });
}

+ (id)kkk_alloc
{
    NSLog(@"Alloc %@", [self class]);
    return [self kkk_alloc];
}

- (void)kkk_dealloc
{
    NSLog(@"Dealloc %@", [self class]);
    [self kkk_dealloc];
}

@end
