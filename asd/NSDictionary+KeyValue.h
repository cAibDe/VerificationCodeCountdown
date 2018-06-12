//
//  NSDictionary+KeyValue.h
//  50+sh
//
//  Created by 宋海梁 on 15/12/3.
//  Copyright © 2015年 jicaas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (KeyValue)

- (BOOL)boolForKey:(NSString *)key;

- (NSInteger)integerForKey:(NSString *)key;

- (int)intForKey:(NSString *)key;

- (double)doubleForKey:(NSString *)key;

- (float)floatForKey:(NSString *)key;

- (long long)longLongForKey:(NSString *)key;

- (unsigned long long)unsignedLongLongForKey:(NSString *)key;

- (NSString *)stringForKey:(NSString *)key;

- (NSArray *)arrayForKey:(NSString *)key;

/**
 *  value为空时，不set此key
 *
 *  @param value value（可nil）
 *  @param key   key
 */
- (void)safeValue:(id)value forKey:(NSString *)key;

@end
