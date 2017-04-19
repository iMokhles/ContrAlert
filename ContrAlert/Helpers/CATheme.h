//
//  CATheme.h
//  ContrAlert
//
//  Created by iMokhles on 19/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CATheme : NSObject
+(CATheme *)defaultTheme;

@property (readonly, nonatomic) UIColor *mainBackgroundColor;
@end
