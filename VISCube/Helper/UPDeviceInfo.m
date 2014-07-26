//
//  UPDeviceInfo.m
//  UPCommon
//
//  Created by Li Wang on 14-7-11.
//  Copyright 2014年 UnionPay All rights reserved.
//

#import "UPDeviceInfo.h"
#import "UPMacros.h"
#import <CommonCrypto/CommonDigest.h>
#include <sys/sysctl.h>
#include <netinet/in.h>
#include <net/if.h>
#include <net/if_dl.h>


static CGSize       g_screenSize = {0,0};
static BOOL         g_isIphone5Simulator =NO;

@implementation UPDeviceInfo

/* Return a string description of the UUID, such as "E621E1F8-C36C-495A-93FC-0C247A3E6E5F" */
+ (NSString*)vendorIdentifier
{
    
    if (UP_IOS_VERSION >= 6.0) {
        return [self readVendorID];
    }
    else{
        return [self getMD5MAC];
    }
}
// 读取 VendorID，并存储钥匙串
+ (NSString *)readVendorID {
    /*
    NSString *group = [NSString stringWithFormat:@"%@.%@",[self bundleSeedID],kKeyKeychainVendorIDGroup];
    // 存储account
    KeychainItemWrapper *accountWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:kKeyKeychainVendorIDIdentifier accessGroup:group];
    NSString *account = [accountWrapper objectForKey:(id)kSecAttrAccount];
    if (!account || [account isEqualToString:@""]) {
        [accountWrapper setObject:kKeyKeychainVendorIDIdentifier forKey:(id)kSecAttrAccount];
    }
    NSString *uuid = [accountWrapper objectForKey:(id)kSecValueData];
    if (!uuid || [uuid isEqualToString:@""]) {
        uuid = UIDevice.currentDevice.identifierForVendor.UUIDString;
        
        // save to keychain
        [accountWrapper setObject:uuid forKey:(id)kSecValueData];
    }else {
        
    }
    [accountWrapper release];
    return uuid;
     */
    
    return nil;
}

+ (void)keychain:(NSString *)identifier SetObject:(id)inObject forKey:(id)key{
    /*
    NSString *group = [NSString stringWithFormat:@"%@.%@",[self bundleSeedID],kKeyKeychainVendorIDGroup];
    KeychainItemWrapper *accountWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:identifier accessGroup:group];
    // save to keychain
    [accountWrapper setObject:inObject forKey:(id)key];
    [accountWrapper release];
     */
}
+ (id)keychain:(NSString *)identifier ObjectForKey:(id)key{
    /*
    NSString *group = [NSString stringWithFormat:@"%@.%@",[self bundleSeedID],kKeyKeychainVendorIDGroup];
    KeychainItemWrapper *accountWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:identifier accessGroup:group];
    id result = [[accountWrapper objectForKey:(id)key] retain];
    [accountWrapper release];
    return [result autorelease];
     */
    return nil;
}

/* 读取 AppIdentifierPrefix
 You can programmatically retrieve the Bundle Seed ID by looking at the access group attribute (i.e. kSecAttrAccessGroup) of an existing KeyChain item. In the code below, I look up for an existing KeyChain entry and create one if it doesn't not exist. Once I have a KeyChain entry, I extract the access group information from it and return the access group's first component separated by "." (period) as the Bundle Seed ID.
 */
+ (NSString *)bundleSeedID {
    /*
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                           kSecClassGenericPassword, kSecClass,
                           @"bundleSeedID", kSecAttrAccount,
                           @"", kSecAttrService,
                           (id)kCFBooleanTrue, kSecReturnAttributes,
                           nil];
    CFDictionaryRef result = nil;
    OSStatus status = SecItemCopyMatching((CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status == errSecItemNotFound)
        status = SecItemAdd((CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status != errSecSuccess)
        return nil;
    NSString *accessGroup = [(NSDictionary *)result objectForKey:kSecAttrAccessGroup];
    NSArray *components = [accessGroup componentsSeparatedByString:@"."];
    NSString *bundleSeedID = [[components objectEnumerator] nextObject];
    CFRelease(result);
    return bundleSeedID;
     */
    
    return nil;
}

