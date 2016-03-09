//
//  MineViewModel.m
//  XXKit
//
//  Created by tomxiang on 16/3/5.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "MineViewModel.h"

@interface MineViewModel()
@property(nonatomic,strong) NSMutableArray *listContentData;
@end


@implementation MineViewModel

-(instancetype)init{
    if (self = [super init]) {
        [self initData];
    }
    return self;
}

-(void)initData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SettingViewController" ofType:@"plist"];
    self.listContentData = [[NSMutableArray alloc] initWithArray:[NSArray arrayWithContentsOfFile:path]];
}


-(NSUInteger) getModelGroupCount{
    return _listContentData.count;
}

-(NSDictionary*) getObjectAtIndex:(NSUInteger) section{
    return [_listContentData objectAtIndex:section];
}
@end
