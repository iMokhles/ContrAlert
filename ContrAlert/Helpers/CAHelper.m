//
//  CAHelper.m
//  ContrAlert
//
//  Created by iMokhles on 19/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import "CAHelper.h"
#import "CABackendKeys.h"
#import "CATheme.h"
#import "CAConstant.h"
#import "TOCropViewController.h"
#import "JSImagePickerViewController.h"
#import "CAMacros.h"
#import "UIViewController+SLPhotoSelection.h"

@implementation CAHelper

#pragma mark - Instance Methods

static BOOL useinside = NO;
static CAHelper *_sharedInstance = nil;

+(CAHelper *)sharedInstance {
    static dispatch_once_t p = 0;
    dispatch_once(&p, ^{
        useinside = YES;
        _sharedInstance = [[CAHelper alloc] init];
        useinside = NO;
    });
    return _sharedInstance;
}

+ (instancetype) alloc {
    if (!useinside) {
        @throw [NSException exceptionWithName:@"Singleton Vialotaion" reason:@"You are violating the singleton class usage. Please call +sharedInstance method" userInfo:nil];
    }
    else {
        return [super alloc];
    }
}
+ (instancetype) new {
    if (!useinside) {
        @throw [NSException exceptionWithName:@"Singleton Vialotaion" reason:@"You are violating the singleton class usage. Please call +sharedInstance method" userInfo:nil];
    }
    else {
        return [super new];
    }
}
- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

#pragma mark - USER Methods

- (void)loginUser:(NSDictionary *)loginInfo completion:(HelperBlockCompletion)completionBlock {
    [PFUser logInWithUsernameInBackground:loginInfo[kUsersUserName] password:loginInfo[kUsersPassword] block:^(PFUser *user, NSError *error) {
        completionBlock(user,error);
    }];
}
- (void)signupUser:(NSDictionary *)signupInfo completion:(HelperBlockCompletion)completionBlock {
    PFUser *user = [PFUser user];
    user[kUsersFullName] = signupInfo[kUsersFullName];
    user.username = signupInfo[kUsersUserName];
    user.password = signupInfo[kUsersPassword];
    user.email = signupInfo[kUsersEmail];
    user[kUsersGender] = signupInfo[kUsersGender];
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        completionBlock(@(succeeded), error);
    }];
}
- (void)uploadUserProfileAvatar:(UIImage *)image forUser:(PFUser *)user completion:(HelperBlockCompletion)completionBlock {
    UIImage *thumnailImage = [self resizeImage:image withSize:[[CATheme defaultTheme] profileThumbnailSize] andScale:1];
    UIImage *avatarImage = [self resizeImage:image withSize:[[CATheme defaultTheme] profileAvatarSize] andScale:1];
    
    PFFile *thumnailFile = [PFFile fileWithData:UIImagePNGRepresentation(thumnailImage)];
    PFFile *avatarFile = [PFFile fileWithData:UIImagePNGRepresentation(avatarImage)];
    
    [thumnailFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error == nil) {
            [avatarFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                if (error == nil) {
                    user[kUsersAvatarThumbnail] = thumnailFile;
                    user[kUsersAvatar] = avatarFile;
                    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                        completionBlock(@(succeeded), error);
                    }];
                } else {
                    completionBlock(nil, error);
                }
            }];
        } else {
            completionBlock(nil, error);
        }
    }];
}
- (void)uploadUserProfileCover:(UIImage *)image forUser:(PFUser *)user completion:(HelperBlockCompletion)completionBlock {
    UIImage *coverImage = [self resizeImage:image withSize:[[CATheme defaultTheme] profileAvatarSize] andScale:1];
    
    PFFile *coverFile = [PFFile fileWithData:UIImagePNGRepresentation(coverImage)];
    
    [coverFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (error == nil) {
            user[kUsersCoverImage] = coverFile;
            [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                completionBlock(@(succeeded), error);
            }];
        } else {
            completionBlock(nil, error);
        }
    }];
}
- (void)isUsernameExiste:(NSString *)username completion:(HelperBlockCompletion)completionBlock {
    PFQuery *query = [PFUser query];
    [query whereKey:kUsersUserName equalTo:username];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        completionBlock(object, error);
    }];
}
- (void)isEmailExiste:(NSString *)email completion:(HelperBlockCompletion)completionBlock {
    PFQuery *query = [PFUser query];
    [query whereKey:kUsersEmail equalTo:email];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        completionBlock(object, error);
    }];
}
- (BOOL)isUserLinkedTwitterAccount {
    BOOL isLinkedToTwitter = [PFTwitterUtils isLinkedWithUser:[PFUser currentUser]];
    return isLinkedToTwitter;
}
- (BOOL)isUserLinkedFacebookAccount {
    BOOL isLinkedToFacebook = [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]];
    return isLinkedToFacebook;
}

