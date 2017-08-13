//
//  CANavigationView.m
//  ContrAlert
//
//  Created by iMokhles on 13/08/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import "CANavigationView.h"
#import "CAHelper.h"
#import "CATheme.h"

@interface CANavigationView ()
@property (nonatomic, strong) IBOutlet UIButton *backBtn;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@end

@implementation CANavigationView

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupButtons];
}
- (void)setupButtons {
    [[CATheme defaultTheme] buttonWithIcon:_backBtn iconId:@"fa-chevron-left"];
}
- (IBAction)backBtnTapped:(id)sender {
    if (self.backBtnClicked) {
        self.backBtnClicked();
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
