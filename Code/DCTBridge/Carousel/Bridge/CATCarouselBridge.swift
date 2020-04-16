//
//  DCTCarouselBridge.swift
//  DCTBridge
//
//  Created by three stone 王 on 2020/3/12.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import DCTCollection
import RxCocoa
import RxSwift
import RxDataSources
import DCTCocoa
import WLToolsKit
import ObjectMapper

public typealias DCTCarouselAction = (_ carouse: DCTCarouselBean) -> ()

@objc (DCTCarouselBridge)
public final class DCTCarouselBridge: DCTBaseBridge {
    
    var viewModel: DCTCarouselViewModel!
    
    typealias Section = DCTSectionModel<(), DCTCarouselBean>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    var vc: DCTCollectionNoLoadingViewController!
    
    var style: DCTCarouselStyle = .normal
}

// MARK: skip item 101 pagecontrol 102
extension DCTCarouselBridge {
    
    @objc public func createCarousel(_ vc: DCTCollectionNoLoadingViewController ,canPageHidden: Bool ,canTimerResp: Bool,carousels: [[String: String]],style: DCTCarouselStyle ,carouseAction: @escaping DCTCarouselAction) {
        
        if let pageControl = vc.view.viewWithTag(102) as? UIPageControl {
            
            pageControl.numberOfPages = carousels.count
            
            self.vc = vc
            
            self.style = style
            
            let input = DCTCarouselViewModel.WLInput(contentoffSetX: vc.collectionView.rx.contentOffset.map({ $0.x }),
                                                     modelSelect: vc.collectionView.rx.modelSelected(DCTCarouselBean.self),
                                                     itemSelect: vc.collectionView.rx.itemSelected,
                                                     canTimerResp: canTimerResp,
                                                     currentPage: BehaviorRelay<Int>(value: 0),
                                                     style: style)
            
            viewModel = DCTCarouselViewModel(input, disposed: disposed)
            
            var result : [DCTCarouselBean] = []
            
            for carousel in carousels {
                
                let c = DCTCarouselBean(JSON: carousel)!
                
                result += [c]
                
            }
            
            let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(
                configureCell: { ds, cv, ip, item in return vc.configCollectionViewCell(item, for: ip)})
            
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
                .zip
                .subscribe(onNext: { (carouse,ip) in
                    
                    carouseAction(carouse)
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .timered
                .subscribe(onNext: { [unowned self] (index) in
                    
                    if !self.viewModel.output.tableData.value.isEmpty {
                        
                        vc.collectionView.selectItem(at: IndexPath(item: index, section:0), animated: true, scrollPosition: .centeredHorizontally)
                    }
                })
                .disposed(by: disposed)
            
            viewModel
                .output
                .currentPage
                .bind(to: pageControl.rx.currentPage)
                .disposed(by: disposed)
            
            var mutable: [DCTCarouselBean] = []
            
            for _ in 0..<999 {
                
                mutable += result
            }
            
            viewModel
                .output
                .tableData
                .accept(mutable)
            
            vc
                .collectionView
                .rx
                .setDelegate(self)
                .disposed(by: disposed)
        }
    }
}
extension DCTCarouselBridge: UICollectionViewDelegate {
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        DispatchQueue.main.async {
            
            let width = self.style == .normal ? WL_SCREEN_WIDTH : (WL_SCREEN_WIDTH - 60 )
            
            let floatx = scrollView.contentOffset.x / width
            
            let intx = floor(floatx)
            
            if floatx + 0.5 >= intx {
                
                self.vc.collectionView.selectItem(at: IndexPath(item: Int(scrollView.contentOffset.x / width) + 1, section:0), animated: true, scrollPosition: .centeredHorizontally)
            } else {
                
                self.vc.collectionView.selectItem(at: IndexPath(item: Int(scrollView.contentOffset.x / width), section:0), animated: true, scrollPosition: .centeredHorizontally)
            }
        }
    }
}
