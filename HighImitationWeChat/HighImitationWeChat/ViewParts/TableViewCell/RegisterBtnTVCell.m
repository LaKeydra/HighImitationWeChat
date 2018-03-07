//
//  RegisterBtnTVCell.m
//  HighImitationWeChat
//
//  Created by fenrir-32 on 2018/3/5.
//  Copyright © 2018年 zl. All rights reserved.
//

#import "RegisterBtnTVCell.h"

@interface RegisterBtnTVCell()

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation RegisterBtnTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.registerBtn.rac_command.executionSignals subscribeNext:^(id x) {
        
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
