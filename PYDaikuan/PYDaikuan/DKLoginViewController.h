//
//  DKLoginViewController.h
//  PYDaikuan
//
//  Created by 洋 裴 on 17/6/5.
//  Copyright © 2017年 piang. All rights reserved.
//

#import "ViewController.h"

typedef void(^Callback)(NSString *phoneNumber);

@interface DKLoginViewController : ViewController

@property (nonatomic, copy) Callback callback;

@end