+ (NSString*)macaddress
{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
//        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
//        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
//        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
//        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

+ (NSString*)getMD5MAC
{
    
    static NSString* uniqueIdentifier = nil;
    
    if (uniqueIdentifier == nil)
    {
        
        NSString *macaddress = [UPDeviceInfo macaddress];
        
        if(macaddress == nil || [macaddress length] == 0)
            return nil;
        
        const char *value = [macaddress UTF8String];
        
        unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
        CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
        
        NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
            [outputString appendFormat:@"%02x",outputBuffer[count]];
        }
        
        
        uniqueIdentifier = [NSString stringWithString:outputString];
    }
    
    return uniqueIdentifier;
}




//iPhone OS
+ (NSString*)deviceOS 
{
    return [[UIDevice currentDevice] systemName];
}
//4.3.3
+ (NSString*)deviceOSVersion 
{
    
    return [[UIDevice currentDevice] systemVersion];
}

//iPhone
+ (NSString*)deviceModel {
    return [[UIDevice currentDevice] model];
}

+ (NSString*)machineType
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *answer = (char*)malloc(size);
    sysctlbyname("hw.machine", answer, &size, NULL, 0);
    NSString *results = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];//iPhone3,1
    free(answer);
    return results;
}

+ (NSString*)machineTypeMap
{
	NSString *platform = [UPDeviceInfo machineType];
	if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone1-1";
	if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone1-2";
	if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone2-1";
	if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone3-1";
	if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4-1";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5-1";
    
	if ([platform isEqualToString:@"iPod1,1"])   return @"iPod1-1";
	if ([platform isEqualToString:@"iPod2,1"])   return @"iPod2-1";
	if ([platform isEqualToString:@"iPod3,1"])   return @"iPod3-1";
	if ([platform isEqualToString:@"iPad1,1"])   return @"iPad1-1";
	if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2-1";
    
	if ([platform hasPrefix:@"iPhone"]) return @"iPhone";
	if ([platform hasPrefix:@"iPod"]) return @"iPod";
	if ([platform hasPrefix:@"iPad"]) return @"iPad";
    
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"])
    {
        return @"Simulator";
    }
    
	return nil;
}

+ (int)machineTypeInt
{
	NSString *platform = [UPDeviceInfo machineType];
	if ([platform isEqualToString:@"iPhone1,1"]) return UIDevice1GiPhone;
	if ([platform isEqualToString:@"iPhone1,2"]) return UIDevice3GiPhone;
	if ([platform isEqualToString:@"iPhone2,1"]) return UIDevice3GSiPhone;
	if ([platform isEqualToString:@"iPhone3,1"]) return UIDevice4GiPhone;
	if ([platform isEqualToString:@"iPhone4,1"]) return UIDevice4GSiPhone;
    if ([platform isEqualToString:@"iPhone5,1"]) return UIDevice5iPhone;
	if ([platform isEqualToString:@"iPod1,1"])   return UIDevice1GiPod;
	if ([platform isEqualToString:@"iPod2,1"])   return UIDevice2GiPod;
	if ([platform isEqualToString:@"iPod3,1"])   return UIDevice3GiPod;
	if ([platform isEqualToString:@"iPad1,1"])   return UIDevice1GiPad;
	if ([platform isEqualToString:@"iPad2,1"])   return UIDevice2GiPad;
	if ([platform hasPrefix:@"iPhone"]) return UIDeviceUnknowniPhone;
	if ([platform hasPrefix:@"iPod"]) return UIDeviceUnknowniPod;
	if ([platform hasPrefix:@"iPad"]) return UIDeviceUnknowniPad;
    if ([platform hasSuffix:@"86"] || [platform isEqual:@"x86_64"])
    {
        if (g_isIphone5Simulator) {
            return UIDeviceiPhone5Simulator;
        }else
            return UIDeviceSimulator;
    }
	return UIDeviceUnknown;
}

+ (void)setIsIphone5Simulator:(BOOL) isOrNot
{
    g_isIphone5Simulator = isOrNot;
}

+ (CGSize)deviceScreenBound
{
    if ((g_screenSize.height ==0) && (g_screenSize.width ==0)) {
        if (([self machineTypeInt] == UIDevice5iPhone) || ([self machineTypeInt] == UIDeviceiPhone5Simulator))
        {      //主要是因为iphone5存在兼容模式 而在兼容模式下获取的bounds不对
            g_screenSize =CGSizeMake(320, 568);
        }else
        {
            g_screenSize =[UIScreen mainScreen].bounds.size;
        }
    }
    return g_screenSize;
}


+ (CGSize)screenSize
{
    return [UIScreen mainScreen].bounds.size;
}

