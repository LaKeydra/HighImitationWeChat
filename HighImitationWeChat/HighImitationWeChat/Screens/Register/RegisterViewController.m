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

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *registerTableView;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_registerTableView registerNib:[UINib nibWithNibName:@"RegisterCountryTVCell" bundle:nil] forCellReuseIdentifier:@"RegisterCountryTVCell"];
    [_registerTableView registerNib:[UINib nibWithNibName:@"RegisterPhoneNumTVCell" bundle:nil] forCellReuseIdentifier:@"RegisterPhoneNumTVCell"];
    [_registerTableView registerNib:[UINib nibWithNibName:@"RegisterBtnTVCell" bundle:nil] forCellReuseIdentifier:@"RegisterBtnTVCell"];
    _registerTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyBoardGesture)];
    [self.view addGestureRecognizer:gesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)closeKeyBoardGesture {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
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
        return cell;
    } else if (indexPath.row == 1){
        RegisterPhoneNumTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegisterPhoneNumTVCell" forIndexPath:indexPath];
        return cell;
    } else {
        RegisterBtnTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegisterBtnTVCell" forIndexPath:indexPath];
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
