//
//  WeatherView.m
//  WangYiNews
//
//  Created by lifangli on 15/10/29.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "WeatherView.h"
#import <pop/POP.h>
#import "WeatherDetailModel.h"

@interface WeatherView()

@property(nonatomic, strong) UILabel *nightLabel;
@property(nonatomic, strong) UIButton *nightBtn;
@property(nonatomic,assign,getter=isSwitchNightMode)BOOL switchNightMode;

@end

@implementation WeatherView
{
    UILabel *_lab1;
    UILabel *_lab2;
    UILabel *_lab3;
    UILabel *_lab4;
    UILabel *_lab5;
    UILabel *_lab6;
    UILabel *_lab7;
    UIImageView *_img;
    NSMutableArray *_dateWeatherArr;
}

-(void)layoutSubviews
{
    self.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], [UIColor blackColor]);
    UIView *topView = [[UIView alloc] init];
    topView.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], [UIColor blackColor]);
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(64);
        make.bottom.mas_equalTo(self).offset(-400);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [topView addGestureRecognizer:tap];
    
    _lab1 = [[UILabel alloc] init];
    _lab1.font = [UIFont fontWithName:@"AvenirNext-UltraLight" size:105];
    _lab1.textColor = [UIColor colorWithRed:0.87 green:0.19 blue:0.19 alpha:1.0f];
    [self addSubview:_lab1];
    [_lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(self).offset(60);
        make.size.sizeOffset(CGSizeMake(120, 100));
    }];
    
    _lab2 = [[UILabel alloc] init];
    _lab2.font = [UIFont systemFontOfSize:25];
    _lab2.textColor = [UIColor colorWithRed:0.87 green:0.19 blue:0.19 alpha:1.0f];
    [self addSubview:_lab2];
    [_lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lab1.mas_right);
        make.top.mas_equalTo(_lab1.mas_top);
        make.size.sizeOffset(CGSizeMake(42, 42));
    }];
    
    _lab3 = [[UILabel alloc] init];
    _lab3.dk_textColorPicker = DKColorWithColors([UIColor grayColor], [UIColor lightGrayColor]);
    _lab3.font = [UIFont systemFontOfSize:16];
    [self addSubview:_lab3];
    [_lab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lab1.mas_right);
        make.bottom.mas_equalTo(_lab1.mas_bottom).offset(-10);
        make.size.sizeOffset(CGSizeMake(80, 30));
    }];
    
    _lab4 = [[UILabel alloc] init];
    _lab4.dk_textColorPicker = DKColorWithColors([UIColor darkGrayColor], [UIColor whiteColor]);
    _lab4.font = [UIFont systemFontOfSize:15];
    [self addSubview:_lab4];
    [_lab4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lab1.mas_left);
        make.top.mas_equalTo(_lab1.mas_bottom).offset(-5);
        make.size.sizeOffset(CGSizeMake(150, 25));
    }];
    
    _lab5 = [[UILabel alloc] init];
    _lab5.dk_textColorPicker = DKColorWithColors([UIColor darkGrayColor], [UIColor whiteColor]);
    _lab5.font = [UIFont systemFontOfSize:15];
    [self addSubview:_lab5];
    [_lab5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lab1.mas_left);
        make.top.mas_equalTo(_lab4.mas_bottom);
        make.size.sizeOffset(CGSizeMake(150, 25));
    }];
    
    _img = [[UIImageView alloc] init];
    [self addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-30);
        make.top.mas_equalTo(_lab1.mas_top);
        make.size.sizeOffset(CGSizeMake(60, 60));
    }];
    
    _lab6 = [[UILabel alloc] init];
    _lab6.dk_textColorPicker = DKColorWithColors([UIColor darkGrayColor], [UIColor whiteColor]);
    _lab6.font = [UIFont systemFontOfSize:15];
    _lab6.textAlignment = NSTextAlignmentRight;
    [self addSubview:_lab6];
    [_lab6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-30);
        make.top.mas_equalTo(_img.mas_bottom);
        make.size.sizeOffset(CGSizeMake(80, 25));
    }];
    
    _lab7 = [[UILabel alloc] init];
    _lab7.dk_textColorPicker = DKColorWithColors([UIColor darkGrayColor], [UIColor whiteColor]);
    _lab7.font = [UIFont systemFontOfSize:15];
    _lab7.textAlignment = NSTextAlignmentRight;
    [self addSubview:_lab7];
    [_lab7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-30);
        make.top.mas_equalTo(_lab6.mas_bottom);
        make.size.sizeOffset(CGSizeMake(80, 25));
    }];
    
    CGFloat Y = [Helper screenHeight]-410;
    UIView *midLine = [[UIView alloc] init];
    midLine.dk_backgroundColorPicker = DKColorWithColors(LINECOLOR, NIGHTLINECOLOR);
    [self addSubview:midLine];
    [midLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(30);
        make.right.mas_equalTo(self).offset(-30);
        make.bottom.mas_equalTo(self).offset(-Y);
        make.height.offset(0.5);
    }];
    
    [self addBtn:@"pluginboard_icon_search@2x.png" text:@"搜索" index:0];
    [self addBtn:@"pluginboard_icon_headline@2x.png" text:@"上头条" index:1];
    [self addBtn:@"pluginboard_icon_offline@2x.png" text:@"离线" index:2];
    [self addBtn:@"pluginboard_icon_night@2x.png" text:@"夜间" index:3];
    [self addBtn:@"pluginboard_icon_search.png" text:@"扫一扫" index:4];
    [self addBtn:@"pluginboard_icon_invite@2x.png" text:@"邀请好友" index:5];
}

