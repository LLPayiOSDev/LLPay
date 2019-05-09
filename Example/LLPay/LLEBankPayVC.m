//
//  LLEBankPayVC.m
//  DemoPay
//
//  Created by EvenLin on 2017/7/21.
//  Copyright © 2017年 LianLianPay. All rights reserved.
//

#import "LLEBankPayVC.h"
#import "LLEBankPaySDK.h"
#import "LLPayUtil.h"
#import "LLEBankPayVC.h"
#import "LLPayTool.h"

#define width ([UIScreen mainScreen].bounds.size.width)
#define height ([UIScreen mainScreen].bounds.size.height)
#define LLColor ([UIColor colorWithRed:0 green:160 / 255.0 blue:233 / 255.0 alpha:1])

static NSString *cellIdentifier = @"cellIdentifier";
static NSString *kSelectedBankKey = @"selectedBankKey";

@interface LLEBankPayVC () <UITableViewDelegate, UITableViewDataSource, LLPStdSDKDelegate>

@property (nonatomic, strong) UITableView *bankTableView;

@property (nonatomic, strong) NSArray *bankArr;
@property (nonatomic, assign) NSUInteger index;

@end

@implementation LLEBankPayVC

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行APP支付";
    self.index = [[NSUserDefaults standardUserDefaults] integerForKey:kSelectedBankKey];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bankTableView];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

#pragma mark - LLBankAPPPay

- (void)pay {
    NSString *bankCode = self.bankArr[self.index][@"code"];
    [self payOrderWithBankCode:bankCode];
}

- (void)payOrderWithBankCode:(NSString *)bankCode {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *time = [LLPayTool timeStamp];
    param[@"user_id"] = time;
    param[@"oid_partner"] = @"201306081000001016";
    param[@"sign_type"] = @"MD5";
    param[@"busi_partner"] = @"101001";
    param[@"no_order"] = [LLPayTool generateTradeNO];
    param[@"dt_order"] = time;
    param[@"name_goods"] = @"连连测试商品";
    param[@"money_order"] = @"0.01";
    param[@"notify_url"] = @"https://www.lianlianpay.com";
    param[@"return_url"] = @"https://www.lianlianpay.com";

    param[@"bank_code"] = bankCode;
    // sign
    LLPayUtil *util = [[LLPayUtil alloc] init];
    NSDictionary *dic = [util signedOrderDic:[param copy] andSignKey:@"yintong1234567890"];
    [LLEBankPaySDK sharedSDK].sdkDelegate = self;
    [[LLEBankPaySDK sharedSDK] llEBankPayInViewController:self andPaymentInfo:dic];
}

- (void)paymentEnd:(LLPStdSDKResult)resultCode withResultDic:(NSDictionary *)dic {
    NSString *msg = @"支付异常";
    switch (resultCode) {
        case LLPStdSDKResultSuccess: msg = @"支付成功"; break;
        case LLPStdSDKResultFail: msg = @"支付失败"; break;
        case LLPStdSDKResultCancel: msg = @"支付取消"; break;
        case LLPStdSDKResultInitError: msg = @"SDK初始化异常"; break;
        case LLPStdSDKResultInitParamError: msg = dic[@"ret_msg"]; break;
        default: break;
    }
    UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:@"提示" message:dic[@"ret_msg"] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (NSString *)bankNameForCode:(NSString *)bankCode {
    if (bankCode == nil) {
        return nil;
    }
    for (NSDictionary *dic in self.bankArr) {
        NSString *code = dic[@"code"];
        if ([code isEqualToString:bankCode]) {
            return dic[@"name"];
        }
    }
    return nil;
}

#pragma mark - Delegate

#pragma mark *** <UITableViewDataSource> ***

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.bankArr.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"   选择支付方式";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 59;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    NSString *bankName = self.bankArr[indexPath.row][@"name"];
    NSString *bankDetailName = self.bankArr[indexPath.row][@"detailName"];
    UIImage *image = [UIImage imageNamed:self.bankArr[indexPath.row][@"abbreviation"]];
    UIImage *bankImage = [UIImage imageWithData:UIImagePNGRepresentation(image) scale:2];
    cell.imageView.image = bankImage;

    cell.textLabel.text = bankName;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.detailTextLabel.text = bankDetailName;
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];

    if (indexPath.row == 0) {
        UIImageView *recommendIV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"recommend"]];
        recommendIV.contentMode = UIViewContentModeScaleAspectFit;
        recommendIV.frame = CGRectMake(150, 10, 30, 20);
        [cell.contentView addSubview:recommendIV];
    }

    BOOL isSelected = indexPath.row == self.index;

    cell.accessoryView =
        [[UIImageView alloc] initWithImage:[UIImage imageNamed:isSelected ? @"checkbox_checked" : @"checkbox_normal"]];

    return cell;
}

#pragma mark *** <UITableViewDelegate> ***

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.index = indexPath.row;
    [[NSUserDefaults standardUserDefaults] setInteger:self.index forKey:kSelectedBankKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

    [tableView reloadData];
}

#pragma mark - Private

- (UIView *)tableHeaderView {
    UIView *headerView = [UIView new];
    CGFloat headHeight = 75;
    headerView.frame = CGRectMake(0, -2, width, headHeight);
    headerView.backgroundColor = self.navigationController.navigationBar.barTintColor;// LLColor;
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(12, 0, width / 2 - 12, headHeight);
    nameLabel.numberOfLines = 0;
    nameLabel.text = @"连连测试商品";
    nameLabel.font = [UIFont systemFontOfSize:15];
    nameLabel.textColor = [UIColor whiteColor];
    [headerView addSubview:nameLabel];

    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(width / 2, 0, width / 2 - 12, headHeight)];
    moneyLabel.font = [UIFont boldSystemFontOfSize:30];
    moneyLabel.textColor = [UIColor whiteColor];
    moneyLabel.text = @"￥0.01";
    moneyLabel.textAlignment = NSTextAlignmentRight;
    moneyLabel.adjustsFontSizeToFitWidth = YES;
    [headerView addSubview:moneyLabel];

    return headerView;
}

- (UIView *)tableFooterView {
    UIView *footerView = [UIView new];
    footerView.frame = CGRectMake(0, 0, width, 100);
    footerView.backgroundColor = [UIColor clearColor];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(12, 20, width - 24, 44);
    btn.backgroundColor = self.navigationController.navigationBar.barTintColor;
    [btn addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 5;
    [btn setTitle:@"立即支付" forState:UIControlStateNormal];
    [footerView addSubview:btn];

    return footerView;
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    rect = CGRectMake(0, 0, width, 100);

    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return theImage;
}

#pragma mark - Getter/Setter

- (UITableView *)bankTableView {
    if (!_bankTableView) {
        _bankTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _bankTableView.backgroundColor = [UIColor clearColor];
        _bankTableView.dataSource = self;
        _bankTableView.delegate = self;
        _bankTableView.separatorInset = UIEdgeInsetsZero;
        _bankTableView.tableFooterView = [self tableFooterView];
        _bankTableView.tableHeaderView = [self tableHeaderView];
    }
    return _bankTableView;
}

- (NSArray *)bankArr {
    if (!_bankArr) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"LLDemoBankList" ofType:@"plist"];
        _bankArr = [NSArray arrayWithContentsOfFile:path];
    }
    return _bankArr;
}

@end
