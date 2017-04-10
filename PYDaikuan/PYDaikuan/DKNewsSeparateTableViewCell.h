//
//  DKNewsSeparateTableViewCell.h
//  PYDaikuan
//
//  Created by 洋 裴 on 17/3/28.
//  Copyright © 2017年 piang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKNewsSeparateTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *data;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
