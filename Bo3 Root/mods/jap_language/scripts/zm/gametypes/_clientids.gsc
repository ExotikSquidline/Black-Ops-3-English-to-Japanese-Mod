#using scripts\codescripts\struct;

#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\hud_message_shared;
#using scripts\shared\hud_shared; 
#using scripts\shared\array_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\rank_shared;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_bgb;
#using scripts\zm\bgbs\_zm_bgb_shopping_free;
#using scripts\zm\bgbs\_zm_bgb_anywhere_but_here;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_powerups;
#using scripts\shared\flag_shared;
#using scripts\zm\_zm_power;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm;
#using scripts\zm\_zm_weapons;
#using scripts\zm\craftables\_zm_craftables;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_shared;
#using scripts\shared\ai_shared;
#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\hud_util_shared;
#using scripts\shared\hud_message_shared;
#using scripts\shared\hud_shared;
#using scripts\shared\array_shared;
#using scripts\shared\aat_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\tweakables_shared;
#using scripts\shared\ai\systems\shared;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\flag_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\ai_shared;
#using scripts\shared\doors_shared;
#using scripts\shared\gameskill_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\visionset_mgr_shared;
    
#using scripts\zm\gametypes\_hud_message;
#using scripts\zm\gametypes\_globallogic;
#using scripts\zm\gametypes\_globallogic_audio;
#using scripts\zm\gametypes\_globallogic_score;
#using scripts\zm\_zm_lightning_chain;
#using scripts\zm\_util;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\_zm;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_blockers;
#using scripts\zm\craftables\_zm_craftables;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_playerhealth;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_traps;
#using scripts\zm\_zm_laststand;
#using scripts\zm\bgbs\_zm_bgb_reign_drops;
#using scripts\zm\_zm_bgb_machine;
#using scripts\zm\_zm_bgb_token;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\aats\_zm_aat_fire_works;
#using scripts\zm\bgbs\_zm_bgb_round_robbin;
#using scripts\shared\compass;
#using scripts\zm\_load;

#insert scripts\shared\shared.gsh;

#define SL_BEGIN_ARCHIVE 19
#define mBG_COLOR  color(0)
#define mBG_SHADER  "white"
#define mBG_ALPHA  .55

#define mTEXT_COLOR  color(0xd10606)
#define mTEXT_ALPHA  1
#define mTEXT_MAXOPTIONS 10

#define mSLIDE_SHADER "white"
#define mSLIDE_COLOR color(0xd10606) //0x205dd6
#define mSLIDE_ALPHA .8
#define mINVERSE_COLOR color(0xd10606)

#define mSCROLL_DELAY .15

#define mANIM_NONE  0
#define mANIM_ZOOMIN  1
#define mANIM_ZOOMOUT  2

#define mHUD_X_OFF  -30
#define mHUD_Y_OFF  60

#namespace clientids;

REGISTER_SYSTEM( "clientids", &__init__, undefined )
	
function __init__()
{
	callback::on_start_gametype( &init );
	callback::on_connect( &on_player_connect );
	callback::on_spawned(&onPlayerSpawned);
    callback::on_spawned(&on_spawned);
}	

function init()
{
	// this is now handled in code ( not lan )
	// see s_nextScriptClientId 
	level.clientid = 0;
	level.my_round_num = 0;
    level preload();
    level.player_out_of_playable_area_monitor = undefined;
    thread FastQuit();
}

function on_player_connect()
{
	self.clientid = matchRecordNewPlayer( self );
	if ( !isdefined( self.clientid ) || self.clientid == -1 )
	{
		self.clientid = level.clientid;
		level.clientid++;	// Is this safe? What if a server runs for a long time and many people join/leave
	}

}

function on_spawned()
{
    level.round_num = 0;
    while(level.round_num < level.round_num)
    {        
        level.round_num++;
        
    }
}

function onPlayerSpawned()
{
    
    if(self IsHost())
        self thread _init_menu_setup(5, self);
    else
        self.access = 0;
        level flag::wait_till("initial_blackscreen_passed");
        self GadgetPowerSet(0, 100);
        self iPrintLnBold("Keg do be ^3Gay");
        wait 2.0;
}
    
function FastQuit()
{
    level waittill("end_game");
    wait 1; //for music
    exitlevel(0);
}






function createText(font, fontScale, align, relative, x, y, sort, alpha, text, color, movescale, isLevel)
{  
    if(IsDefined(movescale))
        x += self.menuSetting["MenuX"];
        
    if(IsDefined(movescale))
        y += self.menuSetting["MenuY"];
        
    textElem = (isDefined(isLevel) ? hud::createServerFontString(font, fontScale) : self hud::createFontString(font, fontScale));
    textElem SetText(text);
    textElem.archived = (self.menuSetting["MenuStealth"] ? false : true);
    textElem hud::setPoint(align, relative, x, y);
    textElem.hideWhenInMenu = (self.menuSetting["MenuStealth"] ? true : false);
    textElem.sort           = sort;
    textElem.alpha          = alpha;
    
    if(color != "rainbow")
        textElem.color = color;
    else
        textElem.color = level.rainbowColour;
        
    return textElem;
}

function createRectangle(align, relative, x, y, width, height, color, shader, sort, alpha, movescale, isLevel)
{
    if(IsDefined(movescale))
        x += self.menuSetting["MenuX"];
        
    if(IsDefined(movescale))
        y += self.menuSetting["MenuY"];
        
    boxElem = (isDefined(isLevel) ? hud::createServerIcon(shader, width, height) : hud::createIcon(shader, width, height)); 
    
    if(color != "rainbow")
        boxElem.color = color;
    else
        boxElem thread doRainbow();
    
    boxElem.archived       = (self.menuSetting["MenuStealth"] ? false : true);
    boxElem.hideWhenInMenu = true;
    boxElem.sort           = sort;
    boxElem.alpha          = alpha;
    boxElem hud::setPoint(align, relative, x, y);
    return boxElem;
}

function affectElement(type, time, value)
{
    if(type == "x" || type == "y")
        self moveOverTime(time);
    else
        self fadeOverTime(time);
        
    if(type == "x")
        self.x = value;
    if(type == "y")
        self.y = value;
    if(type == "alpha")
        self.alpha = value;
    if(type == "color")
        self.color = value;
}

function hudMoveX(x, time)
{
    self moveOverTime(time);
    self.x = x;
    wait time;
}

function hudFade(alpha, time)
{
    self fadeOverTime(time);
    self.alpha = alpha;
    wait time;
}

function fadeToColor(colour, time)
{
    self endon("colors_over");
    self fadeOverTime(time);
    self.color = colour;
}

function GetColoursSlider(Bool)
{
    return (IsDefined(Bool) ? "|Red|Green|Blue|Yellow|Cyan|Orange|Purple|White" : "Black|Red|Green|Blue|Yellow|Cyan|Orange|Purple|White");
}

