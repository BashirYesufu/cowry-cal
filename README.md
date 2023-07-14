# cowry-cal

## Getting Started
This repository contain the code for the Cowry Wise Assessment. This project was written using Apple's UIKit framework and Swift programming Language. If you're new to UIKkit and Swift, Check out the Framework at (https://developer.apple.com/documentation/uikit) and the language at (https://developer.apple.com/swift/).

## Running Instructions 

**Step 1:**

You must have XCode Installed to build this project. Check the MacOS AppStore if you don't have it installed. You might experience build issues running on a older xcode versions prior to iOS 16 introduction. I have included a link to the latest version of XCode.

```
[Xcode](https://apps.apple.com/us/app/xcode/id497799835?mt=12
```

Download or clone this repo by using the link below:

```
https://github.com/BashirYesufu/cowry-cal.git
```

This project includes third party libraries and such must be installed in order to run. Open up your mac terminal, change directories to where you have the project cloned, and run the below command using Cocoapods. Bear in mind you must have cocoapods installed on your device to do this. A quick google search will help you install this if you do not have it. You can also visit https://brew.sh/ to help with this installation.
```
pod install
```
If you're running on a Silicon chip mac i.e 2020 and newer, you might need to install ffi and then run
```
arch -x86_64 pod install
```

**Step 2:**

Connect your device via cable or network if you have it setup. Alternatively, you could build it on the any simulator on your XCode: 


**Step 3:**

Your mobile device may ask you to trust the app and the Computer, You can do this by going to Settings >> General >> VPN & Device Managemanet and select trust. Alternatively, Run your simulator for iOS and smash the build button. Easy right? Leggo!

## NB: This app depends on fixer.io apis. However the api key used to test is a free version and such thorough testing was severely limited. Feel free to swap the key which is located at the DashboardViewModel file and you should have a smooth running experience.

## Screenshots of the app
<table>
 <tr>
  <td>
   <img align="left" alt="IMG" src="https://raw.githubusercontent.com/BashirYesufu/cowry-cal/main/Documentation/1.png" width="400" height="700" />
  </td>
  <td>
    <img align="right" alt="IMG" src="https://raw.githubusercontent.com/BashirYesufu/cowry-cal/main/Documentation/2.png" width="400" height="700" />
  </td>
   <td>
    <img align="right" alt="IMG" src="https://raw.githubusercontent.com/BashirYesufu/cowry-cal/main/Documentation/3.png" width="400" height="700" />
  </td>
 </tr>
</table>
