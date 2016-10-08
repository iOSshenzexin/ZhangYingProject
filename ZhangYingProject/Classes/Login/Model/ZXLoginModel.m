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
    
    [coder encodeObject:self.email forKey:@"email"];
    
    [coder encodeDouble:self.phone forKey:@"phone"];
    
    [coder encodeObject:self.mid forKey:@"mid"];
    
    
    [coder encodeFloat:self.allCommision forKey:@"allCommision"];
    
    [coder encodeFloat:self.commision forKey:@"commision"];
    
    
    [coder encodeObject:self.address forKey:@"address"];

}

- (id)initWithCoder:(NSCoder*)decoder
{
    if (self = [super init])
    {
        self.headPortrait = [decoder decodeObjectForKey:@"headPortrait"];
        
        self.name = [decoder decodeObjectForKey:@"name"];
        
        self.nickname = [decoder decodeObjectForKey:@"nickname"];

        self.mid = [decoder decodeObjectForKey:@"mid"];
        
        self.email = [decoder decodeObjectForKey:@"email"];
        
        self.phone = [decoder decodeDoubleForKey:@"phone"];
        
        self.allCommision = [decoder decodeFloatForKey:@"allCommision"];
        
         self.commision = [decoder decodeFloatForKey:@"commision"];
        
        self.address = [decoder decodeObjectForKey:@"address"];

    }
    return self;
}

//- (NSString *)description
//{
//    return [NSString stringWithFormat:@"name:%@  nickname:%@  mid:%@  email:%d, head:%@ phone: %.0f allCommision:%d" , self.name, self.nickname,self.mid,self.email,self.headPortrait,self.phone ,self.allCommision];
//}


- (id)copyWithZone:(NSZone *)zone
{
    ZXLoginModel *model = [[ZXLoginModel alloc]init];
    model.headPortrait = self.headPortrait;
    model.name = self.name;
    model.nickname = self.nickname;
    model.mid = self.mid;
    model.email = self.email;
    model.phone = self.phone;
    model.allCommision = self.allCommision;
    model.commision = self.commision;
    model.address = self.address;
    return model;
}
@end
