//
//  ViewController.m
//  SocketDemo
//
//  Created by barara on 16/6/15.
//  Copyright © 2016年 Jay. All rights reserved.
//

#import "ViewController.h"

#define Length 64

@interface ViewController ()

{
    UITextView *_textView;
    NSMutableString *_mutableString;
    NSMutableArray *_saveArray;
    
    UITextField *_timeTF;
    UITextField *_wenduTF;
    
    NSInputStream *_inputStream;//对应输入流
    NSOutputStream *_outputStream;//对应输出流
    
    UITapGestureRecognizer *_tap;
    
    int _isback;
}

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    if (_isback == 2) {
        
        _textView.text = @"数据发送中...\n";
        [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 1)];
        
        [NSThread sleepForTimeInterval:1];
        
        _textView.text = @"数据发送成功!\n";
        [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 1)];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _nameArray = [NSMutableArray arrayWithObjects:@"稀饭",@"超快煮",@"标准煮",@"精华煮",@"煲仔饭",@"蛋糕", nil];
    
    NSArray *arr0 = [NSArray arrayWithObjects:@60,@80,@100,@100,@100,@50, nil];
    NSArray *arr1 = [NSArray arrayWithObjects:@60,@100,@60,@100,@80,@50, nil];
    NSArray *arr2 = [NSArray arrayWithObjects:@60,@80,@100,@60,@100,@50, nil];
    NSArray *arr3 = [NSArray arrayWithObjects:@60,@100,@50,@100,@100,@50, nil];
    NSArray *arr4 = [NSArray arrayWithObjects:@80,@100,@100,@80,@100,@80, nil];
    NSArray *arr5 = [NSArray arrayWithObjects:@60,@80,@100,@60,@100,@50, nil];
    
    _dataArray = [NSMutableArray arrayWithObjects:arr0,arr1,arr2,arr3,arr4,arr5, nil];
    
    UILabel *wifiLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width-300)/2, 64-Length, 300, 80)];
    wifiLabel.numberOfLines = 2;
    wifiLabel.text = @"Wifi名称:MXCHIP_CA565B\n密码:无";
    wifiLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:wifiLabel];
    
    UIButton *copyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    copyBtn.frame = CGRectMake((self.view.frame.size.width/2-100)/2, 114-Length, 100, 40);
    [copyBtn setTitle:@"连接Wifi" forState:UIControlStateNormal];
    [copyBtn addTarget:self action:@selector(copyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:copyBtn];
    
    UIButton *socketBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    socketBtn.frame = CGRectMake((self.view.frame.size.width/2-100)/2+self.view.frame.size.width/2, 114-Length, 100, 40);
    [socketBtn setTitle:@"连接设备" forState:UIControlStateNormal];
    [socketBtn addTarget:self action:@selector(socketBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:socketBtn];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3-80, 114+40-Length, 80, 40)];
    timeLabel.numberOfLines = 2;
    timeLabel.text = @"输入时间:";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:timeLabel];
    
    _timeTF = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3, 114+40-Length, self.view.frame.size.width/3*2-40, 40)];
    _timeTF.layer.masksToBounds = YES;
    _timeTF.layer.cornerRadius = 10;
    _timeTF.layer.borderColor = [[UIColor grayColor]CGColor];
    _timeTF.layer.borderWidth = 1;
    _timeTF.keyboardType= UIKeyboardTypeNumberPad;
    [self.view addSubview:_timeTF];
    
    UILabel *wenduLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3-80, 114+40+50-Length, 80, 40)];
    wenduLabel.numberOfLines = 2;
    wenduLabel.text = @"输入温度:";
    wenduLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:wenduLabel];
    
    _wenduTF = [[UITextField alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3, 114+40+50-Length, self.view.frame.size.width/3*2-40, 40)];
    _wenduTF.layer.masksToBounds = YES;
    _wenduTF.layer.cornerRadius = 10;
    _wenduTF.layer.borderColor = [[UIColor grayColor]CGColor];
    _wenduTF.layer.borderWidth = 1;
    _wenduTF.keyboardType= UIKeyboardTypeNumberPad;
    [self.view addSubview:_wenduTF];
    
    UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sendBtn.frame = CGRectMake((self.view.frame.size.width/2-80)/2, 114+40+50+40+10-Length, 80, 40);
    sendBtn.backgroundColor = [UIColor blueColor];
    sendBtn.layer.masksToBounds = YES;
    sendBtn.layer.cornerRadius = 10;
    [sendBtn setTitle:@"send" forState:UIControlStateNormal];
    [sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sendBtn];
    
    UIButton *readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    readBtn.frame = CGRectMake((self.view.frame.size.width/2-80)/2+self.view.frame.size.width/2, 114+40+50+40+10-Length, 80, 40);
    readBtn.backgroundColor = [UIColor blueColor];
    readBtn.layer.masksToBounds = YES;
    readBtn.layer.cornerRadius = 10;
    [readBtn setTitle:@"查看记录" forState:UIControlStateNormal];
    [readBtn addTarget:self action:@selector(readBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:readBtn];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104+60+150-Length, self.view.frame.size.width, self.view.frame.size.height-(104+60+150-Length)-60)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 60;
    [self.view addSubview:_tableView];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 60)];
    _textView.font = [UIFont fontWithName:@"Arial" size:18.0];
    _textView.backgroundColor = [UIColor blackColor];
    _textView.textColor = [UIColor whiteColor];
    _textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _textView.scrollEnabled = YES;
    //_textView.selectable = YES;//选择复制功能
    //_textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    _textView.delegate = self;
    _textView.editable = NO;//禁止编辑
    [self.view addSubview:_textView];
    
