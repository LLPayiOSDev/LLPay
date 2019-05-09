//
//  LLPay.h
//  LLPay
//
//  Created by EvenLin on 2018/12/24.
//  Copyright © 2018 LLPayiOSDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LLPStdSDKResult) {
    LLPStdSDKResultSuccess,            /**< 支付成功    */
    LLPStdSDKResultFail,               /**< 支付失败    */
    LLPStdSDKResultCancel,             /**< 支付取消，用户行为 */
    LLPStdSDKResultInitError,          /**< 支付初始化错误，订单信息有误，签名失败等 */
    LLPStdSDKResultInitParamError,     /**< 支付订单参数有误，无法进行初始化，未传必要信息等 */
    LLPStdSDKResultUnknow,             /**< 其他 */
    LLPStdSDKResultRequestingCancel,   /**< 授权支付后取消(支付请求已发送) */
};

@protocol LLPStdSDKDelegate <NSObject>

@required

/**
 *  调用sdk以后的结果回调
 *
 *  @param resultCode 支付结果
 *  @param dic        回调的字典，参数中，ret_msg会有具体错误显示
 */
- (void)paymentEnd:(LLPStdSDKResult)resultCode withResultDic:(NSDictionary*)dic;

@optional
/**
 *  支付成功后返回的用户信息
 *
 *  @param shippingMessages 用户信息的字典，key值就是LLShippingMessageName等
 */
- (void)paymentSucceededWithShippingMessages: (NSDictionary *)shippingMessages;

@end