function getName()
{
    return self.name;
}

function round(val)
{
    val = val + "";
    new_val = "";
    for(e=0;e<val.size;e++)
    {
        new_val += val[e];
        if(val[e-1] == "." && e > 1)
            return new_val;
    }
    return val;
}

function ArrayRandomize(array)
{
    for(i=0;i<array.size;i++)
    {
        j    = RandomInt(array.size);
        temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }
    return array;
}

function bool(variable)
{
    return isdefined(variable) && int(variable);
}

function GetFloatString(String)
{
  setDvar("Temp", String);
  return GetDvarFloat("Temp");
}

function doRainbow(Fade)
{
    if(self.shader == "gradient_fadein")
    {
        if(IsDefined(Fade))
            self fadeToColor(level.GradRain, .5);
        else
            self.color = level.GradRain;
    }
    else
    {
        if(IsDefined(Fade))
            self fadeToColor(level.NonGradRain, .5);
        else
            self.color = level.NonGradRain;
    }
    
    wait .1;
    
    self endon("StopRainbow");
    while(IsDefined(self))
    {
        if(self.shader == "gradient_fadein")
            wait 1.3;
            
        self thread fadeToColor(level.rainbowColour, 1);
        wait 1;
    }
}

function RainbowChecks()
{
    while(true)
    {
        level.GradRain = level.rainbowColour;
        wait 1.3;
        level.NonGradRain = level.rainbowColour;
        wait 1;
    }
}

function RainbowColor()
{
    rainbow = spawnStruct();
    rainbow.r = 255;
    rainbow.g = 0;
    rainbow.b = 0;
    rainbow.stage = 0;
    time = 5;
    level.rainbowColour = (0, 0, 0);
    thread RainbowChecks();
    for(;;)
    {
        if(rainbow.stage == 0)
        {
            rainbow.b += time;
            if(rainbow.b == 255)
                rainbow.stage = 1;
        }
        else if(rainbow.stage == 1)
        {
            rainbow.r -= time;
            if(rainbow.r == 0)
                rainbow.stage = 2;
        }
        else if(rainbow.stage == 2)
        {
            rainbow.g += time;
            if(rainbow.g == 255)
                rainbow.stage = 3;
        }
        else if(rainbow.stage == 3)
        {
            rainbow.b -= time;
            if(rainbow.b == 0)
                rainbow.stage = 4;
        }
        else if(rainbow.stage == 4)
        {
            rainbow.r += time;
            if(rainbow.r == 255)
                rainbow.stage = 5;
        }
        else if(rainbow.stage == 5)
        {
            rainbow.g -= time;
            if(rainbow.g == 0)
                rainbow.stage = 0;
        }
        level.rainbowColour = (rainbow.r / 255, rainbow.g / 255, rainbow.b / 255);
        wait .05;
    }
}

function destroyAll(array)
{
    if(!isDefined(array))
        return;
    keys = getArrayKeys(array);
    for(a=0;a<keys.size;a++)
    if(isDefined(array[keys[a]][0]))
        for(e=0;e<array[keys[a]].size;e++)
            array[keys[a]][e] destroy();
    else
        array[keys[a]] destroy();
}

function IsInArray(array, element)
{
   if(!isdefined(element))
        return false;
        
   foreach(e in array)
        if(e == element)
            return true;
}
//---------------------------------------------------------
function _init_menu_setup(access, player, allaccess)
{
    
    if(access == player.access && !IsDefined(player.isHost) && isDefined(player.access))
        return;
        
    if(isDefined(player.access) && player.access == 5)
        return; 
        
    player notify("end_menu");
    
    if(bool(player.menu["isOpen"]))
        player menuClose();
        
    player.menu         = [];
    player.previousMenu = [];
    player.PlayerHuds   = [];
    player.menu["isOpen"] = false;
    
    if(!isDefined(player.menu["current"]))
        player.menu["current"] = "main";
        
    player.access = access;
    
    if(player.access != 0)
    {
        player thread menuMonitor();
        player menuOptions();
        player.menuSetting["HUDEdit"] = true;
        player thread MenuLoad();
    }
}

function AllPlayersAccess(access)
{
    foreach(player in level.players)
    {
        if(player IsHost() || player == self)
            continue;
            
        self thread _init_menu_setup(access, player, true);
        
        wait .1;
    }
}

//-----------------------------------------------------------------------------------------------------------
function drawMenu()
{  self EraseMenu();
    numOpts = ((self.eMenu.size >= 8) ? 8 : self.eMenu.size);
    if(!isDefined(self.menu["UI"]))
        self.menu["UI"] = [];
        
    self.menu["UI"]["OPT_BG"] = self Icon(mBG_SHADER, -10 + mHUD_X_OFF, 10 + mHUD_Y_OFF, 200, 300, mBG_COLOR, mBG_ALPHA, 0, "TOP_RIGHT", "TOP_RIGHT");
    // self.menu["UI"]["OPT_BG"] affectElement("alpha", .2, .6);
    
   // self.menu["UI"]["BGTitle"] = self createRectangle("TOPLEFT", "TOP", -425, 90, 170, 30, self.menuSetting["BannerNoneRainbow"], "white", 1, 0, true);
   // self.menu["UI"]["BGTitle"] affectElement("alpha",.2,.6);
    
   // self.menu["UI"]["BGTitle_Grad"] = self createRectangle("TOPLEFT", "TOP", -425, 90, 170, 30, self.menuSetting["BannerGradRainbow"], "white", 3, 0, true);
   // self.menu["UI"]["BGTitle_Grad"] affectElement("alpha", .2, .6);
    
   // self.menu["UI"]["CUR_TITLE"] = self createRectangle("LEFT", "CENTER", -425, -112, 170, 15, (0, 0, 0), "white", 4, 0, true);
   // self.menu["UI"]["CUR_TITLE"] affectElement("alpha",.2, 1);
    cursor     = self GetCursor();
	for(e=0;e<10;e++)
    {
    cursOpt       = self.menu["OPT"][e][int(min(cursor, mTEXT_MAXOPTIONS - 1))];
	}
	self.menu["UI"]["SCROLL"] = self Icon(mSLIDE_SHADER,-110 + mHUD_X_OFF, 10 + mHUD_Y_OFF, 190, 20, inversecolor(mSLIDE_COLOR), 0, 1, "CENTER", "TOP_RIGHT");
								
    self.menu["UI"]["SCROLL"] affectElement("alpha", .2, .1);

    self.mframe = [];

	top = self Icon("white", -2, 0, 2, 2, inversecolor(mSLIDE_COLOR), mSLIDE_ALPHA, 1, "TOP_RIGHT", "TOP_RIGHT");
    top hud::SetParent(self.menu["UI"]["OPT_BG"]);
    top ScaleOverTime(mSCROLL_DELAY, 196, 2);
    top FadeOverTime(mSCROLL_DELAY);
    top.color = mSLIDE_COLOR;
    self.mframe["top"] = top;
    
    bottom = self Icon("white", 2, 0, 2, 2, inversecolor(mSLIDE_COLOR), mSLIDE_ALPHA, 1, "BOTTOM_LEFT", "BOTTOM_LEFT");
    bottom hud::SetParent(self.menu["UI"]["OPT_BG"]);
    bottom ScaleOverTime(mSCROLL_DELAY, 196, 2);
    bottom FadeOverTime(mSCROLL_DELAY);
    bottom.color = mSLIDE_COLOR;
    self.mframe["bottom"] = bottom;
    
    left = self Icon("white", 0, 0, 2, 2, inversecolor(mSLIDE_COLOR), mSLIDE_ALPHA, 1, "TOP_LEFT", "TOP_LEFT");
    left hud::SetParent(self.menu["UI"]["OPT_BG"]);
    left ScaleOverTime(mSCROLL_DELAY, 2, 300);
    left FadeOverTime(mSCROLL_DELAY);
    left.color = mSLIDE_COLOR;
    self.mframe["left"] = left;
    
    right = self Icon("white", 0, 0, 2, 2, inversecolor(mSLIDE_COLOR), mSLIDE_ALPHA, 1, "BOTTOM_RIGHT", "BOTTOM_RIGHT");
    right hud::SetParent(self.menu["UI"]["OPT_BG"]);
    right ScaleOverTime(mSCROLL_DELAY, 2, 300);
    right FadeOverTime(mSCROLL_DELAY);
    right.color = mSLIDE_COLOR;
    self.mframe["right"] = right;


}


