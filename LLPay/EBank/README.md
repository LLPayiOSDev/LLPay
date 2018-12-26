# LLMPay/EBank

[![Version](https://img.shields.io/cocoapods/v/LLPay.svg?style=flat)](https://cocoapods.org/pods/LLPay)
[![License](https://img.shields.io/cocoapods/l/LLPay.svg?style=flat)](https://cocoapods.org/pods/LLPay)
[![Platform](https://img.shields.io/cocoapods/p/LLMPay.svg?style=flat)](https://cocoapods.org/pods/LLPay)

# 银行APP支付 iOS SDK 接入指南

> 本指南为连连支付银行APP iOS SDK 模式接入指南， 阅读对象为接入 LLPay/EBank SDK 的开发者  

## 一、场景介绍
商户APP调用连连支付提供的 iOS SDK 调用客户端的支付模块。

如果用户安装了对应银行的 APP， 商户 APP 就会跳转到安装的银行 APP 中完成支付， 支付完成后跳回商户APP 内， 最后由商户根据连连支付 SDK 的回调，处理返回的支付结果， 并展示给用户。

如果用户没有安装对应的银行APP， 会在 SDK 内启动 WAP 支付页面进行支付， 支付完成后， 由代理方法返回给商户支付结果。

**商户需要在接收到回调后调用商户服务端的订单查询接口**

## 二、SDK 文件说明

|文件名|                       说明|
|------------------           |-------------------                   |
|libLLPStdSDKCore.a            |	SDK base模块                        |
|libLLEBankPaySDK.a                  |	连连支付银行 APP 支付统一网关 iOS SDK  |
|LLEBankPaySDK.h                 |	SDK 头文件                           |
|walletResources.bundle      |  资源文件， 包含自定义 css 以及图片资源   |
|README.md                		|	连连支付银行APP支付iOS SDK接入指南|
|CHANGELOG.md                 |	更新日志                              |
|BankSDK 文件夹					|	银行 SDK（请手动集成）                |

## 三、集成连连银行APP支付 SDK

> 使用 Pod 接入

在 podfile 中加入以下代码执行 `pod install` 即可

`pod 'LLPay/EBank'`

> 直接导入工程

导入连连支付银行APP支付的静态库及相应的 LLEBankResources.bundle 文件（请勿更改 bundle 文件名）

请检查 build phases 中 是否有导入**`libLLEBankPaySDK.a`**

Copy Bundle Resources  是否有引入**`walletResources.bundle `**

## 四、导入银行 SDK

将 [BankSDK 文件夹](https://gitee.com/LLPayiOS/LLPay/tree/master/LLPay/EBank)拖入工程目录， 勾选 Copy Item If Needed 以导入银行SDK以及相应的bundle文件

请检查 build phases 中 是否有导入

* libABCAppCaller.a (农行 SDK )
* ICBCPaySDK.framework (工行 SDK )
* CCBNetPaySDK.framework （建行SDK）

Copy Bundle Resources  是否有引入

* ICBCPaySDK.bundle (工行资源包)
* CCBSDK.bundle （建行资源包）

接入**工商银行SDK**所需的第三方组件。 主要为

[XML组件](https://github.com/neonichu/GDataXML/tree/master/Sources/GDataXML)、
[base64组件](https://github.com/nicklockwood/Base64) 、
[GTM Base 64](https://github.com/r258833095/GTMBase64)、
[AFNetWorking](https://github.com/AFNetworking/AFNetworking/)、
[toast组件](https://github.com/scalessec/Toast)。

**注： 如果使用了 CocoaPods 集成， LLPay/EBank 会自动依赖 AFNetworking 3.0以上版本， 以及 Toast 4.0.0 组件， 有关XML的工程配置也会自动加上**

## 五、Xcode 配置

### 5.1 Build Setting 

**如果使用 CocoaPods， 则无需配置**

* Other linker flags  
	* 添加 **-ObjC**  解决使用LLEBankPaySDK中分类时出现的Unrecognized Selector的问题
	* 添加**-lxml2**  解决“Libxml/tree.h” file not found
* Header Search Path
	* 添加 **/usr/include/libxml2**  解决“Libxml/tree.h” file not found

### 5.2 Build Phases 

请确保导入了BankSDK文件夹

* Compile sources
	* 找到GTMBase64.m 和 GDataXmlNode.m， 点击右边的Compiler Flags 添加 **-fno-objc-arc** 以禁用ARC
	
### 5.3 Info

* Plist : Custom iOS Target Properties
* 为了调起银行的 APP ， 需要在 info.plist 中，将银行APP的Scheme添加到白名单中
* 添加 key **LSApplicationQueriesSchemes** ，Type 设置为 NSArray 类型， 并添加以下items (String)
	* mbspay    （中国建设银行）
	* bankabc   （中国农业银行）
	* com.icbc.iphoneclient   （中国工商银行）
	* cmbmobilebank   （招商银行）
	* bocpay    （中国银行）
	
```xml
<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>mbspay</string>
		<string>bankabc</string>
		<string>com.icbc.iphoneclient</string>
		<string>cmbmobilebank</string>
		<string>bocpay</string>
	</array>
```

### 5.4 URL Types

为了让银行APP在处理完交易后点击返回商户能返回商户的APP， 需要配置商户APP的 URL Schemes

* 添加 URL Schemes，设置 Identifier 为 **LLEBankScheme**, 此处需要添加三个 schemes，  建行与中行需要单独配置，每个 schemes 中间以英文逗号隔开，schemes 格式如下：
	1. schemes 格式为 ll*****
	2. schemes 格式为 comccbpay105330173990049+字母如（llebankpay）
	3. schemes 为 bocmcht

```xml
<key>CFBundleURLTypes</key>
	<array>
		<dict>
			<key>CFBundleTypeRole</key>
			<string>Editor</string>
			<key>CFBundleURLName</key>
			<string>LLEBankScheme</string>
			<key>CFBundleURLSchemes</key>
			<array>
				<string>ll201310102000003524EbankPay</string>
				<string>comccbpay105330173990049EBankPay</string>
				<string>bocmcht</string>
			</array>
		</dict>
	</array>
```
### 5.5 App Transport Security Settings

* **若 Allow Arbitrary Loads 为 NO**，请为建行 SDK 设置 ExceptionDomain
* Info.plist Open As Source Code 然后加入以下Xml代码

```xml
<dict>
		<key>NSAllowsArbitraryLoads</key>
		<false/>
		<key>NSExceptionDomains</key>
		<dict>
			<key>ccb.com.cn</key>
			<dict>
				<key>NSExceptionAllowsInsecureHTTPLoads</key>
				<true/>
				<key>NSExceptionMinimumTLSVersion</key>
				<string>TLSv1.2</string>
				<key>NSIncludesSubdomains</key>
				<true/>
				<key>NSRequiresCertificateTransparency</key>
				<true/>
				<key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
				<false/>
			</dict>
		</dict>
	</dict>	
```

## 六、代码示例

> LLEBankPaySDK调用， 需要根据接入文档组织报文， 在商户服务端签名后， 将签名值放入dic中，再调用此方法

**请务必在服务端签名！**

```objc
[LLEBankPaySDK sharedSDK].sdkDelegate = self;
[[LLEBankPaySDK sharedSDK] llEBankPayInViewController:self andPaymentInfo:dic];
```

实现代理方法， 处理SDK返回的对应信息，调用服务端结果轮询接口，并将结果展示给用户:

```objc
- (void)paymentEnd:(LLPayResult)resultCode withResultDic:(NSDictionary *)dic {
    //根据resultCode和dic中的ret_code与ret_msg作相应的处理
}
```

**支付完成后请务必发起订单结果轮询， 确认支付结果，包括非正常返回情况**

> 回调处理  


需要根据iOS版本在APP Delegate中加入以下代码：

```objc
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [LLEBankPaySDK handleOpenURL:url];
}

///iOS 9 later
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return [LLEBankPaySDK handleOpenURL:url];
}
```


## 七、SDK返回码说明

|返回码|说明|
|-----|-----|
|  LE0000  |  用户操作完成，请通过轮询查询方式获取订单支付结果  |
|	LE0001	|   用户中途取消支付操作|
|  LE0002  |  交易在WAP中处理完成  |  
|  LE0003  |  交易在APP中处理完成  |  
|  LE0011  |  交易异常，该SDK并未支持此手机银行  |  
|  LE0012  |  商户请求参数校验错误[%s]  |
|  LE1022  |  该银行渠道暂不支持！  |  
|  LE1001  |  支付处理失败! |  

**请注意，支付完成后必须通过订单查询接口查询订单结果，LE1001支付处理失败也可能是因为没有导入银行的SDK**

## 注意事项
* 本SDK最低支持 iOS 7.0
* 工行SDK暂不支持bitcode

## Author

LLPayiOSDev, iosdev@yintong.com.cn

## License

© 2003-2018 Lianlian Yintong Electronic Payment Co., Ltd. All rights reserved.

