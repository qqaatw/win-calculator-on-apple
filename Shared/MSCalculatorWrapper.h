#ifndef MSCalculatorWrapper_h
#define MSCalculatorWrapper_h

#import <Foundation/Foundation.h>

// This is a wrapper Objective-C++ class around the C++ class
@interface CalculatorManagerWrapper : NSObject


-(void)SetStandardMode;
-(void)SetScientificMode;
-(void)SetProgrammerMode;
-(NSString *)GetPrimaryDisplay;
-(NSString *)GetResultForRadix:(const uint)radix :(const int) precision :(const bool) groupDigitsPerRadix;
-(void)ExecuteCommands:(NSArray<NSNumber *>*) commands;
-(void)SendCommand:(const NSNumber*) command;
-(int)TestWithFirstValue:(int)a secondValue:(int)b;
-(void)Reset:(bool)clearMemory;

@end

#endif /* MSCalculatorWrapper_h */
