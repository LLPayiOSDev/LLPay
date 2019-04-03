Pod::Spec.new do |s|
  s.name             = 'LLPay'
  s.version          = '2.7.7'
  s.summary          = 'LianLian Pay Standard Payment SDK'
  s.description      = <<-DESC
LLPay 是一个支持认证、快捷、分期付,银行APP支付等支付方式的SDK， 为商户提供内嵌于APP的支付功能。
                       DESC

  s.homepage         = 'https://gitee.com/LLPayiOS/LLPay'
  s.license          = { :type => 'Copyright', :text => '© 2003-2018 Lianlian Yintong Electronic Payment Co., Ltd. All rights reserved.' }
  s.author           = { 'LLPayiOSDev' => 'iosdev@yintong.com.cn' }
  s.source           = { :git => 'https://gitee.com/LLPayiOS/LLPay.git', :tag => s.version.to_s }
  s.platform = :ios
  s.ios.deployment_target = '7.0'
  s.requires_arc = true
  #s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  s.default_subspecs = 'Pay'
  #s.source_files = 'LLPay/**/*.{h,m}'
  #s.public_header_files = 'LLPay/**/*.h'
  #s.ios.vendored_library = 'LLPay/*.a'
  #s.resource = 'LLPay/Assets/walletResources.bundle'
  
  s.subspec 'Core' do |cs|
      cs.vendored_library = 'LLPay/Core/*.a'
      cs.public_header_files = 'LLPay/Core/*.h'
      cs.source_files = 'LLPay/Core/*.h'
      cs.xcconfig = { 'OTHER_LDFLAGS' => '-lObjC'}
  end
  
  s.subspec 'Pay' do |ps|
      ps.vendored_library = 'LLPay/Pay/*.a'
      ps.public_header_files = 'LLPay/Pay/*.h'
      ps.dependency 'LLPay/Core'
      ps.resource = 'LLPay/walletResources.bundle'
      ps.source_files = 'LLPay/Pay/*.h'
  end
  
  s.subspec 'EBank' do |es|
      es.vendored_library = 'LLPay/EBank/*.a'
      es.public_header_files = 'LLPay/EBank/*.h'
      es.dependency 'LLPay/Core'
      es.source_files = 'LLPay/EBank/*.h'
      es.resource = 'LLPay/walletResources.bundle'
      #ICBC Dependency
      es.dependency 'AFNetworking','~>3.0'
      es.dependency 'Toast'
      es.xcconfig = {'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2'}
      es.libraries = 'xml2'
  end
  
end
