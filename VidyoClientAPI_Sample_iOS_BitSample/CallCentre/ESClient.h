//
//  ESClient.h
//  VidyoClientSample_iOS
//
//  Created by 赖长宽 on 2017/1/21.
//
//

#import <Foundation/Foundation.h>

@interface ESClient : NSObject


@property (copy, nonatomic) void (^actionBlock) (NSDictionary * _Nonnull );


/**
 *  初始化系统
 */

//+(BOOL)ESClientInitialize:(NSDictionary *)esuser controller:(UICollectionView*)controller;



-(void)esClientLogin:( NSString * _Nonnull )userId userName:( NSString * _Nonnull )userName userPwd:( NSString* _Nullable )userPwd userDept:( NSString * _Nullable )userDept userTel:( NSString * _Nullable )userTel userEmail:( NSString * _Nullable )userEmail;



-(void)esClientCreateRoom:(NSDictionary * _Nonnull)roomDict;


-(void)esClientLogout;


// 查询房间接口
-(void)esClientQueryRoom:(NSString *_Nullable )userId userName:( NSString *  _Nullable)userName
                 getType:(int)getType;

// 队列排队数查询接口
-(void)esClientQueueinfo;




@end
