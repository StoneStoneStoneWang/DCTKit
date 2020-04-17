//
//  DCTAreaJson.swift
//  DCTBridge
//
//  Created by 王磊 on 2020/4/10.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation

@objc (DCTAreaJson)
public final class DCTAreaJsonBridge: DCTBaseBridge { }

extension DCTAreaJsonBridge {
    @objc (fetchAreas)
    public func fetchAreas() {
        
        DCTAreaManager
            .default
            .fetchAreas()
            .drive(onNext: { (result) in
                
                
            })
            .disposed(by: disposed)
    }
}
