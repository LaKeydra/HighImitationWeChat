//
//  RegisterViewController.m
//  HighImitationWeChat
//
//  Created by fenrir-32 on 2018/3/5.
//  Copyright © 2018年 zl. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterCountryTVCell.h"
#import "RegisterPhoneNumTVCell.h"
#import "RegisterBtnTVCell.h"
#import "DiallingCodeViewController.h"


@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *registerTableView;
@property (strong, nonatomic) CountryModel *currentCountry;
@property (strong, nonatomic) RegisterPhoneNumTVCell *phoneNumTVCell;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_registerTableView registerNib:[UINib nibWithNibName:@"RegisterCountryTVCell" bundle:nil] forCellReuseIdentifier:@"RegisterCountryTVCell"];
    [_registerTableView registerNib:[UINib nibWithNibName:@"RegisterPhoneNumTVCell" bundle:nil] forCellReuseIdentifier:@"RegisterPhoneNumTVCell"];
    [_registerTableView registerNib:[UINib nibWithNibName:@"RegisterBtnTVCell" bundle:nil] forCellReuseIdentifier:@"RegisterBtnTVCell"];
    _registerTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.currentCountry = [[CountryModel alloc] init];
    self.currentCountry.name = @"中国";
    self.currentCountry.dial_code = @"+86";
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    tap.cancelsTouchesInView = NO;
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        RegisterCountryTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegisterCountryTVCell" forIndexPath:indexPath];
        [cell refreshUI:self.currentCountry.name];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else if (indexPath.row == 1){
        _phoneNumTVCell = [tableView dequeueReusableCellWithIdentifier:@"RegisterPhoneNumTVCell" forIndexPath:indexPath];
        [_phoneNumTVCell refreshUI:self.currentCountry.dial_code];
        _phoneNumTVCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return _phoneNumTVCell;
    } else {
        RegisterBtnTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegisterBtnTVCell" forIndexPath:indexPath];
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        return 80;
    } else {
        return 48;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (indexPath.row == 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"DiallingCode" bundle:nil];
        DiallingCodeViewController *vc = [sb instantiateInitialViewController];
        vc.doneBlock = ^(CountryModel *country) {
            self.currentCountry.name = country.name;
            self.currentCountry.dial_code = country.dial_code;
            [self.registerTableView reloadData];
        };
        [self.navigationController pushViewController:vc animated:true];
    }
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
