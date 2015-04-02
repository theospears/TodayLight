//
//  TodayViewController.m
//  TodayLightWidget
//
//  Created by Theo Spears on 3/30/15.
//  Copyright (c) 2015 Theo Spears. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <CocoaAsyncSocket/GCDAsyncUdpSocket.h>

NSString* host = @"192.168.0.51";
int port = 8899;

@interface TodayViewController () <NCWidgetProviding>

@end

@implementation TodayViewController  {
    GCDAsyncUdpSocket *socket;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    socket = [[GCDAsyncUdpSocket alloc] initWithSocketQueue:dispatch_get_main_queue()];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsZero;
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (void)sendPacket:(NSData*)data {
    [socket sendData:data
              toHost:host
                port:port
         withTimeout:0
                 tag:0];

}

- (IBAction)turnOnLights:(id)sender {
    [self sendPacket:[NSData dataWithBytes:"\x4B\x00\x55" length:3]];
    [self sendPacket:[NSData dataWithBytes:"\xC2\x00\x55" length:3]];
}

- (IBAction)turnOffLights:(id)sender {
    [self sendPacket:[NSData dataWithBytes:"\x4C\x00\x55" length:3]];
}

- (IBAction)redLights:(id)sender {
    [self sendPacket:[NSData dataWithBytes:"\x4B\x00\x55" length:3]];
    [self sendPacket:[NSData dataWithBytes:"\x40\xB0\x55" length:3]];
    [self sendPacket:[NSData dataWithBytes:"\x40\xB0\x55" length:3]];
    [self sendPacket:[NSData dataWithBytes:"\x40\xB0\x55" length:3]];
}

- (IBAction)greenLights:(id)sender {
    [self sendPacket:[NSData dataWithBytes:"\x4B\x00\x55" length:3]];
    [self sendPacket:[NSData dataWithBytes:"\x40\x60\x55" length:3]];
    [self sendPacket:[NSData dataWithBytes:"\x40\x60\x55" length:3]];
    [self sendPacket:[NSData dataWithBytes:"\x40\x60\x55" length:3]];
}

- (IBAction)blueLights:(id)sender {
    [self sendPacket:[NSData dataWithBytes:"\x4B\x00\x55" length:3]];
    [self sendPacket:[NSData dataWithBytes:"\x40\x10\x55" length:3]];
    [self sendPacket:[NSData dataWithBytes:"\x40\x10\x55" length:3]];
    [self sendPacket:[NSData dataWithBytes:"\x40\x10\x55" length:3]];
}

@end
