//
//  ChatRoomViewController.h
//  0834XMPP
//
//  Created by 郑建文 on 15/11/25.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatRoomViewController : UIViewController
//当前聊天的人
@property (nonatomic,strong) XMPPJID * jidChatTo;

@end
