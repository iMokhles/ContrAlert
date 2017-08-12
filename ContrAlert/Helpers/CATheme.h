//
//  CATheme.h
//  ContrAlert
//
//  Created by iMokhles on 19/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CATheme : NSObject
+(CATheme *)defaultTheme;

@property (readonly, nonatomic) UIColor *mainBackgroundColor;
@property (readonly, nonatomic) CGSize profileThumbnailSize;
@property (readonly, nonatomic) CGSize profileAvatarSize;
@property (readonly, nonatomic) NSArray *introPages;
@property (readonly, nonatomic) NSInteger introPagesCount;

@property (readonly, nonatomic) UIColor *googleColor;
@property (readonly, nonatomic) UIColor *facebookColor;
@property (readonly, nonatomic) UIColor *twitterColor;

- (NSArray *)setupIntroPagesWithCount:(NSInteger)pages;

- (UIImage *)imageFromIconId:(NSString *)iconId fontSize:(float)fontSize size:(CGSize)size color:(UIColor *)color;
- (void)buttonWithIcon:(UIButton *)button iconId:(NSString *)iconId;
- (void)facebookButton:(UIButton *)button;
- (void)twitterButton:(UIButton *)button;
- (void)googlePlusButton:(UIButton *)button;
- (void)changeFieldPlaceholderColor:(UITextField *)field withColor:(UIColor *)color andText:(NSString *)text;
- (void)addLeftIconToField:(UITextField *)field withIcon:(NSString *)iconId;
- (void)addCornerBorderTo:(UIView *)view color:(UIColor *)color width:(float)width;
- (void)addCornerView:(UIView *)view radius:(float)radius;
- (void)makeCircleView:(UIView *)view;
- (void)setShadowToView:(UIView *)view color:(UIColor *)color offset:(CGSize)offset radius:(float)radius opacity:(float)opacity;
@end
