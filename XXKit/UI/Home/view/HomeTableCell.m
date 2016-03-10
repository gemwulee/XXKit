//
//  XXHomeTableCell.m
//  XXKit
//
//  Created by tomxiang on 16/2/27.
//  Copyright © 2016年 tomxiang. All rights reserved.
//

#import "HomeTableCell.h"
#import "XXMessageModel.h"
#import "XXGlobalColor.h"
#import "UITableViewCell+Custom.h"

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
    
    _deleteButton = [UIButton new];
    _deleteButton.backgroundColor = [UIColor redColor];
    [_deleteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [self insertSubview:_deleteButton belowSubview:self.contentView];

    _tagButton = [UIButton new];
    _tagButton.backgroundColor =[UIColor lightGrayColor];
    [_tagButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_tagButton setTitle:@"标记未读" forState:UIControlStateNormal];
    [self insertSubview:_tagButton belowSubview:self.contentView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    int tableViewWidth = self.contentView.frame.size.width;

    int tx = ADDCOMMENDFRIEND_CELL_HEAD_HOR_MARGIN + ADDCOMMENDFRIEND_LISTSTYLE_HEAD_SIZE + ADDCOMMENDFRIEND_CELL_HEAD_HOR_MARGIN;
    int ty = ADDCOMMENDFRIEND_CELL_VERTICAL_MARGIN2;//
    int tw = tableViewWidth - tx - ADDCOMMENDFRIEND_CELL_RIGHT_MARGIN;

    _iconImageView.frame = CGRectMake(ADDCOMMENDFRIEND_CELL_HEAD_HOR_MARGIN, ADDCOMMENDFRIEND_CELL_HEAD_VERTICAL_MARGIN, ADDCOMMENDFRIEND_LISTSTYLE_HEAD_SIZE, ADDCOMMENDFRIEND_LISTSTYLE_HEAD_SIZE);
    
    _nameLabel.frame = CGRectMake(tx, ty, tw, _nameLabel.font.lineHeight);
    
    _messageLabel.frame = CGRectMake(tx, ty + _nameLabel.font.lineHeight + 5, tw, _messageLabel.font.lineHeight);
}


- (void)configureForData:(XXMessageModel*) xxMsgModel row:(NSInteger) msgRow
{
    [self setCustomAccessoryViewEnabled:NO];
    
    _iconImageView.image = [UIImage imageNamed:xxMsgModel.imageName];
    _nameLabel.text = xxMsgModel.name;
    _messageLabel.text = xxMsgModel.message;
    
    self.homeRow = msgRow;
    
    [self setNeedsLayout];
}


@end
