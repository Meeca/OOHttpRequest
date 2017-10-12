//
//  ViewController.m
//  OOHttpRequest
//
//  Created by feng on 2017/9/19.
//  Copyright © 2017年 皮蛋. All rights reserved.
//

#import "ViewController.h"
#import "GardenNoticeViewCell.h"
#import "ConsultModel.h"
#import "OONetworking.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain) UITableView * tableView;
@property (strong, nonatomic) NSMutableArray * dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 🌐
    
    self.navigationItem.title = @"园区公告";
    
    _dataArray = [NSMutableArray new];
    
    [self.view addSubview:self.tableView];
    //
    
    [self OOHttpAnalysis];
    
    [self OOHttpAnalysis1];
    // Do any additional setup after loading the view from its nib.
}


- (void)OOHttpAnalysis{
    
    NSMutableDictionary * params = [NSMutableDictionary new];
    params[@"cid"] = @"2";
    
 
    
    [[[OOHttpAnalysis alloc] init] requestConfig:^(OOHttpRequestConfig *config) {
        
        config.url = @"/api/news/getList/cid";
        config.param = params;
        config.hud = YES;
        config.log = YES;
        config.urlExplain = @"资讯列表";
        config.cache = YES;
        
    } progress:^(float progres) {
        
        
    } cacheSuccess:^(id responseObject, NSString *msg) {
        
        //        NSLog(@"缓存cacheSuccess ---  \n %@",responseObject);
        
    } success:^(id responseObject, NSString *msg) {
        
        //        NSLog(@"网络success ---  \n %@",responseObject);
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}



- (void)OOHttpAnalysis1{
    
    NSMutableDictionary * params = [NSMutableDictionary new];
    params[@"proprietorid"] = @"28";
    
    [[[OOHttpAnalysis alloc] init] requestConfig:^(OOHttpRequestConfig *config) {

        config.url = @"/api/proprietor/read";
        config.param = params;
        config.urlExplain = @"订单列表";
     
    } progress:^(float progres) {

        
    } cacheSuccess:^(id responseObject, NSString *msg) {
        
        //        NSLog(@"缓存cacheSuccess ---  \n %@",responseObject);
        
    } success:^(id responseObject, NSString *msg) {
        
        //        NSLog(@"网络success ---  \n %@",responseObject);
        
    } failure:^(NSString *error, NSInteger code) {
        
    }];
    
}

























#pragma mark - UITableViewDelegate UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GardenNoticeViewCell * cell  = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GardenNoticeViewCell class])];
    //    if (_dataArray.count > indexPath.section) {
    //        ConsultModel * consultModel = _dataArray[indexPath.section];
    //        cell.consultModel  =consultModel;
    //    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewAutomaticDimension;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001f;
}


- (CGFloat )tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001f;
}




-(UITableView *)tableView
{
    if(_tableView == nil){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 100;
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[GardenNoticeViewCell class] forCellReuseIdentifier:NSStringFromClass([GardenNoticeViewCell class])];
        
    }
    return _tableView;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