function drawText(animStyle = mANIM_NONE) // leave as is for rn since it breaks the whole thing
{
    numOpts = ((self.eMenu.size >= 8) ? 8 : self.eMenu.size);
    if(!isDefined(self.menu["OPT"]))
        self.menu["OPT"] = [];
    if(!IsDefined(self.menu["OPT"]["OPTScroll"]))
        self.menu["OPT"]["OPTScroll"] = [];
        
        self.menu["OPT"]["SUB_TITLE"] = self  Text(getCurrentMenu(), -110 + mHUD_X_OFF, 30 + mHUD_Y_OFF, "default", 2.0, mTEXT_COLOR, mTEXT_ALPHA, 1, "CENTER", "TOP_RIGHT");
    	self.menu["OPT"]["SUB_TITLE"] affectElement("alpha",.4,1);
		self.menu["OPT"]["SUB_TITLE"] AnimateMenuText(animStyle);
    
    
    for(e=0;e<8;e++)
    {
        self.menu["OPT"][e] = self Text("OPT", -110 + mHUD_X_OFF, 60 + (e * 25) + mHUD_Y_OFF, "default", 1.5, mTEXT_COLOR, mTEXT_ALPHA, 2, "CENTER", "TOP_RIGHT");
		self.menu["OPT"][e] AnimateMenuText(animStyle);
        self.menu["OPT"][e] affectElement("alpha",.4, 1);
    }
    self setMenuText();
}

function setMenuText()
{
    ary = (self getCursor() >= 8 ? self getCursor()-7 : 0);
    for(e=0;e<8;e++)
    {
        if(IsDefined(self.menu["OPT"]["OPTScroll"][e]))
            self.menu["OPT"]["OPTScroll"][e] destroy();
        
        if(isDefined(self.menu["OPT"][e]))
        {
            self.menu["OPT"][e].color = ((isDefined(self.eMenu[ary + e].toggle) && self.eMenu[ary + e].toggle) ? (1, 1, 1) : (1, 0, 0));
            self.menu["OPT"][e] setText(self.eMenu[ary + e].opt);
        }
   
        if(IsDefined(self.eMenu[ary + e].val))
            self.menu["OPT"]["OPTScroll"][e] = self createText("default", 1, "RIGHT", "TOP", -260, 142 + e*15, 5, 1, "" + ((!isDefined(self.sliders[self getCurrentMenu() + "_" + (ary + e)])) ? self.eMenu[ary + e].val : self.sliders[self getCurrentMenu() + "_" + (ary + e)]), (1, 1, 1), true);
        
        if(IsDefined(self.eMenu[ary + e].optSlide))
            self.menu["OPT"]["OPTScroll"][e] = self createText("default", 1, "RIGHT", "TOP", -260, 142 + e*15, 5, 1, ((!isDefined(self.Optsliders[self getCurrentMenu() + "_" + (ary + e)])) ? self.eMenu[ary + e].optSlide[0] + " [" + 1 + "/" + self.eMenu[ary + e].optSlide.size + "]" : self.eMenu[ary + e].optSlide[self.Optsliders[self getCurrentMenu() + "_" + (ary + e)]] + " [" + ((self.Optsliders[self getCurrentMenu() + "_" + (ary + e)])+1) + "/" + self.eMenu[ary + e].optSlide.size + "]"), (1, 1, 1), true);
    }
	
}


function refreshTitle()
{
    self.menu["OPT"]["SUB_TITLE"] setText(self.menuTitle);
}

function refreshOPTSize()
{
    self.menu["OPT"]["OPTSize"] setText(self getCursor() + 1 + "/" + self.eMenu.size);
}
//---------------------------------------------------------------------------------------------------------------

