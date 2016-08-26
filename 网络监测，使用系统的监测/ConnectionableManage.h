//
//  ConnectionableManage.h
//  YJZC
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 pengf. All rights reserved.
//
//使用说明-- systemConfigration.framwork
//必须导入MBProgressHUD
//开始监听，会启动一个run loop
//ConnectionableManage *manage = [ConnectionableManage shareManage];
//[manage startConnection];
//manage.delegate = self;
//manage.isFirstConn = YES;
#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "MBProgressHUD.h"
@protocol connectionManageDelegate;
@interface ConnectionableManage : NSObject

@property (nonatomic,strong)Reachability *conn;
@property (nonatomic,weak)id<connectionManageDelegate>delegate;
//创建单例
+ (instancetype)shareManage;
//开启监听
- (void)startConnection;
@end
@protocol connectionManageDelegate <NSObject>
//获得监听状态
- (BOOL)connectionWithStatue:(NetworkStatus)statue;

@end