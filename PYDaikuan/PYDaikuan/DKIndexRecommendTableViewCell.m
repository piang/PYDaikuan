//
//  DKIndexRecommendTableViewCell.m
//  PYDaikuan
//
//  Created by 洋 裴 on 17/5/7.
//  Copyright © 2017年 piang. All rights reserved.
//

#import "DKIndexRecommendTableViewCell.h"
#import "DKIndexRecommendButton.h"

@interface DKIndexRecommendTableViewCell()

@end

@implementation DKIndexRecommendTableViewCell

- (instancetype)initWithData:(NSArray *)recommandProduct withBlock:(void (^)(NSDictionary *))block {
    if (self = [super init]) {
        
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
        
        DKIndexRecommendButton *leftProductButton = [[DKIndexRecommendButton alloc] initWithData:recommandProduct[0]];
        leftProductButton.tag = 99;
        leftProductButton.frame = CGRectMake(0, 0, width/2 - 0.5, width/4 - 1);
        [self.contentView addSubview:leftProductButton];
        
        DKIndexRecommendButton *rightProductButton = [[DKIndexRecommendButton alloc] initWithData:recommandProduct[1]];
        rightProductButton.frame = CGRectMake(width/2 + 0.5, 0, width/2, width/4 - 1);
        [self.contentView addSubview:rightProductButton];
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
