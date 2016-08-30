//
//  RosterController.m
//  0834XMPP
//
//  Created by 郑建文 on 15/11/25.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "RosterController.h"
#import "XMPPManager.h"
#import "ChatRoomViewController.h"

@interface RosterController ()<XMPPRosterDelegate>
//用来存放所有好友
@property (nonatomic,strong) NSMutableArray * rosters;

@end

@implementation RosterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //遵循协议
    [[XMPPManager sharedManager].roster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rosters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    XMPPJID *jid = self.rosters[indexPath.row];
    cell.textLabel.text = jid.user;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //属性传值
    //1.判断是cell 还是 bar button item
    if ([sender class] != [UITableViewCell class]) {
        return;
    }
    //2.获取到点击的cell 的位置
    NSIndexPath *index = [self.tableView indexPathForCell:(UITableViewCell *)sender];
    //3. 获取到点击的cell对应位置的XMPPJid
    XMPPJID *jid = self.rosters[index.row];
    //4. 将获取的xmppjid 传到下个页面
    ChatRoomViewController *crvc = [segue destinationViewController];
    crvc.jidChatTo = jid;
}

#pragma mark - XMPPRosterDelegate
//开始接收好友列表
- (void)xmppRosterDidBeginPopulating:(XMPPRoster *)sender{
    NSLog(@"开始接收好友列表");
}
//没接收到一个好友就会走一次这个方法
-(void)xmppRoster:(XMPPRoster *)sender didReceiveRosterItem:(DDXMLElement *)item{
    //    <item jid="123@zhengjianwen" name="123" subscription="both"><group>Friends</group></item>
    //通过xml 获取到jid
    //注意获取到item 的属性和节点的问题.
    NSString *jid = [[item attributeForName:@"jid"] stringValue];
    //通过jid 创建一个xmppjid 类
    XMPPJID *xmppjid = [XMPPJID jidWithString:jid resource:kResource];
    [self.rosters addObject:xmppjid];
    
    //不刷新tableview ,而是没接收一个好友就插入一个好友
    NSIndexPath *indexpath = nil;
    if (self.rosters.count == 0) {
        return;
    }else{
        indexpath = [NSIndexPath indexPathForRow:self.rosters.count - 1 inSection:0];
    }
    [self.tableView insertRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationLeft];
}

-(void)xmppRosterDidEndPopulating:(XMPPRoster *)sender{
    NSLog(@"结束接收好友列表");
//    [self.tableView reloadData];
}



- (NSMutableArray *)rosters{
    if (!_rosters) {
        _rosters = [NSMutableArray array];
    }
    return _rosters;
}

//接收到好友请求
- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence{
    NSLog(@"%@",presence);
    
    //取到花名册管理类
    XMPPRoster *roster = [XMPPManager sharedManager].roster;
    NSString *message = [NSString stringWithFormat:@"%@请求添加你为好友",presence.from.user];
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"好友请求" message:message preferredStyle:UIAlertControllerStyleAlert];
 
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //同意好友请求
        [roster acceptPresenceSubscriptionRequestFrom:presence.from andAddToRoster:YES];
        }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"不加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //拒绝好友请求
        [roster rejectPresenceSubscriptionRequestFrom:presence.from];

    }];
    [ac addAction:action1];
    [ac addAction:action2];
    //模态出来好友请求
    [self presentViewController:ac animated:YES completion:nil];
}

@end
