//
//  RegisterView.m
//  ComputerPaperRecommender
//
//  Created by 赵俊法 on 16/8/27.
//  Copyright © 2016年 Eight. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()<NSURLConnectionDataDelegate>
{
    NSMutableData *receiveData_;
}
@end

#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.Height
@implementation RegisterViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
////    _usernameView = [[KeyValueView alloc] initWithFrame:CGRectMake(100, 70, kScreenWidth-100*2, 30)];
////    _usernameView.backgroundColor=[UIColor clearColor];
////    [self.view addSubview:_usernameView];
//    
//    _usernameLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 70, (kScreenWidth-100*2)/3, 30)];
//    _usernameLabel.backgroundColor=[UIColor clearColor];
//    _usernameLabel.textAlignment=NSTextAlignmentLeft;
//    _usernameLabel.font=[UIFont systemFontOfSize:16];
//    _usernameLabel.textColor=[UIColor blackColor];
//    [self.view addSubview:_usernameLabel];
//    
//    _usernameTextField=[[UITextField alloc] initWithFrame:CGRectMake(100+(kScreenWidth-100*2)/3, 70, 2*(kScreenWidth-100*2)/3, 30)];
//     _usernameTextField.backgroundColor=[UIColor clearColor];
//     _usernameTextField.textAlignment=NSTextAlignmentLeft;
//     _usernameTextField.font=[UIFont systemFontOfSize:16];
//     _usernameTextField.textColor=[UIColor blackColor];
//    [self.view addSubview: _usernameTextField];
//    
////    _passwordView = [[KeyValueView alloc] initWithFrame:CGRectMake(100, 70+30, kScreenWidth-100*2, 30)];
////    _passwordView.backgroundColor=[UIColor clearColor];
////    [self.view addSubview:_passwordView];
//    
//    _passwordLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 70+30, (kScreenWidth-100*2)/3, 30)];
//    _passwordLabel.backgroundColor=[UIColor clearColor];
//    _passwordLabel.textAlignment=NSTextAlignmentLeft;
//    _passwordLabel.font=[UIFont systemFontOfSize:16];
//    _passwordLabel.textColor=[UIColor blackColor];
//    [self.view addSubview:_passwordLabel];
//    
//    _passwordTextField=[[UITextField alloc] initWithFrame:CGRectMake(100+(kScreenWidth-100*2)/3, 70+30, 2*(kScreenWidth-100*2)/3, 30)];
//    _passwordTextField.backgroundColor=[UIColor clearColor];
//    _passwordTextField.textAlignment=NSTextAlignmentLeft;
//    _passwordTextField.font=[UIFont systemFontOfSize:6];
//    _passwordTextField.textColor=[UIColor blackColor];
//    [self.view addSubview: _passwordTextField];
//    
//    
//    _nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 70+30*2, (kScreenWidth-100*2)/3, 30)];
//    _nameLabel.backgroundColor=[UIColor clearColor];
//    _nameLabel.textAlignment=NSTextAlignmentLeft;
//    _nameLabel.font=[UIFont systemFontOfSize:16];
//    _nameLabel.textColor=[UIColor blackColor];
//    [self.view addSubview:_nameLabel];
//    
//    _nameTextField=[[UITextField alloc] initWithFrame:CGRectMake(100+(kScreenWidth-100*2)/3, 70+30*2, 2*(kScreenWidth-100*2)/3, 30)];
//    _nameTextField.backgroundColor=[UIColor clearColor];
//    _nameTextField.textAlignment=NSTextAlignmentLeft;
//    _nameTextField.font=[UIFont systemFontOfSize:16];
//    _nameTextField.textColor=[UIColor blackColor];
//    [self.view addSubview: _nameTextField];
//
//    
//    
//    
//    UIButton *registerButton= [[UIButton alloc] initWithFrame:CGRectMake(100, 70+30*2, kScreenWidth-100*2, 30)];
//    registerButton.backgroundColor=[UIColor redColor];
//    [registerButton setTitle:@"Regist" forState:UIControlStateNormal];
//    [registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(loadPostWebRequest:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:registerButton];
}

-(void)loadPostWebRequest:(id)sender
{
    receiveData_=nil;
    NSURL *url=[NSURL URLWithString:@""];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    
    NSString *newusername=[_usernameTextField text];
    NSString *newpassword=[_passwordTextField text];
    NSString *newname=[_nameTextField text];
    NSString *postParam =[NSString stringWithFormat:@"username=%@&password=%@&name=%@",newusername,newpassword,newname];
    NSData *postData=[postParam dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:postData];
    NSURLConnection *connection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    [connection start];
}

//网络请求的响应结果
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"%@",response);
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(receiveData_ ==nil){
        receiveData_ =[[NSMutableData alloc] init];
    }
    [receiveData_ appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"网络请求结束");
    NSURLRequest *request=connection.originalRequest;
    NSString *method= request.HTTPMethod;
    if ([method isEqualToString:@"POST"])
    {
        id obj=[NSJSONSerialization JSONObjectWithData:receiveData_ options:0 error:nil];
        NSLog(@"obj %@",obj);
        id bstatusObj = [(NSDictionary *)obj objectForKey:@"bstatus"];
        NSString *des=[(NSDictionary *)bstatusObj objectForKey:@"des"];
        NSLog(@"%@",des);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
