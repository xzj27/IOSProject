//
//  foodAddingViewController.m
//  FOSAapp1.0
//
//  Created by hs on 2020/3/4.
//  Copyright © 2020 hs. All rights reserved.
//

#import "foodAddingViewController.h"
#import "takePictureViewController.h"
#import "FosaDatePickerView.h"
#import "foodKindCollectionViewCell.h"
#import "FMDB.h"
#import "FoodModel.h"
#import <UserNotifications/UserNotifications.h>
#import "QRCodeScanViewController.h"

@interface foodAddingViewController ()<UIScrollViewDelegate,UITextViewDelegate,UITextFieldDelegate, UICollectionViewDelegate,FosaDatePickerViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UNUserNotificationCenterDelegate>{
    NSString *kindID;
    NSString *selectCategory;
    NSString *docPath;
    NSInteger currentPictureIndex;//标识图片轮播器当前指向哪张图片
}


@property (nonatomic,weak)   FosaDatePickerView *fosaDatePicker;//日期选择器
@property (nonatomic,strong) NSMutableArray<NSString *> *categoryArray;//种类
@property (nonatomic,strong) FMDatabase *db;//数据库
@property (nonatomic,strong) NSString *storageDevice;//存储设备号
// 当前获取焦点的UITextField
@property (strong, nonatomic) UITextView *currentResponderTextView;
//图片轮播器
@property (nonatomic,strong) UIImageView *imageview1,*imageview2,*imageview3;
@property (nonatomic,strong) NSMutableArray<UIImageView *> *imageviewArray;
@end

@implementation foodAddingViewController
#pragma mark - 属性延迟加载
- (UIButton *)likeBtn{
    if (_likeBtn == nil) {
        _likeBtn = [[UIButton alloc]init];
    }
    return _likeBtn;
}
- (UIButton *)helpBtn{
    if (_helpBtn == nil) {
        _helpBtn = [[UIButton alloc]init];
    }
    return _helpBtn;
}
//header
- (UIView *)headerView{
    if (_headerView == nil) {
        _headerView = [[UIView alloc]init];
    }
    return _headerView;
}

