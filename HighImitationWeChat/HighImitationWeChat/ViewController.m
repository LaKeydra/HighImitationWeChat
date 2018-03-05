//
//  ViewController.m
//  HighImitationWeChat
//
//  Created by fenrir-32 on 2018/3/2.
//  Copyright © 2018年 zl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {
    
}

- (IBAction)registerAction:(id)sender {
    UIStoryboard *registerSB = [UIStoryboard storyboardWithName:@"Register" bundle:nil];
    UIViewController *registerVC = [registerSB instantiateInitialViewController];
    [self presentViewController:registerVC animated:true completion:^{
        NSLog(@"completion");
    }];
}

@end
