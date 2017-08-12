//
//  CALoginViewController.m
//  ContrAlert
//
//  Created by iMokhles on 22/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import "CALoginViewController.h"
#import "CATheme.h"
#import "CAHelper.h"
#import "CAMacros.h"
#import "CABackendKeys.h"
#import "FAKFontAwesome.h"

@interface CALoginViewController ()

@property (nonatomic, strong) IBOutlet UIButton *backBtn;

@property (nonatomic, strong) IBOutlet UIButton *googleBtn;
@property (nonatomic, strong) IBOutlet UIButton *facebookBtn;
@property (nonatomic, strong) IBOutlet UIButton *twitterBtn;

@property (nonatomic, strong) IBOutlet UIButton *loginBtn;
@property (nonatomic, strong) IBOutlet UIButton *signupBtn;
@property (nonatomic, strong) IBOutlet UIButton *forgotBtn;

@property (nonatomic, strong) IBOutlet UITextField *usernameField;
@property (nonatomic, strong) IBOutlet UITextField *passwordField;
@end

@implementation CALoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self setupButtons];
    [self setupFields];
}

- (void)setupFields {
    [[CATheme defaultTheme] addLeftIconToField:_usernameField withIcon:@"fa-envelope"];
    [[CATheme defaultTheme] addLeftIconToField:_passwordField withIcon:@"fa-lock"];
    
    [[CATheme defaultTheme] changeFieldPlaceholderColor:_usernameField withColor:[UIColor whiteColor] andText:@"Identifiant"];
    [[CATheme defaultTheme] changeFieldPlaceholderColor:_passwordField withColor:[UIColor whiteColor] andText:@"Mot de passe"];
}
- (void)setupButtons {
    
    [[CATheme defaultTheme] buttonWithIcon:_backBtn iconId:@"fa-chevron-left"];
    
    [[CATheme defaultTheme] addCornerView:_loginBtn radius:30];
    
    [[CATheme defaultTheme] makeCircleView:_googleBtn];
    [[CATheme defaultTheme] makeCircleView:_facebookBtn];
    [[CATheme defaultTheme] makeCircleView:_twitterBtn];
    
    [[CATheme defaultTheme] addCornerBorderTo:_googleBtn color:[UIColor whiteColor] width:2];
    [[CATheme defaultTheme] addCornerBorderTo:_facebookBtn color:[UIColor whiteColor] width:2];
    [[CATheme defaultTheme] addCornerBorderTo:_twitterBtn color:[UIColor whiteColor] width:2];
    
    [[CATheme defaultTheme] googlePlusButton:_googleBtn];
    [[CATheme defaultTheme] facebookButton:_facebookBtn];
    [[CATheme defaultTheme] twitterButton:_twitterBtn];
    
}

- (IBAction)backButtonTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
