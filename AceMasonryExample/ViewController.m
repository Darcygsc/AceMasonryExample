//
//  ViewController.m
//  AceMasonryExample
//
//  Created by chaos on 7/10/15.
//  Copyright (c) 2015 ace. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

#define IMAGE_SIZE 32
@interface ViewController ()

// demo1
@property (strong, nonatomic) UIView *containerView;
@property (strong, nonatomic) NSMutableArray *views;
@property (strong, nonatomic) NSMutableArray *widthConstraints;

// demo2
@property (weak, nonatomic) UILabel *label1;
@property (weak, nonatomic) UILabel *label2;
@property (weak, nonatomic) UILabel *label3;
@property (weak, nonatomic) IBOutlet UIView *contentView;

// demo3
@property (weak, nonatomic) IBOutlet UIView *contentView2;
@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *space;

@end

@implementation ViewController
- (IBAction)showOrHidden:(UISwitch *)sender {
    
    NSUInteger index = (NSUInteger) sender.tag;
    MASConstraint *width = _widthConstraints[index];
    
    if (sender.on) {
        width.equalTo(@(IMAGE_SIZE));
    } else {
        width.equalTo(@0);
    }

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // demo1
    _views = [NSMutableArray array];
    _widthConstraints = [NSMutableArray array];
    [self initContainerView];
    [self initDemo1Views];
    
    // demo2
    [self initViews];
    [self addConstraint];
    
    
    
}

#pragma mark -- demo1
- (void)initContainerView {
    _containerView = [UIView new];
    [self.view addSubview:_containerView];
    
    _containerView.backgroundColor = [UIColor grayColor];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        //只设置高度，宽度由子View决定
        make.height.equalTo(@(IMAGE_SIZE));
        //水平居中
        make.centerX.equalTo(self.view.mas_centerX);
        //距离父View顶部100点
        make.top.equalTo(self.view.mas_top).offset(100);
    }];
}

- (void)initDemo1Views {
    //循环创建、添加imageView
    for (NSUInteger i = 0; i < 4; i++) {
        UIView *view = [[UIView alloc]init];
        view.bounds = CGRectMake(0, 0, 50, 50);
        [_views addObject:view];
        
        CGFloat hue = ( arc4random() % 256 / 256.0 );
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
        view.backgroundColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        [_containerView addSubview:view];
    }
    
    //分别设置每个view的宽高、左边、垂直中心约束，注意约束的对象
    UIView *view1 = _views[0];
    MASConstraint *width = [self setView:view1 size:view1.frame.size left:_containerView.mas_left centerY:_containerView.mas_centerY];
    [_widthConstraints addObject:width];
    
    UIView *view2 = _views[1];
    width = [self setView:view2 size:view2.frame.size left:view1.mas_right centerY:_containerView.mas_centerY];
    [_widthConstraints addObject:width];
    
    UIView *view3 = _views[2];
    width = [self setView:view3 size:view3.frame.size left:view2.mas_right centerY:_containerView.mas_centerY];
    [_widthConstraints addObject:width];
    
    UIView *view4 = _views[3];
    width = [self setView:view4 size:view4.frame.size left:view3.mas_right centerY:_containerView.mas_centerY];
    [_widthConstraints addObject:width];
    
    //最后设置最右边的imageView的右边与父view的最有对齐
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_containerView.mas_right);
    }];
}

/**
 *  设置view的宽高、左边约束，垂直中心约束
 *
 *  @param view    要设置的view
 *  @param size    CGSize
 *  @param left    左边对齐的约束
 *  @param centerY 垂直中心对齐的约束
 *
 *  @return 返回宽约束，用于显示、隐藏单个view
 */
- (MASConstraint *)setView:(UIView *)view size:(CGSize)size left:(MASViewAttribute *)left centerY:(MASViewAttribute *)centerY {
    
    __block MASConstraint *widthConstraint;
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        //宽高固定
        widthConstraint = make.width.equalTo(@(size.width));
        make.height.equalTo(@(size.height));
        //左边约束
        make.left.equalTo(left);
        //垂直中心对齐
        make.centerY.equalTo(centerY);
    }];
    
    return widthConstraint;
}

#pragma mark -- demo2
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
    // 优先级低
    [self.label1 setContentCompressionResistancePriority:UILayoutPriorityDefaultLow
                                             forAxis:UILayoutConstraintAxisHorizontal];
    // 优先级高
    [self.label2 setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
                                                 forAxis:UILayoutConstraintAxisHorizontal];
    // 优先级最高
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

#pragma mark -- demo3
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat count = self.contentView2.subviews.count;
    UIView *subView = self.contentView2.subviews[0];
    for (NSLayoutConstraint *constraint in self.space) {
        constraint.constant = (width - subView.bounds.size.width * count)/(count+1);
    }
    
}

@end
