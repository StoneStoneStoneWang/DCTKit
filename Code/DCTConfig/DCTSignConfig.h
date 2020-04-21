//
//  DCTSignConfig.h
//  DCTContainer
//
//  Created by 王磊 on 2020/3/29.
//  Copyright © 2020 王磊. All rights reserved.
//

#pragma mark ---- DCTSign

#pragma mark ----
#define DCTCONFIGURETYPETHERMAL 1

#define DCTCONFIGURETYPESWIMMING 0

#if DCTCONFIGURETYPESWIMMING

#define DCTCONFIGURETYPE DCTCONFIGURETYPESWIMMING



#elif DCTCONFIGURETYPETHERMAL

#define DCTCONFIGURETYPE DCTConfigureTypeThermal

#define DCTAPPKEY "156d09d660c444c89d46b15ed5366256"

#define DCTDOMAIN "http://zhihw.ecsoi.com/"

#endif


