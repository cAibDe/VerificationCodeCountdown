//
//  PushViewController.m
//  asd
//
//  Created by 张鹏 on 2017/5/19.
//  Copyright © 2017年 张鹏. All rights reserved.
//

#import "PushViewController.h"
#import "TImerObject.h"

@interface PushViewController ()
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation PushViewController
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"getPushVC" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"setPushVC" object:nil];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [TImerObject timerCountDownWithKey:@"pushVC" tipLabel:self.timeLabel forceStart:NO];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [TImerObject cancelTimerByKey:@"pushVC"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCode) name:@"getPushVC" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setCode) name:@"setPushVC" object:nil];

    self.title = @"PUSHVC";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    self.timeLabel.text = @"发送验证码";
    self.timeLabel.backgroundColor = [UIColor redColor];
    self.timeLabel.userInteractionEnabled = YES;
    [self.view addSubview:self.timeLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.timeLabel addGestureRecognizer:tap];
    
}
-(void)tapAction{
    [TImerObject startTimerWithKey:@"pushVC" tipLabel:self.timeLabel];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getCode{
    [TImerObject cancelTimerByKey:@"pushVC"];
}
-(void)setCode{
    [TImerObject timerCountDownWithKey:@"pushVC" tipLabel:self.timeLabel forceStart:NO];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
