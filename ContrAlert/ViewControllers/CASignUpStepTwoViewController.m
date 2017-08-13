//
//  CASignUpStepTwoViewController.m
//  ContrAlert
//
//  Created by iMokhles on 23/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import "CASignUpStepTwoViewController.h"
#import "CATheme.h"
#import "CABackendKeys.h"
#import "Colours.h"
#import "CAHelper.h"
#import "TOCropViewController.h"

@interface CASignUpStepTwoViewController () {
    UIImage *selectedCover;
}
@property (nonatomic, strong) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIButton *addCoverBtn;

@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UIImageView *genderImageView;
@property (nonatomic, strong) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) IBOutlet UITextField *passwordConfirmationField;
@property (nonatomic, strong) IBOutlet UILabel *genderLabel;

@property (nonatomic, strong) IBOutlet UIButton *signupBtn;
@end

@implementation CASignUpStepTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupImageViews];
    [self setupButtons];
    [self setupFields];
}


- (void)setupFields {
    [[CATheme defaultTheme] addLeftIconToField:_passwordField withIcon:@"fa-lock"];
    [[CATheme defaultTheme] addLeftIconToField:_passwordConfirmationField withIcon:@"fa-lock"];
    
    [[CATheme defaultTheme] changeFieldPlaceholderColor:_passwordField withColor:[UIColor whiteColor] andText:@"Mot de passe"];
    [[CATheme defaultTheme] changeFieldPlaceholderColor:_passwordConfirmationField withColor:[UIColor whiteColor] andText:@"Confirm Mot de pass"];
}
- (void)setupButtons {
    [[CATheme defaultTheme] buttonWithIcon:_backBtn iconId:@"fa-chevron-left"];
    [[CATheme defaultTheme] addCornerView:_signupBtn radius:22.5];
    
    [[CATheme defaultTheme] buttonWithIcon:_addCoverBtn iconId:@"fa-plus"];
    [[CATheme defaultTheme] makeCircleView:_addCoverBtn];
}
- (void)setupImageViews {
    [[CATheme defaultTheme] addCornerView:_coverImageView radius:15];
    [_coverImageView setImage:[[CATheme defaultTheme] imageFromIconId:@"fa-picture-o" fontSize:40 size:CGSizeMake(200, 114) color:[UIColor whiteColor]]];
    [_genderImageView setImage:[[CATheme defaultTheme] imageFromIconId:[_genderLabel.text isEqualToString:@"Homme"] ? @"fa-male" : @"fa-female" fontSize:30 size:CGSizeMake(30, 30) color:[UIColor whiteColor]]];
}

#pragma mark - Buttons Actions
- (IBAction)genderLabelTapped:(UITapGestureRecognizer *)sender {
    [[CAHelper sharedInstance] showPickerFromTarget:self withOptions:@[@"Homme", @"Femme"] andMessage:@"Votre Gender" completion:^(UIAlertAction *object, NSError *error) {
        [_genderLabel setText:object.title];
        [_genderImageView setImage:[[CATheme defaultTheme] imageFromIconId:[_genderLabel.text isEqualToString:@"Homme"] ? @"fa-male" : @"fa-female" fontSize:30 size:CGSizeMake(30, 30) color:[UIColor whiteColor]]];
    }];
}
- (IBAction)backButtonTapped:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addCoverButtonTapped:(id)sender {
    [[CAHelper sharedInstance] openImagePickerFromTarget:self completion:^(id object, NSError *error) {
        if (error == nil) {
            [[CAHelper sharedInstance] cropImage:object fromTarget:self];
        }
    }];
}

- (IBAction)signUpButtonTapped:(id)sender {
    if ([self checkValidateInputRules]) {
    
        // everything is okey
        UIImage *avatar = self.avatarImage;
        NSString *fullname = self.fullName;
        NSString *username = self.userName;
        NSString *email = self.email;
        UIImage *cover = selectedCover;
        NSString *password = _passwordField.text;
        NSString *gender = _genderLabel.text;
        
        [[CAHelper sharedInstance] signupUser:@{
                                                kUsersFullName: fullname,
                                                kUsersUserName: username,
                                                kUsersEmail: email,
                                                kUsersPassword: password,
                                                kUsersGender: gender} completion:^(id successed, NSError *error) {
                                                    if (error != nil) {
                                                        [[CAHelper sharedInstance] showPickerFromTarget:self withOptions:@[] andMessage:[error localizedDescription] completion:^(id object, NSError *error) {
                                                            
                                                        }];
                                                    } else {
                                                        // current user is created
                                                        // upload avatar
                                                        [[CAHelper sharedInstance] uploadUserProfileAvatar:avatar forUser:[PFUser currentUser] completion:^(id object, NSError *error) {
                                                            if (error != nil) {
                                                                [[CAHelper sharedInstance] showPickerFromTarget:self withOptions:@[] andMessage:[error localizedDescription] completion:^(id object, NSError *error) {
                                                                    
                                                                }];
                                                            } else {
                                                                
                                                                // upload cover
                                                                [[CAHelper sharedInstance] uploadUserProfileCover:cover forUser:[PFUser currentUser] completion:^(id object, NSError *error) {
                                                                    if (error != nil) {
                                                                        [[CAHelper sharedInstance] showPickerFromTarget:self withOptions:@[] andMessage:[error localizedDescription] completion:^(id object, NSError *error) {
                                                                            
                                                                        }];
                                                                    } else {
                                                                        
                                                                    }
                                                                }];
                                                            }
                                                        }];
                                                    }
                                                }];
        
        
    }
}

#pragma mark - Checks
- (BOOL)checkValidateInputRules {
    if (selectedCover == nil) {
        [[CAHelper sharedInstance] showPickerFromTarget:self withOptions:@[] andMessage:@"Invalid Cover" completion:^(id object, NSError *error) {
            
        }];
        return NO;
    }
    if (![[CAHelper sharedInstance] isValidPassword:_passwordField.text]) {
        [[CAHelper sharedInstance] showPickerFromTarget:self withOptions:@[] andMessage:@"Invalid Password" completion:^(id object, NSError *error) {
            
        }];
        return NO;
    }
    if (![[CAHelper sharedInstance] isValidPasswordConfirmation:@{kUsersPassword: _passwordField.text, kUsersPasswordConfirmation: _passwordConfirmationField.text}]) {
        [[CAHelper sharedInstance] showPickerFromTarget:self withOptions:@[] andMessage:@"Passwords don't matchs" completion:^(id object, NSError *error) {
            
        }];
        return NO;
    }
    if (_genderLabel.text.length < 1) {
        [[CAHelper sharedInstance] showPickerFromTarget:self withOptions:@[] andMessage:@"Invalid gender" completion:^(id object, NSError *error) {
            
        }];
        return NO;
    }
    return YES;
}
#pragma mark - Delegates
- (void)cropViewController:(nonnull TOCropViewController *)cropViewController didCropToImage:(nonnull UIImage *)image withRect:(CGRect)cropRect angle:(NSInteger)angle {
    [cropViewController dismissViewControllerAnimated:YES completion:^{
        selectedCover = image;
        [_coverImageView setImage:image];
    }];
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