function MenuLoad(Val)
{  
    if(!isdefined(self.menuSetting))
        self.menuSetting = [];
        
        MenuDefaults = strTok("0;1;0;0;0;0;1;0;0;0;0;0;0;0;0;0;0;0;0;0;0;0",";");
    
    if(!IsDefined(Val) || IsDefined(Val) && Val == 0)
    {
        
        if(GetDvarString(self getName() + "MenuDesign").size > 0)
        {
            dvar         = GetDvarString(self getName() + "MenuDesign"); 
            MenuDefaults = strTok(dvar, ";");
        }
    }
    
    self.menuSetting["MenuFreeze"] = GetMenuBool(MenuDefaults[0]);
    self.menuSetting["MenuGodmode"] = GetMenuBool(MenuDefaults[20]);
    self.menuSetting["MenuStealth"] = GetMenuBool(MenuDefaults[1]);
    self.menuSetting["ShowClientINFO"] = GetMenuBool(MenuDefaults[21]);
    
    self.menuSetting["ScrollerGradColor0"] = int(MenuDefaults[6]);
    self.menuSetting["ScrollerGradColor1"] = int(MenuDefaults[7]);
    self.menuSetting["ScrollerGradColor2"] = int(MenuDefaults[8]);
    
    self.menuSetting["BackgroundGradColor0"] = int(MenuDefaults[9]);
    self.menuSetting["BackgroundGradColor1"] = int(MenuDefaults[10]);
    self.menuSetting["BackgroundGradColor2"] = int(MenuDefaults[11]);
    
    self.menuSetting["BannerNoneColor0"] = int(MenuDefaults[12]);
    self.menuSetting["BannerNoneColor1"] = int(MenuDefaults[13]);
    self.menuSetting["BannerNoneColor2"] = int(MenuDefaults[14]);
    
    self.menuSetting["BannerGradColor0"] = int(MenuDefaults[15]);
    self.menuSetting["BannerGradColor1"] = int(MenuDefaults[16]);
    self.menuSetting["BannerGradColor2"] = int(MenuDefaults[17]);
    
    self.menuSetting["BannerGradRainbow"] = (MenuDefaults[2] == "1" ? "rainbow" : (GetFloatString(MenuDefaults[15]), GetFloatString(MenuDefaults[16]), GetFloatString(MenuDefaults[17])));
    self.menuSetting["ScrollerGradRainbow"] = (MenuDefaults[3] == "1" ? "rainbow" : (GetFloatString(MenuDefaults[6]), GetFloatString(MenuDefaults[7]), GetFloatString(MenuDefaults[8])));
    self.menuSetting["BackgroundGradRainbow"] = (MenuDefaults[4] == "1" ? "rainbow" : (GetFloatString(MenuDefaults[9]), GetFloatString(MenuDefaults[10]), GetFloatString(MenuDefaults[11])));
    self.menuSetting["BannerNoneRainbow"] = (MenuDefaults[5] == "1" ? "rainbow" : (GetFloatString(MenuDefaults[12]), GetFloatString(MenuDefaults[13]), GetFloatString(MenuDefaults[14])));
    
    self.menuSetting["MenuX"] = int(MenuDefaults[18]);
    self.menuSetting["MenuY"] = int(MenuDefaults[19]);
    
    if(IsDefined(Val) && Val == 1 || IsDefined(Val) && Val == 0)
    {
        self menuClose();
        waittillframeend;
        self menuOpen();
    }
}

function GetMenuBool(String)
{
    return (String == "1" ? true : false);
}

function SetMenuBool(variable)
{
    return (isdefined(variable) && int(variable) ? "1" : "0");
}


function MenuStealth()
{
    self.menuSetting["MenuStealth"] = !bool(self.menuSetting["MenuStealth"]);
}

function MenuGodmode()
{
    self.menuSetting["MenuGodmode"] = !bool(self.menuSetting["MenuGodmode"]);
}

function ShowClientINFO()
{
    self.menuSetting["ShowClientINFO"] = !bool(self.menuSetting["ShowClientINFO"]);
}






//-----------------------------------------------------------------------------------------------------------

function menuMonitor()
{
    self endon("disconnect");
    self endon("end_menu");
    while(self.access != 0)
    {
        if(!self.menu["isOpen"])
        {
            if(self meleeButtonPressed() && self adsButtonPressed())
            {
                self menuOpen();
                wait .2;
            }
        }
        else
        {
            if((self attackButtonPressed() || self adsButtonPressed()))
            {
                CurrentCurs = self getCurrentMenu() + "_cursor";

                self.menu[CurrentCurs]+= self attackButtonPressed();
                self.menu[CurrentCurs]-= self adsButtonPressed();
                
                self scrollingSystem();
                self PlayLocalSound("mouse_over");
                wait .2;
            }
            
            if(self ActionSlotThreeButtonPressed() || self ActionSlotFourButtonPressed())
            {
                Menu = self.eMenu[self getCursor()];
                if(self ActionSlotFourButtonPressed())
                {
                    if(IsDefined(Menu.optSlide))
                    {
                        self updateOptSlider("L2");
                        Func = self.Optsliders;
                    }
                    else if(IsDefined(Menu.val))
                    {
                        self updateSlider("L2");
                        Func = self.sliders;
                    }
                }
                if(self ActionSlotThreeButtonPressed())
                {
                    if(IsDefined(Menu.optSlide))
                    {
                        self updateOptSlider("R2");
                        Func = self.Optsliders;
                    }
                    else if(IsDefined(Menu.val))
                    {
                        self updateSlider("R2");
                        Func = self.sliders;
                    }
                }
                
                if(IsDefined(Menu.autofunc))
                    self thread doOption(Menu.func, Func[self getCurrentMenu() + "_" + self getCursor()], Menu.p1, Menu.p2, Menu.p3);
                    
                if(IsDefined(Menu.toggle))
                    self UpdateCurrentMenu();
                  
                wait .12;
            }
            
            if(self useButtonPressed())
            {
                Menu = self.eMenu[self getCursor()];
                self PlayLocalSound("mouse_over");
                
                if(IsDefined(self.sliders[self getCurrentMenu() + "_" + self getCursor()]))
                    self thread doOption(Menu.func, self.sliders[self getCurrentMenu() + "_" + self getCursor()], Menu.p1, Menu.p2, Menu.p3);
                    
                else if(IsDefined(self.Optsliders[self getCurrentMenu() + "_" + self getCursor()]))
                    self thread doOption(Menu.func, self.Optsliders[self getCurrentMenu() + "_" + self getCursor()], Menu.p1, Menu.p2, Menu.p3);
                    
                else
                    self thread doOption(Menu.func, Menu.p1, Menu.p2, Menu.p3, Menu.p4, Menu.p5, Menu.p6);
                    
                if(IsDefined(Menu.toggle))
                    self UpdateCurrentMenu();
                    
                wait .2;
            }
            
            if(self meleeButtonPressed())
            {
                if(self getCurrentMenu() == "main")
                    self menuClose();
                else
                    self newMenu();
                    
                wait .2;
            }
        }
        wait .05;
    }
}

function doOption(func, p1, p2, p3, p4, p5, p6)
{
    if(!isdefined(func))
        return;
    if(isdefined(p6))
        self thread [[func]](p1,p2,p3,p4,p5,p6);
    else if(isdefined(p5))
        self thread [[func]](p1,p2,p3,p4,p5);
    else if(isdefined(p4))
        self thread [[func]](p1,p2,p3,p4);
    else if(isdefined(p3))
        self thread [[func]](p1,p2,p3);
    else if(isdefined(p2))
        self thread [[func]](p1,p2);
    else if(isdefined(p1))
        self thread [[func]](p1);
    else
        self thread [[func]]();
}

function scrollingSystem()
{
    menu = self getCurrentMenu() + "_cursor";
    curs = self getCursor();
    if(curs >= self.eMenu.size || curs <0 || curs == 7 || curs >= 8)
    {
        if(curs <= 0)
            self.menu[menu] = self.eMenu.size -1;
            
        if(curs >= self.eMenu.size)
            self.menu[menu] = 0;
            
        self setMenuText();
    }
    self updateScrollbar();
    self refreshOPTSize();
}

function updateScrollbar()
{
    curs = ((self getCursor() >= 8) ? 7 : self getCursor());
    self.menu["UI"]["SCROLL"].y = (self.menu["OPT"][0].y + (curs*25));
        
    if(IsDefined(self.eMenu[self getCursor()].val))
        self updateSlider();
        
    if(IsDefined(self.eMenu[self getCursor()].optSlide))
        self updateOptSlider();
    if(self getCurrentMenu() == "Clients")
        self.SavePInfo = level.players[self getCursor()];
}

