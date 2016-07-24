//
//  AddNewBinController.m
//  JC8030
//
//  Created by cxm on 16/6/25.
//  Copyright © 2016年 cxm. All rights reserved.
//

#import "AddNewBinController.h"
#import "CableSettingsController.h"

@implementation AddNewBinController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Bin Settings";
    [self setNavigationLeftOnlyBack:@"Cancel"];
  
    if([self.flag isEqual:@"new"]){
        [btnSave setTitle:@"Next" forState:UIControlStateNormal];
        btnDelete.enabled=false;
    }
    else{
        [btnSave setTitle:@"Save" forState:UIControlStateNormal];
        [self setUIData];
    }
    textFillDate.delegate=self;
    
    //
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectImage)];
    binImageView.userInteractionEnabled=YES;
    [binImageView addGestureRecognizer:gesture];

}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [textBinName resignFirstResponder];
    [textStationID resignFirstResponder];
    [textLevel resignFirstResponder];
    [textCapacity resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//选择图片
-(void)selectImage{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //解释2: handler是一个block,当点击这个按钮的时候,就会调用handler里面的代码.
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate =self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
    }];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate =self;
        imagePicker.allowsEditing = YES;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
    }];
    
    [alert addAction:photo];//添加按钮
    [alert addAction:camera];
    [alert addAction:cancel];//添加按钮
    //以modal的形式
    [self presentViewController:alert animated:YES completion:^{ }];
}

