//
//  DCTCollectionSectionBridge.swift
//  DCTBridge
//
//  Created by 王磊 on 2020/3/31.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation
import DCTCollection
import RxCocoa
import RxSwift
import RxDataSources
import DCTCocoa

public typealias DCTCollectionSectionAction = (_ item: DCTCollectionItemBean) -> ()

@objc (DCTCollectionSectionBridge)
public final class DCTCollectionSectionBridge: DCTBaseBridge {
    
    var viewModel: DCTCollectionSectionViewModel!
    
    typealias Section = DCTSectionModel<DCTCollectionSectionBean, DCTCollectionItemBean>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    var vc: DCTCollectionNoLoadingViewController!
    
}

// MARK: skip item 101 pagecontrol 102
extension DCTCollectionSectionBridge {
    
    @objc public func createCollectionSection(_ vc: DCTCollectionNoLoadingViewController ,sections: [DCTCollectionSectionBean],sectionAction: @escaping DCTCollectionSectionAction) {
        
        let input = DCTCollectionSectionViewModel.WLInput(modelSelect: vc.collectionView.rx.modelSelected(DCTCollectionItemBean.self),
                                                          itemSelect: vc.collectionView.rx.itemSelected,
                                                          sections: sections)
        
        viewModel = DCTCollectionSectionViewModel(input)
        
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
    
    @objc public func fetchSingleData(_ ip: IndexPath) -> DCTCollectionItemBean! {
        
        guard let dataSource = dataSource else { return nil }
        
        return dataSource[ip]
    }
    
    @objc public func fetchCollectionDatas() -> [DCTCollectionItemBean] {
        
        guard let viewModel = viewModel else { return [] }
        
        var mutable: [DCTCollectionItemBean] = []
        
        for item in viewModel.output.collectionData.value {
            
            mutable += item.items
        }
        
        return mutable
    }
}
