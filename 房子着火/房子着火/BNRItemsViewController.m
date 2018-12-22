//
//  BNRItems.m
//  房子着火
//
//  Created by Du Carl on 2018/12/19.
//  Copyright © 2018 杜. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BNRItemsViewController.h"
#import "BNRItemStore.h"

@interface BNRItemsViewController()<UITableViewDataSource>

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation BNRItemsViewController
- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        for (int i = 0; i < 5; ++i) {
            [[BNRItemStore sharedStore] createItem];
        }
    }

    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (IBAction)addNewItem:(id)sender {
}

- (IBAction)toggleEditingMode:(id)sender {
    if (self.isEditing) {
        [sender setTitle:@"编辑" forState:UIControlStateNormal];
        [self setEditing:NO  animated:YES];
    } else {
        [sender setTitle:@"完成" forState:UIControlStateNormal];
        [self setEditing:YES  animated:YES];
    }
}

//getter and setter
- (UIView *)headerView {
    if (!_headerView) {
        [[NSBundle mainBundle] loadNibNamed:@"HeaderVie" owner:self options:nil];
    }
    return _headerView;
}


//delegate method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class]
            forCellReuseIdentifier:@"UITableViewCell"];

    [self.tableView setTableHeaderView:self.headerView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    UITableViewCell *cell = [tableView
            dequeueReusableCellWithIdentifier:@"UITableViewCell"
            forIndexPath:indexPath];

    NSArray *items = [[BNRItemStore sharedStore] allItems];
    cell.textLabel.text = [items[indexPath.row] description];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BNRItemStore sharedStore] allItems] count];
}


@end
