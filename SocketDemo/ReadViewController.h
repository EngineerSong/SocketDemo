//
//  ReadViewController.h
//  SocketDemo
//
//  Created by barara on 16/6/17.
//  Copyright © 2016年 Jay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReadViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *readArray;

@end
