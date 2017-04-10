//
//  DKIndexDetailViewController.m
//  PYDaikuan
//
//  Created by 洋 裴 on 17/3/29.
//  Copyright © 2017年 piang. All rights reserved.
//

#import "DKIndexDetailViewController.h"

@interface DKIndexDetailViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) NSDictionary *data;

@end

@implementation DKIndexDetailViewController

- (instancetype)initWithData:(NSDictionary *)data {
    if (self = [super init]) {
        _data = data;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImageView *bannerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:self.data[@"image"]]];
    bannerView.frame = CGRectMake(15, 15, CGRectGetWidth(self.view.frame) - 30, CGRectGetWidth(self.view.frame) / 2 - 10);
    [self.scrollView addSubview:bannerView];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    NSString *content = self.data[@"content"];
    contentLabel.numberOfLines = 0;
    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    contentLabel.text = content;
    //设置一个行高上限
    CGSize size = CGSizeMake(CGRectGetWidth(self.view.frame) - 30,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    UIFont *font = contentLabel.font;
    CGSize labelsize = [content boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    contentLabel.frame = CGRectMake(15, CGRectGetMaxY(bannerView.frame) + 15, CGRectGetWidth(self.view.frame) - 30, labelsize.height);
    [self.scrollView addSubview:contentLabel];
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetMaxY(contentLabel.frame) + 15);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
