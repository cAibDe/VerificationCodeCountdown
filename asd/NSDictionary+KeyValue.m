//
//  NSDictionary+KeyValue.m
//  50+sh
//
//  Created by 宋海梁 on 15/12/3.
//  Copyright © 2015年 jicaas. All rights reserved.
//

#import "NSDictionary+KeyValue.h"

@implementation NSDictionary (KeyValue)

- (BOOL)boolForKey:(NSString *)key {
    if([self objectForKey:key] == [NSNull null])
        return NO;
    return [[self objectForKey:key] boolValue];
}

- (NSInteger)integerForKey:(NSString *)key {
    if ([self objectForKey:key] == [NSNull null]) {
        return NSIntegerMax;
    }
    return  [[self valueForKey:key] integerValue];
}

- (int)intForKey:(NSString *)key {
    if ([self objectForKey:key] == [NSNull null]) {
        return 0;
    }
    
    return [[self valueForKey:key] intValue];
}

- (double)doubleForKey:(NSString *)key {
    if ([self objectForKey:key] == [NSNull null]) {
        return 0.0;
    }
    return [[self valueForKey:key] doubleValue];
}

- (float)floatForKey:(NSString *)key {
    if ([self objectForKey:key] == [NSNull null]) {
        return 0.0;
    }
    
    return [[self valueForKey:key] floatValue];
}

- (long long)longLongForKey:(NSString *)key {
    if ([self objectForKey:key] == [NSNull null]) {
        return 0.0;
    }
    return [[self valueForKey:key] longLongValue];
}

- (unsigned long long)unsignedLongLongForKey:(NSString *)key {
    if ([self objectForKey:key] == [NSNull null]) {
        return 0.0;
    }
    
    return [[self valueForKey:key] unsignedLongLongValue];
}

- (NSString *)stringForKey:(NSString *)key {
    if ([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil) {
        return @"";
    }
    return [[self valueForKey:key] description];
}

- (NSArray *)arrayForKey:(NSString *)key {

    if ([self objectForKey:key] == [NSNull null] || [self objectForKey:key] == nil || ![[self objectForKey:key] isKindOfClass:[NSArray class]]) {
        return nil;
    }
    
    return [NSArray arrayWithObject:[self objectForKey:key]];
}

/**
 *  value为空时，不set此key
 *
 *  @param value value（可nil）
 *  @param key   key
 */
-(void)safeValue:(id)value forKey:(NSString *)key {
    if(value) {
        [self setValue:value forKey:key];
    }
}

@end