-(void)setWeatherModel:(WeatherModel *)weatherModel
{
    _weatherModel = weatherModel;
    
    _dateWeatherArr = [[NSMutableArray alloc] init];
    for(NSDictionary *dic in _weatherModel.detailArray){
        WeatherDetailModel *detailModel = [WeatherDetailModel objectWithKeyValues:dic];
        [_dateWeatherArr addObject:detailModel];
    }
    
    _lab1.text = [NSString stringWithFormat:@"%@",_weatherModel.rt_temperature];
    _lab2.text = @"℃";
    NSArray *arr = [_weatherModel.dt componentsSeparatedByString:@"-"];
    NSMutableString *dateStr = [[NSMutableString alloc] init];
    [dateStr appendString:arr[0]];
    [dateStr appendString:@"."];
    [dateStr appendString:arr[1]];
    [dateStr appendString:@"."];
    [dateStr appendString:arr[2]];
    WeatherDetailModel *currModel = _dateWeatherArr.firstObject;
    _lab3.text = currModel.temperature;
    _lab4.text = [NSString stringWithFormat:@"%@ %@",dateStr,currModel.week];
    NSInteger pm = [[_weatherModel.pm2d5 objectForKey:@"aqi"] integerValue];
    NSString *status;
    if (pm>=0 && pm<=50)
        status = @"优";
    else if (pm>50 && pm<=100)
        status = @"良好";
    else if (pm>100 && pm<=150)
        status = @"轻度污染";
    else if (pm>150 && pm<=200)
        status = @"中度污染";
    else if (pm>200 && pm<=300)
        status = @"重度污染";
    else if (pm>300)
        status = @"严重污染";
    _lab5.text = [NSString stringWithFormat:@"PM2.5  %@  %@",[_weatherModel.pm2d5 objectForKey:@"pm2_5"],status];
    _lab6.text = [NSString stringWithFormat:@"%@  %@",currModel.climate,currModel.wind];
    _lab7.text = @"北京";
    
    [self setImage:currModel.climate];
}

-(void)setImage:(NSString *)wea
{
    if ([wea isEqualToString:@"晴"]) {
        _img.image = [UIImage imageNamed:@"sun_mini@2x.png"];
    }
    else if ([wea isEqualToString:@"多云"]) {
        _img.image = [UIImage imageNamed:@"sun_and_cloud_mini@2x.png"];
    }
    else if ([wea isEqualToString:@"雨"]) {
        _img.image = [UIImage imageNamed:@"rain_mini@2x.png"];
    }
    else if ([wea isEqualToString:@"雪"]) {
        _img.image = [UIImage imageNamed:@"snow_mini@2x.png"];
    }
    else if ([wea isEqualToString:@"阴"]) {
        _img.image = [UIImage imageNamed:@""];
    }
    else if ([wea isEqualToString:@"雷阵雨"]) {
        _img.image = [UIImage imageNamed:@""];
    }
    else if ([wea isEqualToString:@"雨夹雪"]) {
        _img.image = [UIImage imageNamed:@"rain_and_snow_mini@2x.png"];
    }
    else if ([wea isEqualToString:@"小雪"]) {
        _img.image = [UIImage imageNamed:@"snow_little_mini@2x.png"];
    }
    
}

-(void)addBtn:(NSString *)imageName text:(NSString *)title index:(NSInteger)index
{
    CGFloat Y = [Helper screenHeight]-380;
    CGFloat X = 30;
    CGFloat height = 80;
    CGFloat width = 80;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake((X+(80+([Helper screenWidth]-300)/2)*(index%3)), Y+140*(index/3), width, height);
    btn.layer.cornerRadius = 40;
    btn.tag = index;
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake((X+(80+([Helper screenWidth]-300)/2)*(index%3)), (Y+85)+140*(index/3), width, 30)];
    titleLab.text = title;
    titleLab.font = [UIFont systemFontOfSize:15];
    titleLab.dk_textColorPicker = DKColorWithColors([UIColor darkGrayColor], [UIColor whiteColor]);
    titleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLab];
    
    switch (index) {
        case 0:{
            btn.backgroundColor = [UIColor orangeColor];
        }
            break;
        case 1:{
            btn.backgroundColor = [UIColor redColor];
        }
            break;
        case 2:{
            btn.backgroundColor = [UIColor orangeColor];
        }
            break;
        case 3:{
            btn.backgroundColor = [UIColor cyanColor];
            self.nightLabel = titleLab;
            self.nightBtn = btn;
        }
            break;
        case 4:{
            btn.backgroundColor = [UIColor blueColor];
        }
            break;
        case 5:{
            btn.backgroundColor = [UIColor greenColor];
        }
            break;
        default:
            break;
    }
}

-(void)btnClick:(UIButton *)btn
{
    switch (btn.tag) {
        case 3:
        {
            if (self.isSwitchNightMode) {
                [DKNightVersionManager dawnComing];
                self.nightLabel.text = @"夜间";
                [self.nightBtn setImage:[UIImage imageNamed:@"pluginboard_icon_night@2x.png"] forState:UIControlStateNormal];
            }
            else{
                [DKNightVersionManager nightFalling];
                self.nightLabel.text = @"日间";
                [self.nightBtn setImage:[UIImage imageNamed:@"pluginboard_icon_night@2x.png"] forState:UIControlStateNormal];
            }
            self.switchNightMode = !self.isSwitchNightMode;
            [[NSUserDefaults standardUserDefaults] setBool:self.switchNightMode forKey:@"isNightMode"];
        }
            break;
            
        default:
            break;
    }
}

-(void)tapGesture
{
    
}

@end