+ (NSString*)machineTypeString
{
	switch ([UPDeviceInfo machineTypeInt])
	{
		case UIDevice1GiPhone: return IPHONE_1G_NAMESTRING;
		case UIDevice3GiPhone: return IPHONE_3G_NAMESTRING;
		case UIDeviceUnknowniPhone: return IPHONE_UNKNOWN_NAMESTRING;
		case UIDevice3GSiPhone: return IPHONE_3GS_NAMESTRING;
		case UIDevice4GiPhone: return IPHONE_4G_NAMESTRING;
		case UIDevice4GSiPhone: return IPHONE_4GS_NAMESTRING;
        case UIDevice5iPhone:   return IPHONE_5_NAMESTRING;
        case UIDeviceSimulator: return SIMULATOR_NAMESTRING;
		case UIDevice1GiPod: return IPOD_1G_NAMESTRING;
		case UIDevice2GiPod: return IPOD_2G_NAMESTRING;
		case UIDevice3GiPod: return IPOD_3G_NAMESTRING;
		case UIDevice1GiPad: return IPAD_1G_NAMESTRING;
		case UIDevice2GiPad: return IPAD_2G_NAMESTRING;
		case UIDeviceUnknowniPad: return IPAD_UNKNOWN_NAMESTRING;
		case UIDeviceUnknowniPod: return IPOD_UNKNOWN_NAMESTRING;
            
		default: return nil;
	}
}

+ (int)deviceResolution{
	switch ([UPDeviceInfo machineTypeInt])
	{
		case UIDevice1GiPhone: return UIDeviceScreen320X480;
		case UIDevice3GiPhone: return UIDeviceScreen320X480;
		case UIDeviceUnknowniPhone: return UIDeviceScreen320X480;
		case UIDevice3GSiPhone: return UIDeviceScreen320X480;
		case UIDevice4GiPhone: return UIDeviceScreen640X960;
		case UIDevice4GSiPhone:	return UIDeviceScreen640X960;
		case UIDevice1GiPod: return UIDeviceScreen320X480;
		case UIDevice2GiPod: return UIDeviceScreen320X480;
		case UIDevice3GiPod: return UIDeviceScreen640X960;
		case UIDevice1GiPad: return UIDeviceScreen768X1024;
		case UIDevice2GiPad: return UIDeviceScreen768X1024;
		case UIDeviceUnknowniPad: return UIDeviceScreen768X1024;
		case UIDeviceUnknowniPod: return UIDeviceScreen320X480;
			
		default: return UIDeviceScreen320X480;
	}
    
}

+ (int)platformCapabilities
{
	switch ([UPDeviceInfo machineTypeInt])
	{
		case UIDevice1GiPhone: return UIDeviceBuiltInSpeaker | UIDeviceBuiltInCamera | UIDeviceBuiltInMicrophone | UIDeviceSupportsExternalMicrophone | UIDeviceSupportsTelephony | UIDeviceSupportsVibration;
		case UIDevice3GiPhone: return UIDeviceSupportsGPS | UIDeviceBuiltInSpeaker | UIDeviceBuiltInCamera | UIDeviceBuiltInMicrophone | UIDeviceSupportsExternalMicrophone | UIDeviceSupportsTelephony | UIDeviceSupportsVibration;
		case UIDeviceUnknowniPhone: return UIDeviceBuiltInSpeaker | UIDeviceBuiltInCamera | UIDeviceBuiltInMicrophone | UIDeviceSupportsExternalMicrophone | UIDeviceSupportsTelephony | UIDeviceSupportsVibration;
            
		case UIDevice1GiPod: return 0;
		case UIDevice2GiPod: return UIDeviceBuiltInSpeaker | UIDeviceBuiltInMicrophone | UIDeviceSupportsExternalMicrophone;
		case UIDeviceUnknowniPod: return 0;
            
		default: return 0;
	}
}



+ (NSString*)deviceWidth
{
    CGRect mainRect =  [UIScreen mainScreen].bounds;
	CGFloat scale = [UIScreen mainScreen].scale;
    int width =(int) mainRect.size.width*scale;
    NSString* strWidth = [NSString stringWithFormat:@"%d",width];
    return strWidth;
}

+ (NSString*)deviceHeight
{
    CGRect mainRect =  [UIScreen mainScreen].bounds;
	CGFloat scale = [UIScreen mainScreen].scale;
    int height =(int) mainRect.size.height*scale;
    NSString* strHeight = [NSString stringWithFormat:@"%d",height];
    return strHeight;
}

+ (BOOL)isPad
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}


@end