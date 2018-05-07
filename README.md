# Download a video in Parts

## For Swift4 and Xcode 9 + 

Download a Specific file in parts using Alamofire i.e. the downloaded Portion is stored and next time it starts From that point only.

This prevents to download the same part again and again.

Inspired from WhatsApp and other Applications. Made a simple demo which uses the same logic in following Steps.

#### Step:- 1 Download Begins ####

The normal download of your file begins using Alamofire 

#### Step:- 2 Resume Download form the last know point ####

In the normal case you need to store the last know resume data for this process. 
This resume data helps the App to detect where the download was last stop and can start from there.

#### Step:- 3 Download Completed ####

This depicts that the downloaded has completed successfully. In both the Case i.e. Full download or Partial Download

### Note:- I have also used the MBCircularProgressBar for showing the Progress of completion.

## Thanks to Following:

1. [Alamofire](https://github.com/Alamofire/Alamofire)
2. [MBCircularProgressBar](https://github.com/MatiBot/MBCircularProgressBar)











