//
//  main.m
//  CaesarCipher
//
//  Created by Michael Kavouras on 6/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

//Being amateur codebreakers, we want to know if two distinct looking ciphers correspond to the same input message. Write a method called codeBreaker, which accepts two cipher strings as paramaters and returns a boolean value which tells us whether they are actually the same input message encoded using two different offsets. hint: the maximum offset is 25

//Example:
//okmg = "mike", offset 2
//tprl = "mike", offset 7
//
//Both are the same input message, but different offset. Your method would return YES in this case

@interface CaesarCipher : NSObject


- (NSString *)encode:(NSString *)string offset:(int)offset;
- (NSString *)decode:(NSString *)string offset:(int)offset;

-(BOOL)codeBreaker: (NSString *)string with:(NSString *)otherString;

@end


@implementation CaesarCipher

- (NSString *)encode:(NSString *)string offset:(int)offset {
    if (offset > 25) {
        NSAssert(offset < 26, @"offset is out of range. 1 - 25");
    }
    NSString *str = [string lowercaseString];
    unsigned long count = [string length];
    unichar result[count];
    unichar buffer[count];
    [str getCharacters:buffer range:NSMakeRange(0, count)];
    
    char allchars[] = "abcdefghijklmnopqrstuvwxyz";

    for (int i = 0; i < count; i++) {
        if (buffer[i] == ' ' || ispunct(buffer[i])) {
            result[i] = buffer[i];
            continue;
        }
        
        char *e = strchr(allchars, buffer[i]);
        int idx= (int)(e - allchars);
        int new_idx = (idx + offset) % strlen(allchars);

        result[i] = allchars[new_idx];
    }

    return [NSString stringWithCharacters:result length:count];
}

- (NSString *)decode:(NSString *)string offset:(int)offset {
    return [self encode:string offset: (26 - offset)];
}


-(BOOL)codeBreaker: (NSString *)string with:(NSString *)otherString {
    
    for (int i = 1; i < 26; i++) {
        
        NSString *decodedString = [self decode: string offset: i];
        //NSLog(@"string:%@, offset:%d", decodedString, i);
        
        for (int j = 1; j < 26; j++) {
            
            NSString *decodedOtherString = [self decode: otherString offset: j];
            //NSLog(@"string:%@, offset:%d", decodedOtherString, j);
            
            if ([decodedString isEqualToString: decodedOtherString]){
                NSLog(@"Same input.");
                return 1;
            }
        }
    }
    NSLog(@"Input does not match.");
    return 0;
}

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        CaesarCipher *cipher = [[CaesarCipher alloc] init];
        
        
        //encoding examples
        
        NSString *example1 = [cipher encode:@"mike" offset: 2];
        NSLog(@"%@", example1);
        
        NSString *example2 = [cipher encode:@"mike" offset: 7];
        NSLog(@"%@", example2);
        
        NSString *example3 = [cipher encode:@"seat" offset: 7];
        NSLog(@"%@", example3);
        
        //decoding examples
        
        NSString *decodedExample1 = [cipher decode:@"okmg" offset: 2];
        NSLog(@"%@", decodedExample1);
        
        NSString *decodedExample2 = [cipher decode: @"tprl" offset:7];
        NSLog(@"%@",decodedExample2);
        
        NSString *decodedExample3 = [cipher decode:@"zlha" offset: 7];
        NSLog(@"%@", decodedExample3);
        
        
        [cipher codeBreaker:@"okmg" with:@"tprl"];
        
        [cipher codeBreaker:@"tprl" with:@"zlha"];
        
        
        
    }
    
}
