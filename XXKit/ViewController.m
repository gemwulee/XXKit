//
//  ViewController.m
//  XXKit
//
//  Created by tomxiang on 16/1/6.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "ViewController.h"
#import "XXBase.h"
#import "FPSViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorHex(233344);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onPushFPSVC:(UIButton *)sender {
    
    FPSViewController *fpsVC = [[FPSViewController alloc] init];
    [self.navigationController pushViewController:fpsVC animated:YES];
    
}
@end
