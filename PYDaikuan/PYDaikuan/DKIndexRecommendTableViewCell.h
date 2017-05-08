//
//  DKIndexRecommendTableViewCell.h
//  PYDaikuan
//
//  Created by 洋 裴 on 17/5/7.
//  Copyright © 2017年 piang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKIndexRecommendTableViewCell : UITableViewCell

- (instancetype)initWithData:(NSArray *)recommandProduct withBlock:(void (^)(NSDictionary *product))block;

@end
