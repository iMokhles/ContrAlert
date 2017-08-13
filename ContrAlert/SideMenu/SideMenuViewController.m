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
#import "CASideMenuCell.h"
#import "Colours.h"
#import "CABackendKeys.h"

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
        self.slidingViewController.anchorRightPeekAmount  = 100.0;
        self.tableTrailConstraint.constant  = 100.0;
        self.lineTrailConstraint.constant  = 100.0;
        self.topViewTrailConstraint.constant  = 100.0;
    } else {
        if ([[CAHelper sharedInstance] isIPHONE6PLUS]) {
            self.slidingViewController.anchorRightPeekAmount  = 150.0;
            self.tableTrailConstraint.constant  = 150.0;
            self.lineTrailConstraint.constant  = 150.0;
            self.topViewTrailConstraint.constant  = 150.0;
        } else {
            self.slidingViewController.anchorRightPeekAmount  = 350.0;
            self.tableTrailConstraint.constant  = 350.0;
            self.lineTrailConstraint.constant  = 350.0;
            self.topViewTrailConstraint.constant  = 350.0;
        }
    }
    
    [self setupHeader];
    [self setupTable];
    
}

- (void)setupHeader {
    [[CATheme defaultTheme] addCornerView:_userImageView radius:25];
    
    [self.userFullNameLabel setText:[[PFUser currentUser] objectForKey:kUsersFullName]];
    [self.userNameLabel setText:[[PFUser currentUser] objectForKey:kUsersUserName]];
    PFFile *avatar = [[PFUser currentUser] objectForKey:kUsersAvatar];
    [self.userImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[avatar url]]]]];
}

- (void)setupTable {
    self.menuItems = @[
                       @"Home",
                       @"Notifications",
                       @"Profile",
                       @"Conversations",
                       @"Settings",
                       @"Logout"
                       ];
    [self.mainTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.menuItems.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CASideMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CASideMenuCell" forIndexPath:indexPath];
    
    cell.titleLabel.text = [self.menuItems objectAtIndex:indexPath.section];
    cell.icon.image = [UIImage imageNamed:[self.menuItems objectAtIndex:indexPath.section]];
    return cell;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorFromHexString:@"222527"];
    [cell setSelectedBackgroundView:bgColorView];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
//    if (section == 5) {
//        [view setBackgroundColor:[UIColor colorFromHexString:@"222527"]];
//    }
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 5) {
        [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
            if (error != nil) {
                [[CAHelper sharedInstance] showPickerFromTarget:self withOptions:@[] andMessage:[error localizedDescription] completion:^(id object, NSError *error) {
                    
                }];
            } else {
                [[CATheme defaultTheme] setMainViewControllerIfNeeded];
            }
        }];
    }
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
