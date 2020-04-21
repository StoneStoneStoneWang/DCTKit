//
//  DCTUserCenterBridge.swift
//  DCTBridge
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import DCTCollection
import RxDataSources
import DCTCocoa
import DCTCache
import RxCocoa
import RxSwift
import DCTBean
import RxGesture

@objc(DCTUserCenterActionType)
public enum DCTUserCenterActionType: Int ,Codable {
    
    case header
    
    case about
    
    case userInfo
    
    case setting
    
    case contactUS
    
    case privacy
    
    case focus
    
    case space
    
    case myCircle
    
    case order
    
    case address
    
    case characters
    
    case unLogin
    
    case feedBack
    
    case share
    
    case service
    
    case version
}

public typealias DCTUserCenterAction = (_ action: DCTUserCenterActionType ) -> ()

private var key: Void?

extension DCTCollectionHeaderView {
    
    @objc public var user: DCTUserBean? {
        get {
            return objc_getAssociatedObject(self, &key) as? DCTUserBean
        }
        set{
            objc_setAssociatedObject(self, &key,newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension Reactive where Base: DCTCollectionHeaderView {
    
    var user: Binder<DCTUserBean?> {
        
        return Binder(base) { view, user in
            
            view.user = user
        }
    }
}

@objc (DCTUserCenterBridge)
public final class DCTUserCenterBridge: DCTBaseBridge {
    
    typealias Section = DCTSectionModel<(), DCTUserCenterBean>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    var viewModel: DCTUserCenterViewModel!
    
    weak var vc: DCTCollectionNoLoadingViewController!
}

extension DCTUserCenterBridge {
    
    @objc public func createUserCenter(_ vc: DCTCollectionNoLoadingViewController,centerAction:@escaping DCTUserCenterAction) {
        
        self.vc = vc
        
        let input = DCTUserCenterViewModel.WLInput(modelSelect: vc.collectionView.rx.modelSelected(DCTUserCenterBean.self),
                                                   itemSelect: vc.collectionView.rx.itemSelected)
        
        viewModel = DCTUserCenterViewModel(input, disposed: disposed)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
            configureCell: { ds, cv, ip, item in return vc.configCollectionViewCell(item, for: ip)})
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ [Section(model: (), items: $0)]  })
            .drive(vc.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .zip
            .subscribe(onNext: {(type,ip) in
                
                vc.collectionView.deselectItem(at: ip, animated: true)
                
                let isLogin = DCTAccountCache.default.isLogin()
                
                switch type.type {
                case .setting: centerAction(.setting)
                    
                case .privacy: centerAction(.privacy)
                case .about: centerAction(.about)
                    
                case .userInfo: centerAction(isLogin ? .userInfo : .unLogin)
                case .address: centerAction(isLogin ? .address : .unLogin)
                case .order: centerAction(isLogin ? .order : .unLogin)
                case .focus: centerAction(isLogin ? .focus : .unLogin)
                case .characters: centerAction(isLogin ? .characters : .unLogin)
                case .myCircle: centerAction(isLogin ? .myCircle : .unLogin)
                case .feedBack: centerAction(.feedBack)
                case .service: centerAction(.service)
                case .header: centerAction(isLogin ? .header : .unLogin)
                case .share: centerAction(.share)
                case .version: centerAction(.version)
                case .contactUS: centerAction(.contactUS)
                 
                    
                default:
                    break
                }
            })
            .disposed(by: disposed)
        
    }
}
