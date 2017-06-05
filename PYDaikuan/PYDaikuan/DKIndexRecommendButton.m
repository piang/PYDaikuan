//
//  DKIndexRecommendButton.m
//  PYDaikuan
//
//  Created by 洋 裴 on 17/5/7.
//  Copyright © 2017年 piang. All rights reserved.
//

#import "DKIndexRecommendButton.h"

@implementation DKIndexRecommendButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super init]){
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *maxMoneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 35, 35, 20)];
        maxMoneyLabel.textColor = [UIColor redColor];
        maxMoneyLabel.font = [UIFont systemFontOfSize:14];
        maxMoneyLabel.text = [NSString stringWithFormat:@"%@万",data[@"maxMoney"]];
        [self addSubview:maxMoneyLabel];
        UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(maxMoneyLabel.frame), CGRectGetMinY(maxMoneyLabel.frame), 40, 20)];
        hintLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        hintLabel.font = [UIFont systemFontOfSize:15];
        hintLabel.text = @"最高";
        [self addSubview:hintLabel];
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, CGRectGetMaxY(maxMoneyLabel.frame) + 5, 100, 20)];
        nameLabel.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        nameLabel.font = [UIFont systemFontOfSize:13];
        nameLabel.text = data[@"title"];
        [self addSubview:nameLabel];
        
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2 - 25 - 40, CGRectGetMinY(maxMoneyLabel.frame), 40, 40)];
        iconImageView.layer.cornerRadius = 20;
        iconImageView.layer.masksToBounds = YES;
        [iconImageView sd_setImageWithURL:[NSURL URLWithString:data[@"image"]]];
        [self addSubview:iconImageView];
        
    }
    return self;
}

@end
