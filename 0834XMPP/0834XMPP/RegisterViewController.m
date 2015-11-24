//
//  RegisterViewController.m
//  0834XMPP
//
//  Created by 郑建文 on 15/11/24.
//  Copyright © 2015年 Lanou. All rights reserved.
//

#import "RegisterViewController.h"
#import "XMPPManager.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txt4UserName;
@property (weak, nonatomic) IBOutlet UITextField *txt4PassWord;

- (IBAction)action4Register:(id)sender;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)action4Register:(id)sender {
    [[XMPPManager sharedManager] xmppManagerRegisterWithUserName:self.txt4UserName.text password:self.txt4PassWord.text];
}
@end
