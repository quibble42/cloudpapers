# Cloudpapers
A handy doodad that automatically updates your wallpapers based on a google drive you subscribe to.

## Who it's for
This is a batch script that works on windows, namely, windows 11. It will probably work on windows 10, but no guarantees. 

If you'd like to help me test this on other machines to get the functionality added, please reach out.

## What this does
This downloads RCLONE (open source, here: https://rclone.org/drive/) and sets it up for google drive connection.

It also sets this up for default usage on your computer, and creates a folder of the pictures from google drive.

Lastly, it creates a small .bat file you can click which instantly downloads pictures from google drive you choose (otherwise it will do so at startup).

## How to use
1.) Ask a photographer friend to upload pictures to a google drive that you've created.

1a.) If you're subscribing to a drive folder that they own, right click and "Add Shortcut" to "My Drive".

2.) Download the code as a zip, unzip it, and spam-click "setuprclone" until you are satisfied. You only have to click it once, though.

3.) Set the folder that just opened (the one with your downloaded pictures) as the folder to use as your backgrounds via "Personalization" in Windows.

## If you want to contribute
Feel free! Please give me a heads up and a very detailed contribution note if you do. Hope to add some more functionalities, such as:

 • Automatically add the folder to your wallpaper rotation (this is difficult, but if we assign a number to the files as they come in, we can then cycle through numbers)
 
 • Automatically delete the previous pictures from your folder if they are no longer in google drive (or, move them somewhere—allow user to choose)
 
 • Add dropbox/other drive functionality
 
 • Make it into an .exe with a vague license and a readme so it's not as "anti-firewall-friendly"
 
## Having Issues?
If you're having issues, please contact me as I would love to have information from another system.
