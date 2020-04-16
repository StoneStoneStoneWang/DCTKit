//
//  ZRealReq.swift
//  ZRealReq
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import WLReqKit
import CATCache
import CATReq
import CATUpload
import CATSign

public func CATDictResp<T : WLObserverReq>(_ req: T) -> Observable<[String:Any]> {
    
    return Observable<[String:Any]>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !CATAccountCache.default.token.isEmpty {
            
            params.updateValue(CATAccountCache.default.token, forKey: "token")
        }
        
        CATReq.postWithUrl(url: req.host + req.reqName, params: params, header: req.headers, succ: { (data) in
            
            observer.onNext(data as! [String:Any])
            
            observer.onCompleted()
        }, fail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func CATArrayResp<T : WLObserverReq>(_ req: T) -> Observable<[Any]> {
    
    return Observable<[Any]>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !CATAccountCache.default.token.isEmpty {
            
            params.updateValue(CATAccountCache.default.token, forKey: "token")
        }
        CATReq.postWithUrl(url: req.host + req.reqName, params: params, header: req.headers, succ: { (data) in

            observer.onNext(data as! [Any])

            observer.onCompleted()

        }, fail: { (error) in

            let ocError = error as NSError

            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

// 无返回值的 在data里
public func CATVoidResp<T : WLObserverReq>(_ req: T) -> Observable<Void> {
    
    return Observable<Void>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !CATAccountCache.default.token.isEmpty {
            
            params.updateValue(CATAccountCache.default.token, forKey: "token")
        }
        
        CATReq.postWithUrl(url: req.host + req.reqName, params: params, header: req.headers, succ: { (data) in

            observer.onNext(())

            observer.onCompleted()

        }, fail: { (error) in

            let ocError = error as NSError

            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func CATAliResp<T : WLObserverReq>(_ req: T) -> Observable<CATALCredentialsBean> {
    
    return Observable<CATALCredentialsBean>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !CATAccountCache.default.token.isEmpty {
            
            params.updateValue(CATAccountCache.default.token, forKey: "token")
        }
        CATUpload.fetchAliObj(withUrl: req.host + req.reqName , andParams: params, andHeader: req.headers, andSucc: { (credentials) in

            observer.onNext(credentials)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 131 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func CATUploadImgResp(_ data: Data ,file: String ,param: CATALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        CATUpload.uploadAvatar(with: data, andFile: file, andUid: CATAccountCache.default.uid, andParams: param, andSucc: { (objKey) in

            observer.onNext(objKey)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 132 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func CATUploadPubImgResp(_ data: Data ,file: String ,param: CATALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        CATUpload.uploadImage(with: data, andFile: file, andUid: CATAccountCache.default.uid, andParams: param, andSucc: { (objKey) in

            observer.onNext(objKey)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 132 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}
public func CATUploadVideoResp(_ data: Data ,file: String ,param: CATALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        CATUpload.uploadVideo(with: data, andFile: file, andUid: CATAccountCache.default.uid, andParams: param, andSucc: { (objKey) in

            observer.onNext(objKey)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 132 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
//
        return Disposables.create { }
    })
}

public func CATTranslateResp<T : WLObserverReq>(_ req: T) -> Observable<[String:Any]> {
    
    return Observable<[String:Any]>.create({ (observer) -> Disposable in
        
        CATReq.postTranslateWithParams(params: req.params, succ: { (data) in
            observer.onNext(data as! [String:Any])
            
            observer.onCompleted()
        }, fail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        return Disposables.create { }
    })
}

public func CATAreaResp<T : WLObserverReq>(_ req: T) -> Observable<[Any]> {
    
    return Observable<[Any]>.create({ (observer) -> Disposable in
        
        CATReq.postAreaWithUrl(url: req.host + req.reqName, params: req.params, succ: { (data) in
            
            if data is NSDictionary {
                
                observer.onError(WLBaseError.ServerResponseError("没有权限"))
            } else if data is NSArray {
                
                observer.onNext(data as! [Any])
                
                observer.onCompleted()
            }

        }, fail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(WLBaseError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(WLBaseError.HTTPFailed(error)) }
        })
        
        
        return Disposables.create { }
    })
}
