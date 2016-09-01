//
//  ReceiveImageCell.h
//  0834XMPP
//
//  Created by 郑建文 on 16/9/1.
//  Copyright © 2016年 Lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiveImageCell : UITableViewCell

- (void)configCellWithUserName:(NSString *)name message:(XMPPMessage*)message;
@end
