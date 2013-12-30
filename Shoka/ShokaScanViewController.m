//
//  ShokaScanViewController.m
//  Shoka
//
//  Created by AquarHEAD L. on 12/17/13.
//  Copyright (c) 2013 Team.TeaWhen. All rights reserved.
//

#import "ShokaScanViewController.h"
#import "ShokaResult.h"
#import "ShokaWebpacAPI.h"
#import "ShokaDoubanAPI.h"
#import "ShokaBookDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <SVProgressHUD.h>
#import <DLAVAlertView.h>

@interface ShokaScanViewController () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic) BOOL cn_done, en_done;
@property (nonatomic) ShokaResult *result;

@end

@implementation ShokaScanViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.captureSession = [[AVCaptureSession alloc] init];
    AVCaptureDevice *videoCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    AVCaptureDeviceInput *videoInput = [AVCaptureDeviceInput deviceInputWithDevice:videoCaptureDevice error:&error];
    if(videoInput)
        [self.captureSession addInput:videoInput];
    else
        NSLog(@"Error: %@", error);

    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [self.captureSession addOutput:metadataOutput];
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [metadataOutput setMetadataObjectTypes:@[AVMetadataObjectTypeEAN13Code]];

    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    previewLayer.frame = self.view.layer.bounds;
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.view.layer addSublayer:previewLayer];

    [self.captureSession startRunning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.cn_done = NO;
    self.en_done = NO;
    self.result = nil;
    [self.captureSession startRunning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput
didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    for (AVMetadataObject *metadata in metadataObjects) {
        AVMetadataMachineReadableCodeObject *readableObject = (AVMetadataMachineReadableCodeObject *)metadata;
        if ([metadata.type isEqualToString:AVMetadataObjectTypeEAN13Code]) {
            NSString *isbn = readableObject.stringValue;
            [self.captureSession stopRunning];
            [SVProgressHUD showWithStatus:@"载入中…" maskType:SVProgressHUDMaskTypeClear];
            [ShokaWebpacAPI searchChineseDepositoryWithISBN:isbn success:^(ShokaResult *result) {
                self.cn_done = YES;
                if (result.count > 0) {
                    self.result = result;
                }
                [self dealWithResult];
            } failure:^(NSError *error) {
                NSLog(@"%@", error);
            }];

            [ShokaWebpacAPI searchForeignDepositoryWithISBN:isbn success:^(ShokaResult *result) {
                self.en_done = YES;
                if (result.count > 0) {
                    self.result = result;
                }
                [self dealWithResult];
            } failure:^(NSError *error) {
                NSLog(@"%@", error);
            }];
        }
    }
}

- (void)dealWithResult
{
    if (!(self.cn_done && self.en_done)) {
        return;
    }
    if (self.result == nil || self.result.count == 0) {
        [SVProgressHUD dismiss];
        DLAVAlertView *alertView = [[DLAVAlertView alloc] initWithTitle:@"图书馆里没有找到这本书" message:nil delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alertView showWithCompletion:^(DLAVAlertView *alertView, NSInteger buttonIndex) {
            self.cn_done = NO;
            self.en_done = NO;
            [self.captureSession startRunning];
        }];
        return;
    }
    [self performSegueWithIdentifier:@"scanToDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"scanToDetail"]) {
        [segue.destinationViewController setBook:[self.result objectAtIndex:0]];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    [SVProgressHUD dismiss];
}

@end