#pragma mark -
#pragma UIImagePickerController Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    [self performSelector:@selector(saveImage:)  withObject:img afterDelay:0.5];
        //	[picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //	[picker dismissModalViewControllerAnimated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)image {
    //	NSLog(@"保存头像！");
    //	[userPhotoButton setImage:image forState:UIControlStateNormal];
       //	UIImage *smallImage=[self scaleFromImage:image toSize:CGSizeMake(80.0f, 80.0f)];//将图片尺寸改为80*80
    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(70, 70)];
    binImageView.image=smallImage;
}
- (UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize
{
    UIImage *newimage;
    if (nil == image) {
        newimage = nil;
    }
    else{
        CGSize oldsize = image.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }
        else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [image drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    return newimage;
}
// 改变图像的尺寸，方便上传服务器
- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(IBAction)selectGrainType:(id)sender{
    GrainTypeController *grainTypeView=[[GrainTypeController alloc]init];
    grainTypeView.grainTypeDelegate=self;
    [self.navigationController pushViewController:grainTypeView animated:YES];
}

//保存仓房信息并跳转到传感器设置页面
-(IBAction)saveBinInfo:(id)sender{
    if(textBinName.text.length==0||textStationID.text.length==0){
        [CXMGlobal okAlertFromController:self message:[NSString stringWithFormat:@"BinName and StationID can not be empty!"] btnTitle:@"I Known!"];
        return;
    }
    NSString *binName=textBinName.text;
    if([self.flag isEqualToString:@"new"]||![binName isEqualToString:self.bin.binName]){
        Bin *bin=[[BinOperation sharedBinOperation]getbinByName:binName];
        if(bin!=nil){
            [CXMGlobal okAlertFromController:self message:[NSString stringWithFormat:@"%@ is existed!",binName] btnTitle:@"I Known!"];
                return;
        }
    }
    NSNumber *stationID=(NSNumber *)textStationID.text;
    if(stationID.intValue<1||stationID.intValue>253){
        [CXMGlobal okAlertFromController:self message:[NSString stringWithFormat:@"StationID must be between 1 and 253!"] btnTitle:@"I Known!"];
        return;
    }
    NSString *fillDate=textFillDate.text;
    NSNumber *totalCapacity=(NSNumber *)textCapacity.text;
    if(textCapacity.text.length==0)
        totalCapacity=@(0);
    NSNumber *level=(NSNumber *)textLevel.text;
    if(textLevel.text.length==0)
        level=@(0);
    NSString *grainType=self.labelGrainType.text;
    NSData *binImage=UIImagePNGRepresentation(binImageView.image);
    if(binImage==nil)
        binImage=UIImageJPEGRepresentation(binImageView.image, 1.0);
    //NSLog(@"%lu",(unsigned long)binImage.length);
    NSString *curDate=[CXMGlobal getCurrentDateTime];
    if(self.bin==NULL){
        self.bin=[[Bin alloc]init];
        self.bin.binType=@"";
        self.bin.createdAt=curDate;
        self.bin.updatedAt=curDate;
        self.bin.removed=@(0);
    }
    self.bin.binName=binName;
    self.bin.stationID=stationID;
    self.bin.fillDate=fillDate;
    self.bin.totalCapacity=totalCapacity;
    self.bin.level=level;
    self.bin.bushels=@(totalCapacity.intValue*level.intValue*0.1);
    self.bin.grainType=grainType;
    self.bin.binImage=binImage;
    self.bin.updatedAt=curDate;
    BOOL result;
    if(self.bin.ID==NULL)
        result=[[BinOperation sharedBinOperation] addBin:self.bin];
    else
        result=[[BinOperation sharedBinOperation]modifyBin:self.bin];
    if(!result){
        [CXMGlobal okAlertFromController:self message:[NSString stringWithFormat:@"Operation failed!"] btnTitle:@"I Known!"];
        return;
    }
    if([self.flag isEqualToString:@"new"]){
        CableSettingsController *cableSettingsView=[[CableSettingsController alloc]init];
        self.bin=[[BinOperation sharedBinOperation]getbinByName:self.bin.binName];
        cableSettingsView.binID=self.bin.ID;
        cableSettingsView.flag=@"new";
        [self.navigationController pushViewController:cableSettingsView animated:YES];
    }
    else{
        [CXMGlobal okAlertFromController:self message:[NSString stringWithFormat:@"Modify successful!"] btnTitle:@"OK!"];
    }
}

-(IBAction)deleteBin:(id)sender{
    BOOL result=[[BinOperation sharedBinOperation]removeBin:self.bin.ID];
    if(result)
        [self.navigationController popToRootViewControllerAnimated:YES];
    else
        [CXMGlobal okAlertFromController:self message:[NSString stringWithFormat:@"Operation failed!"] btnTitle:@"I Known!"];
}

-(void)setGrainType:(NSString *)grainType{
    self.labelGrainType.text=grainType;
}

-(void)setUIData{
    if(self.binID!=NULL){
        self.bin=[[BinOperation sharedBinOperation]getBinByID:self.binID];
        textBinName.text=self.bin.binName;
        textStationID.text=self.bin.stationID.description;
        textFillDate.text=self.bin.fillDate;
        textCapacity.text=self.bin.totalCapacity.description;
        textLevel.text=self.bin.level.description;
        self.labelGrainType.text=self.bin.grainType;
        binImageView.image=[UIImage imageWithData:self.bin.binImage];
    }
}


-(void)selectData:(UITextField *)textField{
    if (IOS8) {
        UIDatePicker *datePicker = [[UIDatePicker alloc] init];
        datePicker.datePickerMode = UIDatePickerModeDate;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alert.view addSubview:datePicker];
        //解释2: handler是一个block,当点击ok这个按钮的时候,就会调用handler里面的代码.
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Select" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
            
            //实例化一个NSDateFormatter对象
            [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式
            
            NSString *dateString = [dateFormat stringFromDate:datePicker.date];
            textField.text=dateString;
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
        }];
        
        [alert addAction:ok];//添加按钮
        
        
        [alert addAction:cancel];//添加按钮
        //以modal的形式
        [self presentViewController:alert animated:YES completion:^{ }];
    }
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if(textField.tag==123){
        [self selectData:textField];
        return NO;
    }else{
        return YES;
    }
}









@end
