//
//  DCTProtocolViewModel.swift
//  DCTBridge
//
//  Created by three stone 王 on 2019/8/25.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import DCTViewModel
import RxCocoa
import DCTSign

public struct DCTProtocolViewModel: DCTViewModel {
    
    public var input: WLInput
    
    public var output: WLOutput
    
    public struct WLInput {
        
    }
    
    public struct WLOutput {
        
        let contented: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    }
    public init(_ input: WLInput) {
        
        self.input = input
        
        let output = WLOutput()
        //        https://zhih.ecsoi.com/other/other_PrivacyProtocols?encoded=7e730d5b41f7436da8b1b4a65a5aa49f
        if let url = URL(string: "\(DCTConfigure.fetchDomain())other/other_privacyProtocols?encoded=\(DCTConfigure.fetchAppKey())") {
            //            Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
            if UIApplication.shared.canOpenURL(url) {
                
                let queue = DispatchQueue(label: Bundle.main.bundleIdentifier ?? "com.DCT.pro")
                
                queue.async {
                    
                    do {
                        
                        output.contented.accept(try String(contentsOf: url))
                        
                    } catch  {
                        
                        debugPrint(error)
                    }
                }
            }
        }
        
        self.output = output
    }
}