#pragma mark - ALERT Methods

- (void)getTimelineAlertsForUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion {
    [self getFollowingForUser:[PFUser currentUser] completion:^(id object, NSError *error) {
        if (error == nil) {
            PFQuery *query;
            NSArray *followingUsers = object;
            PFQuery *myAlertsQuery = [PFQuery queryWithClassName:kAlertsClassName];
            [myAlertsQuery whereKey:kAlertsUserPointer equalTo:[PFUser currentUser]];
            
            PFQuery *followingUsersAlertsQuery = [PFQuery queryWithClassName:kAlertsClassName];
            [followingUsersAlertsQuery whereKey:kAlertsUserPointer containedIn:followingUsers];
            
            query = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:myAlertsQuery, followingUsersAlertsQuery, nil]];
            [query orderByDescending:@"createdAt"];
            [query includeKey:kAlertsUserPointer];
            query.limit = 99;
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                compeltion(objects, error);
            }];
        } else {
            compeltion(nil, error);
        }
    }];
}
- (void)commentOnAlert:(PFObject *)object byUser:(PFUser *)user withText:(NSString *)comment completion:(HelperBlockCompletion)compeltion {
    PFQuery *query = [PFQuery queryWithClassName:kCommentsClassName];
    [query whereKey:kCommentsUserPointer equalTo:user];
    [query whereKey:kCommentsAlertPointer equalTo:object];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error == nil) {
            PFObject *commentAlert = [PFObject objectWithClassName:kCommentsClassName];
            if (objects.count == 0) {
                [object incrementKey:kAlertsComments byAmount:[NSNumber numberWithInt:1]];
                [object saveInBackground];
                commentAlert[kCommentsUserPointer] = user;
                commentAlert[kCommentsAlertPointer] = object;
                commentAlert[kCommentsCommentText] = comment;
                [commentAlert saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    if (error == nil) {
                        compeltion(@(succeeded), error);
                    } else {
                        compeltion(NO, error);
                    }
                }];
            } else {
                compeltion(NO, error);
            }
            
        } else {
            compeltion(NO, error);
        }
    }];
}
- (void)removeCommentOnAlert:(PFObject *)object byUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion {
    PFQuery *query = [PFQuery queryWithClassName:kCommentsClassName];
    [query whereKey:kCommentsUserPointer equalTo:user];
    [query whereKey:kCommentsAlertPointer equalTo:object];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error == nil) {
            PFObject *commentAlert = objects[0];
            if (objects.count > 0) {
                [object incrementKey:kAlertsComments byAmount:[NSNumber numberWithInt:-1]];
                [object saveInBackground];
                [commentAlert deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    if (error == nil) {
                        compeltion(@(succeeded), error);
                    } else {
                        compeltion(NO, error);
                    }
                }];
            } else {
                compeltion(NO, error);
            }
            
        } else {
            compeltion(NO, error);
        }
    }];
}
- (void)likeAlert:(PFObject *)object byUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion {
    PFQuery *query = [PFQuery queryWithClassName:kLikesClassName];
    [query whereKey:kLikesLikedBy equalTo:user];
    [query whereKey:kLikesAlertPointer equalTo:object];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error == nil) {
            PFObject *likeAlert = [PFObject objectWithClassName:kLikesClassName];
            if (objects.count == 0) {
                [object incrementKey:kAlertsLikes byAmount:[NSNumber numberWithInt:1]];
                [object saveInBackground];
                likeAlert[kLikesLikedBy] = user;
                likeAlert[kLikesAlertPointer] = object;
                [likeAlert saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    if (error == nil) {
                        compeltion(@(succeeded), error);
                    } else {
                        compeltion(NO, error);
                    }
                }];
            } else {
                compeltion(NO, error);
            }
            
        } else {
            compeltion(NO, error);
        }
    }];
}
- (void)disLikeAlert:(PFObject *)object byUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion {
    PFQuery *query = [PFQuery queryWithClassName:kLikesClassName];
    [query whereKey:kLikesLikedBy equalTo:user];
    [query whereKey:kLikesAlertPointer equalTo:object];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error == nil) {
            PFObject *likeAlert = objects[0];
            if (objects.count > 0) {
                [object incrementKey:kAlertsLikes byAmount:[NSNumber numberWithInt:-1]];
                [object saveInBackground];
                [likeAlert deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    if (error == nil) {
                        compeltion(@(succeeded), error);
                    } else {
                        compeltion(NO, error);
                    }
                }];
            } else {
                compeltion(NO, error);
            }
            
        } else {
            compeltion(NO, error);
        }
    }];
}
- (void)isAlertCommentedByCurrentUser:(PFObject *)object completion:(HelperBlockCompletion)compeltion {
    PFQuery *query = [PFQuery queryWithClassName:kCommentsClassName];
    [query whereKey:kCommentsUserPointer equalTo:[PFUser currentUser]];
    [query whereKey:kCommentsAlertPointer equalTo:object];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error == nil) {
            compeltion(@((objects.count > 0)), error);
        } else {
            compeltion(NO, error);
        }
    }];
}
- (void)isAlertLikedByCurrentUser:(PFObject *)object completion:(HelperBlockCompletion)compeltion {
    PFQuery *query = [PFQuery queryWithClassName:kLikesClassName];
    [query whereKey:kLikesLikedBy equalTo:[PFUser currentUser]];
    [query whereKey:kLikesAlertPointer equalTo:object];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error == nil) {
            compeltion(@((objects.count > 0)), error);
        } else {
            compeltion(NO, error);
        }
    }];
}
#pragma mark - CONVERSATION Methods

