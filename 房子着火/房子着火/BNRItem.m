//
// Created by Du Carl on 2018-12-12.
// Copyright (c) 2018 杜... All rights reserved.
//

#import "BNRItem.h"


@implementation BNRItem {

}
- (void)dealloc {
    NSLog(@"释放 %@", self);
}

+ (instancetype)randomItem {
    // 创建不可变数组对象，包含三个形容词
    NSArray *randomAdjectiveList = @[@"巨大的", @"柔软的", @"坚硬的", @"短小的"];
    // 创建不可变数组对象，包含三个名词
    NSArray *randomNounList = @[@"🐻", @"🐓🐓", @"OO", @"那话儿"];

    NSUInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
    NSUInteger nounIndex = arc4random() % [randomNounList count];

    NSString *randomName = [[NSString alloc] initWithFormat:@"%@%@", randomAdjectiveList[adjectiveIndex], randomNounList[nounIndex]];

    int randomValu = arc4random() % 100;
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
            '0' + arc4random() % 10,
            'A' + arc4random() % 26,
            '0' + arc4random() % 10,
            'A' + arc4random() % 26,
            '0' + arc4random() % 10];

    BNRItem *newItem = [[self alloc] initWithItemName:randomName serialNumber:randomSerialNumber valueInDollars:randomValu];

    return newItem;
}

+ (instancetype)itemWithItemName:(NSString *)itemName {
    return [[self alloc] initWithItemName:itemName];
}

- (instancetype)initWithItemName:(NSString *)name serialNumber:(NSString *)number valueInDollars:(int)value {
    self = [super init];
    if (self) {
        self.itemName = name;
        self.serialNumber = number;
        self.valueInDollars = value;
        _dateCreated = [[NSDate alloc] init];
    }

    return self;
}

- (instancetype)initWithItemName:(NSString *)itemName {
    return [self initWithItemName:itemName serialNumber:@"" valueInDollars:0];
}



- (instancetype)init {
    return [self initWithItemName:@"dusg"];
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"%@: ", NSStringFromClass([self class])];

    NSString *str = [[NSString alloc] initWithFormat:@"%@(%@): Worth $%d, recorded on %@", self.itemName, self.serialNumber, self.valueInDollars, self.dateCreated];

    [description appendString:str];

    return description;
}

- (void)setContainedItem:(BNRItem *)containedItem {
}

@end