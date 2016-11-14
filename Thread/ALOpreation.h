//
//  ALOpreation.h
//  Thread
//
//  Created by D.xin on 2016/11/14.
//  Copyright © 2016年 D.xin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
/*
 定义用来下载图片
 
 */
@protocol ALImageDownLoadDelegae

//图片下载的协议
-(void)downLoadFinishIWithImage:(UIImage *)image;
@end
@interface ALOpreation : NSOperation
//图片的URl 路径
@property(nonatomic,copy)NSString * imageUrl;

//代理
@property(nonatomic,retain)id<ALImageDownLoadDelegae>delegate;

-(instancetype)initWithUrl:(NSString *)url delegate:(id<ALImageDownLoadDelegae>)delegate;



@end
