//
//  ContactViewModel.m
//  XXKit
//
//  Created by tomxiang on 16/3/15.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "ContactViewModel.h"
#import "SDAnalogDataGenerator.h"
#import "NSStringEx.h"

#define NAME @"name"
#define IMAGENAME @"imageName"
#define ITEMCONTENT @"itemContent"

@implementation ContactViewModel

-(void) initOtherDataSource
{
//    [_listContentData addObject:[self getSection1:100]];
}

//-(NSMutableArray*) getSection1:(NSInteger) count
//{
//    //中部排序
//    NSMutableArray *dataArray = [NSMutableArray new];
//    NSArray *xings = @[@"赵",@"钱",@"孙",@"李",@"周",@"吴",@"郑",@"王",@"冯",@"陈",@"楚",@"卫",@"蒋",@"沈",@"韩",@"杨"];
//    NSArray *ming1 = @[@"大",@"美",@"帅",@"应",@"超",@"海",@"江",@"湖",@"春",@"夏",@"秋",@"冬",@"上",@"左",@"有",@"纯"];
//    NSArray *ming2 = @[@"强",@"好",@"领",@"亮",@"超",@"华",@"奎",@"海",@"工",@"青",@"红",@"潮",@"兵",@"垂",@"刚",@"山"];
//
//    for (int i = 0; i < count; i++) {
//        NSString *name = xings[arc4random_uniform((int)xings.count)];
//        NSString *ming = ming1[arc4random_uniform((int)ming1.count)];
//        name = [name stringByAppendingString:ming];
//        if (arc4random_uniform(10) > 3) {
//            NSString *ming = ming2[arc4random_uniform((int)ming2.count)];
//            name = [name stringByAppendingString:ming];
//        }
//
//        ContactModel *model = [ContactModel new];
//        model.name = name;
//        model.imageName = [SDAnalogDataGenerator randomIconImageName];
//        [dataArray addObject:model];
//    }
//
//    [dataArray sortUsingFunction:sortCardInfoByPinying context:nil];
//    
//    return dataArray;
//}
//
//-(NSString*) getFirstLetter:(NSString*) contactName
//{
//    NSString *strTag = nil;
//
//    NSString *pinyin = [contactName pinyinString];
//    if(pinyin.length > 0){
//        strTag = [[pinyin substringToIndex:1] uppercaseString];
//    }else{
//        strTag = @"#";
//    }
//    return strTag;
//}
//
@end
//
////根据字母排序
//NSComparisonResult sortCardInfoByPinying(id obj1, id obj2, void *context)
//{
//    NSString *nick1 = nil;
//    NSString *nick2 = nil;
//    
//    ContactModel *info1 = (ContactModel*)obj1;
//    ContactModel *info2 = (ContactModel*)obj2;
//    
//    nick1 = info1.name;
//    nick2 = info2.name;
//    
//    
//    NSString * py  = [nick1 sortedCharacter];
//    NSString * py2 = [nick2 sortedCharacter];
//    
//    
//    NSComparisonResult res = [py caseInsensitiveCompare:py2];
//    if (res == NSOrderedSame) {
//        return [info1.name caseInsensitiveCompare:info2.name];
//    } else {
//        return res;
//    }
//}