- (void)startConversationWithUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion {
    
    NSString *conversationId = [self randomString:kConversationRandomStringLength];
    
    PFObject *conversation = [PFObject objectWithClassName:kConversationsClassName];
    conversation[kConversationsConversationId] = conversationId;
    conversation[kConversationsSenderUser] = [PFUser currentUser];
    conversation[kConversationsRecipientUser] = user;
    conversation[kConversationsLastMessage] = @"";
    conversation[kConversationsUnreadCounter] = @(0);
    conversation[kConversationsLastUpdate] = [NSDate date];
    conversation[kConversationsDescription] = @"Private Conversation";
    
    [conversation saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        compeltion(@(succeeded), error);
    }];
}
- (void)isConversationExistFromUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion {
    PFQuery *query = [PFQuery queryWithClassName:kConversationsClassName];
    [query whereKey:kConversationsSenderUser equalTo:user];
    [query whereKey:kConversationsRecipientUser equalTo:[PFUser currentUser]];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error == nil) {
            compeltion(@((objects.count > 0)), error);
        } else {
            compeltion(NO, error);
        }
    }];
}
- (void)isConversationExistToUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion {
    PFQuery *query = [PFQuery queryWithClassName:kConversationsClassName];
    [query whereKey:kConversationsSenderUser equalTo:[PFUser currentUser]];
    [query whereKey:kConversationsRecipientUser equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error == nil) {
            compeltion(@((objects.count > 0)), error);
        } else {
            compeltion(NO, error);
        }
    }];
}
- (void)getConversationsListForUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion {
    PFQuery *query = [PFQuery queryWithClassName:kConversationsClassName];
    [query whereKey:kConversationsSenderUser equalTo:[PFUser currentUser]];
    [query includeKey:kConversationsRecipientUser];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error == nil) {
            compeltion(objects, error);
        } else {
            compeltion(nil, error);
        }
    }];
}
- (void)sendMessage:(NSString *)message withAttachement:(NSURL *)attachmentURL toConversation:(PFObject *)conversation completion:(HelperBlockCompletion)compeltion {
    
    PFFile *fileVideo = nil;
    PFFile *filePicture = nil;
    
    NSString *attachmentMime = [self MIMEForFileURL:attachmentURL];
    if (attachmentURL != nil) {
        if ([attachmentMime containsString:@"video"]) {
            // attachment is video
            message = @"[Video message]";
            fileVideo = [PFFile fileWithName:@"video.mp4" data:[[NSFileManager defaultManager] contentsAtPath:attachmentURL.path]];
            [fileVideo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
            }];
        } else if ([attachmentMime containsString:@"image"]) {
            // attachment is image
            message = @"[Picture message]";
            filePicture = [PFFile fileWithName:@"picture.jpg" data:UIImageJPEGRepresentation([UIImage imageWithData:[NSData dataWithContentsOfURL:attachmentURL]], 0.6)];
            [filePicture saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                
            }];
        }
    }
    PFObject *messageObject = [PFObject objectWithClassName:kMessagesClassName];
    messageObject[kMessagesUser] = [PFUser currentUser];
    messageObject[kMessagesConversationId] = conversation[kMessagesConversationId];
    messageObject[kMessagesText] = message;
    if (fileVideo != nil) messageObject[kMessagesAttachment] = fileVideo;
    if (filePicture != nil) messageObject[kMessagesAttachment] = filePicture;
    
    [messageObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        compeltion(@(succeeded), error);
    }];
}
#pragma mark - ACTIVITY Methods

