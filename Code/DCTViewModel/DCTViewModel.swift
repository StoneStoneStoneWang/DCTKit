//
//  DCTViewModel.swift
//  DCTViewModel
//
//  Created by 王磊 on 2020/4/16.
//  Copyright © 2020 王磊. All rights reserved.
//

import Foundation

public protocol DCTViewModel {
    
    associatedtype WLInput
    associatedtype WLOutput
    
    var input: WLInput { get }
    var output: WLOutput { get }
}
