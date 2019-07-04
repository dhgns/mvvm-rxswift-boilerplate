//
//  ATPDFSigner.h
//  ATPDFSigner
//
//  Created by Abrahán Fernández on 23/11/2018.
//  Copyright © 2018 Abrahan Fernandez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import T1Autograph;

static NSString *ATPDFSIGNER_FIRST_SIGNER_NAME = @"FIRST_SIGNER_NAME";
static NSString *ATPDFSIGNER_FIRST_SIGNER_REASON = @"FIRST_SIGNER_REASON";
static NSString *ATPDFSIGNER_FIRST_SIGNER_LOCATION = @"FIRST_SIGNER_LOCATION";

static NSString *ATPDFSIGNER_FIRST_SIGNER_IMAGE = @"FIRST_SIGNER_IMAGE";
static NSString *ATPDFSIGNER_FIRST_SIGNER_XMLISO_19784_7 = @"FIRST_SIGNER_XMLISO_19784_7";

static NSString *ATPDFSIGNER_SECOND_SIGNER_NAME = @"SECOND_SIGNER_NAME";
static NSString *ATPDFSIGNER_SECOND_SIGNER_REASON = @"SECOND_SIGNER_REASON";
static NSString *ATPDFSIGNER_SECOND_SIGNER_LOCATION = @"SECOND_SIGNER_LOCATION";

static NSString *ATPDFSIGNER_SECOND_SIGNER_IMAGE = @"SECOND_SIGNER_IMAGE";
static NSString *ATPDFSIGNER_SECOND_SIGNER_XMLISO_19784_7 = @"SECOND_SIGNER_XMLISO_19784_7";

@interface ATPDFSigner : NSObject <T1AutographDelegate>

@property BOOL firstSignature;// FIXME: Fix this two attr
@property int secondSignature;
@property BOOL resetAllValues;

// First Signer data from serParams:
@property NSString *firstSignerName;
@property NSString *firstSignerReason;
@property NSString *firstSignerLocation;

// First Signer data from T1Autograph
@property NSData *firstSignerImage;
@property NSString *firstSignerXMLISO_19784_7;

// Second signer data from setParams:
@property NSString *secondSignerName;
@property NSString *secondSignerReason;
@property NSString *secondSignerLocation;

// Second Signer data from T1Autograph
@property NSData *secondSignerImage;
@property NSString *secondSignerXMLISO_19784_7;

+ (id) sharedManager;

// Get View to capture biometric signature
- (UIView *) getSignatureView: (CGRect) rect;

- (void) setParams:(NSDictionary*) params;

// Set certificate: Optional
- (void) setCertificate: (NSData *) certificate;

// Sign PDF with dictionary options
// The Biometric signature data is obtain with T1Autograph delegate
// Call this function two times:
// - 1. Capture data from first signature
// - 2. Capture data from second signature and make PDF digitally signed
- (void) signPDF:(NSData *) pdf WithClosure:(void(^)(NSData *pdfWithSignature)) callbackSignature ErrorCallback:(void(^)(NSString* errorString)) errorCallback;

@end
