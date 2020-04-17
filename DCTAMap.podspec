
Pod::Spec.new do |spec|
  
  spec.name         = "DCTAMap"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For 地图封装."
  spec.description  = <<-DESC
  DCTAMap一个是地图封装
  DESC
  
  spec.homepage     = "https://github.com/StoneStoneStoneWang/DCTKit.git"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  
  spec.swift_version = '5.0'
  
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  spec.static_framework = true
  
  spec.frameworks = 'UIKit', 'Foundation' ,'CoreLoDCTion'
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/DCTKit.git", :tag => "#{spec.version}" }
  
  spec.vendored_frameworks = 'Framework/DCTAMap/DCTAMap.framework'
  spec.dependency 'AMapLocattion-NO-IDFA'
  spec.dependency 'AMap2DMap-NO-IDFA'
  spec.dependency 'AMapSearch-NO-IDFA'
  
  spec.pod_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
  
  spec.user_target_xcconfig   = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
  
end


