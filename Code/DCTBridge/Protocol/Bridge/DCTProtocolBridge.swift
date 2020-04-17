//
//  DCTProtocolBridge.swift
//  DCTBridge
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import DCTTextInner

@objc (DCTProtocolBridge)
public final class DCTProtocolBridge: DCTBaseBridge {
    
    public var viewModel: DCTProtocolViewModel!
}

extension DCTProtocolBridge {
    
    @objc public func createProtocol(_ vc: DCTTextInnerViewController) {
        
        let inputs = DCTProtocolViewModel.WLInput()
        
        viewModel = DCTProtocolViewModel(inputs)
        
        viewModel
            .output
            .contented
            .asObservable()
            .subscribe(onNext: {(value) in
                
                DispatchQueue.main.async {
                    
                    vc.DCTLoadHtmlString(htmlString: value)
                }
                
            })
            .disposed(by: disposed)
    }
}
