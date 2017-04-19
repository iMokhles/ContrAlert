//
//  CATheme.m
//  ContrAlert
//
//  Created by iMokhles on 19/04/2017.
//  Copyright © 2017 iMokhles. All rights reserved.
//

#import "CATheme.h"

@implementation CATheme

static BOOL useinside = NO;
static id _sharedTheme = nil;

+(CATheme *)defaultTheme {
    static dispatch_once_t p = 0;
    dispatch_once(&p, ^{
        useinside = YES;
        _sharedTheme = [[CATheme alloc] init];
        useinside = NO;
    });
    return _sharedTheme;
}

+ (instancetype) alloc {
    if (!useinside) {
        @throw [NSException exceptionWithName:@"Singleton Vialotaion" reason:@"You are violating the singleton class usage. Please call +defaultTheme method" userInfo:nil];
    }
    else {
        return [super alloc];
    }
}
+ (instancetype) new {
    if (!useinside) {
        @throw [NSException exceptionWithName:@"Singleton Vialotaion" reason:@"You are violating the singleton class usage. Please call +defaultTheme method" userInfo:nil];
    }
    else {
        return [super new];
    }
}
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}
@end
