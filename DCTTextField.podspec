Pod::Spec.new do |spec|
  
  spec.name         = "DCTTextField"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For textfield."
  spec.description  = <<-DESC
  DCTTextField是地图
  DESC
  
  spec.homepage     = "https://github.com/StoneStoneStoneWang/ZStoreKit.git"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  
  spec.swift_version = '5.0'
  
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  spec.static_framework = true
  
  spec.frameworks = 'UIKit', 'Foundation'
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/ZStoreKit.git", :tag => "#{spec.version}" }
  
  spec.subspec 'Setting' do |setting|
    setting.source_files = "Code/DCTTextField/Setting/*.{swift}"
  end
  spec.subspec 'Base' do |base|
    base.source_files = "Code/DCTTextField/Base/*.{swift}"
    base.dependency 'WLToolsKit/Then'
    base.dependency 'DCTTextField/Setting'
  end
  
  spec.subspec 'LeftTitle' do |leftTitle|
    leftTitle.source_files = "Code/DCTTextField/LeftTitle/*.{swift}"
    leftTitle.dependency 'DCTTextField/Base'
    leftTitle.dependency 'WLToolsKit/Color'
  end
  spec.subspec 'LeftImage' do |leftImage|
    leftImage.source_files = "Code/DCTTextField/LeftImg/*.{swift}"
    leftImage.dependency 'DCTTextField/Base'
  end
  spec.subspec 'NickName' do |nickName|
    nickName.source_files = "Code/DCTTextField/NickName/*.{swift}"
    nickName.dependency 'DCTTextField/Base'
  end
  
  spec.subspec 'Password' do |password|
    password.source_files = "Code/DCTTextField/Password/*.{swift}"
    password.dependency 'DCTTextField/LeftImage'
    password.dependency 'DCTTextField/LeftTitle'
  end
  
  spec.subspec 'Vcode' do |vcode|
    vcode.source_files = "Code/DCTTextField/Vcode/*.{swift}"
    vcode.dependency 'DCTTextField/LeftImage'
    vcode.dependency 'DCTTextField/LeftTitle'
  end
  
end
