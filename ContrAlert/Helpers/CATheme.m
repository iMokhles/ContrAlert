//
//  CATheme.m
//  ContrAlert
//
//  Created by iMokhles on 19/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import "CATheme.h"
#import "Colours.h"
#import "CAConstant.h"
#import "EAIntroView.h"
#import "CAMacros.h"
#import "PureLayout.h"
#import "CAConstraintHelper.h"
#import "FAKFontAwesome.h"
#import "CAHelper.h"
#import "ECSlidingViewController.h"

@implementation CATheme

static BOOL useinside = NO;
static id _sharedTheme = nil;

+(CATheme *)defaultTheme {
    static dispatch_once_t p = 0;
    dispatch_once(&p, ^{
        useinside = YES;
        _sharedTheme = [[CATheme alloc] init];
        useinside = NO;
    });
    return _sharedTheme;
}

+ (instancetype) alloc {
    if (!useinside) {
        @throw [NSException exceptionWithName:@"Singleton Vialotaion" reason:@"You are violating the singleton class usage. Please call +defaultTheme method" userInfo:nil];
    }
    else {
        return [super alloc];
    }
}
+ (instancetype) new {
    if (!useinside) {
        @throw [NSException exceptionWithName:@"Singleton Vialotaion" reason:@"You are violating the singleton class usage. Please call +defaultTheme method" userInfo:nil];
    }
    else {
        return [super new];
    }
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _mainBackgroundColor = [UIColor colorFromHexString:kBackgroundColorHex];
        _googleColor = [UIColor colorFromHexString:kGoogleColorHex];
        _facebookColor = [UIColor colorFromHexString:kFacebookColorHex];
        _twitterColor = [UIColor colorFromHexString:kTwitterColorHex];
        
        _profileThumbnailSize = kProfileThumbnailSize;
        _profileAvatarSize = kProfileAvatarSize;
        _introPagesCount = kIntroPagesCount;
        _introPages = [self setupIntroPagesWithCount:_introPagesCount];
        
    }
    return self;
}
- (void)buttonWithIcon:(UIButton *)button iconId:(NSString *)iconId {
    if ([iconId containsString:@"fa-"]
        || [iconId containsString:@"fi-"]
        || [iconId containsString:@"ion-"]
        || [iconId containsString:@"zocial"]) {
        
        FAKFontAwesome *starIcon = [FAKFontAwesome  iconWithIdentifier:iconId size:20 error:nil];
        [starIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
        [button setBackgroundImage:[starIcon imageWithSize:CGSizeMake(button.frame.size.width, button.frame.size.height)] forState:UIControlStateNormal];
    }
    
    
    
}
- (UIImage *)imageFromIconId:(NSString *)iconId fontSize:(float)fontSize size:(CGSize)size color:(UIColor *)color {
    FAKFontAwesome *starIcon = [FAKFontAwesome  iconWithIdentifier:iconId size:fontSize error:nil];
    [starIcon addAttribute:NSForegroundColorAttributeName value:color];
    
    return [starIcon imageWithSize:size];
}
- (void)facebookButton:(UIButton *)button {
    [button setBackgroundColor:[self facebookColor]];
    
    FAKFontAwesome *facebookIcon = [FAKFontAwesome facebookIconWithSize:40];
    [facebookIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    NSMutableAttributedString *facebookMas = [[facebookIcon attributedString] mutableCopy];
    [button setAttributedTitle:facebookMas forState:UIControlStateNormal];

}
- (void)twitterButton:(UIButton *)button {
    [button setBackgroundColor:[self twitterColor]];
    
    FAKFontAwesome *twitterIcon = [FAKFontAwesome twitterIconWithSize:40];
    [twitterIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    NSMutableAttributedString *twitterMas = [[twitterIcon attributedString] mutableCopy];
    [button setAttributedTitle:twitterMas forState:UIControlStateNormal];
    
}
- (void)googlePlusButton:(UIButton *)button {
    [button setBackgroundColor:[self googleColor]];
    
    FAKFontAwesome *googleIcon = [FAKFontAwesome googlePlusIconWithSize:40];
    [googleIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    NSMutableAttributedString *googleMas = [[googleIcon attributedString] mutableCopy];
    [button setAttributedTitle:googleMas forState:UIControlStateNormal];
}
- (void)changeFieldPlaceholderColor:(UITextField *)field withColor:(UIColor *)color andText:(NSString *)text {
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:text attributes:@{ NSForegroundColorAttributeName : color }];
    field.attributedPlaceholder = str;
}
- (void)addLeftIconToField:(UITextField *)field withIcon:(NSString *)iconId {
    if ([iconId containsString:@"fa-"]
        || [iconId containsString:@"fi-"]
        || [iconId containsString:@"ion-"]
        || [iconId containsString:@"zocial"]) {
        [field setLeftViewMode:UITextFieldViewModeAlways];
        FAKFontAwesome *starIcon = [FAKFontAwesome  iconWithIdentifier:iconId size:20 error:nil];
        [starIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
        
        UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -2, 44, 44)];
        [iconView setImage:[starIcon imageWithSize:CGSizeMake(44, 44)]];
        [spaceView addSubview:iconView];
//        [CAConstraintHelper centerView:iconView inView:spaceView xConstant:0 yConstant:0];
        [field setLeftView:spaceView];
    }
}
- (void)addCornerBorderTo:(UIView *)view color:(UIColor *)color width:(float)width {
    view.layer.borderWidth = width;
    view.layer.borderColor = [color CGColor];
}
- (void)addCornerView:(UIView *)view radius:(float)radius {
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = true;
    view.clipsToBounds = true;
}
- (void)makeCircleView:(UIView *)view {
    view.layer.cornerRadius = view.frame.size.width/2.0;
    view.layer.masksToBounds = true;
    view.clipsToBounds = true;
}
- (void)setShadowToView:(UIView *)view color:(UIColor *)color offset:(CGSize)offset radius:(float)radius opacity:(float)opacity {
    view.layer.shadowColor = [color CGColor];
    view.layer.shadowOffset = offset;
    view.layer.shadowRadius = radius;
    view.layer.shadowOpacity = opacity;
}
- (NSArray *)setupIntroPagesWithCount:(NSInteger)pages {
    NSMutableArray *introPages = [NSMutableArray array];
    for(int i = 1; i <= pages ; i++) {
        UIView *introView = [self customIntroView:i];
        EAIntroPage *page = [EAIntroPage pageWithCustomView:introView];
        [introPages addObject:page];
    }
    return introPages;
}
- (UIView *)customIntroView:(NSInteger)pageNumber {
    
    NSDictionary *appIntro = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AppIntro" ofType:@"plist"]];
    NSArray *infoArray = [appIntro objectForKey:@"Info"];
    NSDictionary *infoDict = [infoArray objectAtIndex:pageNumber-1];
    
    UIView *introView = [[UIView alloc] initWithFrame:MAIN_WINDOW.bounds];
    [introView setBackgroundColor:[UIColor ghostWhiteColor]];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_WINDOW.bounds.size.width, 200)];
    topView.translatesAutoresizingMaskIntoConstraints = NO;
    [topView setBackgroundColor:[UIColor ghostWhiteColor]];
    topView.layer.masksToBounds = NO;
    topView.layer.shadowColor = [[UIColor blackColor] CGColor];
    topView.layer.shadowOffset = CGSizeMake(1, 1);
    topView.layer.shadowRadius = 2;
    topView.layer.shadowOpacity = 0.5;
    [introView addSubview:topView];
    
    [CAConstraintHelper layoutTopView:topView inView:introView withConstant:20];
    [CAConstraintHelper layoutTrailingView:topView inView:introView withConstant:-10];
    [CAConstraintHelper layoutLeadingView:topView inView:introView withConstant:10];
    [CAConstraintHelper addHeightConstraintToView:topView withHeight:250];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MAIN_WINDOW.bounds.size.width, 200)];
    bottomView.translatesAutoresizingMaskIntoConstraints = NO;
    [bottomView setBackgroundColor:[UIColor ghostWhiteColor]];
    bottomView.layer.masksToBounds = NO;
    bottomView.layer.shadowColor = [[UIColor blackColor] CGColor];
    bottomView.layer.shadowOffset = CGSizeMake(1, 1);
    bottomView.layer.shadowRadius = 2;
    bottomView.layer.shadowOpacity = 0.0;
    [introView addSubview:bottomView];
    
    [CAConstraintHelper layoutBottomView:bottomView inView:introView withConstant:0];
    [CAConstraintHelper layoutTrailingView:bottomView inView:introView withConstant:0];
    [CAConstraintHelper layoutLeadingView:bottomView inView:introView withConstant:0];
    [CAConstraintHelper addHeightConstraintToView:bottomView withHeight:100];
    
    UIImageView *centerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, topView.frame.size.width, 250)];
    centerView.translatesAutoresizingMaskIntoConstraints = NO;
    [centerView setBackgroundColor:[UIColor redColor]];
    centerView.layer.cornerRadius = 40;
    centerView.layer.masksToBounds = NO;
    centerView.layer.shadowColor = [[UIColor blackColor] CGColor];
    centerView.layer.shadowOffset = CGSizeMake(1, 1);
    centerView.layer.shadowRadius = 2;
    centerView.layer.shadowOpacity = 0.5;
    
    centerView.image = [UIImage imageNamed:[infoDict objectForKey:@"pageImage"]];
    [topView addSubview:centerView];
    
    
    [CAConstraintHelper layoutTopView:centerView inView:topView withConstant:20];
    [CAConstraintHelper layoutTrailingView:centerView inView:topView withConstant:-10];
    [CAConstraintHelper layoutLeadingView:centerView inView:topView withConstant:10];
    [CAConstraintHelper layoutBottomView:centerView inView:topView withConstant:20];
