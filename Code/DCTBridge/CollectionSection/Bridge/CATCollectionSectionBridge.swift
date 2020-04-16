//
//  CATCollectionSectionBridge.swift
//  CATBridge
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import CATCollection
import RxCocoa
import RxSwift
import RxDataSources
import CATCocoa

public typealias CATCollectionSectionAction = (_ item: CATCollectionItemBean) -> ()

@objc (CATCollectionSectionBridge)
public final class CATCollectionSectionBridge: CATBaseBridge {
    
    var viewModel: CATCollectionSectionViewModel!
    
    typealias Section = CATSectionModel<CATCollectionSectionBean, CATCollectionItemBean>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    var vc: CATCollectionNoLoadingViewController!
    
}

// MARK: skip item 101 pagecontrol 102
extension CATCollectionSectionBridge {
    
    @objc public func createCollectionSection(_ vc: CATCollectionNoLoadingViewController ,sections: [CATCollectionSectionBean],sectionAction: @escaping CATCollectionSectionAction) {
        
        let input = CATCollectionSectionViewModel.WLInput(modelSelect: vc.collectionView.rx.modelSelected(CATCollectionItemBean.self),
                                                          itemSelect: vc.collectionView.rx.itemSelected,
                                                          sections: sections)
        
        viewModel = CATCollectionSectionViewModel(input)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
            configureCell: { ds, cv, ip, item in return vc.configCollectionViewCell(item, for: ip) },
            configureSupplementaryView: { ds, cv, kind, ip in return vc.configCollectionViewHeader(self.viewModel.output.collectionData.value[ip.section], for: ip)})
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .collectionData
            .map({ $0.map({ Section(model: $0, items: $0.items) }) })
            .bind(to: vc.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { (item,ip) in

                sectionAction(item)
            })
            .disposed(by: disposed)
        
    }
    
    @objc public func fetchSingleData(_ ip: IndexPath) -> CATCollectionItemBean! {
        
        guard let dataSource = dataSource else { return nil }
        
        return dataSource[ip]
    }
    
    @objc public func fetchCollectionDatas() -> [CATCollectionItemBean] {
        
        guard let viewModel = viewModel else { return [] }
        
        var mutable: [CATCollectionItemBean] = []
        
        for item in viewModel.output.collectionData.value {
            
            mutable += item.items
        }
        
        return mutable
    }
}
