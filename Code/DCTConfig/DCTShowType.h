//
//  DCTShowType.h
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//
#import "DCTSignConfig.h"

#if DCTCONFIGURETYPESWIMMING

#define DCTColor "#a21362"

#pragma mark --- 是否更新时启用

#define DCTUPDATEVERSION 1

#pragma mark ---

#define DCTCONTAINDRAWER 0

#define DCTCONTAINERTAB 1

// MARK: 登陆 导航透明色
#define DCTLOGINNAVALPHA 1

// MARK: 个人中心 导航透明色
#define DCTPROFILEALPHA 1

#pragma mark ---welcome

#define DCTWelcomeOne 1

#pragma mark ---login

#define DCTLoginOne 1

#pragma mark ---个人中心 1- 4 profile 5- 8 usercenter

#define DCTMeOne 1

#pragma mark ---bannerType

#define DCTCarouselOne 1

#pragma mark ---setting userinfo one hasplace two no place

#define DCTUserInfoOne 1

#pragma mark --- name signtrue feedback

#define DCTNameOne 1

#elif DCTCONFIGURETYPETHERMAL

#define DCTColor "#333333"

#pragma mark --- 是否更新时启用

#define DCTUPDATEVERSION 0

#pragma mark ---

#define DCTCONTAINDRAWER 0

#define DCTCONTAINERTAB 1

// MARK: 登陆 导航透明色
#define DCTLOGINNAVALPHA 0

// MARK: 个人中心 导航透明色
#define DCTPROFILEALPHA 0

#pragma mark ---welcome

#define DCTWelcomeOne 0

#define DCTWelcomeTwo 1

#pragma mark ---login

#define DCTLoginOne 0

#define DCTLoginTwo 1

#pragma mark ---个人中心 1- 4 profile 5- 8 usercenter

#define DCTMeOne 0

#define DCTMeTwo 1

#pragma mark ---bannerType

#define DCTCarouselOne 0

#define DCTCarouselTwo 1

#pragma mark ---setting userinfo one hasplace two no place

#define DCTUserInfoOne 0

#define DCTUserInfoTwo 1

#pragma mark --- name signtrue feedback

#define DCTNameOne 0

#define DCTNameTwo 1

#endif


