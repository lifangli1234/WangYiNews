//
//  LoginViewController.m
//  News
//
//  Created by lifangli on 15/9/7.
//  Copyright (c) 2015年 lifangli. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
{
    UITextField *_userNameTF;
    UITextField *_passwordTF;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.dk_backgroundColorPicker = DKColorWithColors([UIColor whiteColor], NIGHTBACKGROUNDCOLOR);
    [self createNavigationBar];
    [self loadUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -----------------UI--------------
-(void)createNavigationBar
{
    UIView *nav = [Helper createNavigationBarWithTitle:@"登录网易新闻" andTarget:self andSel:@selector(loginPageBack)];
    [self.view addSubview:nav];
    [nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.offset(64);
    }];
}

-(void)loadUI
{
    UIImageView *userNameImg = [Helper imageView:@"login_username_icon@2x"];
    [self.view addSubview:userNameImg];
    [userNameImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(self.view).offset(84);
        make.size.sizeOffset(CGSizeMake(30, 30));
    }];
    
    _userNameTF = [[UITextField alloc] init];
    _userNameTF.placeholder = @"邮箱账号或手机号";
    _userNameTF.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_userNameTF];
    [_userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNameImg.mas_right).offset(8);
        make.top.equalTo(userNameImg);
        make.right.equalTo(self.view).offset(-20);
        make.height.offset(30);
    }];
    
    UIView *line1 = [Helper view:GRAYCOLOR nightColor:NIGHTGRAYCOLOR];
    [self.view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userNameImg);
        make.height.offset(1);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(_userNameTF.mas_bottom).offset(10);
    }];
    
    UIImageView *userPassWordImg = [Helper imageView:@"login_password_icon@2x"];
    [self.view addSubview:userPassWordImg];
    [userPassWordImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.equalTo(line1.mas_bottom).offset(10);
        make.size.sizeOffset(CGSizeMake(30, 30));
    }];
    
    UILabel *forgotLabel = [Helper label:@"忘记密码" font:[UIFont systemFontOfSize:12] textColor:[UIColor grayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentLeft];
    [self.view addSubview:forgotLabel];
    [forgotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(63, 30));
        make.top.equalTo(userPassWordImg);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    UIButton *forgotBtn = [Helper button:@"login_forgot_button@2x" target:self action:@selector(forgotPass) tag:0];
    [self.view addSubview:forgotBtn];
    [forgotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.sizeOffset(CGSizeMake(72, 30));
        make.top.equalTo(userPassWordImg);
        make.right.equalTo(self.view).offset(-20);
    }];
    
    _passwordTF = [[UITextField alloc] init];
    _passwordTF.placeholder = @"密码";
    _passwordTF.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_passwordTF];
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userPassWordImg.mas_right).offset(8);
        make.top.equalTo(userPassWordImg);
        make.right.equalTo(forgotBtn.mas_left).offset(-8);
        make.height.equalTo(@30);
    }];
    
    UIView *line2 = [Helper view:GRAYCOLOR nightColor:NIGHTGRAYCOLOR];
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userPassWordImg);
        make.height.offset(1);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(_passwordTF.mas_bottom).offset(10);
    }];
    
    UILabel *loginLab = [Helper label:@"登录" font:[UIFont systemFontOfSize:17] textColor:[UIColor blackColor] nightTextColor:[UIColor whiteColor] textAligment:NSTextAlignmentCenter];
    [self.view addSubview:loginLab];
    [loginLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.height.offset(40);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(line2.mas_bottom).offset(30);
    }];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn addTarget:self action:@selector(userLogin) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.layer.cornerRadius = 5;
    loginBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    loginBtn.layer.borderWidth = 0.8;
    loginBtn.layer.shadowColor = [UIColor darkGrayColor].CGColor;
    loginBtn.layer.shadowOpacity = 0.6f;
    loginBtn.layer.shadowOffset = CGSizeMake(0, 1.0);
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(loginLab);
    }];

    UILabel *otherMethod = [Helper label:@"还可以选择以下方式登陆" font:[UIFont systemFontOfSize:11] textColor:[UIColor lightGrayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentLeft];
    [self.view addSubview:otherMethod];
    [otherMethod mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.height.offset(20);
        make.top.equalTo(loginBtn.mas_bottom).offset(55);
    }];
    
    UIView *line3 = [Helper view:GRAYCOLOR nightColor:NIGHTGRAYCOLOR];
    [self.view addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.offset(1);
        make.top.equalTo(otherMethod.mas_bottom).offset(1);
    }];
    
    [self addLoginButton:WECHAT_LOGIN_TAG name:@"微信账号登陆" image:@"share_platform_wechat@2x" index:0 view:line3];
    [self addLoginButton:XINLANG_LOGIN_TAG name:@"新浪微博登陆" image:@"share_platform_sina@2x" index:1 view:line3];
    [self addLoginButton:QQ_LOGIN_TAG name:@"QQ账号登陆" image:@"share_platform_qqfriends@2x" index:2 view:line3];
    
    UILabel *registerLabel = [Helper label:@"手机号快速注册" font:[UIFont systemFontOfSize:12] textColor:[UIColor grayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentCenter];
    [self.view addSubview:registerLabel];
    [registerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-50);
        make.height.offset(30);
        make.bottom.equalTo(self.view).offset(-15);
    }];
    
    UIImageView *registerImg = [Helper imageView:@"login_forgot_button@2x"];
    [self.view addSubview:registerImg];
    registerImg.contentMode = UIViewContentModeScaleAspectFill;
    [registerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(registerLabel).offset(21);
        make.height.offset(30);
        make.centerY.equalTo(registerLabel);
        make.left.equalTo(registerLabel).offset(-12);
    }];
    
    UIButton *registerBtn = [[UIButton alloc] init];
    registerBtn.backgroundColor = [UIColor clearColor];
    registerBtn.tag = 0;
    [registerBtn addTarget:self action:@selector(registerBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(registerImg);
    }];
    
    UILabel *registerAlertLabel = [Helper label:@"还没账号？" font:[UIFont systemFontOfSize:13] textColor:[UIColor lightGrayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentCenter];
    [self.view addSubview:registerAlertLabel];
    [registerAlertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(registerImg.mas_left).offset(-8);
        make.height.offset(30);
        make.centerY.equalTo(registerImg);
    }];
}

-(void)addLoginButton:(NSInteger)tag name:(NSString *)name image:(NSString *)image index:(NSInteger)index view:(UIView *)view
{
    CGFloat x = ([Helper screenWidth]-280)/2;
    UIImageView *img = [Helper imageView:image];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(35+(70+x)*index);
        make.size.sizeOffset(CGSizeMake(70, 70));
        make.top.equalTo(view.mas_bottom).offset(30);
    }];
    UIButton *btn = [[UIButton alloc] init];
    btn.backgroundColor = [UIColor clearColor];
    btn.tag = tag;
    [btn addTarget:self action:@selector(otherWayLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(img);
    }];
    UILabel *weChatLab = [Helper label:name font:[UIFont systemFontOfSize:14] textColor:[UIColor grayColor] nightTextColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentLeft];
    [self.view addSubview:weChatLab];
    [weChatLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.offset(25);
        make.top.equalTo(img.mas_bottom).offset(4);
        make.centerX.equalTo(img);
    }];
}

#pragma mark -----------------buttonAction--------------
-(void)userLogin
{}

-(void)forgotPass
{}

-(void)otherWayLogin:(UIButton *)btn
{}

-(void)registerBtn
{}

-(void)loginPageBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
