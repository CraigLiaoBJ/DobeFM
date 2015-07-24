//
//  AvPlayViewController.m
//  Xmly
//
//  Created by lanou3g on 15/6/29.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "LoadDownBase.h"
#import "DrawerView.h"
#import "UIImageView+WebCache.h"
#import "AvPlayViewController.h"
#define WINWIDTH self.view.bounds.size.width
#define WINHEIGHT self.view.bounds.size.height
@interface AvPlayViewController ()<DrawerViewDelegate>

@property (nonatomic,strong) AVPlayer *mp3Player;

@property (nonatomic,strong) UISlider *volumeSlider;         //控制

@property (nonatomic,strong) NSTimer *timer;//监控音频播放进度

@property (nonatomic,strong) UIView *playView;//播放层

@property (nonatomic,strong) UIButton *lastButton;//播放按钮

@property (nonatomic,strong) UIButton *nextButton;//暂停按钮

@property (nonatomic,strong) NSMutableArray *idArray;//播放数组

@end

@implementation AvPlayViewController
//static float lastTime = 0;//上次时间
//static float waitTime = 0;//没有播放时 等待播放的时间
static UILabel *curTime;
static UILabel *durTime;
static UIImageView *imageView;
static UIButton *downLoad;//下载
static UIButton *listerListBtn;//播放历史列表
static DrawerView *drawerView;
static NSThread *aThread;
static NSTimer *drawerTimer;
static bool isDrawerOut = NO;//是否显示抽屉效果
static LoadDownBase *loadDownBase;//下载类
static UIImageView *backImageView;
- (void) initWithAvplayer:(NSInteger)playCurrent  albumList:(NSMutableArray*)albumList sAlbum:(SearchAlbum *)sAlbum{
    if (_sAlbum != sAlbum ){
        _sAlbum = sAlbum;
    }
    if (_albumList != albumList ){
        _albumList = albumList;
        [_idArray removeAllObjects];
        for (int i = 0; i < _albumList.count; i++) {
            [_idArray addObject:[_albumList[i] playPathAacv164]];
        }
    }
    
    if(_playCurrent != playCurrent) {
        _playCurrent = playCurrent;
    }
    
    [self cutMusic];
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
    
    backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:backImageView];
    //模糊效果
    UIVisualEffectView *backgroundView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    backgroundView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:backgroundView];
    
    
    loadDownBase = [[LoadDownBase alloc]init];
    
    //----------------初始化
    self.isPlay = YES;
        self.idArray =[[NSMutableArray alloc]init];//初始化音乐集合
        for (int i = 0; i<self.albumList.count; i++) {
            [self.idArray addObject:[self.albumList[i] playPathAacv164]];
        }
    
    self.title = [self.albumList[self.playCurrent] title1];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.playView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-48)];
    self.playView.backgroundColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:0.3];
    [self.view addSubview:self.playView];
    
    
    UIView *buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height*0.7, self.view.bounds.size.width, self.view.bounds.size.height*0.3)];
    buttonView.backgroundColor = [UIColor whiteColor];
    buttonView.alpha  =  0.5;
    [self.playView addSubview:buttonView];

    

    //中间添加图片
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 190, 190)];
    imageView.center = self.playView.center;
    [self.playView addSubview:imageView];
    [NSThread detachNewThreadSelector:@selector(loadImage) toTarget:self withObject:nil];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(self.playView.bounds.size.width*0.50-20, self.playView.bounds.size.height*0.8, 40, 40)];
    [button setBackgroundImage:[UIImage imageNamed:@"iconfont-bofang.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"iconfont-bofangqizanting"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(plays:) forControlEvents:UIControlEventTouchUpInside];
    [self.playView addSubview:button];

    
    self.lastButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.lastButton setFrame:CGRectMake(self.playView.bounds.size.width*0.35-10, self.playView.bounds.size.height*0.8+10, 20, 20)];
    [self.lastButton setBackgroundImage:[UIImage imageNamed:@"iconfont-bofangqishangyiqu.png"] forState:UIControlStateNormal];
    [self.lastButton addTarget:self action:@selector(lastButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.playView addSubview:self.lastButton];

    self.nextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.nextButton setFrame:CGRectMake(self.playView.bounds.size.width*0.65-10, self.playView.bounds.size.height*0.8+10, 20, 20)];
    [self.nextButton setBackgroundImage:[UIImage imageNamed:@"iconfont-bofangqixiayiqu.png"] forState:UIControlStateNormal];
    [self.nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.playView addSubview:self.nextButton];
    
    
    //下载;
    downLoad = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [downLoad setFrame:CGRectMake(self.playView.bounds.size.width*0.1-10, self.playView.bounds.size.height*0.8+10, 20, 20)];
    [downLoad setBackgroundImage:[UIImage imageNamed:@"iconfont-gujianxiazai.png"] forState:UIControlStateNormal];
    [downLoad addTarget:self action:@selector(loadingMusic) forControlEvents:UIControlEventTouchUpInside];
    [self.playView addSubview:downLoad];
    
    //播放历史列表
    listerListBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [listerListBtn setFrame:CGRectMake(self.playView.bounds.size.width*0.9-10, self.playView.bounds.size.height*0.8+10, 20, 20)];
    [listerListBtn setBackgroundImage:[UIImage imageNamed:@"iconfont-list.png"] forState:UIControlStateNormal];
    [listerListBtn addTarget:self action:@selector(listerHistoryList) forControlEvents:UIControlEventTouchUpInside];
    
    [self.playView addSubview:listerListBtn];
    
    
    curTime = [[UILabel alloc]initWithFrame:CGRectMake(20, self.playView.bounds.size.height-30, 40, 20)];
    durTime = [[UILabel alloc]initWithFrame:CGRectMake(self.playView.bounds.size.width-50, self.playView.bounds.size.height-30, 40, 20)];
    curTime.font = [UIFont boldSystemFontOfSize:12];
    durTime.font = [UIFont boldSystemFontOfSize:12];
    [self.playView addSubview: curTime];
    [self.playView addSubview: durTime];
    
    
    //slider控制
    self.volumeSlider = [[UISlider alloc] initWithFrame:CGRectMake(60, self.playView.bounds.size.height-30, self.playView.bounds.size.width-120, 20)];
    [self.volumeSlider addTarget:self action:@selector(volumeChange)
                forControlEvents:UIControlEventValueChanged];
    //设置播放进度
    self.volumeSlider.minimumValue = 0.0f;
    //设置最大进度
    self.volumeSlider.maximumValue = 1.0f;
    //初始化进度多少
    self.volumeSlider.value = 0.0f;
    self.volumeSlider.maximumTrackTintColor = [UIColor whiteColor];
    [self.playView addSubview:self.volumeSlider];
    
    
    //播放历史
    drawerView = [[DrawerView alloc]initWithFrame:CGRectMake(-self.playView.frame.size.width*0.75 , 64, self.playView.frame.size.width*(3.0/4.0), self.playView.frame.size.height - 64)];
    drawerView.alpha = 0.8;
    
    drawerView.delegate = self;
    drawerView.hidden = YES;
    [self.playView addSubview:drawerView];
    //---------------------------------------

    
    //---------初始化设置播放状态----
    
    
    //初始化播放音乐
        self.mp3Player = [[AVPlayer alloc]init];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:self
                                                    selector:@selector(playProgress)
                                                    userInfo:nil repeats:YES];
        [self cutMusic];
    
}


