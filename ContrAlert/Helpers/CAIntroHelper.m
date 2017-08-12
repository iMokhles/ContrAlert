//
//  CAIntroHelper.m
//  ContrAlert
//
//  Created by iMokhles on 22/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import "CAIntroHelper.h"
#import "CATheme.h"
#import "CAMacros.h"

static BOOL useinside = NO;
static id _sharedInstance = nil;

@implementation CAIntroHelper

+(CAIntroHelper *)sharedInstance {
    static dispatch_once_t p = 0;
    dispatch_once(&p, ^{
        useinside = YES;
        _sharedInstance = [[CAIntroHelper alloc] init];
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
-(void)showIntroView:(UIViewController *)rootViewController completion:(CAIntroDidFinish )completion {
    CATheme *defaultTheme = [CATheme defaultTheme];
    NSArray *introPages = [defaultTheme introPages];
    rootView = rootViewController.view;
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:introPages];
    [intro setDelegate:self];
    [intro setPageControlY:-100];
    [intro setSkipButton:nil];
    [intro showInView:rootView animateDuration:0.3];
}
- (void)introDidFinish:(EAIntroView *)introView {
    if(_introDidFinish)
        _introDidFinish();
}
@end
