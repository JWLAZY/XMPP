//
//  ReceiveImageCell.m
//  0834XMPP
//
//  Created by 郑建文 on 16/9/1.
//  Copyright © 2016年 Lanou. All rights reserved.
//

#import "ReceiveImageCell.h"
#import "XMPPElement.h"

@interface ReceiveImageCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *contentImage;


@end

@implementation ReceiveImageCell

- (void)configCellWithUserName:(NSString *)name message:(XMPPMessage*)message{
    self.nameLabel.text = name;
    
    for (XMPPElement *node in message.children) {
        NSString *base64str = node.stringValue;
        NSData *data = [[NSData alloc]initWithBase64EncodedString:base64str options:0];
        UIImage *image = [[UIImage alloc]initWithData:data];
        _contentImage.image = image;
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