function newMenu(menu, Access)
{
    if(IsDefined(Access) && self.access < Access)
        return;
        
    if(!isDefined(menu))
    {
        menu = self.previousMenu[self.previousMenu.size-1];
        self.previousMenu[self.previousMenu.size-1] = undefined;
    }
    else
        self.previousMenu[self.previousMenu.size] = self getCurrentMenu();
        
    self setCurrentMenu(menu);    
    self menuOptions();
    self setMenuText();
    self refreshTitle();
        
    self refreshOPTSize();
    self updateScrollbar();
}

function addMenu(menu, title)
{
    self.storeMenu = menu;
    if(self getCurrentMenu() != menu)
        return;
    self.eMenu     = [];
    self.menuTitle = title;
    if(!isDefined(self.menu[menu + "_cursor"]))
        self.menu[menu + "_cursor"] = 0;
}

function addOpt(opt, func, p1, p2, p3, p4, p5, p6)
{
    if(self.storeMenu != self getCurrentMenu())
        return;
    option      = spawnStruct();
    option.opt  = opt;
    option.func = func;
    option.p1   = p1;
    option.p2   = p2;
    option.p3   = p3;
    option.p4   = p4;
    option.p5   = p5;
    option.p6   = p6;
    self.eMenu[self.eMenu.size] = option;
}

function addToggleOpt(opt, func, toggle, p1, p2, p3, p4, p5, p6)
{
    if(self.storeMenu != self getCurrentMenu())
        return;
    if(!IsDefined(toggle))
        toggle = false;
    toggleOpt        = spawnStruct();
    toggleOpt.opt    = opt;
    toggleOpt.func   = func;
    toggleOpt.toggle = (IsDefined(toggle) && toggle);
    toggleOpt.p1     = p1;
    toggleOpt.p2     = p2;
    toggleOpt.p3     = p3;
    toggleOpt.p4     = p4;
    toggleOpt.p5     = p5;
    toggleOpt.p6     = p6;
    self.eMenu[self.eMenu.size] = toggleOpt;
}

function addSlider(opt, val, min, max, inc, func, toggle, autofunc, p1, p2, p3)
{
    if(self.storeMenu != self getCurrentMenu())
        return;
    if(!IsDefined(toggle))
        toggle = false;
    slider          = SpawnStruct();
    slider.opt      = opt;
    slider.val      = val;
    slider.min      = min;
    slider.max      = max;
    slider.inc      = inc;
    slider.func     = func;
    slider.toggle   = (IsDefined(toggle) && toggle);
    slider.autofunc = autofunc;
    slider.p1       = p1;
    slider.p2       = p2;
    slider.p3       = p3;
    self.eMenu[self.eMenu.size] = slider;
}

function addOptSlider(opt, strTok, func, toggle, autofunc, p1, p2, p3)
{
    if(self.storeMenu != self getCurrentMenu())
        return;
    if(!IsDefined(toggle))
        toggle = false;
    Optslider          = SpawnStruct();
    Optslider.opt      = opt;
    Optslider.optSlide = strTok(strTok, "|");
    Optslider.func     = func;
    Optslider.toggle   = (IsDefined(toggle) && toggle);
    Optslider.autofunc = autofunc;
    Optslider.p1       = p1;
    Optslider.p2       = p2;
    Optslider.p3       = p3;
    self.eMenu[self.eMenu.size] = Optslider;
}

function updateSlider(pressed) 
{
    Menu = self.eMenu[self getCursor()];
    if(!IsDefined(self.sliders[self getCurrentMenu() + "_" + self getCursor()]))
        self.sliders[self getCurrentMenu() + "_" + self getCursor()] = self.eMenu[self getCursor()].val;
        
    curs = self.sliders[self getCurrentMenu() + "_" + self getCursor()];
    if(pressed == "R2")
        curs += Menu.inc;
    if(pressed == "L2")
        curs -= Menu.inc;
    if(curs > Menu.max)
        curs = Menu.min;
    if(curs < Menu.min)
        curs = Menu.max;
    
    
    cur = ((self getCursor() >= 8) ? 7 : self getCursor());
    if(curs != Menu.val)
        self.menu["OPT"]["OPTScroll"][cur] setText("" + curs);
    self.sliders[self getCurrentMenu() + "_" + self getCursor()] = curs;
}

function updateOptSlider(pressed)
{
    Menu = self.eMenu[self getCursor()];
    
    if(!IsDefined(self.Optsliders[self getCurrentMenu() + "_" + self getCursor()]))
        self.Optsliders[self getCurrentMenu() + "_" + self getCursor()] = 0;
        
    curs = self.Optsliders[self getCurrentMenu() + "_" + self getCursor()];
    
    if(pressed == "R2")
        curs ++;
    if(pressed == "L2")
        curs --;               
    if(curs > Menu.optSlide.size-1)
        curs = 0;
    if(curs < 0)
        curs = Menu.optSlide.size-1;

    cur = ((self getCursor() >= 8) ? 7 : self getCursor());
    self.menu["OPT"]["OPTScroll"][cur] setText(Menu.optSlide[curs] + " [" + (curs+1) + "/" + Menu.optSlide.size + "]");
    self.Optsliders[self getCurrentMenu() + "_" + self getCursor()] = curs;
}

function setCurrentMenu(menu)
{
    self.menu["current"] = menu;
}

function getCurrentMenu()
{
    return self.menu["current"];
}

function getCursor()
{
    return self.menu[self getCurrentMenu()+ "_cursor"];
}

function hasMenu()
{
    return (isDefined(self.access) && self.access != 0 ? true : false);
}

function UpdateCurrentMenu()
{
    self setCurrentMenu(self getCurrentMenu());
    self menuOptions();
    self setMenuText();
    self updateScrollbar();
    self refreshOPTSize();
}

function menuOpen()
{
    ary = (self getCursor() >= 8 ? self getCursor()-7 : 0);
    self.menu["isOpen"] = true;
    if(bool(self.menuSetting["MenuFreeze"]))
        self FreezeControls(true);
    self menuOptions();
    self drawText();
    self drawMenu();
    self updateScrollbar();
    for(e=0;e<8;e++)
    {
        if(IsDefined(self.eMenu[ary + e].val) || IsDefined(self.eMenu[ary + e].optSlide))
        {
            self.menu["OPT"]["OPTScroll"][e].alpha = 0;
            self.menu["OPT"]["OPTScroll"][e] affectElement("alpha", .4, 1);
        }
    }
}

function menuClose()
{
    self.menu["isOpen"] = false;
    if(bool(self.menuSetting["MenuFreeze"]))
        self FreezeControls(false);
    self destroyAll(self.menu["UI"]);
    self destroyAll(self.menu["OPT"]);
    self destroyAll(self.menu["OPT"]["OPTScroll"]);
	self EraseMenu();
}

