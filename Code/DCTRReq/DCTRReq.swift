//
//  ZRealReq.swift
//  ZRealReq
//
//  Created by three stone 王 on 2019/8/22.
//  Copyright © 2019 three stone 王. All rights reserved.
//

import Foundation
import RxSwift
import DCTCache
import DCTReq
import DCTUpload
import DCTSign
import DCTError
import DCTOR

public func DCTDictResp<T : DCTOR>(_ req: T) -> Observable<[String:Any]> {
    
    return Observable<[String:Any]>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !DCTAccountCache.default.token.isEmpty {
            
            params.updateValue(DCTAccountCache.default.token, forKey: "token")
        }
        
        DCTReq.postWithUrl(url: req.host + req.reqName, params: params, header: req.headers, succ: { (data) in
            
            observer.onNext(data as! [String:Any])
            
            observer.onCompleted()
        }, fail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(DCTError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(DCTError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func DCTArrayResp<T : DCTOR>(_ req: T) -> Observable<[Any]> {
    
    return Observable<[Any]>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !DCTAccountCache.default.token.isEmpty {
            
            params.updateValue(DCTAccountCache.default.token, forKey: "token")
        }
        DCTReq.postWithUrl(url: req.host + req.reqName, params: params, header: req.headers, succ: { (data) in

            observer.onNext(data as! [Any])

            observer.onCompleted()

        }, fail: { (error) in

            let ocError = error as NSError

            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(DCTError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(DCTError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

// 无返回值的 在data里
public func DCTVoidResp<T : DCTOR>(_ req: T) -> Observable<Void> {
    
    return Observable<Void>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !DCTAccountCache.default.token.isEmpty {
            
            params.updateValue(DCTAccountCache.default.token, forKey: "token")
        }
        
        DCTReq.postWithUrl(url: req.host + req.reqName, params: params, header: req.headers, succ: { (data) in

            observer.onNext(())

            observer.onCompleted()

        }, fail: { (error) in

            let ocError = error as NSError

            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(DCTError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(DCTError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func DCTAliResp<T : DCTOR>(_ req: T) -> Observable<DCTALCredentialsBean> {
    
    return Observable<DCTALCredentialsBean>.create({ (observer) -> Disposable in
        
        var params = req.params
        
        if !DCTAccountCache.default.token.isEmpty {
            
            params.updateValue(DCTAccountCache.default.token, forKey: "token")
        }
        DCTUpload.fetchAliObj(withUrl: req.host + req.reqName , andParams: params, andHeader: req.headers, andSucc: { (credentials) in

            observer.onNext(credentials)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 131 { observer.onError(DCTError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(DCTError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func DCTUploadImgResp(_ data: Data ,file: String ,param: DCTALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        DCTUpload.uploadAvatar(with: data, andFile: file, andUid: DCTAccountCache.default.uid, andParams: param, andSucc: { (objKey) in

            observer.onNext(objKey)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 132 { observer.onError(DCTError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(DCTError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}

public func DCTUploadPubImgResp(_ data: Data ,file: String ,param: DCTALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        DCTUpload.uploadImage(with: data, andFile: file, andUid: DCTAccountCache.default.uid, andParams: param, andSucc: { (objKey) in

            observer.onNext(objKey)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 132 { observer.onError(DCTError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(DCTError.HTTPFailed(error)) }
        })
        
        return Disposables.create { }
    })
}
public func DCTUploadVideoResp(_ data: Data ,file: String ,param: DCTALCredentialsBean) -> Observable<String> {
    
    return Observable<String>.create({ (observer) -> Disposable in
        
        DCTUpload.uploadVideo(with: data, andFile: file, andUid: DCTAccountCache.default.uid, andParams: param, andSucc: { (objKey) in

            observer.onNext(objKey)

            observer.onCompleted()

        }, andFail: { (error) in

            let ocError = error as NSError

            if ocError.code == 132 { observer.onError(DCTError.ServerResponseError(ocError.localizedDescription)) }

            else { observer.onError(DCTError.HTTPFailed(error)) }
        })
//
        return Disposables.create { }
    })
}

public func DCTTranslateResp<T : DCTOR>(_ req: T) -> Observable<[String:Any]> {
    
    return Observable<[String:Any]>.create({ (observer) -> Disposable in
        
        DCTReq.postTranslateWithParams(params: req.params, succ: { (data) in
            observer.onNext(data as! [String:Any])
            
            observer.onCompleted()
        }, fail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(DCTError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(DCTError.HTTPFailed(error)) }
        })
        return Disposables.create { }
    })
}

public func DCTAreaResp<T : DCTOR>(_ req: T) -> Observable<[Any]> {
    
    return Observable<[Any]>.create({ (observer) -> Disposable in
        
        DCTReq.postAreaWithUrl(url: req.host + req.reqName, params: req.params, succ: { (data) in
            
            if data is NSDictionary {
                
                observer.onError(DCTError.ServerResponseError("没有权限"))
            } else if data is NSArray {
                
                observer.onNext(data as! [Any])
                
                observer.onCompleted()
            }

        }, fail: { (error) in
            
            let ocError = error as NSError
            
            if ocError.code == 122 || ocError.code == 123 || ocError.code == 124 || ocError.code == 121 { observer.onError(DCTError.ServerResponseError(ocError.localizedDescription)) }
            else { observer.onError(DCTError.HTTPFailed(error)) }
        })
        
        
        return Disposables.create { }
    })
}
