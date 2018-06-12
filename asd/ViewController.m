//
//  ViewController.m
//  asd
//
//  Created by 张鹏 on 2017/5/19.
//  Copyright © 2017年 张鹏. All rights reserved.
//

#import "ViewController.h"
#import "PushViewController.h"
@interface ViewController (){
    
}


@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"主页";
    UIButton *pushButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
    pushButton.backgroundColor = [UIColor grayColor];
    [pushButton setTitle:@"PUSH" forState:UIControlStateNormal];
    [pushButton addTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pushButton];
}
- (void)pushAction{
    PushViewController *pushVC = [[PushViewController alloc]init];
    [self.navigationController pushViewController:pushVC animated:YES];

}
@end