- (UIScrollView *)picturePlayer{
    if (_picturePlayer == nil) {
        _picturePlayer = [[UIScrollView alloc]init];
    }
    return _picturePlayer;
}
- (UIPageControl *)pageControl{
    if (_pageControl == nil) {
        _pageControl = [UIPageControl new];
    }
    return _pageControl;
}
- (UIView *)storageView{
    if (_storageView == nil) {
        _storageView = [UIView new];
    }
    return _storageView;
}
- (UIView *)expireView{
    if (_expireView == nil) {
        _expireView = [UIView new];
    }
    return _expireView;
}
- (UIButton *)storageIcon{
    if (_storageIcon == nil) {
        _storageIcon = [UIButton new];
    }
    return _storageIcon;
}
- (UIButton *)expireIcon{
    if (_expireIcon == nil) {
        _expireIcon = [UIButton new];
    }
    return _expireIcon;
}
- (UILabel *)storageLabel{
    if (_storageLabel == nil) {
        _storageLabel = [UILabel new];
    }
    return _storageLabel;
}
- (UILabel *)expireLabel{
    if (_expireLabel == nil) {
        _expireLabel = [UILabel new];
    }
    return _expireLabel;
}
- (UILabel *)storageDateLabel{
    if (_storageDateLabel == nil) {
        _storageDateLabel = [UILabel new];
    }
    return _storageDateLabel;
}
- (UILabel *)expireDateLabel{
    if (_expireDateLabel == nil) {
        _expireDateLabel = [UILabel new];
    }
    return _expireDateLabel;
}
- (UILabel *)storageTimeLabel{
    if (_storageTimeLabel == nil) {
        _storageTimeLabel = [UILabel new];
    }
    return _storageTimeLabel;
}
- (UILabel *)expireTimeLabel{
    if (_expireTimeLabel == nil) {
        _expireTimeLabel = [UILabel new];
    }
    return _expireTimeLabel;
}
//content
- (UIScrollView *)contentView{
    if (_contentView == nil) {
        _contentView = [UIScrollView new];
    }
    return _contentView;
}
- (UIView *)foodNameView{
    if (_foodNameView == nil) {
        _foodNameView = [UIView new];
    }
    return _foodNameView;
}
- (UILabel *)foodNameLabel{
    if (_foodNameLabel == nil) {
        _foodNameLabel = [UILabel new];
    }
    return _foodNameLabel;
}
- (UITextField *)foodTextView{
    if (_foodTextView == nil) {
        _foodTextView = [UITextField new];
    }
    return _foodTextView;
}
- (UIButton *)scanBtn{
    if (_scanBtn == nil) {
        _scanBtn = [UIButton new];
    }
    return _scanBtn;
}
- (UIView *)foodDescribedView{
    if (_foodDescribedView == nil) {
        _foodDescribedView = [UIView new];
    }
    return _foodDescribedView;
}
- (UILabel *)foodDescribedLabel{
    if (_foodDescribedLabel == nil) {
        _foodDescribedLabel = [UILabel new];
    }
    return _foodDescribedLabel;
}
- (UITextView *)foodDescribedTextView{
    if (_foodDescribedTextView == nil) {
        _foodDescribedTextView = [UITextView new];
    }
    return _foodDescribedTextView;
}
- (UILabel *)numberLabel{
    if (_numberLabel == nil) {
        _numberLabel = [UILabel new];
    }
    return _numberLabel;
}
- (UIView *)locationView{
    if (_locationView == nil) {
        _locationView = [UIView new];
    }
    return _locationView;
}
- (UILabel *)locationLabel{
    if (_locationLabel == nil) {
        _locationLabel = [UILabel new];
    }
    return _locationLabel;
}
- (UITextField *)locationTextView{
    if (_locationTextView == nil) {
        _locationTextView = [UITextField new];
    }
    return _locationTextView;
}
//footer
- (UIView *)footerView{
    if (_footerView == nil) {
        _footerView = [UIView new];
    }
    return _footerView;
}
- (UIButton *)leftIndex{
    if (_leftIndex == nil) {
        _leftIndex = [UIButton new];
    }
    return _leftIndex;
}
- (UIButton *)rightIndex{
    if (_rightIndex == nil) {
        _rightIndex = [UIButton new];
    }
    return _rightIndex;
}
- (UIButton *)doneBtn{
    if (_doneBtn == nil) {
        _doneBtn = [UIButton new];
    }
    return _doneBtn;
}
- (UIImageView *)imageview1{
    if (_imageview1 == nil) {
        _imageview1 = [[UIImageView alloc]init];
    }
    return _imageview1;
}
- (UIImageView *)imageview2{
    if (_imageview2 == nil) {
        _imageview2 = [[UIImageView alloc]init];
    }
    return _imageview2;
}
- (UIImageView *)imageview3{
    if (_imageview3 == nil) {
        _imageview3 = [[UIImageView alloc]init];
    }
    return _imageview3;
}
- (NSMutableArray<UIImage *> *)foodImgArray{
    if (_foodImgArray == nil) {
        _foodImgArray = [NSMutableArray new];
    }
    return _foodImgArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatNavigation];
    [self creatHeaderView];
    [self creatContentView];
    [self creatFooterView];
    [self InitialDatePicker];
}
- (void)viewWillAppear:(BOOL)animated{
//    //添加键盘弹出与收回的事件
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self OpenSqlDatabase:@"FOSA"]; //打开数据库
    self.storageDevice = @"";
    self.likeBtn.hidden = NO;
}
//UI
- (void)creatNavigation{
/**显示图片和标题的自定义返回按钮*/
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton setImage:[[UIImage imageNamed:@"icon_backW"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];//
    //更改返回按钮填充颜色
    self.navigationController.navigationBar.tintColor = [UIColor darkGrayColor];

/**like*/
    self.likeBtn.frame = CGRectMake(screen_width/2-NavigationBarH/2, 0, NavigationBarH, NavigationBarH);
    [self.likeBtn setImage:[UIImage imageNamed:@"icon_likeW"] forState:UIControlStateNormal];
    self.likeBtn.tag = 0;
    [self.navigationController.navigationBar addSubview:self.likeBtn];
    [self.likeBtn addTarget:self action:@selector(selectToLike) forControlEvents:UIControlEventTouchUpInside];
/**help*/
    UIButton *helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
    helpButton.frame = CGRectMake(0, 0, NavigationBarH, NavigationBarH);
    //[helpButton setTitle:@"Back" forState:UIControlStateNormal];
    [helpButton setBackgroundImage:[UIImage imageNamed:@"icon_helpW"]  forState:UIControlStateNormal];
    [helpButton addTarget:self action:@selector(selectToHelp) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:helpButton];
}
- (void)creatHeaderView{
    //点击
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTappedToCloseKeyBoard:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    self.headerView.frame = CGRectMake(0, 0, screen_width, screen_height*2/5);
    //self.headerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.headerView];

    int headerWidth  = self.headerView.frame.size.width;
    int headerHeight = self.headerView.frame.size.height;
    //self.automaticallyAdjustsScrollViewInsets = NO;
    //图片轮播器
    [self creatPicturePlayer];
    //日期
    self.storageView.frame = CGRectMake(0, headerHeight*4/5, headerWidth*2/5, headerHeight/5);
    [self.headerView addSubview:self.storageView];
    
    self.expireView.frame = CGRectMake(headerWidth*3/5, headerHeight*4/5, headerWidth*2/5, headerHeight/5);
    self.expireView.userInteractionEnabled = YES;
    UITapGestureRecognizer *dateRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectExpireDate)];
    [self.expireView addGestureRecognizer:dateRecognizer];
    [self.headerView addSubview:self.expireView];
    
    int storageWidth = self.storageView.frame.size.width;
    int storageHeight = self.storageView.frame.size.height;
    
    self.storageIcon.frame = CGRectMake(storageWidth/10, storageHeight/5, storageHeight*3/5, storageHeight*3/5);
    [self.storageIcon setImage:[UIImage imageNamed:@"icon_remindW"] forState:UIControlStateNormal];//Background
    self.storageIcon.userInteractionEnabled = NO;
    [self.storageView addSubview:self.storageIcon];
    self.storageLabel.frame = CGRectMake(storageWidth/10+storageHeight*3/5, 0, storageWidth*9/10-storageHeight*3/5, storageHeight/3);
    self.storageLabel.text = @"CHECKED IN";
    self.storageLabel.font = [UIFont systemFontOfSize:15];
    self.storageLabel.textColor = [UIColor whiteColor];
    [self.storageView addSubview:self.storageLabel];
    
    self.storageDateLabel.frame = CGRectMake(storageWidth/10+storageHeight*3/5, storageHeight/3, storageWidth*9/10-storageHeight*3/5, storageHeight/3);
    //获取当天的时间并进行处理
    NSDate *currentDate = [NSDate new];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yy/HH:mm"];
    NSString *currentDateStr = [formatter stringFromDate:currentDate];
    NSArray *currentArrray = [currentDateStr componentsSeparatedByString:@"/"];
    NSString *storageDate = [NSString stringWithFormat:@"%@/%@/%@",currentArrray[0],[mouth valueForKey:currentArrray[1]],currentArrray[2]];
    
    NSLog(@"==========%@",currentDateStr);
    self.storageDateLabel.text = storageDate;
    self.storageDateLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20.0*(414.0/screen_width)];
    self.storageDateLabel.textColor = [UIColor whiteColor];
    [self.storageView addSubview:self.storageDateLabel];
    
    self.storageTimeLabel.frame = CGRectMake(storageWidth/10+storageHeight*3/5, storageHeight*2/3, storageWidth*9/10-storageHeight*3/5, storageHeight/3);
    self.storageTimeLabel.text = currentArrray[3];
    self.storageTimeLabel.textColor = [UIColor whiteColor];
    [self.storageView addSubview:self.storageTimeLabel];
    
    int expireWidth = self.expireView.frame.size.width;
    int expireHeight = self.expireView.frame.size.height;
    
    self.expireIcon.frame = CGRectMake(0, expireHeight/5, expireHeight*3/5, expireHeight*3/5);
    [self.expireIcon setImage:[UIImage imageNamed:@"icon_expireW"] forState:UIControlStateNormal];
    self.expireIcon.userInteractionEnabled = NO;
    [self.expireView addSubview:self.expireIcon];
    self.expireLabel.frame = CGRectMake(expireHeight*3/5, 0, expireWidth-expireHeight*3/5, expireHeight/3);
    self.expireLabel.text = @"EXPIRES";
    self.expireLabel.font = [UIFont systemFontOfSize:15];
    self.expireLabel.textColor = [UIColor whiteColor];
    [self.expireView addSubview:self.expireLabel];
    
    self.expireDateLabel.frame = CGRectMake(expireHeight*3/5, expireHeight/3, expireWidth-expireHeight*3/5, expireHeight/3);
    self.expireDateLabel.text = storageDate;
    self.expireDateLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18.0*(414.0/screen_width)];
    self.expireDateLabel.textColor = [UIColor whiteColor];
    [self.expireView addSubview:self.expireDateLabel];
    
    self.expireTimeLabel.frame = CGRectMake(expireHeight*3/5, expireHeight*2/3, expireWidth-expireHeight*3/5, expireHeight/3);
    self.expireTimeLabel.text = currentArrray[3];
    self.expireTimeLabel.textColor = [UIColor whiteColor];
    [self.expireView addSubview:self.expireTimeLabel];
}

