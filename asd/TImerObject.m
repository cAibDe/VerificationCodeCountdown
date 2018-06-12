//
//  TImerObject.m
//  asd
//
//  Created by 张鹏 on 2017/5/19.
//  Copyright © 2017年 张鹏. All rights reserved.
//

#import "TImerObject.h"
#import "NSDictionary+KeyValue.h"
static NSMutableDictionary *countDownTimerIntervals;
static NSMutableDictionary *countDownTimers;

//设置倒计时的时间
const int kVerifyCodeCountDownSeconds = 60;

@implementation TImerObject

+ (double)timerIntervalForKey:(NSString *)timerKey{
    if (countDownTimerIntervals) {
        return [countDownTimerIntervals doubleForKey:timerKey];
    }
    return 0;
}
+ (dispatch_source_t)startTimerWithKey:(NSString *)timerKey
                              tipLabel:(UILabel *)tipLabel{
    //记录timer开始时间
    if (!countDownTimerIntervals) {
        countDownTimerIntervals = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    if (!countDownTimers) {
        countDownTimers = [NSMutableDictionary dictionaryWithCapacity:10];
    }
    //CFAbsoluteTimeGetCurrent() 相当于[[NSDate data] timeIntervalSinceReferenceDate]
    [countDownTimerIntervals setObject:@(CFAbsoluteTimeGetCurrent()) forKey:timerKey];
    
    //如果之前的timer存在，就取消
    [self cancelTimerByKey:timerKey];
    
    return [self timerCountDownWithKey:timerKey tipLabel:tipLabel forceStart:YES];
}

+ (dispatch_source_t)timerCountDownWithKey:(NSString *)timerKey
                                  tipLabel:(UILabel *)tipLabel
                                forceStart:(BOOL)forceStart{
    //__block修饰的变量可以再block中修改
    __block int timeout = 0;//倒计时时间
    
    double timerInterval = [self timerIntervalForKey:timerKey];
    
    if (timerInterval <=0 ) {
        return nil;
    }
    
    double interval = CFAbsoluteTimeGetCurrent() - timerInterval;
    if (interval < kVerifyCodeCountDownSeconds) {
        timeout = kVerifyCodeCountDownSeconds - (int)interval - 1;
    }
    if (timeout <= 0  && !forceStart) {
        return nil;
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);//每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout<=0) {//倒计时结束，关闭定时器
            dispatch_source_cancel(_timer);
            //到主线程去刷新界面
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面按钮的显示 可以根据自己的项目需求自行修改
                tipLabel.text = @"获取验证码";
                tipLabel.backgroundColor = [UIColor redColor];
                tipLabel.userInteractionEnabled = YES;
            });
        }else{
            //倒计时中
            int seconds = timeout%kVerifyCodeCountDownSeconds;
            NSLog(@"%d",seconds);
            NSString *strTime = [NSString stringWithFormat:@"%d秒后重发",seconds];
            //到主线程去刷新界面
            dispatch_async(dispatch_get_main_queue(), ^{
                //修改界面
                tipLabel.text = strTime;
                tipLabel.backgroundColor = [UIColor grayColor];
                tipLabel.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    //启动定时器
    dispatch_resume(_timer);
    
    [countDownTimers setObject:_timer forKey:timerKey];
    
    return _timer;
}
+ (void)cancelTimerByKey:(NSString *)timerKey{
    dispatch_source_t timer = [countDownTimers objectForKey:timerKey];
    if (timer) {
        dispatch_source_cancel(timer);
        [countDownTimers removeObjectForKey:timer];
    }
}
+ (void)resetTimerByKey:(NSString *)timeKey{
    if (countDownTimerIntervals) {
        [countDownTimerIntervals removeObjectForKey:timeKey];
    }
}
@end
