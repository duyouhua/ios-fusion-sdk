//
//  ViewController.m
//  UpYunFusionSDKDemo
//
//  Created by 林港 on 16/2/19.
//  Copyright © 2016年 upyun. All rights reserved.
//

#import "ViewController.h"
#import "UpYun.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *pv;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}

- (IBAction)uploadAction:(id)sender {
    [_pv setProgress:0.0];
    
    __block UpYun *uy = [[UpYun alloc] init];
    uy.successBlocker = ^(NSURLResponse *response, id responseData) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"上传成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        NSLog(@"response body %@", responseData);
    };
    uy.failBlocker = ^(NSError * error) {
        NSString *message = [error.userInfo objectForKey:@"message"];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"message" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        NSLog(@"error %@", message);
    };
    uy.progressBlocker = ^(CGFloat percent, int64_t requestDidSendBytes) {
        [_pv setProgress:percent];
    };
    uy.uploadMethod = UPFormUpload;
    //    uy.uploadMethod = UPMutUPload;
    
    
    
    //    如果 sinature 由服务端生成, 只需要将policy 和 密钥 拼接之后进行MD5, 否则就不用初始化signatureBlocker
    //    uy.signatureBlocker = ^(NSString *policy)
    //    {
    //        return @"";
    //    };
    
    
    /**
     *	@brief	根据 UIImage 上传
     */
    //    UIImage * image = [UIImage imageNamed:@"test2.png"];
    //    [uy uploadFile:image saveKey:[self getSaveKeyWith:@"jpg"]];
    
    //    [uy uploadFile:image saveKey:@"2016.jpg"];
    //    [uy uploadImage:image savekey:[self getSaveKeyWith:@"png"]];
    /**
     *	@brief	根据 文件路径 上传
     */
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *filePath = [resourcePath stringByAppendingPathComponent:@"image.jpg"];
    //    filePath = [ViewController createTempFileWithSize:1024*1024*20];
    [uy uploadFile:filePath saveKey:@"/imagetest.jpg"];
    /**
     *	@brief	根据 NSDate  上传
     */
    //    NSData * fileData = [NSData dataWithContentsOfFile:filePath];
    //    [uy uploadFile:fileData saveKey:[self getSaveKeyWith:@"png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
