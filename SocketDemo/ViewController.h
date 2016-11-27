//
//  ViewController.h
//  SocketDemo
//
//  Created by barara on 16/6/15.
//  Copyright © 2016年 Jay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReadViewController.h"
#import "ChartViewController.h"

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,NSStreamDelegate,UITextViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *nameArray;

@end

