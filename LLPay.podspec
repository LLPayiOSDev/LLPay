Pod::Spec.new do |s|
  s.name             = 'LLPay'
  s.version          = '2.7.2'
  s.summary          = 'LianLian Pay Standard Payment SDK'
  s.description      = <<-DESC
LLPay 是一个支持认证、快捷、分期付等支付方式的SDK， 为商户提供内嵌于APP的支付功能。
                       DESC

  s.homepage         = 'https://github.com/LLPayiOSDev/LLPay'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LLPayiOSDev' => 'iosdev@yintong.com.cn' }
  s.source           = { :git => 'https://github.com/LLPayiOSDev/LLPay.git', :tag => s.version.to_s }
  s.platform = :ios
  s.ios.deployment_target = '7.0'
  s.requires_arc = true
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  s.source_files = 'LLPay/**/*.{h,m}'
  s.public_header_files = 'LLPay/**/*.h'
  s.ios.vendored_library = 'LLPay/*.a'
  s.resource = 'LLPay/Assets/walletResources.bundle'
end
