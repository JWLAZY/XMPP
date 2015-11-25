//
//  ChatRoomViewController.m
//  0834XMPP
//
//  Created by 郑建文 on 15/11/25.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "ChatRoomViewController.h"
#import "XMPPManager.h"

@interface ChatRoomViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,XMPPStreamDelegate>
@property (weak, nonatomic) IBOutlet UIView *view4ChatContent;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint4bottomFromSuper;
@property (weak, nonatomic) IBOutlet UITextField *txt4Chat;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)action4SendMessage:(id)sender;

//所有聊天消息
@property (nonatomic,strong) NSMutableArray * messages;

@end

@implementation ChatRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //设置代理
    XMPPStream *stream = [XMPPManager sharedManager].stream;
    [stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    //通过通知中心来观察键盘的frame 的变化,当键盘frame 发送变化后触发keyboardFrameChange事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
}

- (void)keyboardFrameChange:(NSNotification *)not{
    NSLog(@"%@",not);
    //键盘改变后的frame
    CGRect rect = [[not.userInfo objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    //计算出聊天窗口的底部偏移量
    CGFloat height = self.view.frame.size.height - rect.origin.y;
    
    self.constraint4bottomFromSuper.constant = height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messages.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    //获取到对应的消息
    XMPPMessage *message = self.messages[indexPath.row];
    if ([message.to isEqual:self.jidChatTo]) {
        cell.textLabel.text = [NSString stringWithFormat:@"我 : %@",message.body];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@ : %@",message.fromStr,message.body];
    }
    return cell;
}

#pragma mark - XMPPStreamDelegate
//接收到一条消息
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    NSLog(@"接收到一条消息%@",message);
    //如果聊天消息不是来自当前聊天页面的聊天对象,就什么都不干
    if (message.from != self.jidChatTo) {
        return;
    }
    
    [self.messages addObject:message];
    [self.tableView reloadData];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.messages.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
//发送一条消息的回调事件
- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message{
    NSLog(@"发送消息成功");
    [self.messages addObject:message];
    [self.tableView reloadData];
}

- (IBAction)action4SendMessage:(id)sender {
    XMPPStream *stream = [XMPPManager sharedManager].stream;
    
    //构造一个XMPPMessage 消息类
    XMPPMessage *message = [XMPPMessage messageWithType:@"chat" to:self.jidChatTo];
    [message addBody:self.txt4Chat.text];
    //通过通讯管道发送消息
    [stream sendElement:message];
    
}
#pragma mark - lazy load
- (NSMutableArray *)messages{
    if (!_messages) {
        _messages = [NSMutableArray array];
    }
    return _messages;
}
@end
