//
//  ConnectionableManage.m
//  YJZC
//
//  Created by apple on 16/3/11.
//  Copyright © 2016年 pengf. All rights reserved.
//

#import "ConnectionableManage.h"

@implementation ConnectionableManage
+ (instancetype)shareManage{
    static ConnectionableManage *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[ConnectionableManage alloc] init];
    });
    return manage;
}
- (void)startConnection{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self.conn = [Reachability reachabilityWithHostName:@"www.baidu.com"] ;
    [self.conn startNotifier];
}
- (void)reachabilityChanged:(NSNotification *)notification{
    Reachability *currReach = [notification object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    if ([self.delegate respondsToSelector:@selector(connectionWithStatue:)]) {
       BOOL flag = [self.delegate connectionWithStatue:status];
        //statue的状态
        //NotReachable   无连接,ReachableViaWiFi  移动WiFi,ReachableViaWWAN   移动数据
        if (flag) {
            switch (status) {
                case NotReachable:
                {
                    [self displayAlertWith:@"无网络连接"];
                }
                    break;
                case ReachableViaWiFi:
                {
                    [self displayAlertWith:@"连接的是WIFI"];
                }
                    break;
                case ReachableViaWWAN:
                {
                    [self displayAlertWith:@"移动数据连接"];
                }
                    break;
                    
                default:
                    break;
            }

        }
            }
}
- (void)displayAlertWith:(NSString *)text{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    HUD.labelText = text;
    HUD.mode = MBProgressHUDModeText;
    HUD.yOffset = 200.0f;
    HUD.margin = 10.0f;
    HUD.userInteractionEnabled = NO;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hide:YES afterDelay:1.5];
}
@end