- (void)creatContentView{
    self.contentView.frame = CGRectMake(0, CGRectGetMaxY(self.headerView.frame), screen_width, screen_height/3);
    //self.contentView.
    int contentHeight = self.contentView.frame.size.height;
    [self.view addSubview:self.contentView];
    
    self.foodNameView.frame = CGRectMake(0, 0, screen_width, contentHeight/4);
    [self.contentView addSubview:self.foodNameView];
    
    self.foodNameLabel.frame = CGRectMake(screen_width/12, contentHeight/16, screen_width/3, contentHeight/16);
    self.foodNameLabel.text = @"Name";
    self.foodNameLabel.textColor = [UIColor grayColor];
    [self.foodNameView addSubview:self.foodNameLabel];
    self.foodTextView.frame = CGRectMake(screen_width/20, contentHeight/8, screen_width*7/10, contentHeight/8);
    self.foodTextView.layer.cornerRadius = 5;
    [self.foodTextView setValue:[NSNumber numberWithInt:10] forKey:@"paddingLeft"];//设置输入文本的起始位置
    self.foodTextView.delegate = self;
    self.foodTextView.returnKeyType = UIReturnKeyDone;
    self.foodTextView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self.foodNameView addSubview:self.foodTextView];
    
    self.scanBtn.frame = CGRectMake(screen_width*4/5, contentHeight/8, contentHeight/8, contentHeight/8);
    [self.scanBtn setImage:[UIImage imageNamed:@"icon_scan"] forState:UIControlStateNormal];
    [self.scanBtn addTarget:self action:@selector(jumpToScan) forControlEvents:UIControlEventTouchUpInside];
    [self.foodNameView addSubview:self.scanBtn];
    
    self.foodDescribedView.frame = CGRectMake(0, contentHeight/4, screen_width, contentHeight/2);
    [self.contentView addSubview:self.foodDescribedView];
    self.foodDescribedLabel.frame = CGRectMake(screen_width/12, contentHeight/16, screen_width/3, contentHeight/16);
    self.foodDescribedLabel.text = @"Description";
    self.foodDescribedLabel.textColor = [UIColor grayColor];
    [self.foodDescribedView addSubview:self.foodDescribedLabel];
    self.foodDescribedTextView.frame = CGRectMake(screen_width/20, contentHeight/8, screen_width*9/10, contentHeight*3/8);
    self.foodDescribedTextView.layer.cornerRadius = 5;
    self.foodDescribedTextView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    self.foodDescribedTextView.textColor = [UIColor lightGrayColor];
    self.foodDescribedTextView.font = [UIFont systemFontOfSize:20*(screen_width/414.0)];
    self.foodDescribedTextView.delegate = self;
    self.foodDescribedTextView.returnKeyType = UIReturnKeyNext;
    self.foodDescribedTextView.textContainerInset = UIEdgeInsetsMake(10, 5, 0, 0);//上、左、下、右
    [self.foodDescribedView addSubview:self.foodDescribedTextView];
    //输入字数提示
    int aboutFoodInputWidth = self.foodDescribedTextView.frame.size.width;
    int aboutFoodInputHeight = self.foodDescribedTextView.frame.size.height;
    self.numberLabel.frame = CGRectMake(aboutFoodInputWidth*4/5, aboutFoodInputHeight*3/4, aboutFoodInputWidth/5, aboutFoodInputHeight/4);
    self.numberLabel.font = [UIFont systemFontOfSize:20*(screen_width/414.0)];
    if ((unsigned long)self.foodDescribedTextView.text.length > 80) {
        self.numberLabel.text = [NSString stringWithFormat:@"%d/80",80];
    }else{
        self.numberLabel.text = [NSString stringWithFormat:@"%lu/80",(unsigned long)self.foodDescribedTextView.text.length];
    }
    self.numberLabel.textColor = [UIColor grayColor];
    self.numberLabel.textAlignment = 2;
    [self.foodDescribedTextView addSubview:self.numberLabel];
    
    self.locationView.frame = CGRectMake(0, contentHeight*3/4, screen_width, contentHeight/4);
    [self.contentView addSubview:self.locationView];
    self.locationLabel.frame = CGRectMake(screen_width/12, contentHeight/16, screen_width/3, contentHeight/16);
    self.locationLabel.text = @"Location";
    self.locationLabel.textColor = [UIColor grayColor];
    [self.locationView addSubview:self.locationLabel];
    self.locationTextView.frame = CGRectMake(screen_width/20, contentHeight/8, screen_width*9/10, contentHeight/8);
    self.locationTextView.layer.cornerRadius = 5;
    self.locationTextView.delegate = self;
    [self.locationTextView setValue:[NSNumber numberWithInt:10] forKey:@"paddingLeft"];
    self.locationTextView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    [self.locationView addSubview:self.locationTextView];
}

