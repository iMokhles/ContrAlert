//
//  SideMenuViewController.m
//  ContrAlert
//
//  Created by iMokhles on 19/05/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import "SideMenuViewController.h"
#import "CAHelper.h"
#import "CATheme.h"

@interface SideMenuViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) IBOutlet UILabel *userFullNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userImageView;

// menu items
@property (nonatomic, strong) NSArray *menuItems;
@property (nonatomic, strong) NSArray *menuItemsIcons;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableTrailConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lineTrailConstraint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topViewTrailConstraint;

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([[CAHelper sharedInstance] isIPHONE4] || [[CAHelper sharedInstance] isIPHONE5] || [[CAHelper sharedInstance] isIPHONE6]) {
        self.tableTrailConstraint.constant  = 100.0;
        self.lineTrailConstraint.constant  = 100.0;
        self.topViewTrailConstraint.constant  = 100.0;
    } else {
        if ([[CAHelper sharedInstance] isIPHONE6PLUS]) {
            self.tableTrailConstraint.constant  = 150.0;
            self.lineTrailConstraint.constant  = 150.0;
            self.topViewTrailConstraint.constant  = 150.0;
        } else {
            self.tableTrailConstraint.constant  = 350.0;
            self.lineTrailConstraint.constant  = 350.0;
            self.topViewTrailConstraint.constant  = 350.0;
        }
    }
}

- (void)setupHeader {
    [[CATheme defaultTheme] addCornerView:_userImageView radius:25];
}

- (void)setupTable {
    
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
