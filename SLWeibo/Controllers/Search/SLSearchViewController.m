//
//  SLSearchViewController.m
//  SLWeibo
//
//  Created by sleen on 2018/3/26.
//  Copyright © 2018年 cn.Xsoft. All rights reserved.
//

#import "SLSearchViewController.h"
#import "UIBarButtonItem+SXCreate.h"

@interface SLSearchViewController () <UITextFieldDelegate>
@property (nonatomic, strong) UIView *searchView;
@property (nonatomic, strong) UITextField *searchField;
@property (nonatomic, weak)   UILabel *searchHolderLabel;
@property (nonatomic, weak)   UIButton *searchFilterButton;
@property (nonatomic, weak)   UIButton *searchCleanButton;
@end

@implementation SLSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kSLBackGroundColor;
    
    [self setupNavBar];
}

- (void)setupNavBar {
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
//    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    negativeSpacer.width = -10;
//    self.navigationItem.rightBarButtonItems = @[negativeSpacer, self.navigationItem.rightBarButtonItem];
    
    self.navigationItem.titleView = self.searchView;
    [self.searchView addSubview:self.searchField];
    [self.searchField becomeFirstResponder];
    self.searchHolderLabel.text = @"网店百万年薪招聘大码模特";
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(backClick) title:@"取消" titleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, -6)];
    
    
}
- (void)backClick {
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)searchFilterButtonClick {
    
}
- (void)searchCleanButtonClick {
    [UIView animateWithDuration:0.5 animations:^{
        [self.searchField setText:@""];
        self.searchHolderLabel.hidden = NO;
        self.searchCleanButton.hidden = YES;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    CGFloat w = self.navigationItem.titleView.bounds.size.width;
    for (UIView *view in self.navigationController.navigationBar.subviews) {

        for (UIView *v in view.subviews) {
            if ([v isKindOfClass:NSClassFromString(@"_UITAMICAdaptorView")]) {
                w = v.frame.size.width;
            }
        }
    }
    self.searchField.frame = CGRectMake(32, 0, w-32-30, 28);
    self.searchFilterButton.frame = CGRectMake(2, 0, 32, 29);
    self.searchCleanButton.frame = CGRectMake(w-30, 0, 30, 28);
}
- (void)searchFieldTextChanged:(UITextField *)textField {
    NSLog(@"%@", textField.text);
    self.searchHolderLabel.hidden = textField.text.length > 0;
    self.searchCleanButton.hidden = textField.text.length == 0;
    if (textField.text.length > 0) {
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (UIView *)searchView {
    if (!_searchView) {
        _searchView = [[UIView alloc] init];
        _searchView.bounds = CGRectMake(0, 0, kSLScreenWidth-54-8, 28);
        _searchView.backgroundColor = kSLColorHex(@"E3E4E6");
        _searchView.layer.cornerRadius = 4.0;
        _searchView.clipsToBounds = YES;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(2, 0, 28, 28);
        [button setImage:[UIImage imageNamed:@"search_bar_arraw"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(searchFilterButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_searchView addSubview:button];
        self.searchFilterButton = button;
        
        UIButton *button2 = [[UIButton alloc] init];
        button2.frame = CGRectMake(kSLScreenWidth-54-8-30, 0, 30, 28);
        button2.hidden = YES;
        [button2 setImage:[UIImage imageNamed:@"search_bar_clean"] forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(searchCleanButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_searchView addSubview:button2];
        self.searchCleanButton = button2;
    }
    return _searchView;
}
- (UITextField *)searchField {
    if (!_searchField) {
        _searchField = [[UITextField alloc] init];
        _searchField.frame = CGRectMake(32, 0, kSLScreenWidth-54-8-32-30, 28);
        _searchField.font = kSLFont(14);
        _searchField.textColor = kSLColorHex(@"000000");
        _searchField.delegate = self;

        [_searchField addTarget:self action:@selector(searchFieldTextChanged:) forControlEvents:UIControlEventEditingChanged];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, _searchField.bounds.size.width, 28);
        label.font = kSLFont(14);
        label.textColor = kSLColorHex(@"95959A");
        [_searchField addSubview:label];
        self.searchHolderLabel = label;
    }
    return _searchField;
}

@end
