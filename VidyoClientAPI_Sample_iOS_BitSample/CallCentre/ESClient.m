//
//  ESClient.m
//  VidyoClientSample_iOS
//
//  Created by 赖长宽 on 2017/1/21.
//

#import "ESClient.h"
#import "AFNetworking.h"
@interface ESClient ()

@property (nonatomic ,copy) NSString * userId;
@property (nonatomic ,copy) NSString * userName;


@property (nonatomic ,copy) NSString  * urlstring;

@end

@implementation ESClient



+(BOOL)ESClientInitialize:(NSDictionary *)esuser controller:(UICollectionView*)controller
{
 
    
    
    
    
    
    
    return YES;

}

-(void)esClientLogin:( NSString * _Nonnull )userId userName:( NSString * _Nonnull )userName userPwd:( NSString* _Nullable )userPwd userDept:( NSString * _Nullable )userDept userTel:( NSString * _Nullable )userTel userEmail:( NSString * _Nullable )userEmail
{
    NSUserDefaults *useDefaults = [NSUserDefaults standardUserDefaults];

    [useDefaults setObject:userId forKey:@"userId"];
    [useDefaults setObject:userName forKey:@"userName"];

    
    NSDictionary *dic=@{@"userId":userId,@"userName":userName,@"userPwd":userPwd,@"userDept":userDept,@"userTel":userTel,@"userEmail":userEmail};
    AFHTTPSessionManager*   manger=[AFHTTPSessionManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [manger.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [ manger POST:@"http://192.168.4.143:8090/api/v1/video/vidyo/vLogin" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        
        NSLog(@"%@",[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil] encoding:NSUTF8StringEncoding]);
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

    
}

-(void)esClientCreateRoom:(NSDictionary * _Nonnull)roomDict
{
  

    NSDictionary * dataDict=@{
                          @"roomLocation":roomDict[@"roomLocation"],
                          @"roomName":roomDict[@"roomName"],
                          @"roomSubject":roomDict[@"roomSubject"]
                          };
    
     self.userId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    self.userName=[[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];

    NSDictionary *dic=@{@"userId":self.userId,@"room":dataDict,@"subMeidaType":@"video",@"callType":@1,@"queueType":@"default"};
    AFHTTPSessionManager*   manger=[AFHTTPSessionManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
//    [manger.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [ manger POST:@"http://192.168.4.143:8090/api/v1/video/vidyo/createRoom" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSUserDefaults *useDefaults = [NSUserDefaults standardUserDefaults];
        
        [useDefaults setObject:responseObject[@"room"][@"roomId"] forKey:@"roomId"];
        
        
        
        NSString * keyValue  =responseObject[@"room"][@"roomInvitedLink"];
        
        
        NSArray *pairs = [keyValue componentsSeparatedByString:@"="];
       
            NSString *value = [[pairs objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    

        NSDictionary * data=@{
           @"key":value,
           @"userName":self.userName
        };
        
        self.actionBlock(data);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}
-(void)esClientDeleteRoom:(NSString *)userId roomId:(NSInteger)roomId
{
    
    
    NSDictionary *dic=@{@"userId":userId,
                        @"roomId":@(roomId),
                        @"deletetype":@2};
    AFHTTPSessionManager*manger=[AFHTTPSessionManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    
    
    
    [manger POST:@"http://192.168.4.143:8090/api/v1/video/vidyo/deleteRoom" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",[[NSString alloc]initWithData:[NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil] encoding:NSUTF8StringEncoding]);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        
    }];
  
    
    
    
    
}
-(void)esClientLogout
{
    
    
    self.userId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];

    NSDictionary *dic=@{@"userId":self.userId};
    
    
    AFHTTPSessionManager*   manger=[AFHTTPSessionManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    //        [manger.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [ manger POST:@"http://192.168.4.143:8090/api/v1/video/vidyo/vLogout" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary * data=@{
                              @"statusCode":responseObject[@"statusCode"]
                              };
        
        self.actionBlock(data);
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}


-(void)esClientQueryRoom:(NSString *_Nullable )userId userName:( NSString *  _Nullable)userName
                 getType:(int)getType
{

    NSDictionary *dic=@{@"userId":userId,@"getType":@(getType)};
    
    
    AFHTTPSessionManager*   manger=[AFHTTPSessionManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    //        [manger.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [ manger POST:@"http://192.168.4.143:8090/api/v1/video/vidyo/queryRoom" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        
        NSDictionary * data=@{
                              };
        
        self.actionBlock(data);
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];


    

}
// 查询当前排队数
-(void)esClientQueueinfo
{

    
    NSString * roomId= [[NSUserDefaults standardUserDefaults] objectForKey:@"roomId"];

    
    NSDictionary *dic=@{@"roomId":roomId};
    
    
    AFHTTPSessionManager*   manger=[AFHTTPSessionManager manager];
    manger.requestSerializer = [AFJSONRequestSerializer serializer];
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    //        [manger.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [ manger POST:@"http://192.168.4.143:8090/api/v1/video/queueinfo" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        
        
        NSDictionary * data=@{
                              @"queuenum":responseObject[@"queueinfo"][@"queuenum"]
                              };
        
        self.actionBlock(data);
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];


}

@end
