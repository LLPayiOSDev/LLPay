//
//  LLViewController.m
//  LLPay
//
//  Created by LLPayiOSDev on 04/25/2018.
//  Copyright (c) 2018 LianLian Pay. All rights reserved.
//

#import "LLViewController.h"
#import "LLEBankPayVC.h"

//如果使用认证或者分期付， 请在createLLOrder方法中传入姓名和身份证
LLPayType payType = LLPayTypeNewVerify;

@interface LLViewController ()

@end

@implementation LLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - Actions

- (IBAction)sdkversion:(id)sender {
    [self llAlertWithMsg:[LLPaySdk getSDKVersion]];
}

/**
 调用连连支付
 */
- (IBAction)lianlianpay:(id)sender {
    NSDictionary *paymentInfoNotSigned = [self createLLOrder];

    /*  签名操作， 请注意⚠️
     Demo中为了方便演示， 所以将加签过程以及密钥放在本地
     但是在真实APP中， 请务必⚠️将privateKey和加签过程放在商户服务端⚠️
     以防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险" */
    self.signUtil.signKeyArray = nil;
    NSDictionary *traderInfo = [self llSignOrder:paymentInfoNotSigned];

    [LLPaySdk sharedSdk].sdkDelegate = self;
    [[LLPaySdk sharedSdk] presentLLPaySDKInViewController:self withPayType:payType andTraderInfo:traderInfo];
    // payType为接入的产品， 如： 认证支付传LLPayTypeVerify
}


/**
 调用连连支付的绑卡接口
 */
- (IBAction)lianliansign:(id)sender {
    NSMutableDictionary *paymentInfo = [[self createLLOrder] mutableCopy];
    [paymentInfo removeObjectForKey:@"money_order"];

    /*  签名操作， 请注意⚠️
     Demo中为了方便演示， 所以将加签过程以及密钥放在本地≠
     但是在真实APP中， 请务必⚠️将privateKey和加签过程放在商户服务端⚠️
     以防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险" */
    self.signUtil.signKeyArray = @[
        @"acct_name", @"card_no", @"id_no", @"oid_partner", @"risk_item", @"sign_type", @"user_id", @"repayment_plan",
        @"repayment_no", @"sms_param"
    ];
    NSDictionary *traderInfo = [self llSignOrder:paymentInfo];

    [LLPaySdk sharedSdk].sdkDelegate = self;
    [[LLPaySdk sharedSdk] presentLLPaySignInViewController:self withPayType:payType andTraderInfo:traderInfo];
}

