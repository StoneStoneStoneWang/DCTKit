Pod::Spec.new do |spec|
  
  spec.name         = "DCTBridge"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For bridge."
  spec.description  = <<-DESC
  DCTBridge是oc swift 转换的封装呢
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
  
  spec.subspec 'Base' do |base|
    base.source_files = "Code/DCTBridge/Base/*.{swift}"
    base.dependency 'RxSwift'
  end
  
  #欢迎界面
  spec.subspec 'Welcome' do |welcome|
    
    welcome.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/Welcome/VM/*.{swift}"
      vm.dependency 'WLToolsKit/Common'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
    end
    
    welcome.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Welcome/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Welcome/VM'
      bridge.dependency 'DCTCollection'
      bridge.dependency 'DCTCocoa/SM'
      bridge.dependency 'DCTCocoa/Button'
      bridge.dependency 'DCTBridge/Base'
    end
  end
  
  # 协议
  spec.subspec 'Protocol' do |protocol|
    
    protocol.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/Protocol/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'DCTSign'
    end
    
    protocol.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Protocol/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Protocol/VM'
      bridge.dependency 'DCTTextInner'
      bridge.dependency 'DCTBridge/Base'
    end
  end
  # 协议
  spec.subspec 'Privacy' do |privacy|
    
    privacy.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/Privacy/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'DCTSign'
    end
    
    privacy.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Privacy/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Privacy/VM'
      bridge.dependency 'DCTInner'
      bridge.dependency 'DCTBridge/Base'
      
    end
  end
  
  # 登陆
  spec.subspec 'Login' do |login|
    
    login.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/Login/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'DCTCheck'
      vm.dependency 'DCTRReq'
      vm.dependency 'DCTApi'
    end
    
    login.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Login/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Login/VM'
      bridge.dependency 'DCTHud'
      bridge.dependency 'DCTBase'
      bridge.dependency 'DCTBridge/Base'
    end
  end
  
  # 注册/登陆
  spec.subspec 'Reg' do |reg|
    
    reg.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/Reg/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'DCTCheck'
      vm.dependency 'DCTRReq'
      vm.dependency 'DCTApi'
    end
    
    reg.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Reg/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Reg/VM'
      bridge.dependency 'DCTCocoa/Button'
      bridge.dependency 'DCTHud'
      bridge.dependency 'DCTBase'
      bridge.dependency 'DCTBridge/Base'
    end
  end
  
  # 密码
  spec.subspec 'Password' do |password|
    
    password.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/Password/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'DCTCheck'
      vm.dependency 'DCTRReq'
      vm.dependency 'DCTApi'
    end
    
    password.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Password/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Password/VM'
      bridge.dependency 'DCTCocoa/Button'
      bridge.dependency 'DCTHud'
      bridge.dependency 'DCTBase'
      bridge.dependency 'DCTBridge/Base'
    end
  end
  
  # 设置
  spec.subspec 'Setting' do |setting|
    
    setting.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/Setting/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'DCTCache/Account'
      vm.dependency 'DCTSign'
    end
    
    setting.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Setting/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Setting/VM'
      bridge.dependency 'DCTTable'
      bridge.dependency 'DCTCocoa/SM'
      bridge.dependency 'RxDataSources'
      bridge.dependency 'DCTBridge/Base'
    end
  end
  
  # 关于我们
  spec.subspec 'About' do |about|
    
    about.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/About/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLToolsKit/String'
    end
    
    about.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/About/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/About/VM'
      bridge.dependency 'DCTTable'
      bridge.dependency 'DCTCocoa/SM'
      bridge.dependency 'RxDataSources'
      bridge.dependency 'DCTBridge/Base'
    end
  end
  # 昵称
  spec.subspec 'Name' do |name|
    
    name.subspec 'VM' do |vm|
      
      vm.source_files = "Code/DCTBridge/Name/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'DCTCache/User'
      vm.dependency 'DCTRReq'
      vm.dependency 'DCTApi'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
    end
    
    name.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Name/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Name/VM'
      bridge.dependency 'DCTHud'
      bridge.dependency 'DCTBase'
      bridge.dependency 'DCTBridge/Base'
    end
  end
  # 个性签名
  spec.subspec 'Signature' do |signature|
    
    signature.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/Signature/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'DCTCache/User'
      vm.dependency 'DCTRReq'
      vm.dependency 'DCTApi'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
    end
    
    signature.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Signature/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Signature/VM'
      bridge.dependency 'DCTHud'
      bridge.dependency 'DCTBase'
      bridge.dependency 'DCTBridge/Base'
    end
  end
  
  # 我的资料
  spec.subspec 'UserInfo' do |userinfo|
    
    userinfo.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/UserInfo/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
      vm.dependency 'DCTCache/User'
      vm.dependency 'DCTApi'
      vm.dependency 'DCTRReq'
    end
    
    userinfo.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/UserInfo/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/UserInfo/VM'
      bridge.dependency 'DCTTable'
      bridge.dependency 'DCTCocoa/SM'
      bridge.dependency 'RxDataSources'
      bridge.dependency 'DCTHud'
      bridge.dependency 'DCTBridge/Base'
    end
  end
  
  # 评论
  spec.subspec 'Comment' do |comment|
    
    comment.subspec 'VM' do |vm|
      
      vm.source_files = "Code/DCTBridge/Comment/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'DCTRReq'
      vm.dependency 'DCTApi'
      vm.dependency 'DCTBean/Comment'
      vm.dependency 'WLBaseResult'
      vm.dependency 'WLBaseViewModel'
    end
    
    comment.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Comment/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Comment/VM'
      bridge.dependency 'DCTHud'
      bridge.dependency 'DCTTable'
      bridge.dependency 'DCTCocoa/ASM'
      bridge.dependency 'DCTCocoa/Refresh'
      bridge.dependency 'DCTBridge/Base'
    end
  end
  # 举报
  spec.subspec 'Report' do |report|
    
    report.subspec 'VM' do |vm|
      
      vm.source_files = "Code/DCTBridge/Report/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'ObjectMapper'
      vm.dependency 'RxDataSources'
      vm.dependency 'DCTApi'
      vm.dependency 'DCTRReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'WLBaseViewModel'
    end
    
    report.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Report/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Report/VM'
      bridge.dependency 'DCTTable'
      bridge.dependency 'DCTCocoa/SM'
      bridge.dependency 'RxDataSources'
      bridge.dependency 'DCTBridge/Base'
      bridge.dependency 'DCTHud'
    end
  end
  
  # 黑名单
  spec.subspec 'Black' do |black|
    
    black.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/Black/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'DCTBean/Black'
      vm.dependency 'DCTRReq'
      vm.dependency 'DCTApi'
      vm.dependency 'WLBaseResult'
    end
    
    black.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Black/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Black/VM'
      bridge.dependency 'DCTHud'
      bridge.dependency 'DCTTable'
      bridge.dependency 'DCTCocoa/ASM'
      bridge.dependency 'DCTCocoa/Refresh'
      bridge.dependency 'DCTBridge/Base'
    end
  end
  # 我的关注
  spec.subspec 'Focus' do |focus|
    
    focus.subspec 'VM' do |vm|
      
      vm.source_files = "Code/DCTBridge/Focus/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'DCTBean/Focus'
      vm.dependency 'DCTRReq'
      vm.dependency 'DCTApi'
      vm.dependency 'WLBaseResult'
    end
    
    focus.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Focus/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Focus/VM'
      bridge.dependency 'DCTHud'
      bridge.dependency 'DCTTable'
      bridge.dependency 'DCTCocoa/ASM'
      bridge.dependency 'DCTCocoa/Refresh'
      bridge.dependency 'DCTBridge/Base'
    end
  end
  
  # 翻译
  spec.subspec 'Translate' do |translate|
    
    translate.subspec 'VM' do |vm|
      
      vm.source_files = "Code/DCTBridge/Translate/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ObjectMapper'
      vm.dependency 'DCTApi'
      vm.dependency 'DCTRReq'
      vm.dependency 'WLBaseResult'
    end
    
    translate.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Translate/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Translate/VM'
      bridge.dependency 'DCTTransition'
      bridge.dependency 'DCTBridge/Base'
      bridge.dependency 'DCTHud'
    end
  end
  
  spec.subspec 'Video' do |video|
    
    video.subspec 'VM' do |vm|
      
      vm.source_files = "Code/DCTBridge/Video/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'DCTApi'
      vm.dependency 'DCTRReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'WLBaseViewModel'
    end
    
    video.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Video/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Video/VM'
      bridge.dependency 'DCTTransition'
      bridge.dependency 'DCTCache/Account'
      bridge.dependency 'DCTBridge/Base'
      bridge.dependency 'DCTHud'
    end
  end
  
  spec.subspec 'Profile' do |profile|
    
    profile.subspec 'VM' do |vm|
      
      vm.source_files = "Code/DCTBridge/Profile/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'DCTApi'
      vm.dependency 'DCTRReq'
      vm.dependency 'DCTCache/User'
      vm.dependency 'WLBaseResult'
      vm.dependency 'WLBaseViewModel'
    end
    
    profile.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Profile/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Profile/VM'
      bridge.dependency 'DCTTable'
      bridge.dependency 'DCTCache/Account'
      bridge.dependency 'DCTBridge/Base'
      bridge.dependency 'RxGesture'
      bridge.dependency 'DCTCocoa/SM'
    end
  end
  spec.subspec 'UserCenter' do |userCenter|
    
    userCenter.subspec 'VM' do |vm|
      
      vm.source_files = "Code/DCTBridge/UserCenter/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'DCTApi'
      vm.dependency 'DCTRReq'
      vm.dependency 'DCTCache/User'
      vm.dependency 'WLBaseResult'
      vm.dependency 'WLBaseViewModel'
    end
    
    userCenter.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/UserCenter/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/UserCenter/VM'
      bridge.dependency 'DCTCollection'
      bridge.dependency 'DCTCache/Account'
      bridge.dependency 'DCTBridge/Base'
      bridge.dependency 'RxGesture'
      bridge.dependency 'DCTCocoa/SM'
    end
  end
  # 个性签名
  spec.subspec 'FeedBack' do |feedBack|
    
    feedBack.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/FeedBack/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'DCTRReq'
      vm.dependency 'DCTApi'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
    end
    
    feedBack.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/FeedBack/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/FeedBack/VM'
      bridge.dependency 'DCTHud'
      bridge.dependency 'DCTBase'
      bridge.dependency 'DCTBridge/Base'
    end
  end
  
  # 评论 comment
  spec.subspec 'Comment' do |comment|
    
    comment.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/Comment/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'DCTBean/Comment'
      vm.dependency 'DCTRReq'
      vm.dependency 'DCTApi'
      vm.dependency 'WLBaseResult'
    end
    
    comment.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Comment/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Comment/VM'
      bridge.dependency 'DCTHud'
      bridge.dependency 'DCTTable'
      bridge.dependency 'DCTBean/Circle'
      bridge.dependency 'DCTCocoa/ASM'
      bridge.dependency 'DCTCocoa/Refresh'
      bridge.dependency 'DCTBridge/Base'
    end
  end
  
  # Collections 列表
  spec.subspec 'Collections' do |collections|
    
    collections.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/Collections/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'DCTBean/Circle'
      vm.dependency 'DCTRReq'
      vm.dependency 'DCTApi'
      vm.dependency 'WLBaseResult'
    end
    
    collections.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Collections/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Collections/VM'
      bridge.dependency 'DCTHud'
      bridge.dependency 'DCTCollection'
      bridge.dependency 'DCTCocoa/ASM'
      bridge.dependency 'DCTCocoa/Refresh'
      bridge.dependency 'DCTBridge/Base'
      bridge.dependency 'DCTCache/Account'
    end
  end
  
  # 黑名单
  spec.subspec 'Tables' do |tables|
    
    tables.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/Tables/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'DCTBean/Circle'
      vm.dependency 'DCTRReq'
      vm.dependency 'DCTApi'
      vm.dependency 'WLBaseResult'
    end
    
    tables.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Tables/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Tables/VM'
      bridge.dependency 'DCTHud'
      bridge.dependency 'DCTTable'
      bridge.dependency 'DCTCocoa/ASM'
      bridge.dependency 'DCTCocoa/Refresh'
      bridge.dependency 'DCTBridge/Base'
      bridge.dependency 'DCTCache/Account'
    end
  end
  
  # 轮播
  spec.subspec 'Carousel' do |welcome|
    
    welcome.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/Carousel/VM/*.{swift}"
      vm.dependency 'WLToolsKit/Common'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
      vm.dependency 'ObjectMapper'
    end
    
    welcome.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Carousel/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Carousel/VM'
      bridge.dependency 'DCTCollection'
      bridge.dependency 'DCTCocoa/SM'
      bridge.dependency 'DCTBridge/Base'
      bridge.dependency 'RxDataSources'
    end
  end
  
  # 1
  spec.subspec 'CollectionSection' do |cs|
    
    cs.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/CollectionSection/VM/*.{swift}"
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
    end
    
    cs.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/CollectionSection/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/CollectionSection/VM'
      bridge.dependency 'DCTCollection'
      bridge.dependency 'DCTCocoa/SM'
      bridge.dependency 'DCTBridge/Base'
      bridge.dependency 'RxDataSources'
    end
  end
  
  # 2
  spec.subspec 'TableSection' do |cs|
    
    cs.subspec 'VM' do |vm|
      vm.source_files = "Code/DCTBridge/TableSection/VM/*.{swift}"
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
    end
    
    cs.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/TableSection/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/TableSection/VM'
      bridge.dependency 'DCTTable'
      bridge.dependency 'DCTCocoa/SM'
      bridge.dependency 'DCTBridge/Base'
      bridge.dependency 'RxDataSources'
    end
  end
  
  spec.subspec 'Area' do |area|
    
    area.subspec 'Manager' do |manager|
      
      manager.source_files = "Code/DCTBridge/Area/Manager/*.{swift}"
      manager.dependency 'RxCocoa'
      manager.dependency 'WLBaseViewModel'
      manager.dependency 'DCTApi'
      manager.dependency 'DCTRReq'
      manager.dependency 'WLBaseResult'
      manager.dependency 'DCTYY'
      manager.dependency 'DCTBean/Area'
      manager.dependency 'DCTRReq'
    end
    area.subspec 'VM' do |vm|
      
      vm.source_files = "Code/DCTBridge/Area/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
      vm.dependency 'DCTBean/Area'
    end
    
    area.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Area/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Area/VM'
      bridge.dependency 'DCTBridge/Area/Manager'
      bridge.dependency 'DCTTable'
      bridge.dependency 'DCTCollection'
      bridge.dependency 'DCTBridge/Base'
      bridge.dependency 'DCTCocoa/SM'
    end
  end
  
  spec.subspec 'AreaJson' do |areaJson|
    
    areaJson.source_files = "Code/DCTBridge/AreaJson/*.{swift}"
  end
  
  spec.subspec 'Address' do |address|
    
    address.subspec 'VM' do |vm|
      
      vm.source_files = "Code/DCTBridge/Address/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ObjectMapper'
      vm.dependency 'DCTApi'
      vm.dependency 'DCTRReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'DCTBean/Area'
      vm.dependency 'DCTBean/Address'
      vm.dependency 'WLToolsKit/String'
      
    end
    
    address.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Address/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Address/VM'
      bridge.dependency 'DCTTable'
      bridge.dependency 'DCTBridge/Base'
      bridge.dependency 'DCTHud'
      bridge.dependency 'DCTCocoa/ASM'
      bridge.dependency 'DCTCocoa/SM'
      bridge.dependency 'DCTCocoa/Refresh'
    end
  end
  spec.subspec 'Message' do |message|
    
    message.subspec 'VM' do |vm|
      
      vm.source_files = "Code/DCTBridge/Message/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'DCTApi'
      vm.dependency 'DCTRReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'DCTBean/Message'
      
    end
    
    message.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/DCTBridge/Message/Bridge/*.{swift}"
      bridge.dependency 'DCTBridge/Message/VM'
      bridge.dependency 'DCTCollection'
      bridge.dependency 'DCTBridge/Base'
      bridge.dependency 'DCTCocoa/ASM'
      bridge.dependency 'DCTCocoa/Refresh'
    end
  end
end
