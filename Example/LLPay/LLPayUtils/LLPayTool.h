//
//  LLPayTool.h
//  LLPayDemo
//
//  Created by EvenLam on 2017/11/22.
//  Copyright © 2017年 LianLianPay Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LLHexColor(rgbValue)                                                                                                     \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0                                                         \
                    green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0                                                            \
                     blue:((float)(rgbValue & 0xFF)) / 255.0                                                                     \
                    alpha:1.0]

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
