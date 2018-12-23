//
//  BNREditDateController.m
//  房子着火
//
//  Created by Du Carl on 2018/12/23.
//  Copyright © 2018 杜. All rights reserved.
//

#import "BNREditDateController.h"
#import "BNRItem.h"

@interface BNREditDateController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end

@implementation BNREditDateController
- (void)setItem:(BNRItem *)item {
    _item = item;
    self.datePicker.date = item.dateCreated;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.item.dateCreated = self.datePicker.date;
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
