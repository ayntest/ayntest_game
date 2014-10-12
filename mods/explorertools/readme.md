This mod adds a pick, axe, and shovel that not only dig on a left click, but will place whatever item is in the inventory slot immediately to their right on a right click.

**Explorer Tools Version 1.1**

Have you ever been frustrated when digging a mine or exploring a cavern because you have to dig, dig, dig, then swap the active inventory item to a torch, place a torch, swap the active inventory item back to your pick, and repeat?  Did you ever wish that you could just place a torch (or a block of stone or glass) with a right click while still wielding your pick, axe, or shovel?  If so, then this mod is for you!

The tools are based upon the diamond versions, and are crafted by replacing the top stick in the recipe with a mese crystal:<p>
```
diamond,   diamond   ,diamond        diamond,diamond              diamond
       ,mese fragment,               diamond,mese fragment      mese fragment
       ,   stick     ,                      ,stick                 stick
```
![alt text](http://i57.tinypic.com/2maaog.png "image")

These tools have the same stats as a diamond tool, with the exception that the uses has been increased by 10%.  (to account for the extra expense of adding a mese crystal)<p>
The tools work exactly like the base diamond version, EXCEPT that when wielding these tools, if you right click, it does a "place" using the item directly to the right in the players inventory.  So, for example, if your inventory slots looked like this:

![alt text](http://i60.tinypic.com/11huw7k.png "image")

Then a left click with the pick would dig, but point the pick at the wall and right click, and it will place a torch from your second inventory slot on the wall.  No need to switch active inventory items at all.  Left click to dig with the pick, right click to place a torch.

And it doesn't have to be a torch.  Perhaps you are building a project that requires digging out stone and replacing it with glass.  Just put your stack of glass in the inventory slot next to the explorer pick, dig the stone out with a left click, place the glass with a right click.  The axe and the shovel work the same way.

**Alternative mod:**<p>
There was a request that the explorertool place on rightclick function be added to every pick, axe, and shovel in the game.  4aiman implemented this in his magichet game, and kindly gave me permission to create an explorertoolsall mod based on his code.  Download THAT version if you want ALL tools to be able to place an item on right click.

**Possible future changes:**<p>
The textures, eh, not so great here.  If someone gets inspired to suggest an improvement, I'm very open to it.  I didn't create an explorer hoe, because there was not a diamond version of the hoe in the default game, but adding a hoe would be simple.<p>
This is my first MineTest mod, and my first time ever programming in Lua, so any suggestions for improvements in the code are very welcome.

**Credits:**<p>
My son helped me with the idea, the programming, and the textures.  Thanks to kaeza for sample code of how to get the inventory item to the right of the tool, and to PilzAdam and Stu for answering my questions about how the uses field works.  4aiman for the change the code for Explorer Tools All.

**Incompatibilities:**<p>
Do not use with Inventory Tweak mod, on right click your tool will disappear!

**---For Explorer Tools:** (use this one for special explorer tools)<p>
**Dependencies:**<p>
soft depends on default, but without default you have no recipe.

**License:** CC0

**To browse source:**<p>
[https://github.com/Kilarin/ExplorerTools](https://github.com/Kilarin/ExplorerTools)

**Download:**<p>
[https://github.com/Kilarin/ExplorerTools/archive/master.zip](https://github.com/Kilarin/ExplorerTools/archive/master.zip)

**---For Explorer Tools All:** (use this one to let all tools do a right click place)<p>
**Dependencies:**<p>
Soft depends on default.  Add soft dependencies for any other tool mods you want this to affect.

**License:** gplv3

**To browse source:**<p>
[https://github.com/Kilarin/explorertoolsall](https://github.com/Kilarin/explorertoolsall)

**Download:**<p>
[https://github.com/Kilarin/explorertoolsall/archive/master.zip](https://github.com/Kilarin/explorertoolsall/archive/master.zip)

**---**

**To install:**<p>
Simply unzip the file into your mods folder, and rename the folder to explorertools (Or explorertoolsall)<p>
OR, simply install it directly from minetest using the online mod repository.

**Mod Database:**<p>
If you use either of these mods, please consider reviewing it on the MineTest Mod Database.<p>
[https://forum.minetest.net/mmdb/mod/explorertools/](https://forum.minetest.net/mmdb/mod/explorertools/)<p>
[https://forum.minetest.net/mmdb/mod/explorertoolsall/](https://forum.minetest.net/mmdb/mod/explorertoolsall/)

**Change Log:**<p>
1.1 changed hard depends on default to soft<p>
    removed requirement that index pos of tool be less than 8<p>
    updated readme to include explorertoolsall referenc<p>
1.0 initial release