-(void )loadImage{
    //中间添加图片
    NSURL *picurl ;
    if([self.albumList[self.playCurrent] albumImage] != nil &&  ![[self.albumList[self.playCurrent] albumImage]isEqualToString:@""]){
      picurl = [NSURL URLWithString:[self.albumList[self.playCurrent] albumImage]];
        NSData *picData  = [NSData dataWithContentsOfURL:picurl];
        [imageView setImage:[UIImage imageWithData:picData]];
        [backImageView setImage:[UIImage imageWithData:picData]];
    }
    else{
     // picurl = [NSURL URLWithString:@"losePic.jpg"];
        [imageView setImage:[UIImage imageNamed:@"losePic.jpg"]];
        [backImageView setImage:[UIImage imageNamed:@"losePic.jpg"]];

    }

    imageView.layer.cornerRadius = imageView.bounds.size.width/2;
    //设置masksToBounds才能设置圆角
    imageView.layer.masksToBounds = YES;
    
}

//kvo 检测
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"status"])
    {


        if (0 == self. mp3Player.currentItem.status)
        {
            [self. mp3Player play];
            //用NSTimer来监控音频播放进度
            if (self.isPlay) {
                [self.mp3Player play];
            }
            else
            {
                [self.mp3Player pause];
            }
        } else if ([self. mp3Player status] == AVPlayerStatusFailed) {
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"网络不给力啊!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
    }
}

