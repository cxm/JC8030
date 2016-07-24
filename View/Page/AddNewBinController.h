//
//  AddNewBinController.h
//  JC8030
//
//  Created by cxm on 16/6/25.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "BaseConroller.h"
@protocol setGrainTypeDelegate;
#import "GrainTypeController.h"
#import "Bin.h"
#import "BinOperation.h"

@interface AddNewBinController : BaseConroller<setGrainTypeDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    IBOutlet UITextField *textBinName;
    IBOutlet UITextField *textStationID;
    IBOutlet UITextField *textFillDate;
    IBOutlet UITextField *textCapacity;
    IBOutlet UITextField *textLevel;
    IBOutlet UIImageView *binImageView;
    IBOutlet UIButton *btnSave;
    IBOutlet UIButton *btnDelete;
    
    IBOutlet UIView *nameView;
    IBOutlet UIScrollView *scroll;
}
@property(nonatomic,strong) IBOutlet UILabel *labelGrainType;
@property(nonatomic,strong) Bin *bin;
@property(nonatomic,copy)NSString *flag;//新添加还是设置
@end
