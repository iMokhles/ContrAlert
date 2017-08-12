//
//  CAConstant.m
//  ContrAlert
//
//  Created by iMokhles on 19/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import "CAConstant.h"

@implementation CAConstant

/*
 * Configurations
 */
NSString *const kCAUnFollowErrorDomain = @"CAUnFollowErrorDomain";
NSInteger const kUsernameMinimumLength = 3;
NSInteger const kPasswordMinimumLength = 4;
NSInteger const kConversationRandomStringLength = 6;
NSInteger const kIntroPagesCount = 6;
/*
 * Share Text
 */
NSString *const TEXT_SHARE_APP = @"ContrAlert, first social network to";

/*
 * Theme values
 */

NSString *const kBackgroundColorHex = @"ffffff";
NSString *const kGoogleColorHex = @"dd4b39";
NSString *const kFacebookColorHex = @"3b5998";
NSString *const kTwitterColorHex = @"55acee";
CGSize const kProfileThumbnailSize = {80, 80};
CGSize const kProfileAvatarSize  = {180, 180};

@end
