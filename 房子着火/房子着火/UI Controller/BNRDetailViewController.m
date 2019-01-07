//
//  BNRDetailViewController.m
//  房子着火
//
//  Created by Du Carl on 2018/12/23.
//  Copyright © 2018 杜. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>
#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"

@interface BNRDetailViewController ()
        <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation BNRDetailViewController
- (void)setItem:(BNRItem *)item {
    _item = item;
    self.navigationItem.title = item.itemName;
}
- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
//    for (UIView *subview in self.view.subviews) {
//        if ([subview hasAmbiguousLayout]) {
//            [subview exerciseAmbiguityInLayout];
//        }
//    }
}
- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.delegate = self;
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted){
        if (granted) {
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
//- (void)viewDidLayoutSubviews {
//    for (UIView *subview in self.view.subviews) {
//        if ([subview hasAmbiguousLayout]) {
//            NSLog(@"AMBIGUOUS: %@", subview);
//        }
//    }
//}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.nameField.text = self.item.itemName;
    self.serialNumberField.text = self.item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", self.item.valueInDollars];

    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }

    self.dateLabel.text = [dateFormatter stringFromDate:self.item.dateCreated];
    UIImage *image = [[BNRImageStore sharedInstance] imageForKey:self.item.itemKey];
    self.imageView.image = image;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];

    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [[BNRImageStore sharedInstance] setImage:image forKey:self.item.itemKey];
    self.imageView.image = image;

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView = [[UIImageView alloc] initWithImage:nil];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    // 告诉自动布局系统不要将自动缩放掩码转换为约束
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.imageView];
}

@end
