//
//  MSSCommunicationController.h
//  pieMenu
//
//  Created by Tommaso Piazza on 2/23/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncUdpSocket.h"
#import "CodeineStructs.h"


@protocol MSSCommunicationProtocol <NSObject>

@required

-(void) newContacs:(NSDictionary *) contacDictionary;

@end


@interface MSSCommunicationController : NSObject <GCDAsyncUdpSocketDelegate>
{
    
    GCDAsyncUdpSocket *udpSocket;
    NSMutableDictionary *_contacDescriptorsDictionaty;
    __weak id <MSSCommunicationProtocol> _delegate;
    
}

@property (strong, atomic) NSMutableDictionary* contactDictionary;
@property (weak, nonatomic) id <MSSCommunicationProtocol> delegate;

+ (id)sharedController;
- (MSSCommunicationController *) init;
-(void) hasData:(PackedContactDescriptors *) pcd;
-(void) connectToHost:(NSString *)host onPort:(uint16_t) port;
-(void) sendData:(NSData *) data;
-(void) handshake;

@end
