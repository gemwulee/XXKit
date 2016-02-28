//
//  FPSViewController.m
//  XXKit
//
//  Created by tomxiang on 16/2/27.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "FPSViewController.h"
#import "FPSTableCell.h"
#import "uikit/XXFPSMonitorEngine.h"

@interface FPSViewController()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *xxTableView;
@end

@implementation FPSViewController

-(instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"FPSTest";
    [self initData];
}

-(void) initData
{
    [[XXFPSMonitorEngine sharedInstance] startMonistor];
}

-(void)loadView
{
    [super loadView];
    
    _xxTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [_xxTableView registerClass:[FPSTableCell class] forCellReuseIdentifier:XXCELLIDENDIFIFY];
    _xxTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _xxTableView.delegate = self;
    _xxTableView.dataSource = self;
    
    [self.view addSubview:_xxTableView];
}

#pragma mark- Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return XXTableCellHeight;
}


#pragma mark- DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FPSTableCell *cell = [tableView dequeueReusableCellWithIdentifier:XXCELLIDENDIFIFY forIndexPath:indexPath];
    [cell configureForData:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row %2 == 0){
        [[XXFPSMonitorEngine sharedInstance] startMonistor];
    }else{
        [[XXFPSMonitorEngine sharedInstance] endMonistor];
    }
}
@end
