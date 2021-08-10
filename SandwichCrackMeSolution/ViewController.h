//
//  ViewController.h
//  JetesFirstCrackme
//
//  Created by Kim David Hauser on 24.07.21.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (nonatomic) IBOutlet NSTextView *txtOutput;
@property (nonatomic, weak) IBOutlet NSTextField *txtName;

- (void)validateSerial;
- (void)logMsg2Output: (NSString*)msg;

@end

