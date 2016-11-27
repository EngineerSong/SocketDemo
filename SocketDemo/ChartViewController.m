//
//  ChartViewController.m
//  SocketDemo
//
//  Created by barara on 16/6/24.
//  Copyright © 2016年 Jay. All rights reserved.
//

#import "ChartViewController.h"

@interface ChartViewController ()

{
    UITapGestureRecognizer *_tap;
}

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 折线图设置
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 135.0, SCREEN_WIDTH, 200.0)];
    lineChart.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:143/255.0 alpha:0.5];
    //lineChart.showSmoothLines = YES;
    [lineChart setXLabels:@[@"5 分钟",@"10分钟",@"15分钟",@"20分钟",@"25分钟",@"30分钟"]];
    
    // 折现数据配置1
    //NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [_numberArray[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    
    // 整合数据 // 绘制折现
    lineChart.chartData = @[data01];
    [lineChart strokeChart];
    [self.view addSubview:lineChart];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake((self.view.frame.size.width-120)/2, 400, 120, 40);
    sendBtn.backgroundColor = [UIColor blueColor];
    sendBtn.layer.masksToBounds = YES;
    sendBtn.layer.cornerRadius = 10;
    [sendBtn setTitle:@"开始煮饭" forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];

    _tap = [[UITapGestureRecognizer alloc] init];
    [_tap addTarget:self action:@selector(tapp)];
    [self.view addGestureRecognizer:_tap];
}

- (void)sendBtnClick
{
    
}

- (void)tapp
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
