//
//  BNRHypnosisViewController.m
//  催眠器
//
//  Created by Du Carl on 2018/12/16.
//  Copyright © 2018 desg. All rights reserved.
//

#import "BNRHypnosisViewController.h"
#import "BNRHypnosisView.h"

@interface BNRHypnosisViewController () <UITextFieldDelegate>

@end

@implementation BNRHypnosisViewController
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"textField.text = %@", textField.text);
    [self drawHypnoticMessage:textField.text];
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

- (void)drawHypnoticMessage:(NSString *)text {
    for (int i = 0; i < 20; ++i) {
        UILabel *label = [[UILabel alloc] init];
        // 设置UILabel对象的文字和颜色
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        label.text = text;
        // 根据需要显示的文字调整UILabel对象的大小
        [label sizeToFit];
        // 获取随机x坐标，
        // 使UILabel对象的宽度不超出BNRHypnosisViewController的view宽度
        int width = self.view.bounds.size.width - label.bounds.size.width;
        int x = arc4random() % width;
        // 使UILabel对象的宽度不超出BNRHypnosisViewController的view宽度
        int height = self.view.bounds.size.height - label.bounds.size.height;
        int y = arc4random() % height;

        CGRect rect = label.frame;
        rect.origin = CGPointMake(x, y);
        label.frame = rect;

        [self.view addSubview:label];
        //添加视差效果
        UIInterpolatingMotionEffect *motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [label addMotionEffect:motionEffect];

        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [label addMotionEffect:motionEffect];
    }
}

- (void)loadView {
    [super loadView];

    BNRHypnosisView *backgroundView = [[BNRHypnosisView alloc] init];

    CGRect rect = CGRectMake(40, 100, 300, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:rect];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"催眠我";
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    [backgroundView addSubview:textField];

    self.view = backgroundView;
}

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"催眠";
        UIImage *image = [UIImage imageNamed:@"Hypno"];
        self.tabBarItem.image = image;
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSLog(@"催眠视图加载了。。。");
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
