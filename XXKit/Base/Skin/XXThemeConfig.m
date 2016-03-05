//
//  XXThemeConfig.m
//  XXKit
//
//  Created by tomxiang on 16/3/5.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "XXThemeConfig.h"
#import "XXGlobalColor.h"

#define ColorTable @"ColorTable"

@interface XXThemeConfig()
@property(nonatomic,strong) XXGlobalColor *globalColor;
@end
@implementation XXThemeConfig

+(instancetype) sharedInstance
{
    static XXThemeConfig *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XXThemeConfig alloc] init];
    });
    return sharedInstance;
}

-(instancetype)init
{
    if(self = [super init]){
        self.globalColor = [XXGlobalColor new];
    }
    return self;
}

- (void) refreshTheme:(NSString*) fileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    NSDictionary *themeConfig = [NSDictionary dictionaryWithContentsOfFile:path];
    
    [self.globalColor setConfigValues:[themeConfig objectForKey:ColorTable]];
}

@end