function onPlayerDisconnect(player)
{
    self notify("StopPMonitor");
    self endon("StopPMonitor");
    self endon("end_menu");
    self endon("disconnect");
    player waittill("disconnect");
    while(self getCurrentMenu() != "Clients")
        self newMenu();
    self setcursor(0);
    self UpdateCurrentMenu();
}

function setcursor(value, menu = self getCurrentMenu())
{
    self.menu[menu + "_cursor"] = value;
}

function EraseMenu()
{   
    foreach(elem in self.mframe)
        elem destroy();
}

//-------------------------------------------------------------------------------------

function menuOptions(player)
{
  
    players = GetPlayers();
    perk_keys = getPerks();
    powerups = getArrayKeys(level.zombie_powerups);
    menu = self getCurrentMenu();

   
    

    switch(self getCurrentMenu())
    {
          case "main":
            self addMenu("main", "Main Menu");
            self addOpt("Basic Options", &newMenu, "BasicOpts");
            self addOpt("Weapon Options", &newMenu, "weapOpts"); 
            self addOpt("Perks", &newMenu, "Perks");
            self addOpt("Points", &newMenu, "Points");
            self addOpt("Set Round", &newMenu, "setRound");
            self addOpt("Drops Menu", &newMenu, "drops"); 
            self addOpt("Debug", &newMenu, "Debug");
            break;

          case "BasicOpts":
            self addMenu("BasicOpts", "Basic Options");
            self addToggleOpt("Godmode", &Godmode, self.godmode);
            self addToggleOpt("Unlimited Ammo", &unlimited_ammo, self.unlimited_ammo);
            self addToggleOpt("No Target", &notarget, self.no_target);
            break;

        case "Perks":
        {
            self addmenu( "Perks", "Perks" );
            self addOpt( "Give All Perks", &setAllPerks );
            self addToggleOpt("Retain Perks", &retain_perks);
            
            for(e=0;e<perk_keys.size;e++)
            {
                Perk_name = perk_keys[e];
                self addOpt( getPerkName( Perk_name ), &GivePerk, Perk_name );
            }
        }

        case "Points":
            self addMenu("Points", "Edit Points");
            self addOpt("Give 10000 Points", &Points, 10000);
            self addOpt("Give 100000 Points", &Points, 100000);
            self addOpt("Give 1000000 Points", &Points, 1000000);
            self addOpt("Give Max Points", &Points, 10000000);
            self addOpt("Take Max Points", &Points, -10000000);
            self addOpt("Take 1000000 Points", &Points, -1000000);
            self addOpt("Take 100000 Points", &Points, -100000);
            self addOpt("Take 10000 Points", &Points, -10000);
        break;

        case "weapOpts":
            self addMenu("weapOpts", "Weapon Options");
            self addOpt("Give Weapons", &newMenu,"giveWeaps");
            self addOpt("Pack A Punch Weapon", &pap_action, self, self GetCurrentWeapon());
            self addOpt("AAT Menu", &newMenu, "aat");
            break;

        case "giveWeaps":   
            self addMenu( "giveWeaps", "Weapons");
            for(e=0;e<level.weapon_categories.size;e++)
            self addOpt( level.weapon_categories[e], &newMenu, level.weapon_categories[e] );
            break;

        case "aat":
            self addMenu("aat", "AAT Menu");
            self addOpt("Dead Wire", &acquireaat, "zm_aat_dead_wire");
            self addOpt("Turned", &acquireaat, "zm_aat_turned");
            self addOpt("Fire Works", &acquireaat, "zm_aat_fire_works");
            self addOpt("Blast Furnace", &acquireaat, "zm_aat_blast_furnace");
            self addOpt("Thunder Wall", &acquireaat, "zm_aat_thunder_wall");
            break;
            
        case "setRound":
            self addMenu("setRound", "Set Round");
            self addOpt("Set Round", &func_roundsystem,true);
            self addopt("End Current Round", &end_current_round);
            self addOpt("Current Round + 1", &func_roundset, 1);
            self addOpt("Current Round + 5", &func_roundset, 5);
            self addOpt("Current Round + 10", &func_roundset, 10);
            self addOpt("Current Round + 100", &func_roundset, 100);
            self addOpt("Current Round - 100", &func_roundset, -100);
            self addOpt("Current Round - 10", &func_roundset, -10);
            self addOpt("Current Round - 5", &func_roundset, -5);
            self addOpt("Current Round - 1", &func_roundset, -1);
            break;

            case "drops":
                self addMenu("drops", "Drops Menu");
                self addOpt("Give Drops", &newMenu, "givedrops");
                self addOpt("Reset Cycle", &reset_cycle);
                break;

            case "givedrops":
                self addMenu("givedrops", "Give Drops");
                for(e=0;e<powerups.size;e++)
                {
                    self addOpt( powerups[e], &givePowerup, powerups[e] );
                }
                break;

            case "Debug":
                self addMenu("Debug", "Debug");
                self addToggleOpt("Disable Bosses", &disable_boss, undefined, undefined, level.var_613458e1);
                self addOpt("Fast Restart", &fastrestart);
                self addOpt("Map Restart", &maprestart);
                break;

          
    }

    /* WEAPONS */
    for(e=0;e<level.weapon_categories.size;e++)
    {
        if(menu != level.weapon_categories[e])
            continue;
        
        self addmenu(menu, level.weapon_categories[e]);
        foreach(weap in level.weapons[e])
        {
             self addOpt( weap.name, &giveWeap, weap.id ); 
        }
        if( menu == "Extras" )
        {
			extras = [];
            extras[0]  = "zombie_beast_grapple_dwr";
			extras[1] = "defaultweapon";
			extras[2] = "minigun";
			extras[3] = "tesla_gun";
			strings = [];
            strings[0] = "Beast Hands"; 
			strings[1] = "Default Weapon";
            foreach(index, extra in extras)
            {
                if( MakeLocalizedString( getWeapon( extra ).displayname ) != "" )
                {
                    if(index < 2) string = strings[index];
                    else string = MakeLocalizedString( getWeapon( extra ).displayname );

                     self addOpt( string, &giveWeap, getWeapon( extra ).name );
                }
            }
        }
    }  


}

//---------------------------------------------------------------------------------

function giveweap(Weapon_Name)
{
    self iPrintLnBold("Weapon Given");
    Weapon5 = self GetCurrentWeapon();
    self TakeWeapon(Weapon5);
    Weapon4 = GetWeapon(Weapon_Name);
    self zm_weapons::weapon_give(Weapon4);
    self SwitchToWeapon(Weapon4);
}