//    [CAConstraintHelper addHeightConstraintToView:centerView withHeight:250];
    
//    [CAConstraintHelper centerView:centerView inView:topView xConstant:0 yConstant:0];
//    [CAConstraintHelper addHeightConstraintToView:centerView withHeight:250];
//    [CAConstraintHelper addWidthConstraintToView:centerView withWidth:150];
    
    [CAConstraintHelper layoutView:bottomView underView:topView withConstant:20];
    
    UILabel *introLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, MAIN_WINDOW.bounds.size.width, 100)];
    introLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [introLabel setText:[infoDict objectForKey:@"pageTitle"]];
    
    
    [introLabel setFont:[UIFont fontWithName:@"Arial" size:17]];
    [introLabel setTextAlignment:NSTextAlignmentCenter];
    [introLabel setNumberOfLines:0];
    [introLabel setTextColor:[UIColor blackColor]];
    [introLabel setBackgroundColor:[UIColor clearColor]];
    [bottomView addSubview:introLabel];
    
    [CAConstraintHelper centerView:introLabel inView:bottomView xConstant:0 yConstant:0];
    [CAConstraintHelper addHeightConstraintToView:introLabel withHeight:100];
    [CAConstraintHelper addWidthConstraintToView:introLabel withWidth:MAIN_WINDOW.bounds.size.width];
    
