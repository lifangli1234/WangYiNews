//
//  NewsDetailViewController.m
//  WangYiNews
//
//  Created by lifangli on 15/10/30.
//  Copyright © 2015年 lifangli. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "NormalDetailModel.h"
#import "NormalImageModel.h"
#import "NormalVideoModel.h"
#import "MGTemplateEngine.h"
#import "ICUTemplateMatcher.h"
#import <WebKit/WebKit.h>
#import "NSObject+Extension.h"

@interface NewsDetailViewController ()

@property (nonatomic, strong) NormalDetailModel *detail;

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    [self createNavigation];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createNavigation
{
    UIButton *backBtn = [Helper button:@"icon_back@2x" target:self action:@selector(backBtn) tag:0];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(0);
        make.top.mas_equalTo(self.view).offset(20);
        make.size.sizeOffset(CGSizeMake(54, 44));
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    NSString *str = [NSString stringWithFormat:@"%@跟帖", self.newsModel.replyCount];
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    rightBtn.frame = CGRectMake([Helper screenWidth]-size.width-34, 20, size.width + 20, 40);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightBtn setTitle:str forState:UIControlStateNormal];
    [rightBtn needsUpdateConstraints];
    UIImage *normalImg = [UIImage imageNamed:@"contentview_commentbacky"];
    UIImage *highlightedImg = [UIImage imageNamed:@"contentview_commentbacky_selected"];
    CGFloat normalW = normalImg.size.width;
    CGFloat normalH = normalImg.size.height;
    CGFloat highW = highlightedImg.size.width;
    CGFloat highH = highlightedImg.size.height;
    normalImg = [normalImg resizableImageWithCapInsets:UIEdgeInsetsMake(normalH * 0.5, normalW * 0.5, normalH * 0.5, normalW * 0.5)];
    highlightedImg = [highlightedImg resizableImageWithCapInsets:UIEdgeInsetsMake(highH * 0.5, highW * 0.5, highH * 0.5, highW * 0.5)];
    [rightBtn setBackgroundImage:normalImg forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:highlightedImg forState:UIControlStateHighlighted];
    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 15);
    [self.view addSubview:rightBtn];
}

- (void)loadData {
    // 发送一个GET请求, 获得新闻的详情数据
    NSString *url = [NSString stringWithFormat:@"/nc/article/%@/full.html", self.newsModel.docid];
    [[NetworkTools sharedNetworkTools] GET:url parameters:nil success:^(NSURLSessionDataTask *operation, NSDictionary *responseObject) {
        self.detail = [NormalDetailModel objectWithKeyValues:responseObject[self.newsModel.docid]];
        NSString *html = [self loadHTMLByMGTempEngine:self.detail];
        UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, [Helper screenWidth], [Helper screenHeight]-64)];
        [web loadHTMLString:html baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
        [self.view addSubview:web];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"%@", error);
    }];
}

