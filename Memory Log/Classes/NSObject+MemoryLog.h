//
//  NSObject+MemoryLog.h
//  RetainCycle
//
//  Created by Konstantin Koval on 22/03/14.
//  Copyright (c) 2014 Konstantin Koval. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MemoryLog)

/**
 * Enable or disable memory log. By default log is disabled.
 */

+ (void)enableLog;
+ (void)disableLog;

/**
 * Show log only for specified clacses
 * @param classes NSArray of string classes names.
 * Example [NSObject logOnly: @[@"UIView", @"UIViewController"]];
 */

+ (void)logOnly:(NSArray *)classes;

/**
 * Add Memory log for specific class.
 * @param classes An array of classes name. For those classes will be enabled memory log.
 */

+ (void)addLogFor:(NSArray *)classes;
+ (void)addLogForClass:(NSString *)aClass;

/**
 * Remove memory log for cpecific classes
 * @param classes An array of classes name for which memory log should be disabled.
 */

+ (void)removeLogFor:(NSArray *)classes;
+ (void)removeLogForClass:(NSString *)aClass;

+ (void)removeLogForAll;

@end