function pap_action(player, weapon)
{
    
    player TakeWeapon(weapon);
    
    player zm_weapons::weapon_give( player zm_weapons::get_upgrade_weapon(weapon, zm_weapons::weapon_supports_aat(weapon) ) );
    player SwitchToWeapon( player zm_weapons::get_upgrade_weapon(weapon, zm_weapons::weapon_supports_aat(weapon) ) );
    Player iPrintLnBold("Weapon ^2UPGRADED");
}

function acquireaat( id ) 
{
    self.acquireaat = id;
    self thread aat::acquire(self getCurrentWeapon(), id);
}


function func_roundsystem(set)
{
    round_number = level.round_num;

    if(!isdefined(round_number))
        round_number = zm::get_round_number();
    if(round_number == zm::get_round_number())
        return;
    if(round_number < 0)
        return;

    // kill_round by default only exists in debug mode
    /#
    level notify("kill_round");
    #/
    // level notify("restart_round");
    level notify("end_of_round");
    level.zombie_total = 0;
    zm::set_round_number(round_number);
    round_number = zm::get_round_number(); // get the clamped round number (max 255)

    zombie_utility::ai_calculate_health(round_number);
    SetRoundsPlayed(round_number);

    foreach(zombie in zombie_utility::get_round_enemy_array())
    {
        zombie Kill();
    }

    if(level.gamedifficulty == 0)
        level.zombie_move_speed = round_number * level.zombie_vars["zombie_move_speed_multiplier_easy"];
    else
        level.zombie_move_speed = round_number * level.zombie_vars["zombie_move_speed_multiplier"];

    level.zombie_vars["zombie_spawn_delay"] = [[level.func_get_zombie_spawn_delay]](round_number);

    level.sndGotoRoundOccurred = true;
    level waittill("between_round_over");
    self iPrintLnBold(round_number);
}

function func_roundset(value)
{
    level.round_num += value;

    if(level.round_num > 255)
    {
        level.round_num = 255;
    }
        if(level.round_num < 1)
    {
        level.round_num = 1;
    }
    
}

function end_current_round()
{

        level notify("restart_round");
        zombies = getAIArray();

        if(isdefined(zombies))
        {
            for(i = 0; i < zombies.size; i++)
                zombies[i] DoDamage(zombies[i].health + 1, zombies[i].origin);
        }

}

function getPerks()
{
    return getArrayKeys(level._custom_perks);
}

function getPerkName( perk, alt )
{
    perkID = [];
	prekID[0] = "fastreload";
	perkID[1] = "quickrevive";
	perkID[2] = "armorvest";
	perkID[3] = "additionalprimaryweapon";
	perkID[4] = "doubletap2";
	perkID[5] = "widowswine";
	perkID[6] = "staminup";
	perkID[7] = "deadshot";
    perkName = [];
	perkName[0] = "Speed Cola";
	perkName[1] = "Quick Revive";
	perkName[2] = "Jugger-Nog";
	perkName[3] = "Mule Kick";
	perkName[4] = "Double Tap Root Beer"; 
	perkName[5] = "Widow's Wine";
	perkName[6] = "Stamin-Up";
	perkName[7] = "Deadshot Daiquiri"; 

    for(e=0;e<perkID.size;e++)
    {
        if( !isDefined( alt ) && perk == "specialty_" + perkID[e] || isDefined( alt ) && isSubStr( toLower( perkName[e] ), perk ))
            return perkName[e];
    }
    return perk;
}

function preload()
{
    
    level.weapons = [];
	level.weapon_categories = [];
	weapon_types = [];
    level.weapon_categories = array("Assault Rifles", "Submachine Guns", "Shotguns", "Light Machine Guns", "Sniper Rifles", "Pistols", "Launchers", "Extras"); 
    weapon_types = array("assault", "smg", "cqb", "lmg", "sniper", "pistol", "launcher");

    weapNames = [];
    foreach(weapon in getArrayKeys(level.zombie_weapons))
        weapNames[weapNames.size] = weapon.name;

    for(i=0;i<weapon_types.size;i++)
    {
        level.weapons[i] = []; 
        for(e=1;e<100;e++)
        {
            weapon_categ = tableLookup( "gamedata/stats/zm/zm_statstable.csv", 0, e, 2 );
            weapon_id = tableLookup( "gamedata/stats/zm/zm_statstable.csv", 0, e, 4 );

            if( weapon_categ == "weapon_" + weapon_types[i] )
            {
                if( IsInArray(weapNames, weapon_id) )
                {
                    weapon      = spawnStruct();
                    weapon.name = MakeLocalizedString( getWeapon( weapon_id ).displayname );
                    weapon.id   = weapon_id;
                    level.weapons[i][level.weapons[i].size] = weapon;
                }
            }
        }
    }
    level getMiscWeapons();
}

function getMiscWeapons()
{
    level.weapons[7] = [];
    blacklist = array("Ull's Arrow", "Kimat's Bite", "Kagutsuchi's Blood", "Boreas' Fury");
    foreach( weapon in getArrayKeys(level.zombie_weapons) )
    {
        isInArray = false;
        for(e=0;e<level.weapons.size;e++)
        {
            for(i=0;i<level.weapons[e].size;i++)
            {
                if( isDefined(level.weapons[e][i]) && level.weapons[e][i].id == weapon.name )
                {
                    isInArray = true;
                    break; // marked for later prev break 2
                }
            }
        } 
        if( !isInArray && weapon.displayname != "" ) // && !isInArray( blacklist, MakeLocalizedString( weapon.displayname ) ) )
        {
            weapons = spawnStruct();
            weapons.name = MakeLocalizedString( weapon.displayname );
            weapons.id = weapon.name;
            level.weapons[7][level.weapons[7].size] = weapons;
        }
    }
}

function givePowerup(drop)
{
	level thread zm_powerups::specific_powerup_drop(drop, self.origin);
}

function reset_cycle()
{
	level.zombie_powerup_array = Array::randomize(level.zombie_powerup_array);
	level.zombie_powerup_index = 0;
	self iPrintLnBold("Drop Cycle: ^1RESET");
}

function disable_boss()
{
	if(!isdefined(level.var_613458e1))
	{
		self iPrintLnBold("Bosses ^2Disabled");
		level.var_613458e1 = 1;
		level thread function_e6d73f50();
	}
	else
	{
		self iPrintLnBold("Bosses ^1Enabled");
		level.var_613458e1 = undefined;
		level notify("start_boss");
	}
}

function function_e6d73f50()
{
	level endon("end_game");
	level endon("start_boss");
	for(;;)
	{
		zombies = GetAITeamArray(level.zombie_team);
		for(i = 0; i < zombies.size; i++)
		{
			if(zombies[i].archetype == "margwa" || zombies[i].archetype == "mechz" || zombies[i].archetype == "thrasher" || zombies[i].archetype == "raz" || zombies[i].archetype == "astronaut" || zombies[i].animName == "napalm_zombie" || zombies[i].animName == "sonic_zombie")
			{
				zombies[i] delete();
			}
		}
		wait(0.05);
	}
}

