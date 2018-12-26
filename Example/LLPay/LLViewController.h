//
//  LLViewController.h
//  LLPay
//
//  Created by LLPayiOSDev on 04/25/2018.
//  Copyright (c) 2018 LianLian Pay. All rights reserved.
//

@import UIKit;
#import <LLPay/LLPaySdk.h>
#import "LLPayUtil.h"
#import "LLPayTool.h"

#define width ([UIScreen mainScreen].bounds.size.width - 2 * margin)
#define height ([UIScreen mainScreen].bounds.size.height)
#define LLColor (LLHexColor(0x00a0e9))
CGFloat margin = 20;
CGFloat itemHeight = 75;
CGFloat corner = 6;

@interface LLViewController : UIViewController <LLPStdSDKDelegate>

@property (nonatomic, strong) LLPayUtil *signUtil;

@end
