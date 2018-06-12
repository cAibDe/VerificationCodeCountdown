//
//  TImerObject.h
//  asd
//
//  Created by 张鹏 on 2017/5/19.
//  Copyright © 2017年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


//倒计时
@interface TImerObject : NSObject

/**
 *  开启倒计时timer（会记录timer开始时间）
 *
 *  @param timerKey key
 *  @param tipLabel 展示倒计时的Label
 *
 *  @return timer实例
 */
+ (dispatch_source_t)startTimerWithKey:(NSString *)timerKey tipLabel:(UILabel *)tipLabel;

/**
 *  timer自动倒计时（如果没有开始时间，直接return）
 *
 *  @param timerKey key
 *  @param tipLabel 展示倒计时的Label
 *  @param forceStart 是否强制启动timer（如果是NO，则时间超过后不会启动新timer）
 *
 *  @return timer实例
 */
+ (dispatch_source_t)timerCountDownWithKey:(NSString *)timerKey tipLabel:(UILabel *)tipLabel forceStart:(BOOL)forceStart;

/**
 *  取消timer
 *
 *  @param timerKey key
 */
+ (void)cancelTimerByKey:(NSString *)timerKey;

/**
 *  重新设置时间
 *
 *  @param timeKey key
 */
+ (void)resetTimerByKey:(NSString *)timeKey;
@end
