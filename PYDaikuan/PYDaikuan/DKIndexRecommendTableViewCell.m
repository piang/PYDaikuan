//
//  DKIndexRecommendTableViewCell.m
//  PYDaikuan
//
//  Created by 洋 裴 on 17/5/7.
//  Copyright © 2017年 piang. All rights reserved.
//

#import "DKIndexRecommendTableViewCell.h"
#import "DKIndexRecommendButton.h"

typedef void (^ButtonBlock)(NSDictionary *);

@interface DKIndexRecommendTableViewCell()

@property (nonatomic, copy) ButtonBlock myblock;
@property (nonatomic, copy) NSArray *productsArray;

@end

@implementation DKIndexRecommendTableViewCell

- (instancetype)initWithData:(NSArray *)recommandProduct withBlock:(void (^)(NSDictionary *))block {
    if (self = [super init]) {
        
        _productsArray = recommandProduct;
        _myblock = block;
        
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
        
        DKIndexRecommendButton *leftProductButton = [[DKIndexRecommendButton alloc] initWithData:recommandProduct[0]];
        leftProductButton.tag = 99;
        leftProductButton.frame = CGRectMake(0, 0, width/2 - 0.5, width/4 - 1);
        [self.contentView addSubview:leftProductButton];
        [leftProductButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        
        DKIndexRecommendButton *rightProductButton = [[DKIndexRecommendButton alloc] initWithData:recommandProduct[1]];
        rightProductButton.tag = 98;
        rightProductButton.frame = CGRectMake(width/2 + 0.5, 0, width/2, width/4 - 1);
        [self.contentView addSubview:rightProductButton];
        [rightProductButton addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)touchButton:(UIButton *)sender {
    if (sender.tag == 99) {
        _myblock(_productsArray[0]);
    }
    else if (sender.tag == 98) {
        _myblock(_productsArray[1]);
    }
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
