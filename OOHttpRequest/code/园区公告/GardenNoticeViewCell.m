
//
//  GardenNoticeViewCell.m
//  wuye
//
//  Created by feng on 2017/9/14.
//  Copyright © 2017年 冯. All rights reserved.
//

#import "GardenNoticeViewCell.h"
#import "ConsultModel.h"
#import <Masonry/Masonry.h>

@interface GardenNoticeViewCell ()

@property (strong, nonatomic) UIView * coverView;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UIButton *timeBtn;
@property (strong, nonatomic) UILabel * titleLab;

@end


@implementation GardenNoticeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setup{
 
    [self.contentView addSubview:self.coverView];
    [self.coverView addSubview:self.iconImageView];
    [self.coverView addSubview:self.titleLab];
    [self.coverView addSubview:self.timeBtn];
    
    [self.coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(20);
        make.right.equalTo(self.contentView).offset(-20);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.contentView).offset(10);
        make.height.mas_equalTo(90);
    }];
    
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.coverView).offset(10);
        make.left.equalTo(self.coverView).offset(10);
        make.bottom.equalTo(self.coverView).offset(-10);
        make.height.mas_equalTo(70);
        make.width.mas_equalTo(70/3*4);
//        make.width.mas_equalTo(100);

    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView).offset(5);
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.right.equalTo(self.coverView).offset(-10);
    }];
    
    [self.timeBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.titleLab);
        make.right.equalTo(self.titleLab);
        make.bottom.equalTo(self.coverView).offset(-10);
    }];
    
}


- (void)setConsultModel:(ConsultModel *)consultModel{
    
    _titleLab.text = consultModel.title;
    [_timeBtn setTitle:consultModel.create_time forState:UIControlStateNormal];

}




#pragma mark - 懒加载

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.clipsToBounds = YES;
        _iconImageView.backgroundColor = [UIColor redColor];
    }
    return _iconImageView;
}



-(UILabel *)titleLab{
    if(!_titleLab){
        _titleLab=[[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:15.0f];
        _titleLab.textColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.00];
        _titleLab.numberOfLines = 0;
        
    }
    return _titleLab;
}


- (UIButton *)timeBtn{

    if (!_timeBtn) {
        _timeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _timeBtn.userInteractionEnabled = NO;
        [_timeBtn setTitleColor:[UIColor colorWithRed:0.44 green:0.44 blue:0.44 alpha:1.00] forState:UIControlStateNormal];
        _timeBtn.titleLabel.font = [UIFont systemFontOfSize:11];
        [_timeBtn setImage:[UIImage imageNamed:@"home_notice_time"] forState:UIControlStateNormal];
        _timeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }

    return _timeBtn;
}




-(UIView *)coverView{
    if(!_coverView){
        _coverView=[[UIView alloc] init];
        _coverView.backgroundColor = [UIColor whiteColor];
        _coverView.layer.cornerRadius = 5;
        _coverView.clipsToBounds = YES;
        _coverView.layer.borderColor = [UIColor colorWithRed:0.44 green:0.44 blue:0.44 alpha:0.5].CGColor;
        _coverView.layer.borderWidth = 0.5f;
    }
    return _coverView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