- (IBAction)ebankpay:(id)sender {
    LLEBankPayVC *vc = [LLEBankPayVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - LLPaySDK Delegate

- (void)paymentEnd:(LLPStdSDKResult)resultCode withResultDic:(NSDictionary *)dic {

    NSLog(@"%@", [LLPayUtil jsonStringOfObj:dic]);
    NSString *msg = nil;
    switch (resultCode) {
        case LLPStdSDKResultSuccess: msg = @"成功"; break;
        case LLPStdSDKResultFail: msg = @"失败"; break;
        case LLPStdSDKResultCancel: msg = @"取消"; break;
        case LLPStdSDKResultInitError: msg = @"初始化异常"; break;
        case LLPStdSDKResultInitParamError: msg = dic[@"ret_msg"]; break;
        default: msg = @"异常"; break;
    }
    [self llAlertWithTitle:msg andMsg:[LLPayUtil jsonStringOfObj:dic]];
}

#pragma mark - LLPayOrder Function

/**
 创建连连支付订单（未签名）
 */
- (NSDictionary *)createLLOrder {
    NSMutableDictionary *orderParams = [NSMutableDictionary dictionary];
    orderParams[@"user_id"] = [NSString stringWithFormat:@"LLUser%@", [LLPayTool timeStamp]];
    orderParams[@"oid_partner"] = [self oidPartnerForDemo];
    orderParams[@"sign_type"] = @"MD5";//此处仅供Demo演示， 商户签名请务必使用RSA
    orderParams[@"busi_partner"] = @"101001";
    orderParams[@"no_order"] = [LLPayTool generateTradeNO];
    orderParams[@"dt_order"] = [LLPayTool timeStamp];
    orderParams[@"money_order"] = @"0.01";
    orderParams[@"notify_url"] = @"https://sdk.lianlianpay.com";
    orderParams[@"risk_item"] = [LLPayUtil jsonStringOfObj:@{ @"user_info_dt_register" : @"20131030122130" }];
    orderParams[@"name_goods"] = @"连连iOS测试商品";
    orderParams[@"card_no"] = @"6212261202028888888";
    orderParams[@"id_no"] = @"140921199804163925";//    认证支付与分期付必传
    orderParams[@"acct_name"] = @"张三";        //    认证支付与分期付必传

    //    orderParams[@"info_order"] = @"";
    //    orderParams[@"valid_order"] = @"10080";
    //    orderParams[@"plat_form"] = @"";//可实现多个商户号之间用户数据共享， 该标识填写主商户号即可
    //    orderParams[@"id_type"] = @"0";
    //    orderParams[@"card_no"] = @"";
    //    orderParams[@"no_agree"] = @"";
    //    orderParams[@"shareing_data"] = @"";

    //======================= 分期参数 =======================//
    //    orderParams[@"repayment_plan"] = [LLPayUtil jsonStringOfObj:@{@"repaymentPlan":@[@{@"date" : @"2017-05-03", @"amount" :
    //    @"0.01"},@{@"date" : @"2017-06-03", @"amount" : @"0.02"}]}];
    //    orderParams[@"repayment_no"] = @"";
    //    orderParams[@"sms_param"] = [LLPayUtil jsonStringOfObj:@{@"contract_type" : @"短信显示的商户名",@"contact_way" :
    //    @"400-018-8888"}];

    return [orderParams copy];
}

/**
 签名操作， 请注意⚠️
 Demo中为了方便演示， 所以将加签过程以及密钥放在本地
 但是在真实APP中， 请务必⚠️将privateKey和加签过程放在商户服务端⚠️
 以防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险

 @param dic 待签名的数据
 @return 返回签完名的dic
 */
- (NSDictionary *)llSignOrder:(NSDictionary *)dic {
    return [self.signUtil signedOrderDic:dic andSignKey:[self partnerKeyForDemo]];
}

/**
 Demo使用的测试商户号， 对应不同支付产品有不同的商户号

 @return 返回对应产品的商户号
 */
- (NSString *)oidPartnerForDemo {
    NSString *verifyPartner = @"201408071000001543";//认证、分期付可用
    NSString *quickPartner = @"201408071000001546"; //快捷可用
    if (payType == LLPayTypeVerify || payType == LLPayTypeInstalments) {
        return verifyPartner;
    }
    if (payType == LLPayTypeQuick) {
        return quickPartner;
    }
    return verifyPartner;
}

/**
 Demo使用的商户密钥

 @return 返回密钥
 */
- (NSString *)partnerKeyForDemo {
    NSString *verifyPartnerKey = @"201408071000001543test_20140812";//认证、分期可用
    NSString *quickPartnerKey = @"201408071000001546_test_20140815";//快捷可用
    if (payType == LLPayTypeVerify || payType == LLPayTypeInstalments) {
        return verifyPartnerKey;
    }
    if (payType == LLPayTypeQuick) {
        return quickPartnerKey;
    }
    return verifyPartnerKey;
}

#pragma mark - Common Functions

- (void)llAlertWithTitle:(NSString *)title andMsg:(NSString *)msg {
    UIAlertController *alert =
        [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)llAlertWithMsg:(NSString *)msg {
    [self llAlertWithTitle:@"提示" andMsg:msg];
}

#pragma mark - getter

-(LLPayUtil *)signUtil {
    if (!_signUtil) {
        _signUtil = [LLPayUtil new];
    }
    return _signUtil;
}

@end