//    _tap = [[UITapGestureRecognizer alloc] init];
//    [_tap addTarget:self action:@selector(tapp)];
//    [self.view addGestureRecognizer:_tap];
    
    _mutableString = [[NSMutableString alloc] init];
    _saveArray = [[NSMutableArray alloc] init];
}

- (void)readBtnClick
{
    NSMutableArray *defaultsArr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"sendData"]];
    
    ReadViewController *readVC = [[ReadViewController alloc] init];
    readVC.readArray = defaultsArr;
    [self presentViewController:readVC animated:YES completion:nil];
}

- (void)sendBtnClick
{
    if ([_timeTF.text isEqualToString:@""] || [_wenduTF.text isEqualToString:@""]) {
        return;
    }
    
    NSString *sendString = [NSString stringWithFormat:@"time:%@ temperature:%@",_timeTF.text,_wenduTF.text];
     NSData *data = [sendString dataUsingEncoding:NSUTF8StringEncoding];
     [_outputStream write:data.bytes maxLength:data.length];
    
    [_mutableString appendString:[NSString stringWithFormat:@"%@\n",sendString]];
    _textView.text = _mutableString;
    [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 1)];
    
    [_saveArray addObject:sendString];
    [[NSUserDefaults standardUserDefaults] setObject:_saveArray forKey:@"sendData"];
    
    _timeTF.text = @"";
    _wenduTF.text = @"";
}

- (void)socketBtnClick
{
    // 1.建立连接
    NSString *host = @"192.168.1.1";
    int port = 8080;
    
    // 定义C语言输入输出流
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)host, port, &readStream, &writeStream);
    
    // 把C语言的输入输出流转化成OC对象
    _inputStream = (__bridge NSInputStream *)(readStream);
    _outputStream = (__bridge NSOutputStream *)(writeStream);
    
    // 设置代理
    _inputStream.delegate = self;
    _outputStream.delegate = self;
    
    // 把输入输入流添加到主运行循环
    // 不添加主运行循环 代理有可能不工作
    [_inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [_outputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    // 打开输入输出流
    [_inputStream open];
    [_outputStream open];
    
    [_mutableString appendString:@"连接设备成功...\n"];
    _textView.text = _mutableString;
    [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 1)];
}

-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    NSLog(@"%@",[NSThread currentThread]);
    
    //    NSStreamEventOpenCompleted = 1UL << 0,//输入输出流打开完成
    //    NSStreamEventHasBytesAvailable = 1UL << 1,//有字节可读
    //    NSStreamEventHasSpaceAvailable = 1UL << 2,//可以发放字节
    //    NSStreamEventErrorOccurred = 1UL << 3,// 连接出现错误
    //    NSStreamEventEndEncountered = 1UL << 4// 连接结束
    switch (eventCode) {
        case NSStreamEventOpenCompleted:
            NSLog(@"输入输出流打开完成");
            break;
        case NSStreamEventHasBytesAvailable:
            NSLog(@"有字节可读");
            [self readData];
            break;
        case NSStreamEventHasSpaceAvailable:
            NSLog(@"可以发送字节");
            break;
        case NSStreamEventErrorOccurred:
            NSLog(@"连接出现错误");
            break;
        case NSStreamEventEndEncountered:
            NSLog(@"连接结束");
            
            // 关闭输入输出流
            [_inputStream close];
            [_outputStream close];
            
            // 从主运行循环移除
            [_inputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            [_outputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            break;
        default:
            break;
    }
    
}

#pragma mark 读了服务器返回的数据
-(void)readData{
    
    //建立一个缓冲区 可以放1024个字节
    uint8_t buf[1024];
    
    // 返回实际装的字节数
    NSInteger len = [_inputStream read:buf maxLength:sizeof(buf)];
    
    // 把字节数组转化成字符串
    NSData *data = [NSData dataWithBytes:buf length:len];
    
    // 从服务器接收到的数据
    NSString *recStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSLog(@"从服务器收到的数据为%@",recStr);
    
    [_mutableString appendString:[NSString stringWithFormat:@"收到的数据为:%@\n",recStr]];
    _textView.text = _mutableString;
    [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 1)];
}

- (void)copyBtnClick
{
    //剪切板内容
    //UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    //pasteboard.string = @"";
    
    NSURL *url = [NSURL URLWithString:@"prefs:root=WIFI"];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)tapp
{
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //作为cell的标识符
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        //如果复用队列里找不到cell，就创建新的
    }
    
    //indexPath里面放的是cell的位置信息，indexPath.row代表第几行
    cell.textLabel.text = [_nameArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    _isback = 2;
    
    ChartViewController *chartVC = [[ChartViewController alloc] init];
    chartVC.numberArray = _dataArray[indexPath.row];
    [self presentViewController:chartVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
