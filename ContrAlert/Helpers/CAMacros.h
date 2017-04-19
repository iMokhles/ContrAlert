//
//  CAMacros.h
//  ContrAlert
//
//  Created by iMokhles on 19/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#ifndef CAMacros_h
#define CAMacros_h

#define		SYSTEM_VERSION								[[UIDevice currentDevice] systemVersion]
#define		SYSTEM_VERSION_EQUAL_TO(v)					([SYSTEM_VERSION compare:v options:NSNumericSearch] == NSOrderedSame)
#define		SYSTEM_VERSION_GREATER_THAN(v)				([SYSTEM_VERSION compare:v options:NSNumericSearch] == NSOrderedDescending)
#define		SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)	([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedAscending)
#define		SYSTEM_VERSION_LESS_THAN(v)					([SYSTEM_VERSION compare:v options:NSNumericSearch] == NSOrderedAscending)
#define		SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)		([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedDescending)

#define		SCREEN_WIDTH						[UIScreen mainScreen].bounds.size.width
#define		SCREEN_HEIGHT						[UIScreen mainScreen].bounds.size.height
#endif /* CAMacros_h */