- (void)saveLikeActivityForUser:(PFUser *)user andAlert:(PFObject *)object completion:(HelperBlockCompletion)compeltion {
    PFObject *likeActivity = [PFObject objectWithClassName:kActivitiesClassName];
    likeActivity[kActivitiesCurrentUser] = [PFUser currentUser];
    likeActivity[kActivitiesType] = @"like";
    likeActivity[kActivitiesOtherUser] = user;
    likeActivity[kActivitiesText] = [NSString stringWithFormat:@"%@ liked your alert",[PFUser currentUser][kUsersFullName]];
    likeActivity[kActivitiesAlertPointer] = object;
    [likeActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        compeltion(@(succeeded), error);
    }];
}
- (void)saveFollowActivityForUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion {
    PFObject *followActivity = [PFObject objectWithClassName:kActivitiesClassName];
    followActivity[kActivitiesCurrentUser] = [PFUser currentUser];
    followActivity[kActivitiesType] = @"follow";
    followActivity[kActivitiesOtherUser] = user;
    followActivity[kActivitiesText] = [NSString stringWithFormat:@"%@ followed you",[PFUser currentUser][kUsersFullName]];
    [followActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        compeltion(@(succeeded), error);
    }];
}
- (void)getActivitiesForUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion {
    PFQuery *query = [PFQuery queryWithClassName:kActivitiesClassName];
    [query whereKey:kActivitiesCurrentUser equalTo:user];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error == nil) {
            compeltion(@(objects.count), error);
        } else {
            compeltion(0, error);
        }
    }];
}
#pragma mark - FOLLOW Methods

