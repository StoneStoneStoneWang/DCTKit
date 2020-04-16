//
//  CATProtocolBridge.swift
//  CATBridge
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import CATTextInner

@objc (CATProtocolBridge)
public final class CATProtocolBridge: CATBaseBridge {
    
    public var viewModel: CATProtocolViewModel!
}

extension CATProtocolBridge {
    
    @objc public func createProtocol(_ vc: CATTextInnerViewController) {
        
        let inputs = CATProtocolViewModel.WLInput()
        
        viewModel = CATProtocolViewModel(inputs)
        
        viewModel
            .output
            .contented
            .asObservable()
            .subscribe(onNext: {(value) in
                
                DispatchQueue.main.async {
                    
                    vc.CATLoadHtmlString(htmlString: value)
                }
                
            })
            .disposed(by: disposed)
    }
}
