//
//  ABCAppCaller.h
//  ABCAppCaller

//  Created by sam on 16/11/9.
//  Copyright © 2016年 ABC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ABCAppCaller : NSObject<UIApplicationDelegate>{

}

-(BOOL) isABCePayAvailable:(NSString *)url;
-(void)callBankABC:(NSString *)url param:(NSString*)param;
- (NSString *)decryptString:(NSString *)str;
+ (ABCAppCaller *)sharedAppCaller;

@end
