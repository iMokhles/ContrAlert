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

/* Twitter Keys */

#define kTwitterConsumerKey @"69e263ff-1803-4fa3-8629-8d36ee9665d0"
#define kTwitterConsumerSecret @"69e263ff-1803-4fa3-8629-8d36ee9665d0"

/* Users */

#define kUsersClassName @"_User"
#define kUsersAvatar @"avatar"
#define kUsersAvatarThumbnail @"avatarThumbnail"
#define kUsersCoverImage @"coverImage"
#define kUsersUserName @"username"
#define kUsersFullName @"fullName"
#define kUsersEmail @"email"
#define kUsersPassword @"password"
#define kUsersPasswordConfirmation @"password_confirmation"
#define kUsersAboutMe @"aboutMe"
#define kUsersGender @"gender"

/* Reports */

#define kReportsClassName @"Reports"
#define kReportsObject @"reportsObject"
#define kReportsIsReported @"isReported"
#define kUsersReportMessage @"reportMessage"

/* Alerts */

#define kAlertsClassName @"Alerts"
#define kAlertsText @"text"
#define kAlertsUserPointer @"alertUser"
#define kAlertsImage @"alertImageFile"
#define kAlertsCity @"alertCity"
#define kAlertsLikes @"alertLikes"
#define kAlertsComments @"alertComments"
#define kAlertsLikers @"alertLikers"
#define kAlertsCommenters @"alertCommenters"
#define kAlertsCreatedAt @"createdAt"
#define kAlertsIsReported @"isReported"
#define kAlertsReportMessage @"reportMessage"
#define kAlertsReports @"alertReports"
#define kAlertsKeywords @"alertKeywords"

/* Activities */

#define kActivitiesClassName @"Activities"
#define kActivitiesCurrentUser @"currentUser"
#define kActivitiesOtherUser @"otherUser"
#define kActivitiesText @"activityText"
#define kActivitiesType @"activityType"
#define kActivitiesAlertPointer @"alertPointer"

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
#define kConversationsSenderUser @"senderUser"
#define kConversationsConversationId @"conversationId"
#define kConversationsDescription @"description"
#define kConversationsRecipientUser @"recipientUser"
#define kConversationsLastMessage @"lastMessage"
#define kConversationsUnreadCounter @"unreadCounter"
#define kConversationsLastUpdate @"lastUpdate"

/* Messages */

#define kMessagesClassName @"Messages"
#define kMessagesUser @"user"
#define kMessagesConversationId @"conversationId"
#define kMessagesText @"text"
#define kMessagesAttachment @"attachment"
#define kMessagesCreatedAt @"createdAt"

/* NSNotifications */

#define kRefreshCurrentConversation @"kRefreshCurrentConversation"
#define kRefreshCurrentConversationsList @"kRefreshCurrentConversationsList"
#define kRefreshTimeline @"kRefreshTimeline"
#define kRefreshActivties @"kRefreshActivties"

#endif /* CABackendKeys_h */
