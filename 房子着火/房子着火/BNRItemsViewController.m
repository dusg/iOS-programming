//
//  BNRItems.m
//  房子着火
//
//  Created by Du Carl on 2018/12/19.
//  Copyright © 2018 杜. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"

@interface BNRItemsViewController()<UITableViewDataSource>
{

}
@end

@implementation BNRItemsViewController
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView numberOfRowsInSection:0]-1 == indexPath.row) {
        return 44;
    }
    return 60;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class]
            forCellReuseIdentifier:@"UITableViewCell"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    self.tableView.backgroundView = imageView;
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

@end
