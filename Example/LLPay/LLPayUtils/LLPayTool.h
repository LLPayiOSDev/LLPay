//
//  LLPayTool.h
//  LLPayDemo
//
//  Created by EvenLam on 2017/11/22.
//  Copyright © 2017年 LianLianPay Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLPayTool : NSObject


/**
 时间戳

 @return 时间戳
 */
+ (NSString *)timeStamp;

/**
 生成订单号
 
 @return 订单号
 */
+ (NSString *)generateTradeNO;

@end
