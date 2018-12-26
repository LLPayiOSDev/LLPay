//
//  ICBCPaySDK.h
//  ICBCPayDemo
//
//  Created by wq on 16/9/26.
//  Copyright © 2016年 wq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol ICBCPaySDKDelegate <NSObject>
@required
/**
 *  调用sdk以后的结果回调
 *
 *  @param resultCode 支付结果
 *  @param dic        回调的字典，参数中，ret_msg会有具体错误显示
 */
- (void)paymentEndwithResultDic:(NSDictionary*)dic;
@end


@interface ICBCPaySDK : NSObject

/**
 *  单例sdk
 *
 *  @return
 */
+ (ICBCPaySDK *)sharedSdk;

/** 代理 */
@property (nonatomic, weak) id<ICBCPaySDKDelegate>  sdkDelegate;

/**
 *  工行支付 支付接口
 *
 *  @param viewController 推出工行支付支付界面的ViewController
 *  @param traderInfo     交易信息
 */
- (void)presentICBCPaySDKInViewController: (UIViewController *)viewController
                          andTraderInfo: (NSDictionary *)traderInfo;
/**
 
 *  支付回跳App
 *
 *  @param url         支付完成回调的URL信息
 */
- (void)ICBCResultBackWithUrl: (NSURL *)url;

/**
 
 *  获取支付SDK的版本号
 *
 */
- (NSString *)getVersion;


// 请务必配置urlListmain 和urlPortal

@property (nonatomic, strong) NSString *urlListMain;
@property (nonatomic, strong) NSString *urlPortal;

@end
