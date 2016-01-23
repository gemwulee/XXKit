//
//  OCAndJSViewController.m
//  XXKit
//
//  Created by tomxiang on 16/1/11.
//  Copyright © 2016年 tomxiang. All rights reserved.
//
//http://blog.csdn.net/siwen1990/article/details/50504431

#import "OCAndJSViewController.h"
#import "foundationex/UIColorEx.h"

@interface OCAndJSViewController()<UIWebViewDelegate>
@property(nonatomic,strong) UIWebView *webView;
@end


@implementation OCAndJSViewController

-(instancetype)init
{
    if(self = [super init]){
    
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self initViews];

}
-(void) initViews
{
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.backgroundColor = UIColorHex(233344);
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    
    NSString *webPath = [[NSBundle mainBundle]pathForResource:@"ocandjs" ofType:@"html"];//获取文件路径
    NSURL *webURL = [NSURL fileURLWithPath:webPath];//通过文件路径字符串设置URL
    NSURLRequest *URLRequest = [NSURLRequest requestWithURL:webURL];//设置请求提交的相关URL
    
    [self.webView loadRequest:URLRequest];//提交请求
    [self.view addSubview:_webView];
}

#pragma mark-ocCallJS
-(void) ocCallJS
{
    [self.webView stringByEvaluatingJavaScriptFromString:@"showTitle();"];
}

#pragma mark-JSCallOC
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //打印看下URL
    NSLog(@"%@", request.URL);
    
    //这个@"xmg://"就是和后台定的暗号
    NSString *schem = @"xmg://";
    
    //把NSURLRequest转换成字符串的形式
    NSString *urlStr = [request.URL.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //判断暗号是否一样，一样的话进入我们需要调用OC方法
    if ([urlStr hasPrefix:schem]) {
        
        // 1.从URL中获取方法名称 （去除"xmg://callWithNumber_?15830654880"中的@"xmg://"）
        // 此时 subPath = callWithNumber_?15830654880;
        NSString *subPath = [urlStr substringFromIndex:schem.length];
        
        
        // 注意: 如果指定的用于切割的字符串不存在, 那么就会返回整个字符串
        // 切割字符串获得数组中元素：callWithNumber_ 与 15830654880;
        NSArray *subPaths = [subPath componentsSeparatedByString:@"?"];
        
        // 2.获取方法名称--数组中首元素callWithNumber_为方法名
        // 把方法名中的_换成冒号
        NSString *methodName = [subPaths firstObject];
        methodName = [methodName stringByReplacingOccurrencesOfString:@"_" withString:@":"];
        
        // 3.调用方法
        // 讲方法名生成一个方法sel
        SEL sel = NSSelectorFromString(methodName);
        
        // 4.处理参数
        NSString *parma = nil;
        if (subPaths.count == 2) {
            //获取数组中的最后一个元素为电话15830654880
            parma = [subPaths lastObject];
            // 3.截取参数 （保险起见如果有&去除调）
            NSArray *parmas = [parma componentsSeparatedByString:@"&"];
            
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            //去通过刚才生成的方法sel（callWithNumber:） 传入参数电话15830654880 由self调用
            //- (void)callWithNumber:(NSString *)numbe
            [self performSelector:sel withObject:[parmas firstObject] withObject:[parmas lastObject]];
#pragma clang diagnostic pop
            return NO;
        }
        //这里处理参数很麻烦，我们可以自己实现一个类去将苹果自带的方法进行优化，其实就是可以传递不同的参数（多个）去处理相应的事件
        [self performSelector:sel withObject:parma];
        return NO;
    }
    
    return YES;

}

- (void)call{
    NSLog(@"%s", __func__);
}

// callWithNumber:
- (void)callWithNumber:(NSString *)number{
    NSLog(@"打电话给%@", number);
    [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"showTitleMessage('%@')", number]];
}

//sendMessageWithNumber:andContent:
- (void)sendMessageWithNumber:(NSString *)number andContent:(NSString *)content{
    NSLog(@"发信息给%@, 内容是%@", number, content);
}

- (void)sendMessageWithNumber:(NSString *)number andContent:(NSString *)content status:(NSString *)status{
    NSLog(@"发信息给%@, 内容是%@, 发送的状态是%@", number, content, status);
    
}

@end
