//
//  ViewController.m
//  AceMasonryExample
//
//  Created by chaos on 7/10/15.
//  Copyright (c) 2015 ace. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

@interface ViewController ()

@property (weak, nonatomic) UILabel *label1;
@property (weak, nonatomic) UILabel *label2;
@property (weak, nonatomic) UILabel *label3;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self initViews];
    [self addConstraint];
}

- (void)initViews {
    UILabel *label1 = [UILabel new];
    label1.backgroundColor = [UIColor yellowColor];
    label1.text = @"test";
    self.label1 = label1;
    
    UILabel *label2 = [UILabel new];
    label2.backgroundColor = [UIColor greenColor];
    label2.text = @"test";
    self.label2 = label2;

    UILabel *label3 = [UILabel new];
    label3.backgroundColor = [UIColor redColor];
    label3.text = @"test";
    self.label3 = label3;

    [self.contentView addSubview:label1];
    [self.contentView addSubview:label2];
    [self.contentView addSubview:label3];
    
}

- (void)addConstraint
{
    // label1: 位于左上角
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.left.equalTo(self.contentView.mas_left).with.offset(5);
        make.right.lessThanOrEqualTo(self.label2.mas_left).with.offset(-5);
        make.height.equalTo(@40);
    }];
    
    // label1: 位于中间
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.right.equalTo(self.label3.mas_left).with.offset(-5);
        make.height.equalTo(@40);
    }];

    // label3: 位于右上角
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.right.equalTo(self.contentView.mas_right).with.offset(-5);
        make.height.equalTo(@40);
    }];
    
    [self.label1 setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                             forAxis:UILayoutConstraintAxisHorizontal];
    [self.label2 setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
                                                 forAxis:UILayoutConstraintAxisHorizontal];
    [self.label3 setContentCompressionResistancePriority:UILayoutPriorityRequired
                                                 forAxis:UILayoutConstraintAxisHorizontal];

}

- (IBAction)valueChanged:(UIStepper *)sender {
    
    switch (sender.tag) {
        case 0:
            _label1.text = [self getLabelContentWithCount:(NSUInteger)sender.value];
            break;
            
        case 1:
            _label2.text = [self getLabelContentWithCount:(NSUInteger)sender.value];
            break;
            
        case 2:
            _label3.text = [self getLabelContentWithCount:(NSUInteger)sender.value];
            break;
            
        default:
            break;
    }
    
}

- (NSString *)getLabelContentWithCount:(NSUInteger)count {
    NSMutableString *ret = [NSMutableString new];
    
    for (NSUInteger i = 0; i <= count; i++) {
        [ret appendString:@"test"];
    }
    
    return ret.copy;
}

@end
