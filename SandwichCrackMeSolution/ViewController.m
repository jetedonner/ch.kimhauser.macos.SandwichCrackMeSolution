//
//  ViewController.m
//  SandwichCrackme
//
//  Created by Kim David Hauser on 24.07.21.
//

#import "ViewController.h"

@implementation ViewController

NSString *dlCrackMeLink = @"https://reverse.put.as/wp-content/uploads/2010/05/1-Sandwich.zip";
NSString *dlCrackMeLinkAlt = @"http://kimhauser.ch/images/articles/CrackMes/Sandwich/1-Sandwich.zip";
NSString *articleLink = @"http://kimhauser.ch/index.php/projects/crackme/sandwich-crackme";
NSString *githubLink = @"https://github.com/jetedonner/ch.kimhauser.macos.SandwichCrackMeSolution";

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (void)logMsg2Output: (NSString*)msg{
    _txtOutput.string = [NSString stringWithFormat:@"%@\n%@", _txtOutput.string, msg];
    [_txtOutput scrollRangeToVisible: NSMakeRange(_txtOutput.string.length, 0)];
}

- (void)validateSerial{
    NSString *serial = _txtName.stringValue;
    int eax = 0;
    NSString *ebx = serial;
    if ([ebx length] == 0x13) {
        NSArray<NSString *> *edi = [ebx componentsSeparatedByString:@"-"];
        if ((([edi count] == 0x4) && ([[edi objectAtIndex:0x0] length] == 0x4)) && ([[edi objectAtIndex:0x1] length] == 0x4)) {
            if ([[edi objectAtIndex:0x2] length] == 0x4) {
                if ([[edi objectAtIndex:0x3] length] == 0x4) {
                    int esi = [[edi objectAtIndex:0x0] intValue];
                    esi = [[edi objectAtIndex:0x1] intValue] + esi;
                    NSString *eax_2 = [edi objectAtIndex:0x3];
                    eax = [eax_2 intValue];
                    int tmp = (esi / pow(2, 2));
                    int tmp2 = (0x19c5 - tmp);
                    eax = (tmp2 == eax ? 0x1 : 0x0);
                } else {
                    eax = 0x0;
                            }
                } else {
                    eax = 0x0;
                }
            } else {
                eax = 0x0;
            }
    } else {
        eax = 0x0;
    }
    if(eax == 0x1){
        [self logMsg2Output:[NSString stringWithFormat:@"Serial \"%@\" IS VALID", serial]];
    }else{
        [self logMsg2Output:[NSString stringWithFormat:@"Serial \"%@\" IS NOT VALID", serial]];
    }
}

- (IBAction)buttonGenerateLicensePressed:(id)sender {
    NSString *serial = @"";
    
    int lowerBound = 0;
    int upperBound = 9;
    int checkSum = 0;
    for (int i = 0; i < 4; i++) {
        if(i < 3){
            NSString *serPart = @"";
            for (int j = 0; j < 4; j++) {
                int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
                serPart = [NSString stringWithFormat:@"%@%d", serPart, rndValue];
            }
            if(i == 0){
                serial = [NSString stringWithFormat:@"%@-", serPart];
            }else{
                serial = [NSString stringWithFormat:@"%@%@-", serial, serPart];
            }
            if(i < 2){
                checkSum += [serPart intValue];
            }
        }else{
            checkSum = (checkSum / pow(2, 2));
            checkSum = (0x19c5 - checkSum);
            serial = [NSString stringWithFormat:@"%@%d", serial, checkSum];
        }
    }
    _txtName.stringValue = serial;
    [self logMsg2Output:[NSString stringWithFormat:@"New generated serial is: \"%@\"", serial]];
}

- (IBAction)buttonPressed:(id)sender {
    [self validateSerial];
}

- (IBAction)buttonGitHubPressed:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:githubLink]];
}

- (IBAction)buttonDlPressed:(id)sender {
    [self logMsg2Output:[NSString stringWithFormat:@"Downloading CrackMe App: %@\r\n(Mirror: %@)", dlCrackMeLink, dlCrackMeLinkAlt]];
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:dlCrackMeLink]];
}

- (IBAction)buttonArticlePressed:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:articleLink]];
}

@end
