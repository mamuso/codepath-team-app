//
// Generated by CocoaPods-Keys
// on 01/11/2015
// For more information see https://github.com/orta/cocoapods-keys
//

#import <objc/runtime.h>
#import <Foundation/NSDictionary.h>
#import "CodepathKeys.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation CodepathKeys

#pragma clang diagnostic pop

+ (BOOL)resolveInstanceMethod:(SEL)name
{
  NSString *key = NSStringFromSelector(name);
  NSString * (*implementation)(CodepathKeys *, SEL) = NULL;

  if ([key isEqualToString:@"pocketSdkConsumerKey"]) {
    implementation = _podKeys115181847f2855a84d17675986db7b65;
  }

  if (!implementation) {
    return [super resolveInstanceMethod:name];
  }

  return class_addMethod([self class], name, (IMP)implementation, "@@:");
}

static NSString *_podKeys115181847f2855a84d17675986db7b65(CodepathKeys *self, SEL _cmd)
{
  
    
      char cString[31] = { CodepathKeysData[643], CodepathKeysData[580], CodepathKeysData[587], CodepathKeysData[333], CodepathKeysData[811], CodepathKeysData[250], CodepathKeysData[356], CodepathKeysData[696], CodepathKeysData[804], CodepathKeysData[189], CodepathKeysData[740], CodepathKeysData[959], CodepathKeysData[875], CodepathKeysData[866], CodepathKeysData[654], CodepathKeysData[29], CodepathKeysData[377], CodepathKeysData[102], CodepathKeysData[436], CodepathKeysData[850], CodepathKeysData[224], CodepathKeysData[509], CodepathKeysData[132], CodepathKeysData[247], CodepathKeysData[566], CodepathKeysData[14], CodepathKeysData[447], CodepathKeysData[855], CodepathKeysData[86], CodepathKeysData[995], '\0' };
    
    return [NSString stringWithCString:cString encoding:NSUTF8StringEncoding];
  
}


static char CodepathKeysData[1002] = "nRS68iBPnDwkPp8CE6RMuXJ4//Bn20ZIxI96nsuN2r8MIxwhh+uQww1+jeVNVd2o2Q4Sk6jHbiLKQfRXqnSEwCbopBE/v9eUDigybNb+IURWfZRpjK70tt5kchz8lsFd9k9b2t6HaTJdQYvK8fMQw4zSp7Ayp9YGckan9tNwpdqGcR4jsNF6uxtl0pxeY2E5w9lDQljbBiIhQvXPYWKDGpbd/z35NezU3DdXOrLWifv5VJp+4a0J7T78sC-GWzCpVEQZkPjNFomQUtTc9XLRgmQbZ6wvbOL1yjF9hUOk14Qe/fDWPZ47asNXkZoL4eXtew1fwrnaOp/cz8H/W2f0pRXaPb/FglO6ECsQ6A6Z2SXgaHcf98RlsvDb110zH0FMvHAVcIEucjfWiayhVxQ6TneANciVnbr9IomrJnIpl8PHXyjTpR7IbnH9NEv/0yA9yYyM647TrjVpBz7pIr8Pgu1MKoqTIf9tUza2M4JUnNOvC4O5030IyCI4I83dD4Zxb0ilZDxVRnG18wKjgLy2JFkfMw56c5mUNTkty+TO4N2zeJiQhvVACS65bDX0d9mwmliJ7Ye6+Cs2heQw1AvQ19+FOWsW1nW8H71D86LIdmfusEv+M4UgaUZUhCI4e5Z/xlg4KEdD9qjILTelMw1KdAlm21adHJxh09aI1jIsKehvUZjbnl8u/7xd0oornWzLFM3CXal06kavrFU+jebmlQVvUGIrcG8oASih4NnZU7iWjoAZEMB486UPJjCtWP8l8E+KYDZvbVgkSbpG+tJk1cIiDHN/pDy50EFQaEHu8bb6E1lII9sTY2oJAeHD6hPHO2h8eBApVDYvHRCbV/bXM6Y4owd3QSUJcZ2xH7tl7hNdZsx4KEgAxifM3qb+U1+RrslblLRN68TWP8pdL0OuW6KemPt8lJgpu7IA9u+ox7SA7jVz5xov9HQS081drxbbARFP63gxrZLuYwcJ/g67QG+K43eDa2pdCDT0Gl3i\\\"";

- (NSString *)description
{
  return [@{
            @"pocketSdkConsumerKey": self.pocketSdkConsumerKey,
  } description];
}

- (id)debugQuickLookObject
{
  return [self description];
}

@end
