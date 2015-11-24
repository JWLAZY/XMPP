//
//  LoginViewController.m
//  0834XMPP
//
//  Created by 郑建文 on 15/11/24.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "LoginViewController.h"
#import "XMPPManager.h"

@interface LoginViewController ()<XMPPStreamDelegate>

//控件
@property (weak, nonatomic) IBOutlet UITextField *txt4UserName;
@property (weak, nonatomic) IBOutlet UITextField *txt4PassWord;

//事件
- (IBAction)action4Login:(id)sender;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //取到单例类里的通讯管道,
    XMPPStream *stream = [XMPPManager sharedManager].stream;
    //设置通讯管道的代理为这个控制器
    [stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

#pragma mark - XMPPStreamDelegate
//登陆成功
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"登陆成功");
    //取到登陆控制器,模态消失
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)action4Login:(id)sender {
    
    //1. 设置通信管道的目标地址和端口-> 2. 设置通信管道的创建者 -> 3. 链接目标服务器
    [[XMPPManager sharedManager] xmppManagerLoginWithUserName:self.txt4UserName.text password:self.txt4PassWord.text];
}
@end
