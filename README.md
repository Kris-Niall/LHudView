# LHudView

## 顶部弹出类型提示框
该控件为简单提示框，开发者也可根据自己需求修改，简易可复用

![image](https://raw.githubusercontent.com/Kris-Niall/LHudView/master/screenshotImg.gif)

## 调用方法
提供了4种样式，用于显示提示框

    [LHudView showSuccess:@"发送成功"]; 
    [LHudView showError:@"发送失败"];
    [LHudView showWarning:@"请稍后发送"];
    [LHudView showProcess:@"正在发送......"];
    
在使用showProcess样式的时候需要配合dismiss使用

    [LHudView dismiss];
    
觉得好用的话，方便给个star✨,谢谢🙏

