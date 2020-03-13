# LLPay

[![Version](https://img.shields.io/cocoapods/v/LLPay.svg?style=flat)](https://cocoapods.org/pods/LLPay)
[![License](https://img.shields.io/cocoapods/l/LLPay.svg?style=flat)](https://cocoapods.org/pods/LLPay)
[![Platform](https://img.shields.io/cocoapods/p/LLPay.svg?style=flat)](https://cocoapods.org/pods/LLPay)

> 银行APP支付SDK接入说明请点击[银行APP支付SDK接入指南](./LLPay/EBank)

## 如何安装

LLPay is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'LLPay'
```

## 如何调用
- 导入SDK头文件

```
#import <LLPay/LLPaySdk.h>
```

- 设置SDK代理

```objc
[LLPaySdk sharedSdk].sdkDelegate = self;
```
> 如果设置代理为一个支付model， 请保证这个modle在支付过程中不会销毁，以防程序崩溃

- 调用SDK,如认证支付

```objc
[[LLPaySdk sharedSdk] presentLLPaySDKInViewController:self withPayType:LLPayTypeVerify andTraderInfo:traderInfo];
```

## 页面自定义
> LLPay iOS SDK可以通过修改资源bundle进行定制

1. 图片的替换，在内部的图片可以替换修改为自己的样式
2. 颜色等的修改，可以修改default.css文件，支持#abcdef，123,123,123两种颜色表示, 连连的主色调是#00a0e9 , 如需更换可替换成商户自己的主色调，请注意更换高亮颜色
3. 修改值意义列表

|修改的对象    |修改方法|
|--------    |-------|
|导航栏颜色    |替换ll_nav_bg3.png文件，以及修改css文件中NavBar字段（后面只表示字段，都是在default.css文件中）中的background-color|
|标题|CusTitle字段， 暂时只能定义首次支付界面与Alert标题|

## 常见问题
- 商户APPID未报备
	- 请联系连连对接人员， 需要填表报备 APP BundleID

- 商户签名验证失败
	- 确认公私钥配置是否正确
	- 确认签名原串是否一致（特别是risk_item字符串顺序）
	
- 商户无此支付产品权限
	- 检查商户号是否是正确的商户号，然后检查所对应的包、调用方法以及传入参数是否正确。

- 商户无此支付权限
	- 请检查商户号对应的业务类型是否正确



## Author

LLPayiOSDev, iosdev@lianlianpay.com

## License

© 2003-2020 Lianlian Yintong Electronic Payment Co., Ltd. All rights reserved.
