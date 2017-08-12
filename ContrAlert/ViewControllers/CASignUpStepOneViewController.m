//
//  CASignUpStepOneViewController.m
//  ContrAlert
//
//  Created by iMokhles on 23/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import "CASignUpStepOneViewController.h"
#import "CASignUpStepTwoViewController.h"
#import "CATheme.h"
#import "CABackendKeys.h"
#import "Colours.h"
#import "CAHelper.h"
#import "TOCropViewController.h"

@interface CASignUpStepOneViewController () {
    UIImage *selectedAvatar;
}

@property (nonatomic, strong) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIButton *addAvatarBtn;

@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, strong) IBOutlet UITextField *nameField;
@property (nonatomic, strong) IBOutlet UITextField *usernameField;
@property (nonatomic, strong) IBOutlet UITextField *emailField;

@property (nonatomic, strong) IBOutlet UIButton *nextBtn;

@end

@implementation CASignUpStepOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupImageViews];
    [self setupButtons];
    [self setupFields];
}
- (void)setupFields {
    [[CATheme defaultTheme] addLeftIconToField:_nameField withIcon:@"fa-user-circle"];
    [[CATheme defaultTheme] addLeftIconToField:_usernameField withIcon:@"fa-user"];
    [[CATheme defaultTheme] addLeftIconToField:_emailField withIcon:@"fa-envelope"];
    
    [[CATheme defaultTheme] changeFieldPlaceholderColor:_nameField withColor:[UIColor whiteColor] andText:@"Nom complet"];
    [[CATheme defaultTheme] changeFieldPlaceholderColor:_usernameField withColor:[UIColor whiteColor] andText:@"Identifiant"];
    [[CATheme defaultTheme] changeFieldPlaceholderColor:_emailField withColor:[UIColor whiteColor] andText:@"Email"];
}
- (void)setupButtons {
    [[CATheme defaultTheme] buttonWithIcon:_backBtn iconId:@"fa-chevron-left"];
    [[CATheme defaultTheme] addCornerView:_nextBtn radius:22.5];
    
    [[CATheme defaultTheme] buttonWithIcon:_addAvatarBtn iconId:@"fa-plus"];
    [[CATheme defaultTheme] makeCircleView:_addAvatarBtn];
}
- (void)setupImageViews {
    [[CATheme defaultTheme] makeCircleView:_avatarImageView];
    [_avatarImageView setImage:[[CATheme defaultTheme] imageFromIconId:@"fa-user-circle" fontSize:40 size:CGSizeMake(114, 114) color:[UIColor whiteColor]]];
}

#pragma mark - Buttons Actions
- (IBAction)backButtonTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addAvatarButtonTapped:(id)sender {
    [[CAHelper sharedInstance] openImagePickerFromTarget:self completion:^(id object, NSError *error) {
        if (error == nil) {
            [[CAHelper sharedInstance] cropImage:object fromTarget:self];
        }
    }];
}

#pragma mark - Delegates
- (void)cropViewController:(nonnull TOCropViewController *)cropViewController didCropToImage:(nonnull UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle {
    [cropViewController dismissViewControllerAnimated:YES completion:^{
        selectedAvatar = image;
        [_avatarImageView setImage:image];
    }];
}

#pragma mark - Checks
- (BOOL)checkValidateInputRules {
    if (selectedAvatar == nil) {
        [[CAHelper sharedInstance] showPickerFromTarget:self withOptions:@[] andMessage:@"Invalid Avatar" completion:^(id object, NSError *error) {
            
        }];
        return NO;
    }
    if (_nameField.text.length < 1) {
        [[CAHelper sharedInstance] showPickerFromTarget:self withOptions:@[] andMessage:@"Invalid Name" completion:^(id object, NSError *error) {
            
        }];
        return NO;
    }
    if (![[CAHelper sharedInstance] isValidUsername:_usernameField.text]) {
        [[CAHelper sharedInstance] showPickerFromTarget:self withOptions:@[] andMessage:@"Invalid Username" completion:^(id object, NSError *error) {
            
        }];
        return NO;
    }
    if (![[CAHelper sharedInstance] isValidEmail:_emailField.text]) {
        [[CAHelper sharedInstance] showPickerFromTarget:self withOptions:@[] andMessage:@"Invalid Email" completion:^(id object, NSError *error) {
            
        }];
        return NO;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"pushToSignUpStepTwo"]) {
        CASignUpStepTwoViewController *signupTwo = [segue destinationViewController];
        [signupTwo setAvatarImage:selectedAvatar];
        [signupTwo setFullName:_nameField.text];
        [signupTwo setUserName:_usernameField.text];
        [signupTwo setEmail:_emailField.text];
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"pushToSignUpStepTwo"]) {
        
        return [self checkValidateInputRules];
    }
    return NO;
}

@end
