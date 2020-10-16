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

==TBA==
