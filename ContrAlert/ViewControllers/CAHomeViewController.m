//
//  CAHomeViewController.m
//  ContrAlert
//
//  Created by iMokhles on 13/08/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import "CAHomeViewController.h"
#import "CAHelper.h"

#import "CANavigationView.h"

@interface CAHomeViewController ()
@property (nonatomic, strong) IBOutlet CANavigationView *navigationView;
@end

@implementation CAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof(self) weakSelf = self;
    [self.navigationView setBackBtnClicked:^() {
        [weakSelf backBtnTapped];
    }];
}

- (void)backBtnTapped {
    
    if ([self.slidingViewController.topViewController isEqual:self.navigationController] && self.slidingViewController.currentTopViewPosition == ECSlidingViewControllerTopViewPositionAnchoredRight) {
        [self.slidingViewController resetTopViewAnimated:YES];
    } else {
        [self.slidingViewController anchorTopViewToRightAnimated:YES];
    }
    
//    [[CAHelper sharedInstance] showPickerFromTarget:self withOptions:@[] andMessage:@"Back Tapped" completion:^(id object, NSError *error) {
//        
//    }];
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
