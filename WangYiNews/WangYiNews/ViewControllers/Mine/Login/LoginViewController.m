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
    
    self.view.backgroundColor = [UIColor whiteColor];
   // [[[Helper alloc] init] createNavigationBarWithSuperView:self.view andTitle:@"登录网易新闻" andTarget:self andSel:@selector(loginPageBack)];
    //[self loadUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -----------------UI--------------
/*-(void)loadUI
{
   // [self.view addSubview:[Helper imageView:CGRectMake(15, 84, 30, 30) name:@"login_username_icon@2x.png"]];
    _userNameTF = [[UITextField alloc] initWithFrame:CGRectMake(53, 84, [Helper screenWidth]-68, 30)];
    _userNameTF.placeholder = @"邮箱账号或手机号";
    [_userNameTF setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _userNameTF.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_userNameTF];
    //[self.view addSubview:[Helper view:CGRectMake(15, 124, [Helper screenWidth]-30, 0.5) backgroundColor:LINECOLOR]];
    //[self.view addSubview:[Helper imageView:CGRectMake(15, 134, 30, 30) name:@"login_password_icon@2x.png"]];
    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(53, 134, [Helper screenWidth]-148, 30)];
    _passwordTF.placeholder = @"密码";
    [_passwordTF setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    _passwordTF.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:_passwordTF];
//[self.view addSubview:[Helper label:@"忘记密码" frame:CGRectMake([Helper screenWidth]-78, 134, 60, 30) font:[UIFont systemFontOfSize:12] textColor:[UIColor grayColor] textAligment:NSTextAlignmentLeft]];
    //[self.view addSubview:[Helper button:nil normalImage:@"login_forgot_button@2x.png" highlightedImage:nil frame:CGRectMake([Helper screenWidth]-87, 134, 72, 30) target:self action:@selector(forgotPass) textColor:nil textFont:nil tag:0]];
    //[self.view addSubview:[Helper view:CGRectMake(15, 174, [Helper screenWidth]-30, 0.5) backgroundColor:LINECOLOR]];
    
    //UIButton *loginBtn = [Helper button:@"登录" normalImage:nil highlightedImage:nil frame:CGRectMake(15, 205, [Helper screenWidth]-30, 45) target:self action:@selector(userLogin) textColor:[UIColor blackColor] textFont:[UIFont systemFontOfSize:17] tag:0];
    loginBtn.layer.borderColor = LINECOLOR.CGColor;
    loginBtn.layer.borderWidth = 0.8;
    loginBtn.layer.cornerRadius = 5;
    loginBtn.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    loginBtn.layer.shadowOffset = CGSizeMake(0, 5);
    [self.view addSubview:loginBtn];
    
//[self.view addSubview:[Helper label:@"还可以选择以下方式登陆" frame:CGRectMake(15, 300, 200, 20) font:[UIFont systemFontOfSize:12] textColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentLeft]];
    [self.view addSubview:[Helper view:CGRectMake(0, 325, [Helper screenWidth], 0.5) backgroundColor:LINECOLOR]];
    
    UIButton *weChatBtn = [Helper button:nil normalImage:@"biz_account_login_way_wx.png" highlightedImage:nil frame:CGRectMake(0, 325, [Helper screenWidth]/3, 95) target:self action:@selector(otherWayLogin:) textColor:nil textFont:nil tag:WECHAT_LOGIN_TAG];
    weChatBtn.contentEdgeInsets = UIEdgeInsetsMake(20, ([Helper screenWidth]/3-70)/2, 5, ([Helper screenWidth]/3-70)/2);
    [self.view addSubview:weChatBtn];
    [self.view addSubview:[Helper label:@"微信账号登陆" frame:CGRectMake(0, 420, [Helper screenWidth]/3, 25) font:[UIFont systemFontOfSize:13] textColor:[UIColor grayColor] textAligment:NSTextAlignmentCenter]];
    
    UIButton *xinLangBtn = [Helper button:nil normalImage:@"biz_account_login_way_sina.png" highlightedImage:nil frame:CGRectMake([Helper screenWidth]/3, 325, [Helper screenWidth]/3, 95) target:self action:@selector(otherWayLogin:) textColor:nil textFont:nil tag:XINLANG_LOGIN_TAG];
    xinLangBtn.contentEdgeInsets = UIEdgeInsetsMake(20, ([Helper screenWidth]/3-70)/2, 5, ([Helper screenWidth]/3-70)/2);
    [self.view addSubview:xinLangBtn];
    [self.view addSubview:[Helper label:@"新浪微博登陆" frame:CGRectMake([Helper screenWidth]/3, 420, [Helper screenWidth]/3, 25) font:[UIFont systemFontOfSize:13] textColor:[UIColor grayColor] textAligment:NSTextAlignmentCenter]];
    
    UIButton *QQBtn = [Helper button:nil normalImage:@"biz_account_login_way_qq.png" highlightedImage:nil frame:CGRectMake([Helper screenWidth]/3*2, 325, [Helper screenWidth]/3, 95) target:self action:@selector(otherWayLogin:) textColor:nil textFont:nil tag:QQ_LOGIN_TAG];
    QQBtn.contentEdgeInsets = UIEdgeInsetsMake(20, ([Helper screenWidth]/3-70)/2, 5, ([Helper screenWidth]/3-70)/2);
    [self.view addSubview:QQBtn];
    [self.view addSubview:[Helper label:@"QQ账号登陆" frame:CGRectMake([Helper screenWidth]/3*2, 420, [Helper screenWidth]/3, 25) font:[UIFont systemFontOfSize:13] textColor:[UIColor grayColor] textAligment:NSTextAlignmentCenter]];
    
    UIView *registerView = [Helper view:CGRectMake([Helper screenWidth]-132, [Helper screenHeight]-25, 105, 15) backgroundColor:[UIColor whiteColor]];
    registerView.layer.borderColor = [UIColor colorWithRed:203.0/255.0 green:203.0/255.0 blue:203.0/255.0 alpha:1.0].CGColor;
    registerView.layer.borderWidth = 0.5;
    registerView.layer.cornerRadius = 7.5;
    [self.view addSubview:registerView];
    [registerView addSubview:[Helper imageView:CGRectMake(95, 4, 4, 7) name:@"lm_cell_detail_indicator@2x.png"]];
    [registerView addSubview:[Helper label:@"手机号快速注册" frame:CGRectMake(6, 0, 86, 15) font:[UIFont systemFontOfSize:12] textColor:[UIColor grayColor] textAligment:NSTextAlignmentCenter]];
    
    [self.view addSubview:[Helper label:@"还没账号？" frame:CGRectMake([Helper screenWidth]-245, [Helper screenHeight]-25, 108, 15) font:[UIFont systemFontOfSize:13] textColor:[UIColor lightGrayColor] textAligment:NSTextAlignmentRight]];
}*/

#pragma mark -----------------buttonAction--------------
-(void)userLogin
{}

-(void)forgotPass
{}

-(void)otherWayLogin:(UIButton *)btn
{}

-(void)loginPageBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
