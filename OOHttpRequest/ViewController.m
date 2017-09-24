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
#import "OOHttpModelAnalysis.h"
#import "OOHttpAnalysis.h"
#import "OOChainedHttpRequest.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,retain) UITableView * tableView;
@property (strong, nonatomic) NSMutableArray * dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"园区公告";
    
    _dataArray = [NSMutableArray new];
    
    [self.view addSubview:self.tableView];
    
    NSMutableDictionary * params = [NSMutableDictionary new];
    params[@"u_id"] = @"8";
    params[@"a_id"] = @"259";
    params[@"lat"] = @"44";
    params[@"long"] = @"166";

    
http://www.pidans.xyz/temperature//api.php/Index/index?u_id=8&lat=0&long=0&a_id=166

    
    [OORequest requestConfig:^(OOHttpRequestConfig *config) {
        
        config.url = @"/temperature//api.php/Index/index";
        config.baseUrl = @"http://www.pidans.xyz";
        config.param = params;
        config.dataArray = _dataArray;
        config.cache = YES;
        config.hud = YES;
//        config.loadingMsg = @"123";
        config.succMsg = @"加载成功";
        config.urlExplain = @"地址说明";

    }]
    .startRequest()
    .progress(^(float progres){
        NSLog(@"----------------------  %f",progres);
    })
    .cacheData(^(id responseObject){
        
//        NSLog(@"缓存--- \n%@",responseObject);
        
    })
    .success(^(id responseObject,NSString * msg){
        
//        NSLog(@"网络--- \n%@",responseObject);
        
    })
    .failure(^(NSString * error,NSInteger code){
        
        
    });
    
    // Do any additional setup after loading the view from its nib.
}




- (void)OOHttpAnalysis{
    
    NSMutableDictionary * params = [NSMutableDictionary new];
    params[@"cid"] = @"2";
    
    
    [[OOHttpAnalysis sharedInstance] requestConfig:^(OOHttpRequestConfig *config) {
        
        config.url = @"/api/news/getList/cid";
        config.param = params;
        config.cache = YES;
        config.urlExplain = @"地址说明";
        
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