- (void)creatFooterView{
    //初始化种类数据
    NSArray *array = @[@"Biscuit",@"Bread",@"Cake",@"Cereal",@"Dairy",@"Fruit",@"Meat",@"Snacks",@"Spice",@"Veggie"];
    self.categoryArray = [[NSMutableArray alloc]initWithArray:array];
    kindID = @"categoryCell";
    
    self.footerView.frame = CGRectMake(0, CGRectGetMaxY(self.contentView.frame), screen_width, screen_height/4);
    //self.footerView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.footerView];
    int footerHeight = self.footerView.frame.size.height;
    self.leftIndex.frame = CGRectMake(screen_width/60, footerHeight*5/12, screen_width/15, screen_width/15);
    self.leftIndex.layer.cornerRadius = self.leftIndex.frame.size.width/2;
    self.leftIndex.backgroundColor = [UIColor grayColor];
    [self.leftIndex setBackgroundImage:[UIImage imageNamed:@"icon_leftindex"] forState:UIControlStateNormal];
    [self.footerView addSubview:self.leftIndex];
    
    self.rightIndex.frame = CGRectMake(screen_width*11/12, footerHeight*5/12, screen_width/15, screen_width/15);//
    self.rightIndex.layer.cornerRadius = self.rightIndex.frame.size.width/2;
    [self.rightIndex setBackgroundImage:[UIImage imageNamed:@"icon_rightindex"] forState:UIControlStateNormal];
    self.rightIndex.backgroundColor = [UIColor grayColor];
    [self.footerView addSubview:self.rightIndex];
    
    
    //食物种类选择栏 可滚动
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake((screen_width)/7, footerHeight/2);

    self.categoryCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(screen_width/12, footerHeight/12, screen_width*5/6, footerHeight/2) collectionViewLayout:flowLayout];
    
    self.categoryCollection.backgroundColor = [UIColor whiteColor];
    self.categoryCollection.delegate = self;
    self.categoryCollection.dataSource = self;
    self.categoryCollection.showsHorizontalScrollIndicator = NO;
    self.categoryCollection.bounces = NO;
    [self.categoryCollection registerClass:[foodKindCollectionViewCell class] forCellWithReuseIdentifier:kindID];
    [self.footerView addSubview:self.categoryCollection];
    
    self.doneBtn.frame = CGRectMake(screen_width/3, footerHeight*2/3, screen_width/3, footerHeight/6);
    self.doneBtn.layer.cornerRadius = self.doneBtn.frame.size.height/2;
    [self.doneBtn setTitle:@"DONE" forState:UIControlStateNormal];
    self.doneBtn.backgroundColor = FOSAgreen;
    [self.footerView addSubview:self.doneBtn];
    [self.doneBtn addTarget:self action:@selector(saveInfoAndFinish) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark - 图片轮播器
- (void)creatPicturePlayer{
    self.imageviewArray = [[NSMutableArray alloc]initWithObjects:self.imageview1,self.imageview2,self.imageview3, nil];
    
    int headerWidth  = self.headerView.frame.size.width;
    int headerHeight = self.headerView.frame.size.height;
    self.picturePlayer.frame = CGRectMake(0, 0, headerWidth, headerHeight);
    self.picturePlayer.pagingEnabled = YES;
    self.picturePlayer.delegate = self;
    self.picturePlayer.showsHorizontalScrollIndicator = NO;
    self.picturePlayer.showsVerticalScrollIndicator = NO;
    self.picturePlayer.alwaysBounceVertical = NO;
        // 解决UIscrollerView在导航栏透明的情况下往下偏移的问题
    self.picturePlayer.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    self.picturePlayer.bounces = NO;
    self.picturePlayer.contentSize = CGSizeMake(headerWidth*3, 0);
    for (NSInteger i = 0; i < 3; i++) {
            CGRect frame = CGRectMake(i*headerWidth, 0, headerWidth, self.headerView.frame.size.height);
        self.imageviewArray[i].frame = frame;
            self.imageviewArray[i].userInteractionEnabled = YES;
            self.imageviewArray[i].contentMode = UIViewContentModeScaleAspectFill;
            self.imageviewArray[i].clipsToBounds = YES;
        NSString *imgName = [NSString stringWithFormat:@"%@%ld",@"picturePlayer",i+1];
            self.imageviewArray[i].image = [UIImage imageNamed:imgName];
            UITapGestureRecognizer *clickRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumptoPhoto)];
               //clickRecognizer.view.tag = i;
            [self.imageviewArray[i] addGestureRecognizer:clickRecognizer];
            [self.picturePlayer addSubview:self.imageviewArray[i]];
        }
           [self.headerView addSubview:self.picturePlayer];
            //轮播页面指示器
           self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(headerWidth*2/5, headerHeight-30, headerWidth/5, 20)];
           self.pageControl.currentPage = 0;
           self.pageControl.numberOfPages = 3;
           self.pageControl.pageIndicatorTintColor = FOSAFoodBackgroundColor;
           self.pageControl.currentPageIndicatorTintColor = FOSAgreen;
           [self.headerView addSubview:self.pageControl];
}

