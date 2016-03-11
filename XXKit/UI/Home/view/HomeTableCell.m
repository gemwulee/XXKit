//
//  XXHomeTableCell.m
//  XXKit
//
//  Created by tomxiang on 16/2/27.
//  Copyright © 2016年 tomxiang. All rights reserved.
//  AutoLayout学习:http://liuyanwei.jumppo.com/2015/06/14/ios-library-masonry.html
//                http://adad184.com/2014/09/28/use-masonry-to-quick-solve-autolayout/

#import "HomeTableCell.h"
#import "XXMessageModel.h"
#import "XXGlobalColor.h"
#import "UITableViewCell+Custom.h"
#import "XXBase.h"
#import "Masonry.h"

static const CGFloat ADDCOMMENDFRIEND_CELL_HEAD_HOR_MARGIN      = 15;//headImage的x
static const CGFloat ADDCOMMENDFRIEND_CELL_HEAD_VERTICAL_MARGIN = 6;//headImage的y
static const CGFloat ADDCOMMENDFRIEND_LISTSTYLE_HEAD_SIZE       = 50;//headImage的宽高

static const CGFloat ADDCOMMENDFRIEND_CELL_VERTICAL_MARGIN2     = 10;//nickname的y
static const CGFloat ADDCOMMENDFRIEND_CELL_RIGHT_MARGIN         = 15;//button和右边的距离

@interface HomeTableCell()
@property(nonatomic,strong) UIImageView *iconImageView;
@property(nonatomic,strong) UILabel     *nameLabel;
@property(nonatomic,strong) UILabel     *messageLabel;
@property(nonatomic,strong) UIButton    *deleteButton;
@property(nonatomic,strong) UIButton    *tagButton;
@property(nonatomic,assign) NSInteger   homeRow;
@end

@implementation HomeTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
     _iconImageView.image = [UIImage imageNamed:@"user_avatar_default.png"];
    [self.contentView addSubview:_iconImageView];

    UIFont *fontTitle = [UIFont systemFontOfSize:16.f];
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLabel.backgroundColor = [UIColor clearColor];
    _nameLabel.highlightedTextColor = QQGLOBAL_COLOR(kTableViewCellTextLabelTextColorHighlighted);
    _nameLabel.textColor = QQGLOBAL_COLOR(kTableViewCellTextLabelTextColorNormal);
    _nameLabel.font = fontTitle;
    [self.contentView addSubview:_nameLabel];
    
    UIFont *fontDetail = [UIFont systemFontOfSize:14.f];
    _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _messageLabel.backgroundColor = [UIColor clearColor];
    _messageLabel.highlightedTextColor = QQGLOBAL_COLOR(kTableViewCellDetailTextLabelTextColorHighlighted);
    _messageLabel.textColor = QQGLOBAL_COLOR(kTableViewCellDetailTextLabelTextColorNormal);
    _messageLabel.font = fontDetail;
    [self.contentView addSubview:_messageLabel];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(ADDCOMMENDFRIEND_CELL_HEAD_HOR_MARGIN);
        make.top.equalTo(self.contentView).with.offset(ADDCOMMENDFRIEND_CELL_HEAD_VERTICAL_MARGIN);
        make.height.and.width.mas_equalTo(ADDCOMMENDFRIEND_LISTSTYLE_HEAD_SIZE);
    }];
    
    int tx = ADDCOMMENDFRIEND_CELL_HEAD_HOR_MARGIN + ADDCOMMENDFRIEND_LISTSTYLE_HEAD_SIZE + ADDCOMMENDFRIEND_CELL_HEAD_HOR_MARGIN;
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(tx);
        make.right.equalTo(self.contentView).with.offset(-ADDCOMMENDFRIEND_CELL_RIGHT_MARGIN);
        make.top.equalTo(self.contentView).with.offset(ADDCOMMENDFRIEND_CELL_VERTICAL_MARGIN2);
    }];
    
    [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_left);
        make.right.mas_equalTo(_nameLabel.mas_right);
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(5.f);
    }];
}



- (void)configureForData:(XXMessageModel*) xxMsgModel row:(NSInteger) msgRow
{
    [self setCustomAccessoryViewEnabled:NO];
    
    UIImage* image = [UIImage imageNamed:xxMsgModel.imageName];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        
        UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
        [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, image.size.width, image.size.height) byRoundingCorners:UIRectCornerAllCorners cornerRadii: CGSizeMake(12.f, 12.f)] addClip];
        [image drawAtPoint:CGPointZero];
        UIImage *tempImg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            _iconImageView.image = tempImg;
        });
    });
    
    _nameLabel.text = xxMsgModel.name;
    _messageLabel.text = xxMsgModel.message;
    
    self.homeRow = msgRow;
    
    [self setNeedsLayout];
}


@end
