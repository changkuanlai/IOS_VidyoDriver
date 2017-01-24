//
//  QueueStatusViewController.m
//  VidyoMobile
//
//  Created by 赖长宽 on 2017/1/4.
//  Copyright © 2017年 changkuan.lai.com. All rights reserved.
//

#import "QueueStatusViewController.h"

@interface QueueStatusViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgeView;
@property (weak, nonatomic) IBOutlet UILabel *loginName;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (nonatomic ,strong)  NSNumber  *retCode;

@end

@implementation QueueStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupQueue];
    // Do any additional setup after loading the view from its nib.
}
-(void)setupQueue
{
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//       [dict setObject:@"queueNumber.action" forKey:@"operation"];
//    
//       [dict setObject:@"test5" forKey:@"userid"];
//    
//   AFHTTPSessionManager *manger= [AFHTTPSessionManager manager];
//    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
//    
//    [ manger POST:@"http://192.168.5.49:8580/Every360/Every360Api" parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//     } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//         
//         
//         
//         
//     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//         NSLog(@"%@",error);
//     }];
//    
    
    dispatch_queue_t queue =  dispatch_queue_create("yx", NULL);
    
    dispatch_async(queue, ^{
        
        NSURLSession *session = [NSURLSession sharedSession];
        
        //2.根据会话对象创建task
        NSURL *url = [NSURL URLWithString:@"http://192.168.5.49:8580/Every360/Every360Api"];
        
        //3.创建可变的请求对象
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        //4.修改请求方法为POST
        request.HTTPMethod = @"POST";
        
        //5.设置请求体
        request.HTTPBody = [@"operation=queueNumber.action&userid=test5" dataUsingEncoding:NSUTF8StringEncoding];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            //8.解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            self.stateLabel.text=[NSString stringWithFormat:@"状态:正在获取排队数..."];
            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
            
            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
                
                self.stateLabel.text=[NSString stringWithFormat:@"状态:还有%@人排队中...",dict[@"RetCode"]];
                
            });
            

            
        }];
        
        //7.执行任务
        [dataTask resume];
        
        
    });

}
- (IBAction)giveUpTheCall:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
