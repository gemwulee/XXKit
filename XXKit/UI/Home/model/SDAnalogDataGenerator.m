//
//  SDAnalogDataGenerator.m
//  GSD_WeiXin(wechat)
//
//  Created by aier on 16/2/10.
//  Copyright © 2016年 GSD. All rights reserved.
//

#import "SDAnalogDataGenerator.h"

static NSArray *namesArray;
static NSArray *iconNamesArray;
static NSArray *messagesArray;

@implementation SDAnalogDataGenerator

+ (NSString *)randomName
{
    int randomIndex = arc4random_uniform((int)[self names].count);
    return [self names][randomIndex];
}

+ (NSString *)randomIconImageName
{
    int randomIndex = arc4random_uniform((int)[self iconNames].count);
    return iconNamesArray[randomIndex];
}

+ (NSString *)randomMessage
{
    int randomIndex = arc4random_uniform((int)[self messages].count);
    return messagesArray[randomIndex];
}

+ (NSString *)indexName:(NSInteger) index
{
    return [self names][index];
}

+ (NSString *)indexImageName:(NSInteger) index
{
    return [self iconNames][index];
}

+ (NSString *)indexMessage:(NSInteger) index
{
    return [self messages][index];
}


+ (NSArray *)names
{
    if (!namesArray) {
        namesArray = @[@"超级帅",
                       @"傻BB",
                       @"灿灿",
                       @"BB",
                       @"向小贱",
                       @"向神棍",
                       @"1年",
                       @"2年",
                       @"3年",
                       @"4年",
                       @"5年",
                       @"3月27",
                       @"终于要来深圳了",
                       @"异地",
                       @"艰难",
                       @"熬",
                       @"柳暗花明",
                       @"我很开心",
                       @"原来我不帅",
                       @"亲亲",
                       @"吴彦祖",
                       @"刘德华",
                       @"张卫健",
                       @"梁朝伟"
                       ];
    }
    return namesArray;
}

+ (NSArray *)iconNames
{
    if (!iconNamesArray) {
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < 24; i++) {
            NSString *iconName = [NSString stringWithFormat:@"%d.png", i];
            [temp addObject:iconName];
        }
        iconNamesArray = [temp copy];
    }
    return iconNamesArray;
}

+ (NSArray *)messages
{
    if (!messagesArray) {
        messagesArray = @[@"傻瓜，该起床了🐷🐷🐷",
                          @"给我一团熊火 试炼我",
                          @"证明我这么狠狠爱过🐂",
                          @"期望不多 只要得到过",
                          @"你身旁 那宝座🐂🐂🐂",
                          @"给我一场洪水 冷静我",
                          @"眼泪太多已汇聚成河",
                          @"力竭声嘶请你喜欢我",
                          @"什么事都做过",
                          @"都不能感动你么",
                          @"原来暂时共你没缘份",
                          @"来年先会变得更合衬",
                          @"顽石哪天变黄金 我可以等",
                          @"融和二人是哪样成份",
                          @"但愿虔诚能显得吸引",
                          @"用五十年熔化你",
                          @"成就 金禧一吻",
                          @"不够激情仍可靠耐性",
                          @"对付你的冷酷及无情",
                          @"沉默假使都算种本领",
                          @"我一定 最安静",
                          @"深信忠诚迟会获胜",
                          @"那份固执终于都会被尊敬",
                          @"如炼金般等你先转性"
                          ];
    }
    return messagesArray;
}

@end