//数值转化成时间格式
- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}

//切换音乐 -1 上一曲 1 下一曲
-(void)cutMusic{
    [self lastNextIsEnble];

    //检测本地
    if(![self playLocationAudio:[self.albumList[self.playCurrent] trackId]]){
        NSURL * songUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@", self.idArray[self.playCurrent]]];
        AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:songUrl];
        [self.mp3Player replaceCurrentItemWithPlayerItem:playerItem];
        
        
        
    }
    else{
        if (self.idArray.count != 0 || (self.idArray[self.playCurrent]!=nil && ![self.idArray[self.playCurrent] isEqualToString: @""])) {
        }
        else
        {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"网络不给力啊!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }
    self.title = [self.albumList[self.playCurrent] title1];
    //重置图片
    [self loadImage];

    [self.mp3Player addObserver:self forKeyPath:@"status" options:0 context:NULL];
    //记录播放历史
    [self. mp3Player setAllowsExternalPlayback:YES];
    [self setListerHistoryList];


}

- (void)plays:(UIButton *)sender
{
    
    sender.selected = !sender.selected ;
    self.isPlay = !self.isPlay;
    self.isPlay ? [self.mp3Player play ] : [self.mp3Player pause] ;

}

//    播放进度条
- (void)playProgress
{
    if(self. mp3Player.currentItem.status==1){
    //通过音频播放时长的百分比,
    CGFloat duration = [[self.albumList[self.playCurrent] durationTime] floatValue];

    CGFloat currentTimeToSecond = self.mp3Player.currentTime.value / self.mp3Player.currentTime.timescale;// 转换成秒
    //self.progressV.progress = currentTimeToSecond/totalSecond;
        curTime.text = [self convertTime:currentTimeToSecond];
        durTime.text = [self convertTime:duration];
        //设置进度条
        self.volumeSlider.value = currentTimeToSecond/(int)duration;
        ///NSLog(@"%f",self.volumeSlider.value);
        if (self.volumeSlider.value >= 1.0f)
        {
            [self nextButtonClick];
        }
    }
    //设置旋转
    imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI/(8*10));
}


//播放进度控制
- (void)volumeChange
{
    if(self.volumeSlider.value>0.999f)
    {
        self.volumeSlider.value = 0.999f;
    }
    CGFloat duration = [[self.albumList[self.playCurrent] durationTime] floatValue];
    
    CMTime newTime = CMTimeMake(duration*self.volumeSlider.value, 1) ;
    [self.mp3Player seekToTime:newTime completionHandler:^(BOOL finished) {

    }];
}


//播放完成时调用的方法  (代理里的方法),需要设置代理才可以调用
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.timer invalidate]; //NSTimer暂停   invalidate  使...无效;
}


//点击上一个音乐按钮
-(void)lastButtonClick{
    
    self.playCurrent --;
    [self cutMusic];
}

//点击下一个音乐按钮
-(void)nextButtonClick{
    self.playCurrent ++;
    [self cutMusic];
}

//上级 下级是否可用
-(void)lastNextIsEnble{
    [self.lastButton setEnabled:false];
    self.lastButton.alpha = 0.4;
    [self.nextButton setEnabled:false];
    self.nextButton.alpha = 0.4;
        if (self.idArray.count > 1 && self.playCurrent-1>=0) {
            [self.lastButton setEnabled:true];
            self.lastButton.alpha = 1;
        }
    if ( self.playCurrent < self.idArray.count-1) {
        [self.nextButton setEnabled:true];
        self.nextButton.alpha = 1;
    }

}
-(void)playMusic{
[self cutMusic];

}


-(void)replayMusic{
    [self playMusic];
    
}
//多线程下载
-(void)loadingMusic{
    [aThread start];
    downLoad.enabled = NO;
    downLoad.alpha = 0.4;
    [NSThread detachNewThreadSelector:@selector(threadLoad) toTarget:self withObject:nil];
    
}
//下载音乐
-(void)threadLoad{
    [loadDownBase loadAudioToLocation:self.idArray[self.playCurrent] styp:@".mp3" albumName:(AlbumList *)self.albumList[self.playCurrent]];
    
    [loadDownBase setLoadData:[self.albumList[self.playCurrent] trackId] plsitName:@"LoadDownList" albumName:(AlbumList *)self.albumList[self.playCurrent]];
    
    downLoad.enabled = YES;
    downLoad.alpha = 1;
}