- (void)getFollowersCountForUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion {
    PFQuery *query = [PFQuery queryWithClassName:kFollowsClassName];
    [query whereKey:kFollowsIsFollowing equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error == nil) {
            compeltion(@(objects.count), error);
        } else {
            compeltion(0, error);
        }
    }];
}
- (void)getFollowingCountForUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion {
    PFQuery *query = [PFQuery queryWithClassName:kFollowsClassName];
    [query whereKey:kFollowsAUser equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error == nil) {
            compeltion(@(objects.count), error);
        } else {
            compeltion(0, error);
        }
    }];
}
- (void)getFollowersForUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion {
    PFQuery *query = [PFQuery queryWithClassName:kFollowsClassName];
    [query whereKey:kFollowsIsFollowing equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error == nil) {
            compeltion(objects, error);
        } else {
            compeltion(nil, error);
        }
    }];
}
- (void)getFollowingForUser:(PFUser *)user completion:(HelperBlockCompletion)compeltion {
    PFQuery *query = [PFQuery queryWithClassName:kFollowsClassName];
    [query whereKey:kFollowsAUser equalTo:user];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error == nil) {
            compeltion(objects, error);
        } else {
            compeltion(nil, error);
        }
    }];
}
- (void)isThisUser:(PFUser *)firstUser followThisUser:(PFUser *)secondUser completion:(HelperBlockCompletion)compeltion {
    
    PFQuery *query = [PFQuery queryWithClassName:kFollowsClassName];
    [query whereKey:kFollowsAUser equalTo:firstUser];
    [query whereKey:kFollowsIsFollowing equalTo:secondUser];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        if (error == nil) {
            compeltion(@((objects.count > 0)), error);
        } else {
            compeltion(NO, error);
        }
    }];
}
- (void)changeFollowStateOfUser:(PFUser *)user unFollow:(BOOL)unfollow completion:(HelperBlockCompletion)compeltion {
    if (![user.objectId isEqual:[PFUser currentUser].objectId]) {
        
        PFUser *currentUser = [PFUser currentUser];
        __block PFObject *followObject = [PFObject objectWithClassName:kFollowsClassName];
        if (unfollow) {
            PFQuery *query = [PFQuery queryWithClassName:kFollowsClassName];
            [query whereKey:kFollowsAUser equalTo:currentUser];
            [query whereKey:kFollowsIsFollowing equalTo:user];
            [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
                if (error == nil) {
                    if (objects.count > 0) {
                        followObject = objects[0];
                        [followObject deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                            compeltion(@(succeeded), error);
                        }];
                    } else {
                        compeltion(NO, error);
                    }
                } else {
                    compeltion(NO, error);
                }
            }];
        } else {
            followObject[kFollowsAUser] = currentUser;
            followObject[kFollowsIsFollowing] = user;
            [followObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                compeltion(@(succeeded), error);
            }];
        }
    } else {
        compeltion(nil, [NSError errorWithDomain:kCAUnFollowErrorDomain code:-1000 userInfo:@{ NSLocalizedDescriptionKey: @"Cannot follow/unfollow yourself" }]);
    }
}
#pragma mark - Parse Methods

- (void)initParseServer {
    [Parse setLogLevel:PFLogLevelDebug];
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = kParseAppId;
        configuration.clientKey = kParseAppClientKey;
        configuration.server = kParseApiAddress;
        configuration.localDatastoreEnabled = YES;
    }]];
}
- (void)trackWithLaunchOptions:(NSDictionary *)launchOptions {
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
}
#pragma mark - Facebook Methods

- (void)initFacebookUtilsWithLaunchOptions:(NSDictionary *)launchOptions {
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:launchOptions];
}

#pragma mark - TWITTER Methods

