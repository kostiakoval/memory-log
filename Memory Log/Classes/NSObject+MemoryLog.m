//
//  NSObject+MemoryLog.m
//  RetainCycle
//
//  Created by Konstantin Koval on 22/03/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

#import "NSObject+MemoryLog.h"
#import <JRSwizzle.h>
#import "KKNSObject+Associated.h"


static NSMutableArray  *k_classesToLog = nil;
static BOOL             k_enabled = NO;

@implementation NSObject (MemoryLog)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        k_classesToLog = [NSMutableArray new];
        NSError *error;
        [NSObject jr_swizzleMethod:NSSelectorFromString(@"dealloc") withMethod:@selector(kkk_dealloc) error:&error];
//        [NSObject jr_swizzleClassMethod:NSSelectorFromString(@"alloc") withClassMethod:@selector(kkk_alloc) error:&error];
        [NSObject jr_swizzleMethod:NSSelectorFromString(@"init") withMethod:@selector(kkk_init) error:&error];
    });
}

- (id)kkk_init
{
    if ([self.class canLog]) {
        NSLog(@"Init %@", [self class]);
    }
    return [self kkk_init];
}

+ (id)kkk_alloc
{
    if ([self.class canLog]) {
        NSLog(@"Alloc %@", [self class]);
    }
    return [self kkk_alloc];
}

- (void)kkk_dealloc
{
    if ([self.class canLog]) {
        NSLog(@"Dealloc %@", [self class]);
    }
    [self kkk_dealloc];
}

#pragma mark - Private

+ (BOOL)canLog
{
    BOOL canLog = k_enabled && [k_classesToLog containsObject:NSStringFromClass(self.class)];
    return canLog;
}

#pragma mark - Public

+ (void)enableLog
{
    k_enabled = YES;
}

+ (void)disableLog
{
    k_enabled = NO;
}

#pragma mark - Add Classes to Log
+ (void)logOnly:(NSArray *)classes
{
    k_classesToLog = [NSMutableArray arrayWithArray:classes];
}

+ (void)addLogFor:(NSArray *)classes
{
    [k_classesToLog addObject:classes];
}

+ (void)addLogForClass:(NSString *)aClass
{
    [k_classesToLog addObject:aClass];
}

#pragma mark - remove log for classes
+ (void)removeLogFor:(NSArray *)classes
{
    [k_classesToLog removeObjectsInArray:classes];
}

+ (void)removeLogForClass:(NSString *)aClass
{
    [k_classesToLog removeObject:aClass];
}

+ (void)removeLogForAll
{
    [k_classesToLog removeAllObjects];
}


@end
