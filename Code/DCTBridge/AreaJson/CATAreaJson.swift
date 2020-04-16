//
//  CATAreaJson.swift
//  CATBridge
//
//  Created by 王磊 on 2020/4/10.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation

@objc (CATAreaJson)
public final class CATAreaJson: CATBaseBridge { }

extension CATAreaJson {
    @objc (fetchAreas)
    public func fetchAreas() {
        
        CATAreaManager
            .default
            .fetchAreas()
            .drive(onNext: { (result) in
                
                
            })
            .disposed(by: disposed)
    }
}
