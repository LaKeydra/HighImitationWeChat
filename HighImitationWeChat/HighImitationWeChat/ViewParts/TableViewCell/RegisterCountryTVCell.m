//
//  RegisterCountryTVCell.m
//  HighImitationWeChat
//
//  Created by fenrir-32 on 2018/3/5.
//  Copyright © 2018年 zl. All rights reserved.
//

#import "RegisterCountryTVCell.h"

@interface RegisterCountryTVCell()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation RegisterCountryTVCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshUI: (NSString *)content{
    self.contentLabel.text = content;
}

@end