- (NSString *)loadHTMLByMGTempEngine:(NormalDetailModel *)data {
    NSString *tempPath = [[NSBundle mainBundle] pathForResource:@"content_template" ofType:@"html"];
    MGTemplateEngine *engine = [MGTemplateEngine templateEngine];
    [engine setMatcher:[ICUTemplateMatcher matcherWithTemplateEngine:engine]];
    if (data.ptime) {
        [engine setObject:data.ptime forKey:@"ptime"];
    }
    if (data.body) {
        NSString *newbody = [self setupBody:data.body];
        [engine setObject:newbody forKey:@"body"];
    }
    if (data.title) [engine setObject:data.title forKey:@"title"];
    if (data.source) [engine setObject:data.source forKey:@"source"];
    if (data.source_url) [engine setObject:data.source_url forKey:@"source_url"];
    if (data.app) [engine setObject:data.app forKey:@"app"];
    if (data.replyBoard) [engine setObject:data.replyBoard forKey:@"replyBoard"];
    if (data.link) [engine setObject:data.link forKey:@"link"];
    if (data.tid) [engine setObject:data.tid forKey:@"tid"];
    if (data.boboList) [engine setObject:data.boboList forKey:@"boboList"];
    if (data.img) [engine setObject:data.img forKey:@"img"];
    if (data.topiclist_news) [engine setObject:data.topiclist_news forKey:@"topiclist_news"];
    if (data.picnews) [engine setObject:data.picnews forKey:@"picnews"];
    if (data.relative) [engine setObject:data.relative forKey:@"relative"];
    if (data.replyCount) [engine setObject:data.replyCount forKey:@"replyCount"];
    if (data.docid) [engine setObject:data.docid forKey:@"docid"];
    if (data.hasNext) [engine setObject:data.hasNext forKey:@"hasNext"];
    if (data.topiclist) [engine setObject:data.topiclist forKey:@"topiclist"];
    if (data.votes) [engine setObject:data.votes forKey:@"votes"];
    if (data.voicecomment) [engine setObject:data.voicecomment forKey:@"voicecomment"];
    if (data.users) [engine setObject:data.users forKey:@"users"];
    return [engine processTemplateInFileAtPath:tempPath withVariables:nil];
}

- (NSString *)setupBody:(NSString *)oldBody {
    NSMutableString *body = [NSMutableString string];
    [body appendString:oldBody];
    // 拼接图片
    for (NSDictionary *dic in self.detail.img) {
        NSMutableString *imgHtml = [NSMutableString string];
        [imgHtml appendString:@"<div class=\"img-paresent\">"];
        
        NSString *onload = @"this.onclick = function() {"
        "   window.location.href = 'hm:saveImageToAlbum:&' + this.src;"
        "};";
        NSString *src = [dic objectForKey:@"src"];
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%d\" src=\"%@\">", onload, (int)[Helper screenWidth]-40, src];
        [imgHtml appendString:@"</div>"];
        [imgHtml appendString:[NSString stringWithFormat:@"<div>\"%@\"</div></p>",[dic objectForKey:@"alt"]]];
        // 将img.ref替换为img标签的内容
        [body replaceOccurrencesOfString:@"　" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
        [body replaceOccurrencesOfString:[dic objectForKey:@"ref"] withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    for (NSDictionary *videoDic in self.detail.video) {
        NSMutableString *videoHtml = [NSMutableString string];
        [videoHtml appendString:@"<div>"];
        [videoHtml appendFormat:@"<video width=\"%d\" controls preload=\"auto\" poster=\"%@\"> <source src=\"%@\" codecs=\"avc1.42E01E, mp4a.40.2\"  type=\"video/mp4\">", (int)[UIScreen mainScreen].bounds.size.width - 20, [videoDic objectForKey:@"cover"], [videoDic objectForKey:@"url_m3u8"]];
        [videoHtml appendString:@"</div><br/>"];
        [body replaceOccurrencesOfString:[videoDic objectForKey:@"ref"] withString:videoHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
    }
    return body;
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"hm:"];
    if (range.location != NSNotFound) {
        NSUInteger loc = range.location + range.length;
        NSString *path = [url substringFromIndex:loc];
        // 获得方法和参数
        NSArray *methodNameAndParam = [path componentsSeparatedByString:@"&"];
        // 方法名
        NSString *methodName = [methodNameAndParam firstObject];
        // 调用方法
        SEL selector = NSSelectorFromString(methodName);
        if ([self respondsToSelector:selector]) { // 判断方法的目的： 防止因为方法不存在而报错
            NSMutableArray *params = nil;
            if (methodNameAndParam.count > 1) { // 方法有参数
                params = [NSMutableArray arrayWithArray:methodNameAndParam];
                // 从数组中去掉方法名
                [params removeObjectAtIndex:0];
            }
            [self performSelector:selector withObjects:params];
        }
        return NO;
    }
    return YES;
}

-(void)backBtn
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
