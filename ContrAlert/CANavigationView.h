//
//  CANavigationView.h
//  ContrAlert
//
//  Created by iMokhles on 13/08/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackBtnBlockCompletion)(void);

@interface CANavigationView : UIView
@property (nonatomic, copy) BackBtnBlockCompletion backBtnClicked;
@end
