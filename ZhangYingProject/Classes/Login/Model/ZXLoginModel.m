//
//  ZXLoginModel.m
//  ZhangYingProject
//
//  Created by 青岛商通天下 on 16/9/20.
//  Copyright © 2016年 QingDaoShangTong. All rights reserved.
//

#import "ZXLoginModel.h"


@interface ZXLoginModel()<NSCoding>

@end

@implementation ZXLoginModel


- (void)encodeWithCoder:(NSCoder*)coder
{
    [coder encodeObject:self.headPortrait forKey:@"headPortrait"];
    
    [coder encodeObject:self.name forKey:@"name"];
    
    [coder encodeObject:self.nickname forKey:@"nickname"];
    
    [coder encodeInt:self.email forKey:@"email"];
    
    [coder encodeDouble:self.phone forKey:@"phone"];
    
    [coder encodeObject:self.mid forKey:@"mid"];
    
    
    [coder encodeInt:self.allCommision forKey:@"allCommision"];

}

- (id)initWithCoder:(NSCoder*)decoder
{
    if (self = [super init])
    {
        self.headPortrait = [decoder decodeObjectForKey:@"headPortrait"];
        
        self.name = [decoder decodeObjectForKey:@"name"];
        
        self.nickname = [decoder decodeObjectForKey:@"nickname"];

        self.mid = [decoder decodeObjectForKey:@"mid"];
        
        self.email = [decoder decodeIntForKey:@"email"];
        
        self.phone = [decoder decodeDoubleForKey:@"phone"];
        
        self.allCommision = [decoder decodeIntForKey:@"allCommision"];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@  nickname:%@  mid:%@  email:%d, head:%@ phone: %.0f allCommision:%d" , self.name, self.nickname,self.mid,self.email,self.headPortrait,self.phone ,self.allCommision];
}
@end