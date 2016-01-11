//
//  ViewController.m
//  XXKit
//
//  Created by tomxiang on 16/1/6.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "ViewController.h"
#import "XXBase.h"
#import "OCAndJSViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onJumpToOCAndJSController:(UIButton *)sender{
    
    OCAndJSViewController *ocjsVC = [[OCAndJSViewController alloc] init];
    [self.navigationController pushViewController:ocjsVC animated:YES];
    
}

@end