- (void)initTwitterUtils {
    [PFTwitterUtils initializeWithConsumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
}
#pragma mark - PUSH Methods

- (void)initOneSignalWithLaunchOptions:(NSDictionary *)launchOptions {
    [OneSignal initWithLaunchOptions:launchOptions
                               appId:kOneSignalAppId];
}

#pragma mark - Check Invalid Session Token
- (void)checkInvalidCurrentToken {
    PFUser *currentUser = [PFUser currentUser];
    if ([currentUser isAuthenticated]) {
        [PFUser becomeInBackground:[currentUser sessionToken] block:^(PFUser * _Nullable user, NSError * _Nullable error) {
            if (error != nil) {
                [PFUser logOutInBackground];
            }
        }];
    }
}

#pragma mark - Private Methods

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size andScale:(CGFloat)scale {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    [image drawInRect:rect];
    UIImage *resized = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resized;
}
- (BOOL)isValidPasswordConfirmation:(NSDictionary *)passwords {
    if(![passwords[kUsersPassword] isEqualToString:passwords[kUsersPasswordConfirmation]]) {
        return NO;
    }
    return YES;
}
- (BOOL)isValidPassword:(NSString *)password {
    if(password.length < kPasswordMinimumLength) {
        return NO;
    }
    return YES;
}
- (BOOL)isValidEmail:(NSString *)email {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
- (BOOL)isValidUsername:(NSString *)username {
    if(username.length < kUsernameMinimumLength) {
        return NO;
    }
//    if(![username hasPrefix:@"@"]) {
//        return NO;
//    }
    NSCharacterSet *set = [[NSCharacterSet
                            characterSetWithCharactersInString:@"@ABCDEFGHIKLMNOPQRSTUVWXYZabcdefghilkmnopqrstuvwxyz1234567890._"] invertedSet];
    if ([username rangeOfCharacterFromSet:set].location != NSNotFound){
        return NO;
    } else {
        return YES;
    }
}
- (NSString *)randomString:(int)len {
    static NSString *LETTERS = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i = 0; i < len; ++i) {
        [randomString appendFormat:@"%C", [LETTERS characterAtIndex:(arc4random() % [LETTERS length])]];
    }
    
    return randomString;
}
- (NSString *)MIMEForFileURL:(NSURL *)url
{
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef)url.pathExtension, NULL);
    CFStringRef mimeType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    return (NSString *)CFBridgingRelease(mimeType) ;
}
- (void)openImagePickerFromTarget:(id)target completion:(HelperBlockCompletion)compeltion {
    [target addPhotoWithCompletionHandler:^(BOOL success, UIImage *image) {
        if (success) {
            compeltion(image, nil);
        } else {
            //When fail or cancel
            compeltion(nil, [NSError errorWithDomain:kCAUnFollowErrorDomain code:-2000 userInfo:@{ NSLocalizedDescriptionKey: @"Cannot pick/capture image" }]);
        }
    }];
}
- (void)cropCircleImage:(UIImage *)image fromTarget:(id)target {
    TOCropViewController *cropViewController = [[TOCropViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleCircular image:image];
    cropViewController.delegate = target;
    if (IS_IPAD) {
        [cropViewController setModalPresentationStyle:UIModalPresentationFormSheet];
    }
    [target presentViewController:cropViewController animated:YES completion:nil];
}
- (void)cropImage:(UIImage *)image fromTarget:(id)target {
    TOCropViewController *cropViewController = [[TOCropViewController alloc] initWithCroppingStyle:TOCropViewCroppingStyleDefault image:image];
    cropViewController.delegate = target;
    if (IS_IPAD) {
        [cropViewController setModalPresentationStyle:UIModalPresentationFormSheet];
    }
    [target presentViewController:cropViewController animated:YES completion:nil];
}
- (void)showPickerFromTarget:(id)target withOptions:(NSArray *)options andMessage:(NSString *)message completion:(HelperBlockCompletion)compeltion {
    UIAlertController *pickerAlert = [UIAlertController alertControllerWithTitle:kAppName message:message preferredStyle:UIAlertControllerStyleAlert];
    for (NSString *option in options) {
        [pickerAlert addAction:[UIAlertAction actionWithTitle:option style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            compeltion(action, nil);
        }]];
    }
    [pickerAlert addAction:[UIAlertAction actionWithTitle:@"Annuler" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [target presentViewController:pickerAlert animated:YES completion:nil];
}
- (UIImage *)roundedRectImageFromImage:(UIImage *)image withRadious:(CGFloat)radious {
    
    if(radious == 0.0f)
        return image;
    
    if( image != nil) {
        
        CGFloat imageWidth = image.size.width;
        CGFloat imageHeight = image.size.height;
        
        CGRect rect = CGRectMake(0.0f, 0.0f, imageWidth, imageHeight);
        UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        const CGFloat scale = window.screen.scale;
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, scale);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextBeginPath(context);
        CGContextSaveGState(context);
        CGContextTranslateCTM (context, CGRectGetMinX(rect), CGRectGetMinY(rect));
        CGContextScaleCTM (context, radious, radious);
        
        CGFloat rectWidth = CGRectGetWidth (rect)/radious;
        CGFloat rectHeight = CGRectGetHeight (rect)/radious;
        
        CGContextMoveToPoint(context, rectWidth, rectHeight/2.0f);
        CGContextAddArcToPoint(context, rectWidth, rectHeight, rectWidth/2.0f, rectHeight, radious);
        CGContextAddArcToPoint(context, 0.0f, rectHeight, 0.0f, rectHeight/2.0f, radious);
        CGContextAddArcToPoint(context, 0.0f, 0.0f, rectWidth/2.0f, 0.0f, radious);
        CGContextAddArcToPoint(context, rectWidth, 0.0f, rectWidth, rectHeight/2.0f, radious);
        CGContextRestoreGState(context);
        CGContextClosePath(context);
        CGContextClip(context);
        
        [image drawInRect:CGRectMake(0.0f, 0.0f, imageWidth, imageHeight)];
        
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    
    return nil;
}
- (UIStoryboard *)mainStoryboard {
    return [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];

}
- (NSString *)getLibraryPath {
    NSString* libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return libraryPath;
}

- (NSString*)getDocumentsPath {
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [searchPaths objectAtIndex: 0];
    return documentPath;
}

- (CGRect)windowBounds {
    return [[UIApplication sharedApplication] keyWindow].bounds;
}
- (BOOL)isIPHONE {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone);
}
- (BOOL)isIPAD {
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
}

- (BOOL)isIPHONE4 {
    return ([self isIPHONE] && [self windowBounds].size.height < 568.0);
}
- (BOOL)isIPHONE5 {
    return ([self isIPHONE] && [self windowBounds].size.height == 568.0);
}
- (BOOL)isIPHONE6 {
    return ([self isIPHONE] && [self windowBounds].size.height == 667.0);
}
- (BOOL)isIPHONE6PLUS {
    return ([self isIPHONE] && ([self windowBounds].size.height == 736.0 || [self windowBounds].size.width == 736.0));
}
- (BOOL)systemVersionGreaterThanOrEqual:(NSString *)number {
    return  ([[[UIDevice currentDevice] systemVersion] compare:number options:NSNumericSearch] != NSOrderedAscending);
}
- (void)stayLTR {
    
    if ([self systemVersionGreaterThanOrEqual:@"9.0"]) {
        [[UIView appearance] setSemanticContentAttribute:UISemanticContentAttributeForceLeftToRight];
        [[UIView appearanceWhenContainedInInstancesOfClasses:@[[UINavigationController class], [UIAlertView class], [UIButton class], [UILabel class], [UITextField class], [UITextView class], [UIAlertController class], [UIViewController class], [UIView class], [UIImageView class], [UIScrollView class]]] setSemanticContentAttribute:UISemanticContentAttributeUnspecified];
    }
}
@end
