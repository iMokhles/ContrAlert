//
//  CAConstant.h
//  ContrAlert
//
//  Created by iMokhles on 19/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CAConstant : NSObject

/*
 * Configurations
 */
FOUNDATION_EXTERN NSString *const kCAUnFollowErrorDomain;
FOUNDATION_EXTERN NSInteger const kUsernameMinimumLength;
FOUNDATION_EXTERN NSInteger const kPasswordMinimumLength;
FOUNDATION_EXTERN NSInteger const kConversationRandomStringLength;
FOUNDATION_EXTERN NSInteger const kIntroPagesCount;

/*
 * Share Text
 */
FOUNDATION_EXTERN NSString *const TEXT_SHARE_APP;

/*
 * Theme values
 */

FOUNDATION_EXTERN NSString *const kBackgroundColorHex;
FOUNDATION_EXTERN NSString *const kGoogleColorHex;
FOUNDATION_EXTERN NSString *const kFacebookColorHex;
FOUNDATION_EXTERN NSString *const kTwitterColorHex;

CG_EXTERN CGSize const kProfileThumbnailSize;
CG_EXTERN CGSize const kProfileAvatarSize;

@end
