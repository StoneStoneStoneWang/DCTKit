//
//  DCTAreaBridge.swift
//  ZBridge
//
//  Created by three stone 王 on 2020/3/13.
//  Copyright © 2020 three stone 王. All rights reserved.
//

import Foundation
import DCTCocoa
import RxDataSources
import DCTTable
import DCTBean

@objc (DCTAreaType)
public enum DCTAreaType: Int {
    
    case province
    
    case city
    
    case region
}

public typealias DCTAreaAction = (_ selectedArea: DCTAreaBean ,_ type: DCTAreaType ,_ hasNext: Bool) -> ()

@objc (DCTAreaBridge)
public final class DCTAreaBridge: DCTBaseBridge {
    
    var viewModel: DCTAreaViewModel!
    
    typealias Section = DCTSectionModel<(), DCTAreaBean>
    
    var dataSource: RxTableViewSectionedReloadDataSource<Section>!
    
    var type: DCTAreaType = .province
    
    var areas: [DCTAreaBean] = []
    
    var selectedArea: DCTAreaBean!
}

extension DCTAreaBridge {
    
    @objc public func createArea(_ vc: DCTTableNoLoadingViewController ,type: DCTAreaType,areaAction: @escaping DCTAreaAction) {
        
        self.type = type
        
        let input = DCTAreaViewModel.WLInput(areas: areas,
                                             modelSelect: vc.tableView.rx.modelSelected(DCTAreaBean.self),
                                             itemSelect: vc.tableView.rx.itemSelected)
        
        viewModel = DCTAreaViewModel(input, disposed: disposed)
        
        let dataSource = RxTableViewSectionedReloadDataSource<Section>(
            configureCell: { ds, tv, ip, item in return vc.configTableViewCell(item, for: ip)})
        
        self.dataSource = dataSource
        
        viewModel
            .output
            .tableData
            .asDriver()
            .map({ [Section(model: (), items: $0)]  })
            .drive(vc.tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposed)
        
        viewModel
            .output
            .zip
            .subscribe(onNext: { [unowned self](area,ip) in
                
                vc.tableView.deselectRow(at: ip, animated: true)
                
                let values = self.viewModel.output.tableData.value
                
                _ = values.map({ $0.isSelected = false })
                
                area.isSelected = true
                
                self.viewModel.output.tableData.accept(values)
                
                switch type {
                case .province: fallthrough
                case .region:
                    areaAction(area,type, true)
                case .city:
                    
                    areaAction(area,type, self.fetchRegions(area.areaId).count > 0)
                default:
                    break;
                }
            })
            .disposed(by: disposed)
        vc
            .tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposed)
        
        DCTAreaManager
            .default
            .fetchAreas()
            .drive(onNext: { [unowned self ](result) in
                
                switch result {
                case .fetchList(let list):
                    
                    var mutable: [DCTAreaBean] = []
                    
                    switch type {
                    case .province:
                        
                        mutable += self.fetchProvices(list as! [DCTAreaBean])
                    case .city:
                        
                        //                        mutable += self.fetchCitys(<#T##id: Int##Int#>)
                        break
                    case .region:
                        break
                        
                    }
                    
                    self.viewModel.output.tableData.accept(mutable)
                default:
                    break
                }
            })
            .disposed(by: disposed)
    }
    
    @objc public func fetchAreas() {
        
        DCTAreaManager
            .default
            .fetchAreas()
            .drive(onNext: { (result) in
                
                
            })
            .disposed(by: disposed)
    }
    
    @objc public func updateDatas(_ id: Int ,areas: [DCTAreaBean]) {
        
        switch type {
        case .city:
            
            self.viewModel.output.tableData.accept(self.fetchCitys(id))
            
        case .region:
            
            self.viewModel.output.tableData.accept(self.fetchRegions(id))
        case .province:
            
            self.viewModel.output.tableData.accept(self.fetchProvices(areas))
        }
    }
    @objc public func fetchProvice(pName: String) -> DCTAreaBean {
        
        let values = self.viewModel.output.tableData.value
        
        let idx = values.firstIndex(where: {  $0.name == pName })!
        
        return values[idx]
        
    }
    
    @objc public func fetchArea(id: Int) -> DCTAreaBean {
        
        return DCTAreaManager.default.fetchSomeArea(id)
        
    }
    @objc public func fetchIp(id: Int) -> IndexPath {
        
        let values = self.viewModel.output.tableData.value
        
        let idx = values.firstIndex(where: {  $0.areaId == id })!
        
        return IndexPath(row: idx, section: 0)
    }
    @objc public func fetchProvices(_ areas: [DCTAreaBean]) -> [DCTAreaBean] {
        
        var result: [DCTAreaBean] = []
        
        for item in areas {
            
            if item.arealevel == 1 {
                
                result += [item]
            }
        }
        return result
    }
    
    @objc public func fetchCitys(_ id: Int) -> [DCTAreaBean] {
        
        var result: [DCTAreaBean] = []
        
        for item in DCTAreaManager.default.allAreas {
            
            if item.arealevel == 2 {
                
                if item.pid == id {
                    
                    result += [item]
                }
            }
        }
        return result
    }
    
    @objc public func fetchRegions(_ id: Int) -> [DCTAreaBean] {
        
        var result: [DCTAreaBean] = []
        
        for item in DCTAreaManager.default.allAreas {
            
            if item.arealevel == 3 {
                
                if item.pid == id {
                    
                    result += [item]
                }
            }
        }
        return result
    }
}

extension DCTAreaBridge: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
}
