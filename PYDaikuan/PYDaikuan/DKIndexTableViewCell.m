//
//  DKIndexTableViewCell.m
//  PYDaikuan
//
//  Created by 洋 裴 on 17/3/28.
//  Copyright © 2017年 piang. All rights reserved.
//

#import "DKIndexTableViewCell.h"

@implementation DKIndexTableViewCell

- (instancetype)initWithData:(NSDictionary *)product {
    if (self = [super init]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:product[@"image"]]];
        iconImageView.frame = CGRectMake(25, (CGRectGetWidth([UIScreen mainScreen].bounds) / 4 - 70) / 2, 70, 70);
        [self.contentView addSubview:iconImageView];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(iconImageView.frame) + 25, CGRectGetMinY(iconImageView.frame) + 5, 100, 20)];
        nameLabel.font = [UIFont systemFontOfSize:17];
        nameLabel.text = product[@"title"];
        [self addSubview:nameLabel];
        
        UILabel *maxMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(nameLabel.frame), CGRectGetMaxY(nameLabel.frame) + 5, 200, 20)];
        maxMoneyLabel.font = [UIFont systemFontOfSize:15];
        maxMoneyLabel.textColor = [UIColor lightGrayColor];
        maxMoneyLabel.text = [NSString stringWithFormat:@"最高可贷款额度%@万",product[@"maxMoney"]];
        [self addSubview:maxMoneyLabel];
        
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetWidth([UIScreen mainScreen].bounds) / 4 - 1, CGRectGetWidth([UIScreen mainScreen].bounds), 1)];
        lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:lineView];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
