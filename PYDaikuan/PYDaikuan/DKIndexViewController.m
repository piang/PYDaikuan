//
//  DKIndexViewController.m
//  PYDaikuan
//
//  Created by piang on 16/8/14.
//  Copyright © 2016年 piang. All rights reserved.
//

#import "DKIndexViewController.h"
#import "DKWebViewController.h"
#import "UMMobClick/MobClick.h"
#import "AppDelegate.h"
#import "DKIndexDetailViewController.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "DKIndexRecommendTableViewCell.h"
#import "DKIndexTableViewCell.h"
#import <AVOSCloud/AVOSCloud.h>

@interface DKIndexViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation DKIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"一键贷款";
    
    [AVOSCloud setApplicationId:@"XpuV4q5fN2hj9hGr4CwzYvHO-gzGzoHsz" clientKey:@"vOcE9YRm4PLFdxv3GYrnkTVb"];
    AVQuery *query = [AVQuery queryWithClassName:@"channel_version"];
    
    [query getObjectInBackgroundWithId:@"593415d5a22b9d0058e770f6" block:^(AVObject *object, NSError *error) {
        NSLog(@"object%@",object);
        
        int currentVersion = [[[NSUserDefaults standardUserDefaults] objectForKey:@"currentVersion"] intValue];
        
        if ( currentVersion < [object[@"currentVersion"] intValue]) {
            
            AVQuery *query = [AVQuery queryWithClassName:@"channel"];
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                NSLog(@"objects%@",objects);
                
                self.dataSource = [NSMutableArray arrayWithCapacity:5];
                
                for (int i  =0 ; i < objects.count; i++) {
                    [self.dataSource addObject:objects[i][@"localData"]];
                    self.dataSource[i][@"image"] = ((AVFile *)objects[i][@"localData"][@"image"]).url;
                }
                
                [[NSUserDefaults standardUserDefaults] setObject:@(currentVersion) forKey:@"currentVersion"];
                [[NSUserDefaults standardUserDefaults] setObject:self.dataSource forKey:@"channelDatasource"];
                
                if (self.dataSource.count > 3) {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSArray *bannerDataSource = @[_dataSource[0][@"image"],_dataSource[1][@"image"],_dataSource[2][@"image"],_dataSource[3][@"image"]];
                        
                        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame) / 2) imageNamesGroup:bannerDataSource];
                        cycleScrollView.titlesGroup = @[_dataSource[0][@"title"],_dataSource[1][@"title"],_dataSource[2][@"title"],_dataSource[3][@"title"]];
                        cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
                        cycleScrollView.clickItemOperationBlock = ^(NSInteger index){
                            DKWebViewController *webVC = [[DKWebViewController alloc] initWithUrl:_dataSource[index][@"url"]];
                            [self.navigationController pushViewController:webVC animated:YES];
                        };
                        
                        _tableview.tableHeaderView = cycleScrollView;
                        
                        [self.tableview reloadData];
                    });
                }
                
            }];
        }
        
        else {
            self.dataSource = [[NSUserDefaults standardUserDefaults] objectForKey:@"channelDatasource"];
            if (self.dataSource.count > 3) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSArray *bannerDataSource = @[_dataSource[0][@"image"],_dataSource[1][@"image"],_dataSource[2][@"image"],_dataSource[3][@"image"]];
                    
                    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame) / 2) imageNamesGroup:bannerDataSource];
                    cycleScrollView.titlesGroup = @[_dataSource[0][@"title"],_dataSource[1][@"title"],_dataSource[2][@"title"],_dataSource[3][@"title"]];
                    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
                    cycleScrollView.clickItemOperationBlock = ^(NSInteger index){
                        DKWebViewController *webVC = [[DKWebViewController alloc] initWithUrl:_dataSource[index][@"url"]];
                        [self.navigationController pushViewController:webVC animated:YES];
                    };
                    
                    _tableview.tableHeaderView = cycleScrollView;
                    
                    [self.tableview reloadData];
                });
            }
        }
        
    }];
    
    //    self.dataSource = @[@{@"title":@"好贷网",@"image":@"daikuan_haodai",@"url":@"https://loan.rongba.com/H5tuiguang/kff?ref=hd_11016474",@"event_id":@"touch_haodai",@"maxMoney":@"0.5"},@{@"title":@"融360",@"image":@"daikuan_rong360",@"url":@"https://m.rong360.com/express?from=sem21&utm_source=huile&utm_medium=cpa&utm_campaign=sem21_1",@"event_id":@"touch_rong360",@"maxMoney":@"10"},@{@"title":@"信而富",@"image":@"daikuan_xinerfu",@"url":@"https://promotion.crfchina.com/localMarket/index.html?c=&s=imm3&salesmanNo=JKTZNJ0091&agentNo=JKTZNJ0091_20170313BJHL003&from=singlemessage&isappinstalled=0",@"event_id":@"touch_xinerfu",@"maxMoney":@"0.1"},@{@"title":@"2345贷款王",@"image":@"daikuan_2345",@"url":@"https://mdaikuan.2345.com/register3?channel=hj-yjdkw03_cpl_wlei",@"event_id":@"touch_2345",@"maxMoney":@"20"},@{@"title":@"宜人贷",@"image":@"daikuan_yiren",@"url":@"http://wap.yirendai.com/new/?siteId=2829&source=1",@"event_id":@"touch_yiren",@"maxMoney":@"10",@"content":@"    宜人贷（NYSE: YRD）是中国在线金融服务平台，由宜信公司2012年推出。宜人贷通过互联网、大数据等科技手段，为中国城市白领人群提供信用借款咨询服务，并通过”宜人理财“在线平台为投资者提供理财咨询服务。2015年12月18日，宜人贷在美国纽交所成功上市，成为中国互联网金融海外上市第一股。\n\n    宜人贷致力于使出借、借款两端客户之间的需求对接变得更加安全、高效、专业、规范。通过建立、释放和创造信用价值，唤起社会对于大众信用价值的关注和认可，让信用真正成为体现价值的载体，推动普惠金融的发展。\n\n    信用是每个人至关重要的社会资本。人人有信用，能使自己和他人独立自尊、互相信任，使信用价值得以实现。通过建立、释放和创造信用价值，将有助于降低社会和经济活动的交易成本，提高效率，有助于获得发展所需的物质资本和社会资本，并且创造新的商业价值和社会价值。宜人贷倡导通过共同努力唤起社会对于大众信用价值的关注和认可，让信用真正成为体现价值的载体，推动普惠金融的发展。\n\n    宜人贷一直以来坚持技术驱动金融创新，通过对移动互联网与大数据风控技术等高新技术手段驱动金融行业创新，打造更安全、高效、专业、规范的P2P网贷平台。"},@{@"title":@"现金卡",@"image":@"daikuan_xianjinbaika",@"url":@"http://api.51ygdai.com/act/light-loan?source_tag=H5-yjdk3",@"event_id":@"touch_xianjinbaika",@"maxMoney":@"0.3",@"content":@"    刚进入职场，尤其是在大城市打拼的年轻人，资金短缺一直是无法避免的问题。我们深知没钱时捉襟见肘的尴尬与痛苦，因此推出以下主打产品：\n\n    零钱包：新注册用户最高可借1000元，用于解决资金紧张、需要临时周转（如月末、朋友聚会、份子钱）的窘境。\n\n    我们做现金卡(原:员工贷)的初心，是深信“信用”在未来的社会中将占据举足轻重的地位，它能有效的降低社会运转成本、让所有人生活得更便捷。平台的用户只要遵守信用、按时还款，将获得更高的借款额度和更低的借款利率，尽享信用生活带来的便捷。\n\n    我们的目标：\n\n    刚入职的新人来大城市打拼不易，房租、水电、衣食住行、聚会、份子钱……都是不能承受之重。同样经历过这些的我们做出这款APP，希望你在大城市追逐梦想的时候，能更轻松一些。\n\n    现金卡(原:员工贷)隶属于上海融笃资产管理有限公司，公司致力于个人借贷、消费金融业务，核心团队来自腾讯、京东金融、蚂蚁金服、财付通和招商银行等，拥有互联网+金融双重背景，值得信赖。"},@{@"title":@"拍拍贷",@"image":@"daikuan_paipai",@"url":@"https://m.invest.ppdai.com/landinginfonew.html?regsourceid=weimidaixianzhip03&role=1",@"event_id":@"touch_paipai",@"maxMoney":@"2",@"content":@"    拍拍贷成立于2007年6月，公司全称为“上海拍拍贷金融信息服务有限公司”，总部位于上海。是国内首家纯信用无担保网络借贷平台，同时也是第一家由工商部门批准，获得“金融信息服务”资质的互联网金融（ITFIN）平台。除普通散标投资项目外，还为用户提供拍活宝、彩虹计划两款理财产品，方便用户使用。现有员工逾2600人。\n\n    截至2016年底，注册用户达到3261万，是国内用户规模最大的网络信用借贷平台之一。与国内其他网络信用借贷平台相比，拍拍贷的最大特点在于采用纯线上模式运作，平台本身不参与借款，而是实施信息匹配、工具支持和服务等功能，借款人的借款利率在最高利率限制下，由自己设定。而这也是网络信用借贷平台最原始的运作模式。\n\n    拍拍贷成立于2007年6月，公司全称为“上海拍拍贷金融信息服务有限公司”，总部位于国际金融中心上海，是中国第一家网络信用借贷平台。\n\n    拍拍贷是国内第一家由工商部门特批，获得“金融信息服务”经营范围许可，得到政府认可的互联网金融平台。拍拍贷用先进的理念和创新的技术建立了一个安全、高效、透明的互联网金融平台，规范个人借贷行为，让借入者改善生产生活，让借出者增加投资渠道。拍拍贷相信，随着互联网的发展和中国个人信用体系的健全，先进的理念和创新的技术将给民间借贷带来历史性的变革，而拍拍贷将是这场变革的领导者。"},@{@"title":@"好贷网",@"image":@"daikuan_haodaixinyongka",@"url":@"http://8.yun.haodai.com/?ref=hd_11016474",@"event_id":@"touch_haodaixinyongka",@"maxMoney":@"0.5",@"content":@"    好贷网，中国领先的企业及个人贷款智能搜索引擎，是为借贷人寻找贷款渠道，同时为银行及金融机构寻找匹配信贷客户的贷款平台。2013年3月25日，好贷网正式上线运营，好贷网CEO李明顺曾有过成功创业经历，其从2005年起，开始担任论坛技术公司Discuz!联合创始人。2010年Discuz!最终被作价4200万美元出售给腾讯。好贷网公司总部在北京，并在厦门设有分支机构，截止到2013年底已在全国108个城市开通了本地的在线免费贷款搜索与咨询服务，并与5800余家银行 4000余家小贷公司、典当行及各类正规金融机构建立合作。\n\n    好贷网为广大中小企业和个人用户免费提供正规贷款渠道信息。好贷网的合作方均为国家指定的贷款机构，包括银行、小贷公司、担保公司、典当行等等。广大用户可以通过好贷网智能搜索平台直接申请到正规可靠的贷款（省时，低息，高效）。\n\n    团队核心成员曾分别供职于各大互联网、银行和权威金融机构，其中技术团队拥有千万级的海量数据处理及信息匹配能力，同时业务团队拥有面向金融机构的服务经验。"},@{@"title":@"手机贷",@"image":@"daikuan_shoujidai",@"url":@"http://sjd-m.mobanker.com/?channel=xedkw-llcs",@"event_id":@"touch_shoujidai",@"maxMoney":@"0.1",@"content":@"    手机贷是国内基于移动互联网的全流程线上网络信贷应用，是对传统个人信贷业务的移动化创新。由“新金融生活倡导者“上海前隆金融信息服务有限公司研发运营，总部位于上海。\n\n    手机贷由上海前隆金融信息服务有限公司于2013年9月推出，对有小额借款需求的个人客户进行快速、准确的评估和审核，为持牌金融机构提供合格的个人借款客户及大数据风控支持，致力于搭建畅通的借贷信息桥梁，成为中国普惠金融的加速器。\n\n    手机贷作为国内首批基于移动互联网的全流程线上网络信贷应用，是对传统个人信贷业务的移动化创新，产品倡导“信用变现金”的理念，致力于打造以信用为凭证、无需担保的个人移动信用钱包。\n\n    在用户人群的选择上，瞄准被低估的用户群，为初入社会的小白领、蓝领客群提供发薪前的现金周转服务，帮助其累积信用。将美国的“Payday Loan”本土化，创新性的提出“Thin Loan”发展模式，提供1000-5000元的超小借贷额度，7-30天的超短周期，自主定义借款金额、还款周期，为他们提供方便快捷的全流程线上信贷服务。\n\n    手机贷以采集互联网大数据作为主要征信源，进行有效的数据清洗、分析建模、个人信用评分，并与传统金融授信逻辑相结合，是实现撮合借贷交易的互联网金融平台。"}];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    
    self.tableview.tableFooterView = [[UIView alloc] init];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"onlineSetting"] boolValue]) {
        
    }
    else {
        UILabel *tableHeaderHeader = [[UILabel alloc] init];
        tableHeaderHeader.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 30);
        tableHeaderHeader.text = @"  请注意：本app不直接提供贷款，只提供贷款资讯和介绍  ";
        tableHeaderHeader.textColor = [UIColor grayColor];
        tableHeaderHeader.textAlignment = NSTextAlignmentCenter;
        tableHeaderHeader.adjustsFontSizeToFitWidth = YES;
        self.tableview.tableFooterView = tableHeaderHeader;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataSource.count > 3) {
        return self.dataSource.count + 2;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    if (indexPath.row == 0 || indexPath.row == 1) {
        static NSString *indexRecommendCellIdentifier = @"indexRecommendCell";
        cell = [tableView dequeueReusableCellWithIdentifier:indexRecommendCellIdentifier];
        if (!cell) {
            cell = [[DKIndexRecommendTableViewCell alloc] initWithData:@[_dataSource[indexPath.row*2],_dataSource[indexPath.row*2+1]] withBlock:^(NSDictionary *product) {
                [MobClick event:product[@"event_id"]];
                DKWebViewController *webVC = [[DKWebViewController alloc] initWithUrl:product[@"url"]];
                [self.navigationController pushViewController:webVC animated:YES];
            }];
        }
    }
    else {
        static NSString *indexTableViewCellIdentifier = @"indexTableViewCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:indexTableViewCellIdentifier];
        
        if (!cell) {
            cell = [[DKIndexTableViewCell alloc] initWithData:_dataSource[indexPath.row - 2]];
        }
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"onlineSetting"] boolValue]) {
    [MobClick event:self.dataSource[indexPath.row - 2][@"event_id"]];
    DKWebViewController *webVC = [[DKWebViewController alloc] initWithUrl:self.dataSource[indexPath.row - 2][@"url"]];
    [self.navigationController pushViewController:webVC animated:YES];
    //}
    //    else {
    //        DKIndexDetailViewController *indexDetailVC = [[DKIndexDetailViewController alloc] initWithData:self.dataSource[indexPath.row - 2]];
    //        [self.navigationController pushViewController:indexDetailVC animated:YES];
    //    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CGRectGetWidth([UIScreen mainScreen].bounds)/4;
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
