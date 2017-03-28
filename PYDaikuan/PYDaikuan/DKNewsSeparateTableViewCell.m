//
//  DKNewsSeparateTableViewCell.m
//  PYDaikuan
//
//  Created by 洋 裴 on 17/3/28.
//  Copyright © 2017年 piang. All rights reserved.
//

#import "DKNewsSeparateTableViewCell.h"

@interface DKNewsSeparateTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *adImageView;

@end

@implementation DKNewsSeparateTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *newsTableViewCellIdentifier = @"newsSeparateTableViewCellIdentifier";
    
    DKNewsSeparateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsTableViewCellIdentifier];
    
    if (cell == nil) {
        cell = [[DKNewsSeparateTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newsTableViewCellIdentifier];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 30, CGRectGetWidth([UIScreen mainScreen].bounds) - 30, 10)];
        self.titleLabel = titleLabel;
        [self.contentView addSubview:titleLabel];
        
        UIImageView *adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame) + 15, CGRectGetWidth([UIScreen mainScreen].bounds) - 30, 170 - CGRectGetMaxY(self.titleLabel.frame))];
        self.adImageView = adImageView;
        
        [self.contentView addSubview:adImageView];
        
    }
    return self;
}

- (void)setData:(NSDictionary *)data {
    _data = data;
    self.titleLabel.text = _data[@"title"];
    UIImage *pic = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_data[@"imglink"]]]];
    self.adImageView.image = pic;
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
