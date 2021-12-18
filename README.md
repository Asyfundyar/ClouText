[YOUTUBE LINK TO PRESENTATION VIDEO]
https://youtu.be/5LyE4euwPr0




[CANT CREATE ACCOUNT?]
Make sure that when you are creating your own account you have a password that is minimum 6 characters or more.

[FAILED TO REGISTER BUNDLE IDENTIFIER STATUS ERROR]
If after running the application you get an error that says "Failed to register bundle identifier" status, you should go to the "Signing & Capabilities" tab of the project and change the name, go to the Bundle Identifier part and change the "UMD.ClouText" (or if it does not say UMD, change whatever it says before the .ClouText) to "(anything else).ClouText". You can change it to any other name. This issue happens when you want to run a project and you are not in the same Team as the person who created the project. 


[Fail to Compile / Extra Argurment "Minimal Bound" / No member "Horizontal"]
The app doesnt work onn the simulator because it relies on physical phone for the anchor to work. So if you want to run the app, please connect a phone to xcode and run it through your phone.
