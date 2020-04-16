Pod::Spec.new do |spec|
  
  spec.name         = "DCTContainer"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For 某些界面."
  spec.description  = <<-DESC
  DCTContainer是欢迎界面
  DESC
  
  spec.homepage     = "https://github.com/StoneStoneStoneWang/DCTKit.git"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  
  spec.swift_version = '5.0'
  
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  spec.static_framework = true
  
  spec.frameworks = 'UIKit', 'Foundation'
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/DCTKit.git", :tag => "#{spec.version}" }
  
  # 翻译
  spec.subspec 'Welcome' do |welcome|
    
    welcome.source_files = "Code/DCTContainer/Welcome/*.{h,m}"
    welcome.dependency 'DCTConfig'
    welcome.dependency 'DCTBridge/Welcome/Bridge'
    welcome.dependency 'SToolsKit'
    welcome.dependency 'Masonry'
  end
  
  # 协议 textview
  spec.subspec 'Protocol' do |protocol|
    
    protocol.source_files = "Code/DCTContainer/Protocol/*.{h,m}"
    protocol.dependency 'DCTConfig'
    protocol.dependency 'DCTBridge/Protocol/Bridge'
    protocol.dependency 'SToolsKit'
    protocol.dependency 'Masonry'
  end
  # 协议 webview
  spec.subspec 'Privacy' do |privacy|
    
    privacy.source_files = "Code/DCTContainer/Privacy/*.{h,m}"
    privacy.dependency 'DCTConfig'
    privacy.dependency 'DCTBridge/Protocol/Bridge'
    privacy.dependency 'SToolsKit'
    privacy.dependency 'Masonry'
  end
  
  # 登陆 login
  spec.subspec 'Login' do |login|
    
    login.source_files = "Code/DCTContainer/Login/*.{h,m}"
    login.dependency 'DCTConfig'
    login.dependency 'DCTBridge/Login/Bridge'
    login.dependency 'Masonry'
    login.dependency 'DCTTextField'
    login.dependency 'DCTTransition'
  end
  
  # 注册 reg
  spec.subspec 'Reg' do |reg|
    
    reg.source_files = "Code/DCTContainer/Reg/*.{h,m}"
    reg.dependency 'DCTConfig'
    reg.dependency 'DCTBridge/Reg/Bridge'
    reg.dependency 'Masonry'
    reg.dependency 'DCTTextField'
    reg.dependency 'DCTTransition'
  end
  
  # 密码 password
  spec.subspec 'Password' do |password|
    
    password.source_files = "Code/DCTContainer/Password/*.{h,m}"
    password.dependency 'DCTConfig'
    password.dependency 'DCTBridge/Password/Bridge'
    password.dependency 'Masonry'
    password.dependency 'DCTTextField'
    password.dependency 'DCTTransition'
  end
  
  # 轮播 carousel
  spec.subspec 'Carousel' do |carousel|
    
    carousel.source_files = "Code/DCTContainer/Carousel/*.{h,m}"
    carousel.dependency 'DCTConfig'
    carousel.dependency 'DCTBridge/Carousel/Bridge'
    carousel.dependency 'Masonry'
    carousel.dependency 'DCTCollection'
  end
  
  # 轮播 banner
  spec.subspec 'Banner' do |banner|
    
    banner.source_files = "Code/DCTContainer/Banner/*.{h,m}"
    banner.dependency 'DCTConfig'
    banner.dependency 'DCTBridge/Carousel/Bridge'
    banner.dependency 'Masonry'
    banner.dependency 'DCTCollection'
    banner.dependency 'SDWebImage'
  end
  
  # 设置 setting
  spec.subspec 'Setting' do |setting|
    
    setting.source_files = "Code/DCTContainer/Setting/*.{h,m}"
    setting.dependency 'DCTConfig'
    setting.dependency 'DCTBridge/Setting/Bridge'
    setting.dependency 'Masonry'
    setting.dependency 'DCTTable'
    setting.dependency 'SDWebImage'
  end
  
  # 关于我们 about
  spec.subspec 'About' do |about|
    
    about.source_files = "Code/DCTContainer/About/*.{h,m}"
    about.dependency 'DCTConfig'
    about.dependency 'DCTBridge/About/Bridge'
    about.dependency 'Masonry'
    about.dependency 'DCTTable'
  end
  
  # 意见建议 feedBack
  spec.subspec 'FeedBack' do |feedBack|
    
    feedBack.source_files = "Code/DCTContainer/FeedBack/*.{h,m}"
    feedBack.dependency 'DCTConfig'
    feedBack.dependency 'DCTBridge/FeedBack/Bridge'
    feedBack.dependency 'Masonry'
    feedBack.dependency 'DCTTransition'
    feedBack.dependency 'JXTAlertManager'
    feedBack.dependency 'DCTTextField'
  end
  
  # 昵称 Name
  spec.subspec 'Name' do |name|
    
    name.source_files = "Code/DCTContainer/Name/*.{h,m}"
    name.dependency 'DCTConfig'
    name.dependency 'DCTBridge/Name/Bridge'
    name.dependency 'Masonry'
    name.dependency 'DCTTextField'
    name.dependency 'DCTTransition'
  end
  
  # 个性签名 signature
  spec.subspec 'Signature' do |signature|
    
    signature.source_files = "Code/DCTContainer/Signature/*.{h,m}"
    signature.dependency 'DCTConfig'
    signature.dependency 'DCTBridge/Signature/Bridge'
    signature.dependency 'Masonry'
    signature.dependency 'DCTTransition'
  end
  
  # 个人中心 userinfo
  spec.subspec 'UserInfo' do |userInfo|
    userInfo.frameworks = 'UIKit', 'Foundation','CoreServices'
    userInfo.source_files = "Code/DCTContainer/UserInfo/*.{h,m}"
    userInfo.dependency 'DCTConfig'
    userInfo.dependency 'DCTBridge/UserInfo/Bridge'
    userInfo.dependency 'Masonry'
    userInfo.dependency 'DCTTable'
    userInfo.dependency 'ZDatePicker'
    userInfo.dependency 'SDWebImage'
    userInfo.dependency 'JXTAlertManager'
    userInfo.dependency 'WLToolsKit/Image'
  end
  
  # 意见建议 feedBack
  spec.subspec 'FeedBack' do |feedBack|
    
    feedBack.source_files = "Code/DCTContainer/FeedBack/*.{h,m}"
    feedBack.dependency 'DCTConfig'
    feedBack.dependency 'DCTBridge/FeedBack/Bridge'
    feedBack.dependency 'Masonry'
    feedBack.dependency 'DCTTransition'
    feedBack.dependency 'JXTAlertManager'
    feedBack.dependency 'DCTTextField'
  end
  
  #  # 黑名单 black
  #  spec.subspec 'Black' do |black|
  #
  #    black.source_files = "Code/DCTContainer/Black/*.{h,m}"
  #    black.dependency 'DCTConfig'
  #    black.dependency 'DCTBridge/Black/Bridge'
  #    black.dependency 'Masonry'
  #    black.dependency 'DCTTable'
  #    black.dependency 'SDWebImage'
  #    black.dependency 'JXTAlertManager'
  #  end
  #  # 关注 focus
  #  spec.subspec 'Focus' do |focus|
  #
  #    focus.source_files = "Code/DCTContainer/Focus/*.{h,m}"
  #    focus.dependency 'DCTConfig'
  #    focus.dependency 'DCTBridge/Focus/Bridge'
  #    focus.dependency 'Masonry'
  #    focus.dependency 'DCTTable'
  #    focus.dependency 'SDWebImage'
  #    focus.dependency 'JXTAlertManager'
  #  end
  
  # 举报 举报
    spec.subspec 'Report' do |report|
  
      report.source_files = "Code/DCTContainer/Report/*.{h,m}"
      report.dependency 'DCTConfig'
      report.dependency 'DCTBridge/Report/Bridge'
      report.dependency 'Masonry'
      report.dependency 'DCTTable'
      report.dependency 'JXTAlertManager'
    end
  
  
  # 地址 address
  spec.subspec 'Address' do |address|
    
    address.source_files = "Code/DCTContainer/Address/*.{h,m}"
    address.dependency 'DCTConfig'
    address.dependency 'DCTBridge/Address/Bridge'
    address.dependency 'Masonry'
    address.dependency 'DCTTable'
    address.dependency 'JXTAlertManager'
  end
  # 地址 area
  spec.subspec 'Area' do |area|
    
    area.source_files = "Code/DCTContainer/Area/*.{h,m}"
    area.dependency 'DCTConfig'
    area.dependency 'DCTBridge/Area/Bridge'
    area.dependency 'Masonry'
    area.dependency 'DCTTable'
    area.dependency 'DCTCollection'
    area.dependency 'JXTAlertManager'
  end
  
  # 地址 地图
  spec.subspec 'Map' do |map|
    map.source_files = "Code/DCTContainer/Map/*.{h,m}"
    map.dependency 'DCTTransition'
    map.dependency 'DCTAMap'
    map.dependency 'DCTConfig'
    map.dependency 'SToolsKit'
    map.frameworks = 'UIKit', 'Foundation' ,'CoreLoDCTion'
  end
  
end
