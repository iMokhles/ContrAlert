//
//  CAHelper.m
//  ContrAlert
//
//  Created by iMokhles on 19/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import "CAHelper.h"
#import "CABackendKeys.h"

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

#pragma mark - ALERT Methods

#pragma mark - CONVERSATION Methods

#pragma mark - ACTIVITY Methods

#pragma mark - FOLLOW Methods

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
    [PFTwitterUtils initializeWithConsumerKey:@"" consumerSecret:@""];
}
#pragma mark - PUSH Methods

- (void)initOneSignalWithLaunchOptions:(NSDictionary *)launchOptions {
    [OneSignal initWithLaunchOptions:launchOptions
                               appId:kOneSignalAppId];
}


@end
