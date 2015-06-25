//
//  main.m
//  Person
//
//  Created by Michael Kavouras on 6/21/15.
//  Copyright (c) 2015 Mike Kavouras. All rights reserved.
//

#import <Foundation/Foundation.h>

//Write a method called checkSameCity which accepts one parameter of type Person * and checks if they live in the same city. The method should return a boolean value.
//A Person has recently had a child, whose name is 'Abc'. Write a method called registerChild which takes 0 parameters and returns a new Person * instance represeting the child, which has the same phoneNumber and city as the parent.


@interface Person: NSObject

- (void)setName:(NSString *)name;
- (NSString *)name;

- (void)setCity:(NSString *)city;
- (NSString *)city;

- (void)setPhoneNumber:(NSString *)phoneNumber;
- (NSString *)phoneNumber;

- (BOOL)checkSameCity:(NSString *)city;

- (Person *) haveChild;

@end

@implementation Person {
    NSString *_name;
    NSString *_phoneNumber;
    NSString *_city;
}

- (void)setName:(NSString *)name {
    _name = name;
}

- (NSString *)name {
    return _name;
}

- (void)setCity:(NSString *)city {
    _city = city;
}

- (NSString *)city {
    return _city;
}

- (void)setPhoneNumber:(NSString *)phoneNumber {
    _phoneNumber = phoneNumber;
}

- (NSString *)phoneNumber {
    return _phoneNumber;
}

- (BOOL)checkSameCity:(NSString *)city {
    if ([_city isEqualToString:city]){
        NSLog(@"Yes");
        return YES;
    }else {
        NSLog(@"No");
        return NO;
    }
}

- (Person *) haveChild {
    Person *child = [[Person alloc] init];
    [child setCity:[self city]];
    [child setPhoneNumber:[self phoneNumber]];
    return child;
}


@end
//XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Person *julia = [[Person alloc]init];
        
        [julia setName:@"Julia"];
        [julia setCity:@"Cheyenne"];
        [julia setPhoneNumber:@"617-890-4563"];
        
        NSLog(@"%@ lives in %@. Her phone number is %@.", [julia name], [julia city], [julia phoneNumber]);
        
        Person *igor = [[Person alloc]init];
        
        [igor setName:@"Igor"];
        [igor setCity:@"Brooklyn"];
        [igor setPhoneNumber:@"347-517-2345"];
        
        NSLog(@"%@ lives in %@. His phone number is %@.", [igor name], [igor city], [igor phoneNumber]);
        
        NSLog(@"Do %@ and %@ live in the same city?", [julia name], [igor name]);
        [julia checkSameCity:[igor city]];
        
        Person *juliasChild = [julia haveChild];
        [juliasChild setName: @"ABC"];
        
        NSLog(@"%@ just had a child and named it %@. Can you believe that??", [julia name], [juliasChild name]);
        
        
    }
    return 0;
}
