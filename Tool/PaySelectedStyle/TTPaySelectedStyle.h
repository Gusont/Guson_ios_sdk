//
//  TTPaySelectedStyle.h
//  TTLife
//
//  Created by gui_huan on 2017/12/11.
//  Copyright © 2017年 tangshuanghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankCardDataManager.h"

typedef NS_ENUM(NSInteger,TTPayStyle)
{
    payStyleZhiFuBao =0,//支付宝
    payStyleMoney = 1,//现金
    payStyleKuaiJie = 2,//快捷
    payStyleQQ = 3,//QQ
    
};
typedef void(^CellDidSelected)(NSInteger index ,NSString *payCode, NSString *codeIDStr);
typedef void(^CellDidSelectedNoMoney)(NSInteger index);

typedef void(^BankCardList)(NSArray<BankCard *> *bankcardList);

/**
 当其VC存在ScrollView时，若添加在VC的View上，出现ScrollView偏移问题，添加在ScrollView上时没有问题 iOS11====设置IQKeyboardManager的layoutIfNeededOnUpdate为YES
 */
@interface TTPaySelectedStyle : UIView
@property (strong, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) IBOutlet UILabel *promptLabel;

//短信验证码类型
@property (nonatomic, strong)NSString *payCodeType;
@property (nonatomic, strong) NSMutableArray *paySelOptions;

@property (nonatomic, strong) CellDidSelected cellDidSelected;
@property (nonatomic, strong) CellDidSelectedNoMoney cellDidSelectedNoMoney;

- (void)codeViewAppearWithCodeType:(NSString *)codeType;

- (void)getBankList:(BankCardList)bankcardList;

@end
