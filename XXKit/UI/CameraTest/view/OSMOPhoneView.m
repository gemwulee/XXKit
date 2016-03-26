//
//  OSMOPhoneView.m
//  XXKit
//
//  Created by tomxiang on 3/23/16.
//  Copyright © 2016 tomxiang. All rights reserved.
//

#import "OSMOPhoneView.h"
#import <UIKit/UIKit.h>
#import "XXBase.h"
@interface OSMOPhoneView()<UIPickerViewDataSource,UIPickerViewAccessibilityDelegate>
@property(nonatomic,strong) UIPickerView *pickerView;

@end

@implementation OSMOPhoneView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)selectFilter:(UIButton *)sender {
    if(_pickerView == nil){
         self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.height - 200, self.width, 150)];
        // 显示选中框
        _pickerView.backgroundColor = [UIColor yellowColor];
        _pickerView.showsSelectionIndicator=YES;
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [self addSubview:_pickerView];
    }else{
        [_pickerView removeFromSuperview];
        self.pickerView = nil;
    }
}

// pickerView 列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_filterArray count];
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.width;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.selectBlock) {
        self.selectBlock(row);
    }
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_filterArray objectAtIndex:row];
}


@end
