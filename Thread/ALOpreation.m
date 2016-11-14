//
//  ALOpreation.m
//  Thread
//
//  Created by D.xin on 2016/11/14.
//  Copyright © 2016年 D.xin. All rights reserved.
//

#import "ALOpreation.h"

@implementation ALOpreation
@synthesize delegate = _delegate;
@synthesize imageUrl = _imageUrl;

-(instancetype)initWithUrl:(NSString *)url delegate:(id<ALImageDownLoadDelegae>)delegate{

    if(self = [super init]){
        self.imageUrl = url;
        self.delegate = delegate;
    }
    return self;
}

-(void)dealloc{
    
}

//执行主任务
-(void)main{
    //新建一个自动释放池，如果是异步的操作，那就无法访问到主线程的自动释放池
    @autoreleasepool {
        if(self.isCancelled) return; //如过已取消则立即退出执行
        //获取图片的数据
        NSURL *url = [NSURL URLWithString:self.imageUrl];
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        if(self.isCancelled){
            url = nil;
            imageData = nil;
            return;
        }
        //初始化图片
        UIImage *image =[UIImage imageWithData:imageData];
        if(self.isCancelled){
            image = nil;
            return;
        }
        id    del = self.delegate;
        if(  [del respondsToSelector:@selector(downLoadFinishIWithImage:)]){
            [del performSelectorOnMainThread:@selector(downLoadFinishIWithImage:) withObject:image waitUntilDone:NO];
        }
    }
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        //异步执行，函数立即返回，但是这样任务无法取消，因此，不建议使用此办法从网络拉去数据，因为无法取消，所以很有可能这个线程始终都会被占用，资源无法释放。使用NSOperation 是最佳选择
    });
}
/*  不执行任何的操作保持应用的运行，是RunLoop
      RunLoop监听着事件源，把消息发给事件源来执行
 */

//异步执行block





@end
