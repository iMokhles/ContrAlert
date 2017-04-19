//
//  CABackendKeys.h
//  ContrAlert
//
//  Created by iMokhles on 19/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#ifndef CABackendKeys_h
#define CABackendKeys_h

/* Application Keys */

#define kAppName @"ContrAlert"

/* Parse Keys */

#define kParseAppId @"tji9w8P9LQTvDb25nsjIBWvh9uNJSa7ojca0QAoM"
#define kParseAppClientKey @"fXiLN3WiIi2Cl2qG7SSogEP8rAn1QN0a4TW8VI1v"
#define kParseApiAddress @"https://parseapi.back4app.com/"

/* OneSignal Keys */

#define kOneSignalAppId @"69e263ff-1803-4fa3-8629-8d36ee9665d0"

/* Users */

#define kUsersClassName @"_User"
#define kUsersAvatar @"avatar"
#define kUsersCoverImage @"coverImage"
#define kUsersUserName @"username"
#define kUsersFullName @"fullName"
#define kUsersEmail @"email"
#define kUsersAboutMe @"aboutMe"
#define kUsersIsReported @"isReported"
#define kUsersReportMessage @"reportMessage"

/* Alerts */

#define kAlertsClassName @"Alerts"
#define kAlertsText @"text"
#define kAlertsUserPointer @"alertUser"
#define kAlertsImage @"alertImageFile"
#define kAlertsCity @"alertCity"
#define kAlertsLikes @"alertLikes"
#define kAlertsCreatedAt @"createdAt"
#define kAlertsIsReported @"isReported"
#define kAlertsReportMessage @"reportMessage"
#define kAlertsKeywords @"alertKeywords"

/* Activities */

#define kActivitiesClassName @"Activities"
#define kActivitiesCurrentUser @"currentUser"
#define kActivitiesOtherUser @"otherUser"
#define kActivitiesText @"activityText"

/* Likes */

#define kLikesClassName @"Likes"
#define kLikesLikedBy @"likedBy"
#define kLikesAlertPointer @"alertLiked"

/* Comments */

#define kCommentsClassName @"Comments"
#define kCommentsAlertPointer @"alertPointer"
#define kCommentsUserPointer @"userPointer"
#define kCommentsCommentText @"comment"

/* Follows */

#define kFollowsClassName @"Follows"
#define kFollowsAUser @"aUser"
#define kFollowsIsFollowing @"isFollowing"

/* Conversations */

#define kConversationsClassName @"Conversations"
#define kConversationsUser @"user"
#define kConversationsGroupId @"groupId"
#define kConversationsDescription @"description"
#define kConversationsLastUser @"lastUser"
#define kConversationsLastMessage @"lastMessage"
#define kConversationsCounter @"counter"
#define kConversationsUpdatedAction @"updatedAction"

/* Messages */

#define kMessagesClassName @"Messages"
#define kMessagesUser @"user"
#define kMessagesGroupId @"groupId"
#define kMessagesText @"text"
#define kMessagesPicture @"picture"
#define kMessagesVideo @"video"
#define kMessagesCreatedAt @"createdAt"

#endif /* CABackendKeys_h */
