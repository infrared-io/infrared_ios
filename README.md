# Infrared

<p align="center">
  <img src ="https://github.com/infrared-io/infrared_ios/wiki/images/FULL-LOGO-transparent.png" alt='Infrared'/>
</p>

## Introduction  

Infrared is library for iOS development which allows control of app's UI, Interaction and resource.  
How is this achieved:  
* UI:   
instead of defining it in ObjC code and Storyboard, Infrared uses JSON description files  
* Interaction:  
handling user's interaction is done in JavaScript    
(Interaction can also be handled in ObjC.)   
* Resources:   
all resources used by app can be updated at any time. This includes localization, images, files, fonts, etc.

### JSON UI example

```json
{
  "id" : "label_id",
  "type" : "label",
  "backgroundColor" : "#ff000080",
  "text" : "IR Label",
  "textAlignment" : "NSTextAlignmentCenter",
  "textColor" : "#ffffffaa",
  "font" : "SystemBold, 16"
}
```

### JavaScript example

```javascript
IR.plugin({
    "data" : {
        "text_1" : 'value 1',
        "text_2" : 'value 2',
        "color"  : '#ffffff'
    },
    "actionMethod" : function () {
        // do some UI/Interaction/Data manipulation
    }
});
```

## App Structure

Entry point for Infrared based app is App.json where files for defining UI, Interaction and Resources are listed.

### App.json Example

```json
{
  "id": "app_name",
  "screens": [
    {
      "deviceType": "phone",
      "path": "lending_screen.json"
    },
    {
      "deviceType": "phone",
      "path": "signin_and_singup_screen.json"
    }
  ],
  "globalJSPluginPaths" : [
    "data_storage.js", "data_processing.js", "network_communication.js"
  ],
  "mainScreenId": "lending_screen_id",
  "i18n" : {
    "default" : "en",
    "languages" : {
      "en" : "en.json",
      "fr" : "fr.json"
    }
  },
  "version": 2
}
```


## Setup

Simplest way is to use podfile and initiate library in AppDelegate.

### Podfile

```
pod "Infrared"
```

###Code in AppDelegate

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];

    [[Infrared sharedInstance] buildInfraredAppFromPath:@"app.json"];

    return YES;
}
```

## Documentation

Detailed documentation can be find in project's [wiki page](https://github.com/infrared-io/infrared_ios/wiki)

----
IMPORTANT:  
- master branch is for development  
- tags are for stable versions

---

## License

Infrared iOS libarary (infrared_ios) is released under the Apache License, Version 2.0. See
[LICENSE](https://github.com/infrared-io/infrared_ios/blob/master/NOTICE).
