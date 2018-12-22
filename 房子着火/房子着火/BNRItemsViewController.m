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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class]
            forCellReuseIdentifier:@"UITableViewCell"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    UITableViewCell *cell = [tableView
            dequeueReusableCellWithIdentifier:@"UITableViewCell"
            forIndexPath:indexPath];

    NSArray *items = nil;
    if (indexPath.section == 1) {
        items = [[BNRItemStore sharedStore] itemsBigger];
    } else {
        items = [[BNRItemStore sharedStore] itemsLittle];
    }

    cell.textLabel.text = [items[indexPath.row] description];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return [[[BNRItemStore sharedStore] itemsBigger] count];
    } else {
        return [[[BNRItemStore sharedStore] itemsLittle] count];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (instancetype)init {
    self = [super initWithStyle:UITableViewCellStyleValue2|UITableViewStyleGrouped];
    if (self) {
        for (int i = 0; i < 15; ++i) {
            [[BNRItemStore sharedStore] createItem];
        }
    }

    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

@end
