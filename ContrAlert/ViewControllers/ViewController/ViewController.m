//
//  ViewController.m
//  ContrAlert
//
//  Created by iMokhles on 19/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import "ViewController.h"
#import "CAIntroHelper.h"
#import "CATheme.h"

@interface ViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) IBOutlet UIButton *loginBtn;
@property (nonatomic, strong) IBOutlet UIButton *signupBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[CAIntroHelper sharedInstance]  showIntroView:self completion:^{
        
    }];
    // Do any additional setup after loading the view, typically from a nib.
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    [self setupButtons];
}

- (void)setupButtons {
    [[CATheme defaultTheme] addCornerView:_loginBtn radius:_loginBtn.frame.size.height/2.0];
    [[CATheme defaultTheme] addCornerView:_signupBtn radius:_signupBtn.frame.size.height/2.0];
    [[CATheme defaultTheme] addCornerBorderTo:_signupBtn color:[UIColor whiteColor] width:2];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
