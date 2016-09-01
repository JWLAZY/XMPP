//
//  OutImageCell.m
//  0834XMPP
//
//  Created by 郑建文 on 16/9/1.
//  Copyright © 2016年 Lanou. All rights reserved.
//

#import "OutImageCell.h"

@interface OutImageCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@end

@implementation OutImageCell

- (void)configCellWithUserName:(NSString *)name message:(XMPPMessage*)message{
    self.nameLable.text = name;
    
    for (XMPPElement *node in message.children) {
        NSString *base64str = node.stringValue;
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSData *data = [[NSData alloc]initWithBase64EncodedString:base64str options:0];
            UIImage *image = [[UIImage alloc]initWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                _contentImageView.image = image;
            });
        });
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
