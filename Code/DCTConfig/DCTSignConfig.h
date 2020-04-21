//
//  DCTSignConfig.h
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#pragma mark ---- DCTSign

#pragma mark ---- 花店
#define DCTCONFIGURETYPENURSE 0

#define DCTCONFIGURETYPETHERMAL 1

#if DCTCONFIGURETYPENURSE

#define DCTCONFIGURETYPE DCTConfigureTypeNurse

#define DCTAPPKEY "7a855e35140e4a2f8591dbcaeadc32b1"

#define DCTDOMAIN "http://zhihw.ecsoi.com/"

#elif DCTCONFIGURETYPETHERMAL

#define DCTCONFIGURETYPE DCTConfigureTypeThermal

#define DCTAPPKEY "156d09d660c444c89d46b15ed5366256"

#define DCTDOMAIN "http://zhihw.ecsoi.com/"


#endif


