//
//  DiallingCodeViewController.h
//  HighImitationWeChat
//
//  Created by fenrir-32 on 2018/3/6.
//  Copyright © 2018年 zl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryModel.h"

@interface DiallingCodeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) void(^doneBlock)(CountryModel* country);

@end
