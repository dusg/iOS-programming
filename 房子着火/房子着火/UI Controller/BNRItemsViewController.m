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
#import "BNRDetailViewController.h"


@interface BNRItemsViewController()

@property (nonatomic, strong) IBOutlet UIView *headerView;

@end

@implementation BNRItemsViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
//        for (int i = 0; i < 5; ++i) {
//            [[BNRItemStore sharedStore] createItem];
//        }
    }

    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [self init];
}

- (IBAction)addNewItem:(id)sender {
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];

    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
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

//    if (indexPath.row == [items count]) {
//        cell.textLabel.text = @"我是有底线的～";
//    } else {
//        cell.textLabel.text = [items[indexPath.row] description];
//    }

    cell.textLabel.text = [items[indexPath.row] description];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[BNRItemStore sharedStore] allItems] count];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        BNRItem *item = [[BNRItemStore sharedStore] allItems][indexPath.row];
        [[BNRItemStore sharedStore] removeItem:item];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView
    moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
        toIndexPath:(NSIndexPath *)destinationIndexPath {
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == [[[BNRItemStore sharedStore] allItems] count]) {
//        return UITableViewCellEditingStyleNone;
//    }
//    return UITableViewCellEditingStyleInsert|UITableViewCellEditingStyleDelete;
//}
//- (NSIndexPath *)tableView:(UITableView *)tableView
//targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
//       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
//    NSInteger count = [[[BNRItemStore sharedStore] allItems] count];
//    NSInteger row = proposedDestinationIndexPath.row;
//    if (row >= count) {
//        row = count - 1;
//    }
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:proposedDestinationIndexPath.section];
//    return indexPath;
//}

//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row < [[[BNRItemStore sharedStore] allItems] count]) {
//        return YES;
//    }
//    return NO;
//}

//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == [[[BNRItemStore sharedStore] allItems] count]) {
//        return NO;
//    }
//    return YES;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] init];
    BNRItem *item = [[BNRItemStore sharedStore] allItems][indexPath.row];
    detailViewController.item = item;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

@end
