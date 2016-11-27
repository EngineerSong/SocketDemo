//
//  ChartViewController.h
//  SocketDemo
//
//  Created by barara on 16/6/24.
//  Copyright © 2016年 Jay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PNChart.h"
#import "PNChartDelegate.h"
#import "UICountingLabel.h"

@interface ChartViewController : UIViewController <PNChartDelegate>

@property (nonatomic, strong) NSMutableArray *numberArray;

@property (nonatomic) PNLineChart * lineChart;

@end
