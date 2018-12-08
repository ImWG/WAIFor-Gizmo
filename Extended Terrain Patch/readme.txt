===========================================

        Extended Terrains Mod 1.1
             By WAIFor, 2018

===========================================


About
===================================
This is a Age of Empires 2: The Conquerors mod that have exe modified, injected 
with dll. Besides 41 original terrains in TC, you can see 26 new HD terrains, and 
all of them work well.
Extract files at Games\ to game directory and run age2_newter.exe to enjoy the 
modded game. wndmode.dll is window mode library, you don't have to extract it if 
existed.


Background
===================================
many AOKTC mod developers know that, in the dat file, number of terrains cannot
be changed casually, it must be 41 or 42, or the game will crash. Even if the
new 42nd terrain, movement of units is strange: units was blocked first, then
walked in orthogonally. So, adding new terrain is a difficult work, many mods
only changed unused terrains (like hidden grass 1 or KOH road) to new terrains.
In UserPatch 1.5, a new function is added. So scenarios and random maps can 
override original terrain graphics with custom slps. This is a pretty creative
function, making designing more intresting. However, modders may be not satisfied,
because it only changed graphics, not blend types nor minimap colors.

To add more terrains, I used to analyze exe file, found that loading 42 terrains
is highly hardcoded, something obsoleted is also loaded after terrains, like 
borders and old rendom maps. After that, game will jump by a fixed offset to read
more. So I tried to skip those loading codes, expand number of terrains to load.
Then I replaced borders and maps with new terrain data in dat file. This is the 
Extended Terrains Mod 1.0.
But like 42nd terrain, new terrains acted strangely. Without restriction data,
units on them would make unknown traces, like berserker graphic on old "Unknown" 
terrain. Building restrictions on them are also. The most important is movement,
cannot be set by dat file, because it is hardcoded. So in version 1.1, I've made
many more improvements.


Content
===================================
Except 42 terrains, there are 25 new ones, and 42nd has been changed to all black
tiles. Those new terrains have inherited respective original ones, so they act all 
the same as old terrains except visual appearance: movement, trace and restriction.
So we don't have to set new restriction properties for them.
At folder ASM\ is soruce code of ETM's Gizmo patch dll. Developers can read them to 
know how the patch works, or change that to generate their own patch. See the files 
for detailed information.

Folder PHP\ contains two dat file: empires2_x1_p0.dat, new_terrains.dat, and one 
PHP script terrain_merge.php. The former dat file is proto mod data, contains all 
data except new terrains, while the latter contains 25 new terrains only. Both dat
files are started with original grass 1, they are unused except as a flag to locate 
terrains data. 
The script is used to write new_terrains.dat to empires2_x1_p0.dat after its 42 
terrains, overwriting borders and maps. To run the script, you need a PHP compiler.