//保存播放历史
-(void)setListerHistoryList{
    [loadDownBase loadAudioToLocation:[self.albumList[self.playCurrent] albumImage] styp:@".jpg" albumName:(AlbumList *)self.albumList[self.playCurrent]];
    NSLog(@"%@",[self.albumList[self.playCurrent] coverLarge]);
    [loadDownBase setLoadData:[self.albumList[self.playCurrent] trackId] plsitName:@"ListerHistory" albumName:(AlbumList *)self.albumList[self.playCurrent]];

}



//显示播放历史tableView
-(void)listerHistoryList{
    NSMutableDictionary *history = [loadDownBase getListerHistoryList];
    [drawerView setDic: history];
    listerListBtn.enabled = NO;
    [self drawerOutInTimeer];

}
//抽屉进出
-(void)drawerOutInTimeer{
    if (!isDrawerOut) {//YES 打开抽屉
        [self moveTo:drawerView frame:CGRectMake(0, 64, self.playView.frame.size.width*(3.0/4.0), self.playView.frame.size.height - 64)];
        drawerView.frame = CGRectMake(0, 64, self.playView.frame.size.width*(3.0/4.0), self.playView.frame.size.height - 64);
    }
    else//no 关闭抽屉
    {
        [self moveTo:drawerView frame:CGRectMake( - self.playView.frame.size.width*(3.0/4.0), 64, self.playView.frame.size.width*(3.0/4.0), self.playView.frame.size.height - 64)];

    }
}


- (void)moveTo:(DrawerView*)dView frame:(CGRect)frame{
   
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];//动画时长
    [UIView setAnimationDelay:0];//动画前延迟
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//曲线速度
    [UIView setAnimationRepeatCount:1];//设置动画次数
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(moveToStart)];//动画开始方法
    [UIView setAnimationDidStopSelector:@selector(moveToStop)];//动画结束方法
    //[UIView setAnimationRepeatAutoreverses:YES];
    //[UIView setAnimationBeginsFromCurrentState:YES];//设置从当前状态继续执行
    dView.frame = frame;
    [UIView commitAnimations];//提交动画
    isDrawerOut = !isDrawerOut;
    
    
    
//    [UIView animateWithDuration:0.5f animations:^{
//        [self moveToStart ];
//        dView.frame = frame ;
//        isDrawerOut = !isDrawerOut;
//        [self moveToStop ];
//    }];


}

-(void)moveToStart{
    isDrawerOut ? drawerView.hidden = NO : 0;
}

-(void)moveToStop{
    !isDrawerOut ?  drawerView.hidden = YES : 0;
    listerListBtn.enabled = YES;
}

//历史替换
-(void)DrawerTableView:(NSArray *)horitoryAudio{
    NSLog(@"%@",horitoryAudio);
    self.title = [NSString stringWithFormat:@"%@",horitoryAudio[3]];
    NSString *urlStr = [NSString stringWithFormat:@"%@",horitoryAudio[4]];
    NSURL * songUrl = [NSURL URLWithString:urlStr];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc]initWithURL:songUrl];
    [self.mp3Player replaceCurrentItemWithPlayerItem:playerItem];
    [self setLoactionImg:horitoryAudio[5]];

}

-(void)setLoactionImg:(NSString*)imgId{
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [caches stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",imgId]];
    NSString * songUrl = [NSString stringWithFormat:@"%@%@",filePath,@".jpg"];
    [imageView setImage:[UIImage imageWithContentsOfFile:songUrl]];
    [backImageView setImage:[UIImage imageWithContentsOfFile:songUrl]];
}

-(bool)playLocationAudio:(NSString*) audioId{
    if ([self isAudioExist:[NSString stringWithFormat:@"%@.%@",audioId,@"aac"]]) {
        return YES;
    }
    else if ([self isAudioExist:[NSString stringWithFormat:@"%@.%@",audioId,@"mp3"]]) {
        return YES;
    }
    else if  ([self isAudioExist:[NSString stringWithFormat:@"%@.%@",audioId,@"m4a"]]) {
        return YES;
    }
    return false;

}

//本地是否有这数据
-(bool)isAudioExist:(NSString*)audioName{
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [caches stringByAppendingPathComponent:audioName];
    NSURL * songUrl = [NSURL URLWithString:filePath];
    NSData *data = [[NSData alloc]initWithContentsOfURL:songUrl];
    if(data == nil) return NO;
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:songUrl];
    [self.mp3Player replaceCurrentItemWithPlayerItem:playerItem];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
