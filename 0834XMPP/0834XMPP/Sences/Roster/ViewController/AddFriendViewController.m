//
//  AddFriendViewController.m
//  0834XMPP
//
//  Created by 郑建文 on 15/11/25.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "AddFriendViewController.h"
#import "XMPPManager.h"

@interface AddFriendViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txt4UserName;
- (IBAction)action4AddFriend:(id)sender;

@end

@implementation AddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)action4AddFriend:(id)sender {
    
    //拿到花名册管理类
    XMPPRoster *roster = [XMPPManager sharedManager].roster;
    
    //拼装要添加的好友
    XMPPJID *jid = [XMPPJID jidWithUser:_txt4UserName.text domain:kDomin resource:kResource];
    
    //添加好友请求
    [roster subscribePresenceToUser:jid];
    
}
@end
