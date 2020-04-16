//
//  CATWelcomeBridge.swift
//  CATBridge
//
//  Created by three stone 王 on 2019/8/23.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import CATCollection
import RxCocoa
import RxSwift
import RxDataSources
import CATCocoa

public typealias CATWelcomeAction = () -> ()

@objc (CATWelcomeBridge)
public final class CATWelcomeBridge: CATBaseBridge {
    
    public var viewModel: CATWelcomViewModel!
    
    typealias Section = CATSectionModel<(), String>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
}

// MARK: skip item 101 pagecontrol 102
extension CATWelcomeBridge {
    
    @objc public func createWelcome(_ vc: CATCollectionNoLoadingViewController ,welcomeImgs: [String],canPageHidden: Bool ,welcomeAction: @escaping CATWelcomeAction) {
        
        if let skipItem = vc.view.viewWithTag(101) as? UIButton ,let pageControl = vc.view.viewWithTag(102) as? UIPageControl {
            
            let input = CATWelcomViewModel.WLInput(contentoffSetX: vc.collectionView.rx.contentOffset.map({ $0.x }),
                                                 skipTap: skipItem.rx.tap.asSignal(),
                                                 welcomeImgs:welcomeImgs )
            
            viewModel = CATWelcomViewModel(input, disposed: disposed)
            
            let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
                configureCell: { ds, cv, ip, item in return vc.configCollectionViewCell(item, for: ip) })
            
            self.dataSource = dataSource
            
            viewModel
                .output
                .tableData
                .asObservable()
                .map({ [Section(model: (), items: $0)] })
                .bind(to: vc.collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposed)
            
            viewModel
                .output
                .currentpage
                .bind(to: pageControl.rx.currentPage)
                .disposed(by: disposed)
            
            viewModel
                .output
                .numofpage
                .bind(to: pageControl.rx.numberOfPages)
                .disposed(by: disposed)
            
            viewModel
                .output
                .skipHidden
                .asObservable()
                .bind(to: skipItem.rx.isHidden)
                .disposed(by: disposed)
            
            if canPageHidden {
                
                viewModel
                    .output
                    .pageHidden
                    .bind(to: pageControl.rx.isHidden)
                    .disposed(by: disposed)
                
            } else {
                
                viewModel
                    .output
                    .timered
                    .bind(to: skipItem.rx.CATSkipTitle)
                    .disposed(by: disposed)
            }
            
            viewModel
                .output
                .skiped
                .drive(onNext: { (_) in
                    
                    welcomeAction()
                })
                .disposed(by: disposed)
        }
    }
}
