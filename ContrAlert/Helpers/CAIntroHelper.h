//
//  CAIntroHelper.h
//  ContrAlert
//
//  Created by iMokhles on 22/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EAIntroView.h"
typedef void(^CAIntroDidFinish) ();
@interface CAIntroHelper : NSObject <EAIntroDelegate> {
    UIView *rootView;
}
@property (nonatomic, copy) CAIntroDidFinish introDidFinish;
+(CAIntroHelper *)sharedInstance;
-(void)showIntroView:(UIViewController *)rootViewController completion:(CAIntroDidFinish )completionBlock;
@end
