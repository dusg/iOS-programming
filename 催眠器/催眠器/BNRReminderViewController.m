//
//  BNRReminderViewController.m
//  催眠器
//
//  Created by Du Carl on 2018/12/16.
//  Copyright © 2018 desg. All rights reserved.
//

#import <UserNotifications/UserNotifications.h>
#import "BNRReminderViewController.h"

@interface BNRReminderViewController ()
@property(nonatomic, weak) IBOutlet UIDatePicker *datePicker;
@end

@implementation BNRReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"通知器加载了");
}

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"计时";
        UIImage *image = [UIImage imageNamed:@"Time"];
        self.tabBarItem.image = image;
    }

    return self;
}

- (IBAction)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    NSLog(@"date = %@", date);

//    UILocalNotification *notification = [[UILocalNotification alloc] init];

    UNUserNotificationCenter * notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    bool __block ok = YES;
    [notificationCenter requestAuthorizationWithOptions:UNAuthorizationOptionAlert|UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
        ok = NO;
    }];
    if (ok == YES) {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"催眠器";
        content.body = @"催眠我";
        content.sound = [UNNotificationSound defaultSound];
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        dateComponents.calendar = self.datePicker.calendar;
//        dateComponents.weekday = 0;
//        dateComponents.hour = 16;
//        dateComponents.minute = 35;
        dateComponents.second = 0;
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:dateComponents repeats:NO];


        UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:@"abc123" content:content trigger:trigger];
        [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:^(NSError *error){
            if (error != nil) {
                NSLog(@"发送通知失败。。。");
            }
        }];
    }

//    notification.alertBody = @"催眠我";
//    notification.fireDate = self.datePicker.date;

//    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
