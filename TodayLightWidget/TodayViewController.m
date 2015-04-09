//
//  TodayViewController.m
//  TodayLightWidget
//
//  Created by Theo Spears on 3/30/15.
//  Copyright (c) 2015 Theo Spears. All rights reserved.
//

#import "Constants.m"
#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <CocoaAsyncSocket/GCDAsyncUdpSocket.h>

NSString* host = @"192.168.0.50";
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

- (void)sendCommandPacket:(int)command withParam:(int)param {
    unsigned char bytes[] = {command, param, 0x55};

    [self sendPacket:[NSData dataWithBytes:bytes length:3]];
}


- (void)sendCommandPacket:(int)command {
    [self sendCommandPacket:command withParam:0x00];
}

- (void)setColor:(int)color {
    [self sendCommandPacket:COMMAND_GROUP_4_ON];

    // To compensate for packet loss...
    [self sendCommandPacket:COMMAND_COLOR withParam:color];
    [self sendCommandPacket:COMMAND_COLOR withParam:color];
    [self sendCommandPacket:COMMAND_COLOR withParam:color];
}

- (IBAction)turnOnLights:(id)sender {
    [self sendCommandPacket:COMMAND_GROUP_4_ON];
    [self sendCommandPacket:COMMAND_ALL_WHITE];
}

- (IBAction)turnOffLights:(id)sender {
    [self sendCommandPacket:COMMAND_GROUP_4_OFF];
}

- (IBAction)redLights:(id)sender {
    [self setColor:0xB0];
}

- (IBAction)greenLights:(id)sender {
    [self setColor:0x60];
}

- (IBAction)blueLights:(id)sender {
    [self setColor:0x10];
}

@end
