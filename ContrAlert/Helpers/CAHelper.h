//
//  CAHelper.h
//  ContrAlert
//
//  Created by iMokhles on 19/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>
#import <ParseTwitterUtils/ParseTwitterUtils.h>
#import <OneSignal/OneSignal.h>

@interface CAHelper : NSObject

+(CAHelper *)sharedInstance;

#pragma mark - USER Methods

#pragma mark - ALERT Methods

#pragma mark - CONVERSATION Methods

#pragma mark - ACTIVITY Methods

#pragma mark - FOLLOW Methods

#pragma mark - Parse Methods

- (void)initParseServer;
- (void)trackWithLaunchOptions:(NSDictionary *)launchOptions;

#pragma mark - Facebook Methods

- (void)initFacebookUtilsWithLaunchOptions:(NSDictionary *)launchOptions;

#pragma mark - TWITTER Methods

- (void)initTwitterUtils;

#pragma mark - PUSH Methods

- (void)initOneSignalWithLaunchOptions:(NSDictionary *)launchOptions;
@end
