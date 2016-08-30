//
//  XMPPConfig.h
//  XMPPSample
//
//  Created by lewis on 14-3-27.
//  Copyright (c) 2014年 com.lanou3g. All rights reserved.
//
#ifndef XMPPSample_XMPPConfig_h
#define XMPPSample_XMPPConfig_h
// xmpp 文件夹只是通过 oc 代码去实现了xmpp协议,xmpp 只是协议,只是一个规则
// 在android 中也有一套实现了xmpp 协议的代码.

//这套代码通过实现了xmpp协议来给我们提过xmpp服务.
//openfire服务器IP地址
//172.21.60.255

//本地地址 - 127.0.0.1

#define  kHostName      @"127.0.0.1"
//openfire服务器端口 默认5222
#define  kHostPort      5222
//openfire域名
#define kDomin @"zhengjianwen.local"
//resource
#define kResource @"iOS"
#endif