#pragma mark - 初始化日期选择器
-(void)InitialDatePicker{
    FosaDatePickerView *DatePicker = [[FosaDatePickerView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300)];
    DatePicker.delegate = self;
    DatePicker.title = @"请选择时间";
    [self.view addSubview:DatePicker];
    self.fosaDatePicker = DatePicker;
    self.fosaDatePicker.hidden = YES;
}
#pragma mark -- FosaDatePickerViewDelegate
/**
 保存按钮代理方法
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    NSLog(@"保存点击");
    //处理日期字符串
    NSArray *array = [timer componentsSeparatedByString:@"/"];
    NSString *dateStr = [NSString stringWithFormat:@"%@/%@/%@",array[0],[mouth valueForKey:array[1]],array[2]];
    self.expireDateLabel.text = dateStr;
    self.expireTimeLabel.text= array[3];
    NSLog(@"%@",dateStr);
    [UIView animateWithDuration:0.3 animations:^{
       self.fosaDatePicker.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
   }];
}
/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate {
    NSLog(@"取消点击");
    [UIView animateWithDuration:0.3 animations:^{
        self.fosaDatePicker.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
}

#pragma mark -- UIScrollerView
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger index = offset/self.headerView.frame.size.width;
    self.pageControl.currentPage = index;
    currentPictureIndex = index;
}
#pragma mark - UICollectionViewDataSource
//每个section有几个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categoryArray.count;
}
//collectionView有几个section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
//返回这个UICollectionViewCell是否可以被选择
- ( BOOL )collectionView:( UICollectionView *)collectionView shouldSelectItemAtIndexPath:( NSIndexPath *)indexPath{
    return YES ;
}
//每个cell的具体内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath {
    foodKindCollectionViewCell *cell = [self.categoryCollection dequeueReusableCellWithReuseIdentifier:kindID forIndexPath:indexPath];
    cell.kind.text = self.categoryArray[indexPath.row];
    //cell.categoryPhoto.backgroundColor = [UIColor clearColor];
    cell.categoryPhoto.image = [UIImage imageNamed:self.categoryArray[indexPath.row]];
    return cell;
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    foodKindCollectionViewCell *cell = (foodKindCollectionViewCell *)[self.categoryCollection cellForItemAtIndexPath:indexPath];
    cell.rootView.backgroundColor = FOSAgreen;
    cell.categoryPhoto.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@W",cell.kind.text]];
    selectCategory = cell.kind.text;
    NSLog(@"Selectd:%@",selectCategory);
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    foodKindCollectionViewCell *cell = (foodKindCollectionViewCell *)[self.categoryCollection cellForItemAtIndexPath:indexPath];
    cell.rootView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    cell.categoryPhoto.image = [UIImage imageNamed:selectCategory];
    cell.categoryPhoto.backgroundColor = [UIColor clearColor];
}

#pragma mark - UITextViewDelegate,UITextFiledDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.5 animations:^{
        [self.contentView setContentOffset:CGPointMake(0, self.contentView.frame.size.height/4)];
    }];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    //不支持系统表情的输入
        if ([[textView textInputMode]primaryLanguage]==nil||[[[textView textInputMode]primaryLanguage]isEqualToString:@"emoji"]) {
            return NO;
        }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    self.numberLabel.text = [NSString stringWithFormat:@"%lu/80",(unsigned long)textView.text.length];
    if (textView.text.length >= 80) {
        textView.text = [textView.text substringToIndex:80];
        self.numberLabel.text = @"80/80";
    }
}
//已经结束/退出编辑模式
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.5 animations:^{
        [self.contentView setContentOffset:CGPointMake(0, 0)];
    }];
    return YES;
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.foodTextView) {
        [UIView animateWithDuration:0.5 animations:^{
               [self.contentView setContentOffset:CGPointMake(0, CGRectGetMinY(self.foodTextView.frame))];
           }];
        NSLog(@"food");
    }else if(textField == self.locationTextView){
        [UIView animateWithDuration:0.5 animations:^{
            [self.contentView setContentOffset:CGPointMake(0, CGRectGetMinY(self.locationView.frame))];
        }];
        NSLog(@"location");
    }
   
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [UIView animateWithDuration:0.5 animations:^{
        [self.contentView setContentOffset:CGPointMake(0, 0)];
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 响应事件
- (void)selectToLike{
    if (self.likeBtn.tag == 0) {
        [self.likeBtn setImage:[UIImage imageNamed:@"icon_likeHL"] forState:UIControlStateNormal];
        self.likeBtn.tag = 1;
        self.likeBtn.accessibilityValue = @"1";
    }else{
        [self.likeBtn setImage:[UIImage imageNamed:@"icon_likeW"] forState:UIControlStateNormal];
        self.likeBtn.tag = 0;
        self.likeBtn.accessibilityValue = @"0";
    }
}
- (void)selectToHelp{
    
}
- (void)selectExpireDate{
    self.fosaDatePicker.hidden = NO;
       [UIView animateWithDuration:0.3 animations:^{
           self.fosaDatePicker.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
           [self.fosaDatePicker show];
       }];
}
- (void)jumptoPhoto{
    takePictureViewController *photo = [[takePictureViewController alloc]init];
    photo.photoBlock = ^(UIImage *img){
        //通过block将相机拍摄的图片放置在对应的位置
        self.imageviewArray[self->currentPictureIndex].image = img;
        [self.foodImgArray addObject:img];
    };
    [self.navigationController pushViewController:photo animated:NO];
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)jumpToScan{
    QRCodeScanViewController *scan = [QRCodeScanViewController new];
    scan.scanStyle = @"block";
    scan.resultBlock = ^(NSString * _Nonnull result) {
        self.storageDevice = result;
        NSLog(@"%@",self.storageDevice);
    };
    [self.navigationController pushViewController:scan animated:NO];
}


- (void)saveInfoAndFinish{
    [self SavephotosInSanBox:self.foodImgArray];
    [self CreatDataTable];
}
#pragma mark - 键盘事件

//点击键盘以外的地方退出键盘
-(void)viewTappedToCloseKeyBoard:(UITapGestureRecognizer*)tapGr{
    [self.foodTextView resignFirstResponder];
    [self.foodDescribedTextView resignFirstResponder];
    [self.locationTextView resignFirstResponder];
}

#pragma mark -- FMDB数据库操作

- (void)OpenSqlDatabase:(NSString *)dataBaseName{
    //获取数据库地址
    docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
    NSLog(@"%@",docPath);
    //设置数据库名
    NSString *fileName = [docPath stringByAppendingPathComponent:dataBaseName];
    //创建数据库
    self.db = [FMDatabase databaseWithPath:fileName];
    if([self.db open]){
        NSLog(@"打开数据库成功");
    }else{
        NSLog(@"打开数据库失败");
    }
}
//(NSString *) food_name DeviceID:(NSString *)device Description:(NSString *)aboutFood StrogeDate:(NSString *)storageDate ExpireDate:(NSString *)expireDate  foodIcon:(NSString *)foodPhoto category:(NSString *)category like:(NSString *)islike
- (void)CreatDataTable{
    NSString *Sql = @"CREATE TABLE IF NOT EXISTS FoodStorageInfo(id integer PRIMARY KEY AUTOINCREMENT, foodName text NOT NULL, device text, aboutFood text,storageDate text NOT NULL,expireDate text NOT NULL,location text,foodImg text NOT NULL,category text,like text);";
     
    BOOL categoryResult = [self.db executeUpdate:Sql];
    if(categoryResult)
    {
        NSLog(@"创建食物存储表成功");
        [self InsertDataIntoFoodTable];
    }else{
        NSLog(@"创建食物存储表失败");
    }
}

- (void)InsertDataIntoFoodTable{
    
    NSString *insertSql = @"insert into FoodStorageInfo(foodName,device,aboutFood,storageDate,expireDate,location,foodImg,category,like) values(?,?,?,?,?,?,?,?,?)";
    if ([self.foodTextView.text isEqualToString:@""]) {
        [self SystemAlert:@"Please input the name of your food!"];
    }else if([self.expireDateLabel.text isEqualToString:@""]){
        [self SystemAlert:@"Expire Date can‘t be null"];
    }else{
        if ([self.db open]) {
            NSString *storagedate = [NSString stringWithFormat:@"%@/%@",self.storageDateLabel.text,self.storageTimeLabel.text];
            NSString *expiredate  = [NSString stringWithFormat:@"%@/%@",self.expireDateLabel.text,self.expireTimeLabel.text];
            
            BOOL insertResult = [self.db executeUpdate:insertSql, self.foodTextView.text,self.storageDevice,self.foodDescribedTextView.text,storagedate,expiredate,self.locationTextView.text,self.foodTextView.text,selectCategory,self.likeBtn.accessibilityValue];
            if (insertResult) {
                [self SystemAlert:@"Saving Data succeffully"];
            }else{
                [self SystemAlert:@"Error"];
            }
        }
    }
}
#pragma mark - 保存相片
- (void)SavephotosInSanBox:(NSMutableArray *)images{
    if (images.count > 0) {
        NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        for (int i = 0; i < images.count; i++) {
            NSString *photoName = [NSString stringWithFormat:@"%@%d.png",self.foodTextView.text,i+1];
            NSString *filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent: photoName];// 保存文件的路径
            NSLog(@"这个是照片的保存地址:%@",filePath);
            UIImage *img = images[i];//[self fixOrientation:images[i]];
            BOOL result =[UIImagePNGRepresentation(img) writeToFile:filePath  atomically:YES];// 保存成功会返回YES
            if(result == YES) {
                NSLog(@"保存成功");
            }
        }
    }
}
////删除记录
//- (void)DeleteRecord{
//
//}
//- (void)deleteFile:(NSString *)photoName {
//    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *photo = [NSString stringWithFormat:@"%@.png",photoName];
//    NSString *filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent: photo];
//    NSFileManager* fileManager=[NSFileManager defaultManager];
//    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:filePath];
//    if (!blHave) {
//        NSLog(@"no  have");
//    }else {
//        NSLog(@" have");
//        BOOL blDele= [fileManager removeItemAtPath:filePath error:nil];
//        if (blDele) {
//            NSLog(@"dele success");
//        }else {
//            NSLog(@"dele fail");
//        }
//    }
//}
//- (Boolean)CheckFoodInfoWithName:(NSString *)foodName fdevice:(NSString *)device{
//    NSString *sql = [NSString stringWithFormat:@"select * from FoodStorageInfo where foodName = '%@' and device = '%@';",foodName,device];
//    FMResultSet *result = [self.db executeQuery:sql];
//    NSLog(@"查询到数据项:%d",result.columnCount);
//    if (result.columnCount == 0) {
//        return true;
//    }else{
//        return false;
//    }
//}
//- (void)SaveShareinfo{
//    [self OpenSqlDatabase:@"FOSA"];
//
//}
//弹出系统提示
-(void)SystemAlert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:message preferredStyle:UIAlertControllerStyleAlert];
    if ([message isEqualToString:@"Please input the name of your food!"] || [message isEqualToString:@"Expire Date can‘t be null"]) {
         [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
    }else if([message isEqualToString:@"Error"]){
         [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alert animated:true completion:nil];
    }else if([message isEqualToString:@"Food record missing,added or not"]){
        [alert addAction:[UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //[self SaveShareinfo];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"NO" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //不添加
        }]];
        [self presentViewController:alert animated:true completion:nil];
    }else{
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"保存成功");
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        [self presentViewController:alert animated:true completion:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.likeBtn.hidden = YES;
}

@end

//图片的显示模式；
/*
 UIViewContentModeScaleToFill,         // 拉伸充满整个载体；
 UIViewContentModeScaleAspectFit,      //拉伸不改变比例，充满最小的一边；
 UIViewContentModeScaleAspectFill,     // 拉伸不改变比例，充满最大的一边
 UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
 UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
 UIViewContentModeTop,
 UIViewContentModeBottom,
 UIViewContentModeLeft,
 UIViewContentModeRight,
 UIViewContentModeTopLeft,
 UIViewContentModeTopRight,
 UIViewContentModeBottomLeft,
 UIViewContentModeBottomRight,
 */