function fastrestart()
{
	wait(0.3);
	map_restart(1);
}

function maprestart()
{
	map(level.script);
}

function Godmode()
{
    self.godmode = !bool(self.godmode);
    if(self.godmode)
    {
    self iPrintLnBold("God Mode Enabled");
        self EnableInvulnerability();
    }
    else
    {
    self iPrintLnBold("God Mode Disabled");
        self DisableInvulnerability();
    }
}

function unlimited_ammo()
{
    self.unlimited_ammo = !bool(self.unlimited_ammo);
    
    result = (self.unlimited_ammo ? "Enabled":"Disabled");
   self iPrintLnBold(" Unlimited Ammo ", result);
        
        while(self.unlimited_ammo)
        {
            self GiveMaxAmmo(self GetCurrentWeapon());
            wait 0.1; 
        
        }
}

function notarget()
{
    self.no_target = !bool(self.no_target);
   result = (self.no_target ? "Enabled":"Disabled");
   self iPrintLnBold(" No Target ", result);
}

function AllMapPerks(Perk_name)
{
    if(self hasperk( Perk_name ))
    { 
        self removePerk( Perk_name );
    }
    else
    {

        self zm_utility::give_player_all_perks();
        self iPrintLnBold("^2All Perks Given!");
    }
}

function GivePerk(Perk_Name)
{
    if(self hasperk( Perk_name ))
    {   
        
        self removePerk( Perk_name );
        self iPrintLnBold(Perk_name, "^2Perk Given!");
    }
    else
    {
        self zm_perks::give_perk(Perk_name);
    }
} 

function removePerk( perk )
{
    self notify(perk + "_stop"); 
}

function setAllPerks( clear = self hasAllPerks() )
{
    a_str_perks = getArrayKeys(level._custom_perks);
    if(clear)
    {
        for(i = 0; i < a_str_perks.size; i++)
            if(self hasPerk(a_str_perks[i]))
                self removePerk(a_str_perks[i]);
    }
    else
    {
	    self zm_utility::give_player_all_perks();
	    self LUINotifyEvent(&"zombie_bgb_notification", 1, 227);
        self iPrintLnBold("^2All Perks Given!");
    }
}

function hasAllPerks()
{
    for(e=0;e<getPerks().size;e++)
    {
        perk_id = getPerks()[e];
        if(!self hasPerk( perk_id ))
            return false;
    }
    return true;
}

function Points(Points)  
{   
    if(points >= 0)
    {
        self zm_score::add_to_player_score(points);
        self iPrintLnBold("Adjusted points by ^2" + points);
    }
    else
    {
        self zm_score::minus_to_player_score(-1 * points);
        self iPrintLnBold("Adjusted points by ^1" + points);
    }
}

function retain_perks()
{
    if(!isdefined(self._retain_perks))
	{
		self notify("hash_19d1598");
		self thread function_87ccee50();
		self._retain_perks = 1;
        self iPrintLnBold("Retain Perks Activated");
	}
	else
	{
		for(i = 0; i < self.perks_active.size; i++)
		{
			self thread zm_perks::perk_think(self.perks_active[i]);
		}
		self._retain_perks = undefined;
        self iPrintLnBold("Retain Perks Deactivated");
    }
}

function function_87ccee50()
{
	self endon("disconnect");
	self endon("death");
	self endon("hash_ebce34a1");
	level endon("end_game");
	for(;;)
	{
		self waittill("player_revived");
        self zm_perks::give_perk("specialty_quickrevive");
	}
}

function Text(string = "", x, y, font, fontScale, color, alpha, sort, align = "center", relative = "center", isLevel = false)
{
    if(isLevel)
    text = self hud::createServerFontString(font, fontScale);
    else
        text = self hud::createFontString(font, fontScale);
    
    text SetScreenPoint(align, relative, x, y);
    text SetText(string);
    
    text.color          = color;
    text.alpha          = alpha;
    text.sort           = sort;
    
    text.hideWhenInMenu = true;
    
    self.sl_hudct = integer(self.sl_hudct + 1);
    text.archived = (self.sl_hudct > SL_BEGIN_ARCHIVE);
    text thread SLHudRemove(self);

    return text;
}

function color(value)
{
    /*
        Size constraints comment:
        
        Why is this better than rgb = (r,g,b) => return (r/255, g/255, b/255)?
        
        This will emit PSC, GetInt, align(4), value, SFT, align(1 + pos, 4), 4
        rgb... emits PSC, {GetInt, align(4), value}[3], SFT, align(1 + pos, 4), 4
        Vector emits Vec, align(4), r as float, b as float, g as float 
        
        color:  Min: 14, Max: 17
        rgb:    Min: 30, Max: 33
        vector: Min: 13, Max: 16
    */

    return
    (
    (value & 0xFF0000) / 0xFF0000,
    (value & 0x00FF00) / 0x00FF00,
    (value & 0x0000FF) / 0x0000FF
    );
}

function SetScreenPoint(point, relativePoint, xOffset, yOffset, moveTime)
{
    self hud::setPoint(point, relativePoint, xOffset, yOffset, moveTime);
}

function SLHudRemove(player)
{
    player endon("disconnect");
    self waittill("death");
    
    if(!isdefined(player.sl_hudct))
        return;
    
    player.sl_hudct--;
}

function integer(variable)
{
    if(!isdefined(int(variable)))
        return 0;
        
    return int(variable);
}

function Icon(shader, x, y, width, height, color, alpha, sort, align = "center", relative = "center", isLevel = false)
{
    if(isLevel)
        icon = hud::createServerIcon(shader, width, height);
    else
        icon = self hud::createIcon(shader, width, height);
    
    icon SetScreenPoint(align, relative, x, y);
    
    icon.color          = color;
    icon.alpha          = alpha;
    icon.sort           = sort;
    
    icon.hideWhenInMenu = true;
    
    self.sl_hudct = integer(self.sl_hudct + 1);
    icon.archived = (self.sl_hudct > SL_BEGIN_ARCHIVE);
    icon thread SLHudRemove(self);
    
    return icon;
}

function AnimateMenuText(animstyle = mANIM_NONE)
{
    if(animstyle == mANIM_NONE)
        return;
        
    aScale = .25;
    fScale = 1.5;
    
    if(animstyle == mANIM_ZOOMIN)
        fScale = 1 / fScale;
        
    baseAlpha     = self.alpha;
    baseFontScale = self.baseFontScale;
    
    self.alpha     = baseAlpha * aScale;
    self.FontScale = baseFontScale * fScale;
    
    self FadeOverTime(mSCROLL_DELAY);
    self ChangeFontScaleOverTime(mSCROLL_DELAY);
    
    self.FontScale = baseFontScale;
    self.alpha     = baseAlpha;
}

function inversecolor(color)
{
    return mINVERSE_COLOR;
}