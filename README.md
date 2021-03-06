# Chrome Bisect
Chrome Bisect is a fork of the [bisect-builds.py tool](https://www.chromium.org/developers/bisect-builds-py). It's goal is to make it easy for IT admins to determine when Chrome browser began behaving differently and why it did so (deprecation, regression bug, etc).

[![Build Status](https://travis-ci.org/jay0lee/chrome-bisect.svg?branch=master)](https://travis-ci.org/jay0lee/chrome-bisect)

# Quick Start
## Linux / MacOS
Open a terminal and run:
```
bash <(curl -s -S -L https://raw.githubusercontent.com/jay0lee/chrome-bisect/master/install.sh)
```
this will download Chrome Bisect and install it.
## Windows
Download the MSI Installer from the [GitHub Releases](https://github.com/jay0lee/chrome-bisect/releases) page. Install the MSI.

# Running Chrome Bisect
You need to know a few things before you run Chrome Bisect
* Exact steps to reproduce (recreate) the issue you are having with Chrome. This would look something like:
  * Visit http://www.example.com
  * Log in.
  * Browse to Products > Widgets page
  * Attempt to view a widget
  * Issue occurs when widget does not show.
* The last version of Chrome browser where you DID NOT SEE this issue. This can be a major Chrome release number like 65.
* The first version of Chrome browser where you DID SEE the issue. This can be a major Chrome release number like 66.

Once you know these details, go ahead and run Chrome Bisect. You'll be prompted to enter some of these details and then the tool will start downloading versions of Chromium browser and running them on your machine.
* Each time Chromium browser runs on your machine, try to reproduce the issue. If you cannot reproduce the issue, this version of Chromium is considered "good". If you can reproduce the issue, this version of Chromium is considered "bad".
* Once you exit a Chromium browser, the tool will prompt you to mark the build as good or bad. Be sure to enter accurate information or your results will be wrong.
* You can also retry a given Chromium build or quit completely if you think there are other issues.
* Depending on the range of Chromium builds you specified as known good and known bad, you'll need to keep on testing additional builds until the range is narrowed down as tightly as possible. This may mean running a dozen or more builds of Chromium which is why you want to get the reproduction steps as short as possible.
* Once the tool has an exact good > bad build range, it will let you know and provide you with a URL that shows you all of the changes to Chromium browser between the two builds. With this information, you may be able to narrow down why the change was made that caused your issue.
  * Please be aware that not every issue you face is a regression bug in Chrome. For security and stability reasons, the browser regularly removes deprecated features / functionality. It may be on you to upgrade your site or environment to meet the new browser requirements.
  * If you still believe the issue is a regression bug in Chrome browser, please file an issue at crbug.com and/or open a Enterprise support case with full details including the log generated by Chrome Bisect.
  
 # An example Chrome Bisect
 Let's pretend you own the site https://sha1-intermediate.badssl.com/ and that you've noticed it's stopped working after Chrome browser 56 was released (from the site name or error returned by the page, [you may already know why it stopped working](https://security.googleblog.com/2016/11/sha-1-certificates-in-chrome.html) but let's pretend you don't).
  1. Run Chrome Bisect and specify https://sha1-intermediate.badssl.com/ as the site to use.
  1. Specify 55 as the last good version and 56 as the first bad version.
  1. The tool will start downloading Chromium builds. If the Chromium build launches and a red page with text from the website loads properly, exit the browser and mark the build as good. If you see a connection error and the browser fails to load the site, mark the build as bad.
  1. The tool will need to download and run about a dozen builds to narrow the build scope as tightly as possible. Keep marking builds as good or bad until the tool finishes.
  1. Once the tool is finished with builds, it will tell you the exact builds between good and bad behavior. It also gives you a link to the changes that were made to Chromium browser between the last good and first bad build.
  1. Open the changelog page and look through the list.
      * Can you tell which exact change in the list caused the site to stop loading?
      * Why was that change made?
      * What might you need to do to fix your site?

# Known Limitations
As mentioned above, Chrome Bisect has a few limitations that you should be aware of:
* Chrome Bisect downloads public Chromium browser binaries to test with, these open-source public builds do not contain everythng the official Chrome browser contains and may not be good for testing issues related to:
     * The PDF Viewer
     * Adobe Flash Player
     * Widevine DRM
* Currently the tool does not not support Chrome OS. If you have an issue on Chrome OS try reproducing it in Chrome browser on Windows, Mac or Linux and see if you can utilize the tool there.
