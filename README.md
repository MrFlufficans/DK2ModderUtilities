# DK2ModderUtilities
Type Legend.<br/>
P = Powershell.<br/>
B = Batch.<br/>


Contains Utilities Modders can use for Door Kickers 2 Modding

These can be run easily by Right clicking and Running with Powershell.
However if you are running with a Execution Policy higher than Unrestricted you will need to do something else.
Double click is enough for Batch Versions.

For a lack of a better way to explain it you basically have to install my Signature into your Trusted Certificates.
I will include documentation on how to do it and also how to remove it incase you wish to revert it.

If you don't know if this applies to you, If the Powershell Window Opens then closes Instantly It probably applies to you.
I have a Wiki on how to do just that, it takes maybe like a Minute max following it.
https://github.com/MrFlufficans/DK2ModderUtilities/wiki/How-to-Add-The-Signature-to-Run-these

# Modification Check -P
This Tool is used to check for Modified Files after an Update.

1.  To use it place the Script into the Game Directories Data Folder, on the end and Run the Script.
2.  If there is a New version it will prompt you to Update a Simple Yes or Y will suffice, You can Decline but I would suggest Updating.
3.  If you let it update itself It will Automatically Replace itself and Relaunch.
4.  It will Prompt you for How many Days back you want to compare to, e.g 5 will give you a list of everything Modified from then to the moment you press Enter.
5.  After displaying the List it will Output it to a Text file Labelled Results.txt in the same Folder the Script is in.


# Mod Installer -P -B
This Tool Still works but I am declaring it deprecated.
I suggest you use Nexus's mods as they have the Vortex Mod Manager.
However if you want to still use this tool it Will Function Fine.

This is an Installer that can be placed Alongside Mods and used to Automatically Install them
Hopefully I can make it super easy for Mod Makers to use so people don't need to install them Manually Anymore

For Mod Makers, If you are unsure which version you should use, Know that Batch can be run by anyone.
However Powershell depending on their Execution Policy may need them to add my Signature, Wiki at the Top, I am sorry I can't work around that.
Technically I can but it requires me to bypass Their Policy and that is not the Reputation I want with my Tools.

Powershell Version
1.  It's Fairly Simple to use this Tool, Just Place it Side by Side with your Mod's Folder.
2.  Make sure the Top Line of your Readme.txt has the Mods Name.
3.  All people will need to Do is run the ModInstaller with Powershell and it will Do everything Else.
4.  The tool can also Update automatically but I am Not sure what I could change.

Batch Version
1.  Put it with the Mod Folder
2.  When its run it will check all Folders that are alongside it and will ask you to type the Mod Folder
3.  Once you have typed it, It ideally should install for you.

# Mod Downloader/Updater -P
I tried making this work for other File sharing Sites like Mega and Google Drive, No Dice.
For now it will be limited only to Github Releases so I doubt it will get used.

1.  There is an Additional File called AuthorSig it contains instructions on how to use it
2.  If the AuthorSig Doesn't exist it will prompt you to Enter the Details manually
3.  These Details will be Author Name, Mod Name and lastly the Branch this is normally "Main"
4.  After putting in the Details it will download the Repo and Extract it.
5.  You are now Free to place the Mod Folder into your Mods Folder, or Use my Mod Installer
6.  Simply make a readme.txt and put the Mods Name on the First Line and save, Now run the Installer

# Mod Boot Strap -P
This Tool More or less Generates a Blank slate mod for you to work with.
At the moment it only generates a mod.xml but I plan to update it Soon.

1.  Just run the script with Powershell and it will give you prompts.
2.  After filling in the Prompts there should be a generated Mod Folder placed into your Mods Folder.
3.  Profit?
