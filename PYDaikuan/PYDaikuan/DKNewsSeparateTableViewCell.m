//
//  DKNewsSeparateTableViewCell.m
//  PYDaikuan
//
//  Created by 洋 裴 on 17/3/28.
//  Copyright © 2017年 piang. All rights reserved.
//

#import "DKNewsSeparateTableViewCell.h"

@implementation DKNewsSeparateTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *newsTableViewCellIdentifier = @"newsSeparateTableViewCellIdentifier";
    
    DKNewsSeparateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsTableViewCellIdentifier];
    
    if (cell == nil) {
        cell = [[DKNewsSeparateTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:newsTableViewCellIdentifier];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.numberOfLines = 0;
        self.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
    }
    return self;
}

- (void)setData:(NSDictionary *)data {
    _data = data;
    self.textLabel.text = _data[@"title"];
    self.detailTextLabel.text = _data[@"CTIME"];
    
    UIImage *pic = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_data[@"imglink"]]]];
    UIImageView *recommandIV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.frame) - 112, 0, 112, 63)];
    recommandIV.image = pic;
    self.accessoryView = recommandIV;
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