//    [CAConstraintHelper layoutView:bottomView underView:topView withConstant:20];
    return introView;
}
- (void)setSideMenuTopViewController:(id)target {
    if ([PFUser currentUser] != nil) {
        ECSlidingViewController *mainViewController = [[[CAHelper sharedInstance] mainStoryboard] instantiateViewControllerWithIdentifier:@"slidingVC"];
        mainViewController.topViewController = target;
        [UIApplication sharedApplication].delegate.window.rootViewController = mainViewController;
        
        [UIView transitionWithView:[UIApplication sharedApplication].delegate.window
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:nil
                        completion:nil];
    }
}
- (void)setMainViewControllerIfNeeded {
    if ([PFUser currentUser] != nil) {
        ECSlidingViewController *mainViewController = [[[CAHelper sharedInstance] mainStoryboard] instantiateViewControllerWithIdentifier:@"slidingVC"];
        [UIApplication sharedApplication].delegate.window.rootViewController = mainViewController;
        
        [UIView transitionWithView:[UIApplication sharedApplication].delegate.window
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:nil
                        completion:nil];
    } else {
        
        [UIApplication sharedApplication].delegate.window.rootViewController = [[[CAHelper sharedInstance] mainStoryboard] instantiateViewControllerWithIdentifier:@"launchNVC"];
        
        [UIView transitionWithView:[UIApplication sharedApplication].delegate.window
                          duration:0.3
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:nil
                        completion:nil];
    }
}
@end
