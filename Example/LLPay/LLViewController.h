//
//  LLViewController.h
//  LLPay
//
//  Created by LLPayiOSDev on 04/25/2018.
//  Copyright (c) 2018 LLPayiOSDev. All rights reserved.
//

@import UIKit;
#import <LLPay/LLPaySdk.h>
#import "LLPayUtil.h"
#import "LLPayTool.h"

CGFloat margin = 20;
CGFloat itemHeight = 100;
CGFloat corner = 6;
#define width ([UIScreen mainScreen].bounds.size.width - 2 * margin)
#define height ([UIScreen mainScreen].bounds.size.height)
#define LLColor ([UIColor colorWithRed:0 green:160 / 255.0 blue:233 / 255.0 alpha:1])

@interface LLViewController : UIViewController <LLPaySdkDelegate>

@property (nonatomic, strong) LLPayUtil* signUtil;

@end
