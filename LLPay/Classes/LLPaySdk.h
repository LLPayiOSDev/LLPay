//
//  LLPaySdk.h
//  LLPaySdk
//
//  Created by xuyf on 14-4-23.
//  Copyright (c) 2014年 LianLianPay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum LLPayResult {
    kLLPayResultSuccess = 0,      // 支付成功
    kLLPayResultFail = 1,         // 支付失败
    kLLPayResultCancel = 2,       // 支付取消，用户行为
    kLLPayResultInitError,        // 支付初始化错误，订单信息有误，签名失败等
    kLLPayResultInitParamError,   // 支付订单参数有误，无法进行初始化，未传必要信息等
    kLLPayResultUnknow,           // 其他
    kLLPayResultRequestingCancel, // 授权支付后取消(支付请求已发送)
} LLPayResult;


@protocol LLPaySdkDelegate <NSObject>

@required

/**
 *  调用sdk以后的结果回调
 *
 *  @param resultCode 支付结果
 *  @param dic        回调的字典，参数中，ret_msg会有具体错误显示
 */
- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary*)dic;

@end

typedef NS_ENUM(NSUInteger, LLPayType) {
    LLPayTypeQuick,     // 快捷
    LLPayTypeVerify,    // 认证
    LLPayTypePreAuth,   // 预授权
    LLPayTypeTravel,    // 游易付之随心付
    LLPayTypeRealName,  // 实名快捷支付
    LLPayTypeCar,       // 车易付
    LLPayTypeInstalments,//分期付
};

@interface LLPaySdk : NSObject

/**
 *  单例sdk
 *
 *  @return 返回LLPaySdk的单例对象
 */
+ (LLPaySdk *)sharedSdk;

/** 代理 */
@property (nonatomic, assign) NSObject<LLPaySdkDelegate> *sdkDelegate;

/**
 *  连连支付 支付接口
 *
 *  @param viewController 推出连连支付支付界面的ViewController
 *  @param payType        连连支付类型:LLPayType
 *  @param traderInfo     交易信息
 */
- (void)presentLLPaySDKInViewController: (UIViewController *)viewController
                            withPayType: (LLPayType)payType
                          andTraderInfo: (NSDictionary *)traderInfo;

/**
 *  连连支付 签约接口
 *
 *  @param viewController 推出连连支付签约界面的ViewController
 *  @param payType        连连支付类型:LLPayType（签约支持认证签约、分期付签约）
 *  @param traderInfo     交易信息
 */
- (void)presentLLPaySignInViewController:(UIViewController *)viewController
                             withPayType:(LLPayType)payType
                           andTraderInfo:(NSDictionary *)traderInfo;


/**
 获取SDK版本号

 @return 版本号
 */
+ (NSString *)getSDKVersion;

/**
 *  在sdk标题栏下面设定一个广告条或者操作指南bar
 *
 *  @param view 要显示的广告View
 */
+ (void)setADView:(UIView *)view;

@end
