//
//  TTPaySelectedStyle.m
//  TTLife
//
//  Created by gui_huan on 2017/12/11.
//  Copyright © 2017年 tangshuanghui. All rights reserved.
//

#import "TTPaySelectedStyle.h"
#import "TTUserContentCell.h"
#import "TTAuthenticationCodeMode.h"
//#import "HHYBankListViewController.h"
#import "JKCountDownButton.h"
@interface TTPaySelectedStyle()<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UITextField *codeTextField;
@property (strong, nonatomic) IBOutlet JKCountDownButton *codeButton;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;

@property (nonatomic, strong) NSString *codeIDStr;
@property (nonatomic, assign) NSInteger indexPathRow;

@end
@implementation TTPaySelectedStyle

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    
    
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
    self.hidden = YES;
    self.contentView = [[[NSBundle mainBundle]loadNibNamed:@"TTPaySelectedStyle" owner:self options:nil]lastObject];
    self.contentView.frame = self.bounds;
    [self addSubview:self.contentView];
    self.promptLabel.text = @"选择支付方式";
    [self.mainTableView registerNib:[UINib nibWithNibName:@"TTUserContentCell" bundle:nil] forCellReuseIdentifier:@"TTUserContentCell"];
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTUserContentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TTUserContentCell"];

    if ([self.paySelOptions[indexPath.row] isKindOfClass: [QHWTableRowOption class]]) {
        [cell confignPurchaseInventoryWithOption:self.paySelOptions[indexPath.row]];
    }
    if ([self.paySelOptions[indexPath.row] isKindOfClass: [BankCard class]]) {
        BankCard *bank = self.paySelOptions[indexPath.row];
        [cell confignPayCellWithBank:bank];
        //贷记卡不可操作
        if ([bank.cardType isEqualToString:@"2"]) {
            cell.contentView.alpha = 0.5;
            cell.userInteractionEnabled = NO;
        }else{
            cell.contentView.alpha = 1.0;
            cell.userInteractionEnabled = YES;
        }
    }
    cell.selectionStyle = UITableViewCellStyleDefault;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001f;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.paySelOptions.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidden = YES;
    self.indexPathRow = indexPath.row;
    if (self.cellDidSelectedNoMoney) {
        self.cellDidSelectedNoMoney(indexPath.row);
    }
}
- (void)codeViewAppearWithCodeType:(NSString *)codeType{
    self.payCodeType = codeType;
    self.promptLabel.text = @"获取验证码";
    self.hidden = NO;
    self.mainTableView.hidden = YES;
    self.topView.hidden = NO;
    self.headerView.hidden = NO;
    
}
- (IBAction)delBtnClick:(id)sender {
    [self hiddenView];
}
- (void)hiddenView{
    [self endEditing:YES];
    self.hidden = YES;
    self.promptLabel.text = @"选择支付方式";
    self.mainTableView.hidden = NO;
    self.topView.hidden = NO;
    self.headerView.hidden = YES;
    self.codeIDStr = nil;
    self.codeTextField.text = nil;
    [self.codeButton stopCountDown];
}
#pragma mark - 获取验证码
- (void)httGetVerificationCodeWithType:(NSString *)type {
    HHYUser *user = [AppDelegate appDelegate].user;
    TTAuthenticationCodeMode *aCodeMode = [[TTAuthenticationCodeMode alloc]init];
    WEAKSELF
    [aCodeMode httGetVerificationCodeWithView:self PhoneTel:user.account Type:[type integerValue] codeIDStr:^(NSString *codeID) {
        wkSelf.codeIDStr = codeID;
    }];
}

- (IBAction)codeBtnClick:(JKCountDownButton *)sender {

    [sender buttonClickWithStart];
    [self httGetVerificationCodeWithType:self.payCodeType];
    
}
- (IBAction)sureBtnClick:(id)sender {
    
    if (![self.codeIDStr length]) {
        [HHYTools showPromptContent:@"请先获取验证码" onView:self];
        return;
    }
    if (![self.codeTextField.text length]) {
        [HHYTools showPromptContent:@"请输入验证码" onView:self];
        return;
    }
    
    if (self.cellDidSelected) {
        self.cellDidSelected(self.indexPathRow, self.codeTextField.text,self.codeIDStr);
        [self hiddenView];
    }
    
}
- (void)getBankList:(BankCardList)bankcardList{
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:[GetCurrentShowVC getCurrentShowVC].view animated:YES];
    HUD.label.text = @"请求中...";
    BankCardDataManager *manager = [BankCardDataManager manager];
    [manager getBindBankListWithResponse:^(HHYResponse *response) {
        HUD.hidden = YES;
        if ([response isSuccess]) {
            
            if ([[response recordList] count]  > 0) {
                for (NSDictionary *dict in [response recordList]) {
                    BankCard *bank = [[BankCard alloc]initWithDictionary:dict error:nil];
                    bank.bankName = [NSString stringWithFormat:@"%@(%@)",bank.bankName,[bank.cardNo substringFromIndex:bank.cardNo.length - 4]];
                    [self.paySelOptions addObject:bank];
                }
                if (bankcardList) {
                    bankcardList(self.paySelOptions);
                }
                [self.mainTableView reloadData];
            }else{
                self.hidden = YES;
                UIAlertController *alert = [AlertControllerShow alertControllerShowWithTitle:@"提示" Message:@"还没有绑定银行卡" SurBtnTitle:@"确定" CancelBtnTitle:@"取消" SurBtnClick:^{
                    BankListViewController *bankList = [[BankListViewController alloc]initWithNibName:@"BankListViewController" bundle:nil];
                    [[GetCurrentShowVC getCurrentShowVC].navigationController pushViewController:bankList animated:YES];
                } CancelBtnClick:nil];
                [[GetCurrentShowVC getCurrentShowVC] presentViewController:alert animated:YES completion:nil];
            }
        }else{
            [MBProgressHUD hideAfterDelay:1.5f withOnlyMessage:[response backMessage]];
            
        }
    }];
}

- (void)getBankList{
    
   
}
- (NSMutableArray *)paySelOptions{
    if (!_paySelOptions) {
        _paySelOptions = [NSMutableArray new];
    }
    return _paySelOptions;
}


@end
