//
//  CAHelper.h
//  ContrAlert
//
//  Created by iMokhles on 19/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import <MobileCoreServices/MobileCoreServices.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/ParseFacebookUtilsV4.h>
#import <ParseTwitterUtils/ParseTwitterUtils.h>
#import <OneSignal/OneSignal.h>

// Blocks
typedef void(^HelperBlockCompletion)(id object, NSError *error);

@interface CAHelper : NSObject

+(CAHelper *)sharedInstance;

#pragma mark - USER Methods

- (void)loginUser:(NSDictionary *)loginInfo completion:(HelperBlockCompletion)completionBlock;
- (void)signupUser:(NSDictionary *)signupInfo completion:(HelperBlockCompletion)completionBlock;
- (void)uploadUserProfileAvatar:(UIImage *)image forUser:(PFUser *)user completion:(HelperBlockCompletion)completionBlock;
- (void)uploadUserProfileCover:(UIImage *)image forUser:(PFUser *)user completion:(HelperBlockCompletion)completionBlock;
- (void)isUsernameExiste:(NSString *)username completion:(HelperBlockCompletion)completionBlock;
- (void)isEmailExiste:(NSString *)email completion:(HelperBlockCompletion)completionBlock;
- (BOOL)isUserLinkedTwitterAccount;
- (BOOL)isUserLinkedFacebookAccount;

#pragma mark - ALERT Methods

- (void)getTimelineAlertsForUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion;
- (void)commentOnAlert:(PFObject *)object byUser:(PFUser *)user withText:(NSString *)comment completion:(HelperBlockCompletion)compeltion;
- (void)removeCommentOnAlert:(PFObject *)object byUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion;
- (void)likeAlert:(PFObject *)object byUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion;
- (void)disLikeAlert:(PFObject *)object byUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion;
- (void)isAlertCommentedByCurrentUser:(PFObject *)object completion:(HelperBlockCompletion)compeltion;
- (void)isAlertLikedByCurrentUser:(PFObject *)object completion:(HelperBlockCompletion)compeltion;
#pragma mark - CONVERSATION Methods

- (void)startConversationWithUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion;
- (void)isConversationExistFromUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion;
- (void)isConversationExistToUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion;
- (void)getConversationsListForUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion;
- (void)sendMessage:(NSString *)message withAttachement:(NSURL *)attachmentURL toConversation:(PFObject *)conversation completion:(HelperBlockCompletion)compeltion;
#pragma mark - ACTIVITY Methods
- (void)saveLikeActivityForUser:(PFUser *)user andAlert:(PFObject *)object completion:(HelperBlockCompletion)compeltion;
- (void)saveFollowActivityForUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion;
- (void)getActivitiesForUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion;
#pragma mark - FOLLOW Methods
- (void)getFollowersCountForUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion;
- (void)getFollowingCountForUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion;
- (void)getFollowersForUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion;
- (void)getFollowingForUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion;
- (void)isThisUser:(PFUser *)firstUser followThisUser:(PFUser *)secondUser completion:(HelperBlockCompletion)compeltion;
- (void)changeFollowStateOfUser:(PFUser *)user unFollow:(BOOL)unfollow completion:(HelperBlockCompletion)compeltion;

#pragma mark - Parse Methods
- (void)initParseServer;
- (void)trackWithLaunchOptions:(NSDictionary *)launchOptions;
#pragma mark - Facebook Methods
- (void)initFacebookUtilsWithLaunchOptions:(NSDictionary *)launchOptions;
#pragma mark - TWITTER Methods
- (void)initTwitterUtils;
#pragma mark - PUSH Methods
- (void)initOneSignalWithLaunchOptions:(NSDictionary *)launchOptions;
#pragma mark - Private Methods

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size andScale:(CGFloat)scale;
- (BOOL)isValidPasswordConfirmation:(NSDictionary *)passwords;
- (BOOL)isValidPassword:(NSString *)password;
- (BOOL)isValidEmail:(NSString *)email;
- (BOOL)isValidUsername:(NSString *)username;
- (NSString *)randomString:(int)len;
- (NSString *)MIMEForFileURL:(NSURL *)url;
- (void)openImagePickerFromTarget:(id)target completion:(HelperBlockCompletion)compeltion;
- (void)cropCircleImage:(UIImage *)image fromTarget:(id)target;
- (void)cropImage:(UIImage *)image fromTarget:(id)target;
- (void)showPickerFromTarget:(id)target withOptions:(NSArray *)options andMessage:(NSString *)message completion:(HelperBlockCompletion)compeltion;
- (UIImage *)roundedRectImageFromImage:(UIImage *)image withRadious:(CGFloat)radious;
- (NSString *)getLibraryPath;
- (NSString *)getDocumentsPath;
- (CGRect)windowBounds;
- (BOOL)isIPHONE;
- (BOOL)isIPAD;
- (BOOL)isIPHONE4;
- (BOOL)isIPHONE5;
- (BOOL)isIPHONE6;
- (BOOL)isIPHONE6PLUS;
- (BOOL)systemVersionGreaterThanOrEqual:(NSString *)number;
- (void)stayLTR;
@end
