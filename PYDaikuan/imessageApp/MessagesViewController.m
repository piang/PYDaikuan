//
//  MessagesViewController.m
//  imessageApp
//
//  Created by piang on 16/12/27.
//  Copyright © 2016年 piang. All rights reserved.
//

#import "MessagesViewController.h"


@interface MessagesViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSArray *dataSource;
@property (weak, nonatomic) UICollectionView *collectionView;

@end

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置对齐方式
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //cell间距
    layout.minimumInteritemSpacing = 0.1f;
    //cell行距
    layout.minimumLineSpacing = 0.1f;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    collectionView.frame = self.view.frame;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];
    _collectionView = collectionView;
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"bannerCollectionCellId"];
    
    self.dataSource = @[@{@"image":@"daikuan_rong360",@"url":@"https://m.rong360.com/express?from=sem21&utm_source=huile&utm_medium=cpa&utm_campaign=sem21_1"},@{@"image":@"daikuan_yiren",@"url":@"http://wap.yirendai.com/new/?siteId=2829&source=1"},@{@"image":@"daikuan_shoujidai",@"url":@"http://sjd-m.mobanker.com/?channel=xedkw-llcs"},@{@"image":@"daikuan_haodai",@"url":@"https://loan.rongba.com/H5tuiguang/kff?ref=hd_11016474"},@{@"image":@"daikuan_haodaixinyongka",@"url":@"http://8.yun.haodai.com/?ref=hd_11016474"},@{@"image":@"daikuan_xianjinbaika",@"url":@"http://api.51ygdai.com/act/light-loan?source_tag=H5-yjdk3"}];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bannerCollectionCellId" forIndexPath:indexPath];
    
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    UIImageView *bannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10,CGRectGetWidth(self.view.frame)/2 - 20 , CGRectGetWidth(self.view.frame)/32 * 9 - 20)];
    bannerImageView.image = [UIImage imageNamed:self.dataSource[indexPath.row][@"image"]];
    [cell.contentView addSubview:bannerImageView];
    
    return cell;
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){CGRectGetWidth(self.view.frame)/2 - 1,CGRectGetWidth(self.view.frame)/32 * 9};
}


//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(1, 1, 1, 1);
//}


#pragma mark ---- UICollectionViewDelegate


// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self requestPresentationStyle:MSMessagesAppPresentationStyleCompact];
    MSMessageTemplateLayout *layout = [[MSMessageTemplateLayout alloc] init];
    layout.image = [UIImage imageNamed:self.dataSource[indexPath.row][@"image"]];
    MSMessage *message = [[MSMessage alloc] init];
    message.layout =layout;
    message.URL = [NSURL URLWithString:self.dataSource[indexPath.row][@"url"]];
    [self.activeConversation insertMessage:message completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Conversation Handling

-(void)didBecomeActiveWithConversation:(MSConversation *)conversation {
    // Called when the extension is about to move from the inactive to active state.
    // This will happen when the extension is about to present UI.
    
    // Use this method to configure the extension and restore previously stored state.
}

-(void)willResignActiveWithConversation:(MSConversation *)conversation {
    // Called when the extension is about to move from the active to inactive state.
    // This will happen when the user dissmises the extension, changes to a different
    // conversation or quits Messages.
    
    // Use this method to release shared resources, save user data, invalidate timers,
    // and store enough state information to restore your extension to its current state
    // in case it is terminated later.
}

-(void)didReceiveMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    // Called when a message arrives that was generated by another instance of this
    // extension on a remote device.
    
    // Use this method to trigger UI updates in response to the message.
}

-(void)didStartSendingMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    // Called when the user taps the send button.
}

-(void)didCancelSendingMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    // Called when the user deletes the message without sending it.
    
    // Use this to clean up state related to the deleted message.
}

-(void)willTransitionToPresentationStyle:(MSMessagesAppPresentationStyle)presentationStyle {
    // Called before the extension transitions to a new presentation style.
    
    // Use this method to prepare for the change in presentation style.
}

-(void)didTransitionToPresentationStyle:(MSMessagesAppPresentationStyle)presentationStyle {
    // Called after the extension transitions to a new presentation style.
    
    // Use this method to finalize any behaviors associated with the change in presentation style.
}

@end
