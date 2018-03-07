//
//  RegisterPhoneNumTVCell.m
//  HighImitationWeChat
//
//  Created by fenrir-32 on 2018/3/5.
//  Copyright © 2018年 zl. All rights reserved.
//

#import "RegisterPhoneNumTVCell.h"

@interface RegisterPhoneNumTVCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;

@end

@implementation RegisterPhoneNumTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [[self.phoneNumTextField rac_textSignal] subscribeNext:^(id x) {
        
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshUI: (NSString *)title{
    self.titleLabel.text = title;
}

@end
