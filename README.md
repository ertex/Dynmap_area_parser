# Dynmap_area_parser
This is a bodged way of creating area markers on dynmap using .SVG files using AutoHotKey

**Why?**
The Minecraft dynmap plugin https://github.com/webbukkit/dynmap 
has no way of creating areamarkers via the webinterface so this leaves the user to move about the world to create markers for each corner.
If you have a complex network of zones that change over time, this is troublesome. The aim is to make it easier to change that.
Refer to XKCD https://xkcd.com/1319/

**What it does**

It takes a .SVG file with paths / polylines and extracts the coordinates of each node.
it then parses these coordinates to minecraft chat freindly way.

**Why not just modify the JSON file of dynmap directly? Or via the API or something?**

The server im developing it for is not on my machine, I don't even have the password.
So I just could not be bothered


**Usage**

	1. create a snippet or download a image of your dynmap

	2. import the image into a svg editor (like inkscape) and then draw straight lines on it (do not hold shift while drawing them). Make sure they are straight and not bezier curves or arc etc as they will not work.

	3. take notes on the origin of your SVG file and minecraft world and also scale. Input the offset of the origins into config.txt. If done wrong your areas will be missplaced.

	4. Run the script "Dynmap Code generator.ahk" and select your .SVG file. a Output.txt file will be created

	5. (optional) rename your areas in output.txt to match what they should be called

	6. Set your chat key in the config file to the one you have in Minecraft.

	7. Start minecraft and join the server you want to add areas to.

	8. Start the script "Minecraft_chat_paster.ahk" and focus on minecraft, 5 seconds after start of the script it will type things in your client.

	
  
