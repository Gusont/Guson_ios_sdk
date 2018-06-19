//
//  PlaceholderTextView.m
//  SaleHelper
//
//  Created by gitBurning on 14/12/8.
//  Copyright (c) 2014年 Burning_git. All rights reserved.
//

#import "PlaceholderTextView.h"
@interface PlaceholderTextView()<UITextViewDelegate>
@property (nonatomic,strong)UILabel *PlaceholderLabel;
@end
@implementation PlaceholderTextView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self awakeFromNib];
        [self KeyHide];
    }
    return self;
}
- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
        [self KeyHide];
    }
    return self;
}

- (void)KeyHide{
    //定义一个toolBar
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 40)];
    //设置style
    [topView setBarStyle:UIBarStyleDefault];
    //定义两个flexibleSpace的button，放在toolBar上，这样完成按钮就会在最右边
    UIBarButtonItem
    * button1 =[[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem
    * button2 = [[UIBarButtonItem  alloc]initWithBarButtonSystemItem:                                        UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    //定义完成按钮
    UIBarButtonItem
    * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成"style:UIBarButtonItemStyleDone
                                                  target:self action:@selector(resignKeyboard)];
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(60, 0, kSCREEN_WIDTH - 120, CGRectGetHeight(self.frame))];
    textField.placeholder = @"输入车牌号，使用车位";
    textField.backgroundColor = [UIColor yellowColor];
    
    //在toolBar上加上这些按钮
    NSArray * buttonsArray = [NSArray arrayWithObjects:button1,button2,doneButton,nil];
    [topView setItems:buttonsArray];
    [self setInputAccessoryView:topView];
    
    self.layer.borderColor = [UIColor colorFromHexString:@"#CCCCCC"].CGColor;
    self.layer.borderWidth = 0.5;
     
}
- (void)resignKeyboard{
    
    [self resignFirstResponder];
}
-(UILabel *)PlaceholderLabel
{
    if (_PlaceholderLabel==nil) {
        _PlaceholderLabel=[[UILabel alloc] init];
        [self addSubview:_PlaceholderLabel];
        _PlaceholderLabel.font=self.placeholderFont?self.placeholderFont:[UIFont systemFontOfSize:13];
        _PlaceholderLabel.textColor=self.placeholderColor;
        _PlaceholderLabel.text=self.placeholder;

    }
    return _PlaceholderLabel;

}
- (void)awakeFromNib {
   
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DidChange:) name:UITextViewTextDidChangeNotification object:self];
    
    self.placeholderColor = [UIColor lightGrayColor];
    
    

}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-(void)setPlaceholder:(NSString *)placeholder{
    if (placeholder.length == 0 || [placeholder isEqualToString:@""]) {
        self.PlaceholderLabel.hidden=YES;
    }
    else
        self.PlaceholderLabel.text=placeholder;
    _placeholder=placeholder;
    self.PlaceholderLabel.numberOfLines=0;
    self.PlaceholderLabel.preferredMaxLayoutWidth = kSCREEN_WIDTH - 10;
    WEAKSELF;
    [self.PlaceholderLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wkSelf).offset(3);
        make.top.equalTo(wkSelf).offset(6);
        make.right.equalTo(wkSelf).offset(-2);
    }];

    
}

-(void)DidChange:(NSNotification*)noti{
    
    if (self.placeholder.length == 0 || [self.placeholder isEqualToString:@""]) {
        self.PlaceholderLabel.hidden=YES;
    }
    
    if (self.text.length > 0) {
        self.PlaceholderLabel.hidden=YES;
    }
    else{
        self.PlaceholderLabel.hidden=NO;
    }
    
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.PlaceholderLabel removeFromSuperview];
    

}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
