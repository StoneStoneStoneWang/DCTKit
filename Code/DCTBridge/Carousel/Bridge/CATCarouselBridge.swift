//
//  CATCarouselBridge.swift
//  CATBridge
//
//  Created by three stone 王 on 2020/3/12.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import CATCollection
import RxCocoa
import RxSwift
import RxDataSources
import CATCocoa
import WLToolsKit
import ObjectMapper

public typealias CATCarouselAction = (_ carouse: CATCarouselBean) -> ()

@objc (CATCarouselBridge)
public final class CATCarouselBridge: CATBaseBridge {
    
    var viewModel: CATCarouselViewModel!
    
    typealias Section = CATSectionModel<(), CATCarouselBean>
    
    var dataSource: RxCollectionViewSectionedReloadDataSource<Section>!
    
    var vc: CATCollectionNoLoadingViewController!
    
    var style: CATCarouselStyle = .normal
}

// MARK: skip item 101 pagecontrol 102
extension CATCarouselBridge {
    
    @objc public func createCarousel(_ vc: CATCollectionNoLoadingViewController ,canPageHidden: Bool ,canTimerResp: Bool,carousels: [[String: String]],style: CATCarouselStyle ,carouseAction: @escaping CATCarouselAction) {
        
        if let pageControl = vc.view.viewWithTag(102) as? UIPageControl {
            
            pageControl.numberOfPages = carousels.count
            
            self.vc = vc
            
            self.style = style
            
            let input = CATCarouselViewModel.WLInput(contentoffSetX: vc.collectionView.rx.contentOffset.map({ $0.x }),
                                                     modelSelect: vc.collectionView.rx.modelSelected(CATCarouselBean.self),
                                                     itemSelect: vc.collectionView.rx.itemSelected,
                                                     canTimerResp: canTimerResp,
                                                     currentPage: BehaviorRelay<Int>(value: 0),
                                                     style: style)
            
            viewModel = CATCarouselViewModel(input, disposed: disposed)
            
            var result : [CATCarouselBean] = []
            
            for carousel in carousels {
                
                let c = CATCarouselBean(JSON: carousel)!
                
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
            
            var mutable: [CATCarouselBean] = []
            
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
extension CATCarouselBridge: UICollectionViewDelegate {
    
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
