Pod::Spec.new do |s|
  s.name             = 'LLPay'
  s.version          = '2.7.9'
  s.summary          = '连连支付标准版SDK，LianLian Pay Standard SDK'
  s.description      = <<-DESC
LLPay 是一个支持认证、快捷、分期付,银行APP支付等支付方式的SDK， 为商户提供内嵌于APP的支付功能。
                       DESC

  s.homepage         = 'https://gitee.com/LLPayiOS/LLPay'
  s.license          = { :type => 'Copyright', :text => '© 2003-2019 Lianlian Yintong Electronic Payment Co., Ltd. All rights reserved.' }
  s.author           = { 'LLPayiOSDev' => 'iosdev@lianlianpay.com' }
  s.source           = { :git => 'https://gitee.com/LLPayiOS/LLPay.git', :tag => s.version.to_s }
  s.platform = :ios
  s.ios.deployment_target = '7.0'
  s.requires_arc = true
  s.default_subspecs = 'Pay'
  
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
      es.dependency 'LLMPay/ICBC'
  end
  
end
