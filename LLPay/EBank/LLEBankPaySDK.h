//
//  LLBankPaySDK.h
//  LLBankPaySDK
//
//  Created by EvenLam on 2017/7/5.
//  Copyright © 2017年 LianLian Pay. All rights reserved.
//

#import "LLPay.h"

@interface LLEBankPaySDK : NSObject

/// 代理
@property (nonatomic, assign) NSObject<LLPStdSDKDelegate>* sdkDelegate;


/** 单例 */
+ (instancetype)sharedSDK;

/**
 调用银行 APP 支付 SDK

 @param viewController 承载 vc
 @param paymentInfo 支付参数
 */
- (void)llEBankPayInViewController: (UIViewController *)viewController andPaymentInfo:(NSDictionary *)paymentInfo;


/**
 处理银行 APP 返回结果
 */
+ (BOOL)handleOpenURL: (NSURL *)url;


/**
 获取 SDK 版本
 */
+ (NSString *)getSDKVersion;

/**
 *  切换正式、测试服务器（默认不调用是正式环境，请不要随意使用该函数切换至测试环境）
 *
 *  @param isTestServer YES测试环境，NO正式环境
 */
+ (void)switchToTestServer:(BOOL)isTestServer;

@end
