//
//  CATUserCenterBridge.swift
//  CATBridge
//
//  Created by 王磊 on 2020/3/30.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import CATCollection
import RxDataSources
import CATCocoa
import CATCache
import RxCocoa
import RxSwift
import CATBean
import RxGesture

@objc(CATUserCenterActionType)
public enum CATUserCenterActionType: Int ,Codable {
    
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
}

public typealias CATUserCenterAction = (_ action: CATUserCenterActionType ) -> ()

private var key: Void?

extension CATCollectionHeaderView {
    
    @objc public var user: CATUserBean? {
        get {
            return objc_getAssociatedObject(self, &key) as? CATUserBean
        }
        set{
            objc_setAssociatedObject(self, &key,newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension Reactive where Base: CATCollectionHeaderView {
    
    var user: Binder<CATUserBean?> {
        
        return Binder(base) { view, user in
            
            view.user = user
        }
    }
}

@objc (CATUserCenterBridge)
public final class CATUserCenterBridge: CATBaseBridge {
    
    typealias Section = CATSectionModel<(), CATUserCenterBean>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    var viewModel: CATUserCenterViewModel!
    
    weak var vc: CATCollectionNoLoadingViewController!
}

extension CATUserCenterBridge {
    
    @objc public func createUserCenter(_ vc: CATCollectionNoLoadingViewController,headerView: CATCollectionHeaderView,centerAction:@escaping CATUserCenterAction) {
        
        self.vc = vc
        
        let input = CATUserCenterViewModel.WLInput(modelSelect: vc.collectionView.rx.modelSelected(CATUserCenterBean.self),
                                                   itemSelect: vc.collectionView.rx.itemSelected)
        
        viewModel = CATUserCenterViewModel(input, disposed: disposed)
        
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
                
                let isLogin = CATAccountCache.default.isLogin()
                
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
                case .contactUS:
                    
                    vc.collectionViewSelectData(type, for: ip)
                    
                default:
                    break
                }
            })
            .disposed(by: disposed)
        vc
            .collectionView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
        
        viewModel
            .output
            .userInfo
            .bind(to: headerView.rx.user)
            .disposed(by: disposed)
        
        headerView
            .rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { (_) in
                
                let isLogin = CATAccountCache.default.isLogin()
                
                centerAction(isLogin ? .header : .unLogin)
                
            })
            .disposed(by: disposed)
    }
}

extension CATUserCenterBridge: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return vc.configCollectionViewCellItemSize(self.dataSource[indexPath], for: indexPath)
    }
    //
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return vc.configCollectionViewCellSectionInset("", forSection: section)
    }
    //
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return vc.configCollectionViewCellMinimumLineSpacing("", forSection: section)
        
    }
    //
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return vc.configCollectionViewCellMinimumInteritemSpacing("", forSection: section)
    }
}
