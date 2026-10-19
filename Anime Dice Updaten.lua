local _libSource = game:HttpGet("https://raw.githubusercontent.com/najzgaming/Najz-Hub-V2-/refs/heads/main/najzhublib")
local _pgCode = 'game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")'
_libSource = _libSource:gsub("local gethui = gethui or function%(%)%s*return CoreGui%s*end","local gethui = function() return " .. _pgCode .. " end")
_libSource = _libSource:gsub("return CoreGui", "return " .. _pgCode)
_libSource = _libSource:gsub("Parent = CoreGui", "Parent = " .. _pgCode)
_libSource = _libSource:gsub("SafeParentUI%(UI, CoreGui%)", "SafeParentUI(UI, " .. _pgCode .. ")")
_libSource = _libSource:gsub("local protectgui = protectgui or %(syn and syn%.protect_gui%) or function%(%) end","local protectgui = function() end")
local Library = loadstring(_libSource)()
local Players=game:GetService("Players") local RS=game:GetService("ReplicatedStorage") local WS=game:GetService("Workspace")
local VIM=game:GetService("VirtualInputManager") local UIS=game:GetService("UserInputService") local HS=game:GetService("HttpService")
local Lighting=game:GetService("Lighting") local RunService=game:GetService("RunService")
local _ActivePopup=nil local F={} local UI={} local Remotes={} local CFG={}
local Network,EntryRegistry,DataController,Dice,Upgrades,Rebirths,BuffController,Grades,Traits,QuestConfig,Towers,BoostController,Rarities,TreeStructure,RebirthStatsConfig
local HalloweenQuests,HalloweenShop,Quirks,QuirkUtil
pcall(function()Network=require(RS:WaitForChild("Packages",5):WaitForChild("Network",5))end)
pcall(function()EntryRegistry=require(RS:WaitForChild("Framework",5):WaitForChild("Features",5):WaitForChild("Inventory",5):WaitForChild("EntryRegistry",5))end)
pcall(function()DataController=require(RS:WaitForChild("Framework",5):WaitForChild("Features",5):WaitForChild("Data",5):WaitForChild("DataController",5))end)
pcall(function()Dice=require(RS:WaitForChild("Framework",5):WaitForChild("Features",5):WaitForChild("Rolling",5):WaitForChild("Dice",5))end)
pcall(function()Upgrades=require(RS:WaitForChild("Framework",5):WaitForChild("Features",5):WaitForChild("Upgrades",5):WaitForChild("Upgrades",5))end)
pcall(function()Rebirths=require(RS:WaitForChild("Framework",5):WaitForChild("Features",5):WaitForChild("Rebirth",5):WaitForChild("Rebirths",5))end)
pcall(function()BuffController=require(RS:WaitForChild("Framework",5):WaitForChild("Features",5):WaitForChild("Buffs",5):WaitForChild("BuffController",5))end)
pcall(function()Grades=require(RS:WaitForChild("Framework",5):WaitForChild("Features",5):WaitForChild("Grades",5):WaitForChild("Grades",5))end)
pcall(function()Traits=require(RS:WaitForChild("Framework",5):WaitForChild("Features",5):WaitForChild("Traits",5):WaitForChild("Traits",5))end)
pcall(function()Towers=require(RS:WaitForChild("Framework",5):WaitForChild("Features",5):WaitForChild("Towers",5):WaitForChild("Towers",5))end)
pcall(function()BoostController=require(RS:WaitForChild("Framework",5):WaitForChild("Features",5):WaitForChild("Inventory",5):WaitForChild("Kinds",5):WaitForChild("Boost",5):WaitForChild("BoostController",5))end)
pcall(function()local f=RS:FindFirstChild("Framework") if f then local fe=f:FindFirstChild("Features") if fe then local q=fe:FindFirstChild("Quests") if q then QuestConfig=require(q:FindFirstChild("QuestConfig")) end end end end)
pcall(function()local f=RS:FindFirstChild("Framework") if f then local o=f:FindFirstChild("Other") if o then local r=o:FindFirstChild("Rarities") if r then Rarities=require(r) end end end end)
pcall(function()local f=RS:FindFirstChild("Framework") if f then local fe=f:FindFirstChild("Features") if fe then local up=fe:FindFirstChild("Upgrades") if up then local ts=up:FindFirstChild("TreeStructure") if ts then TreeStructure=require(ts) end end end end end)
pcall(function()local f=RS:FindFirstChild("Framework") if f then local fe=f:FindFirstChild("Features") if fe then local rb=fe:FindFirstChild("Rebirth") if rb then local rs=rb:FindFirstChild("RebirthStatsConfig") if rs then RebirthStatsConfig=require(rs) end end end end end)
pcall(function()local f=RS:FindFirstChild("Framework") if f then local fe=f:FindFirstChild("Features") if fe then local h=fe:FindFirstChild("Halloween") if h then local q=h:FindFirstChild("HalloweenQuests") if q then HalloweenQuests=require(q) end local s=h:FindFirstChild("HalloweenShop") if s then HalloweenShop=require(s) end end local qf=fe:FindFirstChild("Quirks") if qf then local qs=qf:FindFirstChild("Quirks") if qs then Quirks=require(qs) end local qu=qf:FindFirstChild("QuirkUtil") if qu then QuirkUtil=require(qu) end end end end end)
CFG.rarityFilterOptions={}
CFG.RARITY_RANK={}
CFG.GEAR_RARITY_RANK=CFG.RARITY_RANK
CFG.POTION_TOWER_PREFIX={["Dragon"]="Dragon ",["Cursed"]="Cursed ",["Pirate"]="Pirate ",["Hidden Leaf"]="Leaf ",["Infinity"]="",["Slayer"]="Slayer ",["Shadow"]="Shadow "}
CFG.POTION_TOWER_ORDER={"Dragon","Cursed","Pirate","Hidden Leaf","Slayer","Shadow","Infinity"}
CFG.POTION_CATEGORIES={"Luck","Damage","Income","Speed"} CFG.POTION_TIERS={"I","II","III","IV"}
CFG.POTION_TOWER_CATEGORIES={["Dragon"]={"Luck","Damage","Income"},["Cursed"]={"Luck","Damage","Income"},["Pirate"]={"Luck","Damage","Income"},["Hidden Leaf"]={"Luck","Damage","Income"},["Slayer"]={"Luck","Damage","Income"},["Shadow"]={"Luck","Speed","Income"},["Infinity"]={"Luck","Damage","Income"}}
CFG.WEATHER_LIST={"Luck Event","Cash Event","Roll Speed Event","Trait Event","Grade Event","Haunted Night"}
CFG.KNOWN_CODES={"RELEASE","UPDATE1","UPDATE2","UPDATE3","UPDATE4","UPDATE5","UPDATE6","UPDATE7","1KCCU","5KCCU","10KCCU","20KCCU","30KCCU","40KCCU","100KLIKES","250KLIKES","400KLIKES","UPDATE8","jptime","Halloween"}
CFG.SPIN_TYPES={"Lucky Spin","Jackpot Spin","Pumpkin Spin","Pumpkin Jackpot","Witch's Jackpot"}
CFG.SPIN_TRIGGER_EVENTS={"(No Weather)","Luck Event","Cash Event","Roll Speed Event","Trait Event","Grade Event","Haunted Night"}
CFG.CONFIG_FOLDER="NajzHub_AnimeDice" CFG.CONFIG_FILE=CFG.CONFIG_FOLDER.."/configs.json" CFG.AUTOLOAD_FILE=CFG.CONFIG_FOLDER.."/autoload.txt"
CFG.TOWER_ACTION_WAIT={damagePlayer=0.62,damageEnemy=0.62,floorCompleted=0.24,memberDefeated=0.32,ended=0,floorStarted=0.76}
CFG.TOWER_FLOOR_STARTED_WAIT={initial=0.76,transition=0.38,repeated=0}
CFG.TOWER_CYCLE={"Dragon Tower","Cursed Tower","Pirate Tower","Hidden Leaf Tower","Slayer Tower","Shadow Tower","Infinity Tower"}
CFG.TOWER_CYCLE_NORMAL=CFG.TOWER_CYCLE
CFG.TOWER_CYCLE_HAUNTED={"Front Yard","Foyer","Crypt","Attic","Bell Tower","The Abyss"}
CFG.HAUNTED_TOWER_ORDER={"Front Yard","Foyer","Crypt","Attic","Bell Tower","The Abyss"}
CFG.PUMPKIN_DICE_COST=100
CFG.PUMPKIN_DICE_MULTI=5
CFG.CANDY_SHOP_NAMES={}
CFG.CANDY_SHOP_INDEX={}
if HalloweenShop then for i,it in ipairs(HalloweenShop) do table.insert(CFG.CANDY_SHOP_NAMES,it.name) CFG.CANDY_SHOP_INDEX[it.name]=i end end
CFG.FUSE_DELAY=4 CFG.GEAR_SLOTS={"Head","Torso","Back","Upper","Waist"}
CFG.GEAR_BUFF_OPTIONS={"Auto (Best Rarity+Total)","Luck","Money Multiplier","Damage Multiplier","Health Multiplier","Trait Luck","Grade Luck","Walkspeed"}
CFG.SUFFIX_LIST = {
    {1e87, "ocvg"},{1e84, "spvg"},{1e81, "sxvg"},{1e78, "qivg"},{1e75, "qavg"},
    {1e72, "tvg"},{1e69, "dvg"},{1e66, "uvg"},{1e63, "vg"},{1e60, "nodc"},
    {1e57, "ocdc"},{1e54, "spdc"},{1e51, "sxdc"},{1e48, "qidc"},{1e45, "qadc"},
    {1e42, "tdc"},{1e39, "ddc"},{1e36, "udc"},{1e33, "dc"},{1e30, "no"},
    {1e27, "oc"},{1e24, "sp"},{1e21, "sx"},{1e18, "qi"},{1e15, "qd"},
    {1e12, "t"},{1e9, "b"},{1e6, "m"},{1e3, "k"},
}
CFG.SUFFIX_TABLE = {}
for _, entry in ipairs(CFG.SUFFIX_LIST) do
    CFG.SUFFIX_TABLE[entry[2]] = entry[1]
end
CFG.SUFFIX_TABLE.k = 1e3
CFG.SUFFIX_TABLE.m = 1e6
CFG.SUFFIX_TABLE.b = 1e9
CFG.SUFFIX_TABLE.t = 1e12
CFG.LOADER_URL = 'loadstring(game:HttpGet("https://raw.githubusercontent.com/trompetnohbhb-maker/isnide/refs/heads/main/animedice"))()'
CFG.LOADER_FILE = "NajzHub_Loader.txt"
CFG.STATE_FILE = CFG.CONFIG_FOLDER.."/state.json"
F.buildRarityData=function()
    local rank={} local list={}
    if Rarities and type(Rarities.Refs)=="table" then
        for key,display in pairs(Rarities.Refs) do
            local so=999
            pcall(function() local info=Rarities.Get(display) if info and info.sortOrder then so=info.sortOrder end end)
            rank[display]=so rank[key]=so table.insert(list,{display=display,sort=so,key=key})
        end
    end
    if next(rank)==nil then
        local fb={"Common","Uncommon","Rare","Epic","Legendary","Mythical","Divine","Exotic","Celestial","Secret I","Secret II","Heavenly","Exclusive","Galactic"}
        for i,r in ipairs(fb) do rank[r]=i table.insert(list,{display=r,sort=i,key=r}) end
    end
    table.sort(list,function(a,b) if a.sort==b.sort then return a.display<b.display end return a.sort<b.sort end)
    local opts={} local seen={}
    for _,o in ipairs(list) do if not seen[o.display] then seen[o.display]=true table.insert(opts,o.display) end end
    CFG.rarityFilterOptions=opts CFG.RARITY_RANK=rank CFG.GEAR_RARITY_RANK=rank
    return opts
end
F.buildRarityData()
local Toggles={webhook=false,autoRoll=false,autoSell=false,autoCollect=false,autoRebirth=false,autoRebirthStats=false,autoUpgrade=false,autoLevelUp=false,autoGift=false,autoGiftUnit=false,autoGrade=false,autoTrait=false,autoClaim=false,autoBuyQuest=false,autoUsePotion=false,equipBest=false,weatherWebhook=false,autoUseSpin=false,antiAfk=true,bruteForce=false,sendPlayerData=false,autoFuse=false,fuseWebhook=true,autoBuyDice=false,autoEquipGear=false,autoFindWeather=false,autoLoadConfig=false}
Toggles.quirksAuto=false
Toggles.pumpkinDiceAuto=false
Toggles.pumpkinPassAuto=false
Toggles.candyShopAuto=false
Toggles.trickOrTreatAuto=false
local State={isDestroyed=false,isRolling=false,rollDelay=2.5,webhookUrl="",webhookCounters={},webhookRarityFilters={},webhookCounterLabel=nil,sellIncomeThreshold=0,selectedSellRarities={},sellChanceThreshold=0,sellChanceThresholdRaw="",equipBestDelay=1,equipBestLoop=nil,selectedDiceToBuy=nil,diceDropdown=nil,diceInfoLabel=nil,autoSellLoop=nil,autoCollectLoop=nil,autoRebirthLoop=nil,autoRebirthToggle=nil,autoRebirthInfoLabel=nil,autoRebirthTargetLabel=nil,autoRebirthMoneyLabel=nil,autoRebirthStatusLabel=nil,autoRebirthStatsLoop=nil,autoRebirthStatsToggle=nil,autoRebirthStatsInfoLabel=nil,autoRebirthStatsOrder={"Luck","Money","Damage","Trait Luck","Grade Luck","Health"},autoUpgradeLoop=nil,selectedLevelUpSlots={},levelUpLoop=nil,levelUpTarget=100,selectedTradePlayer=nil,tradePlayerDropdown=nil,selectedGiftItem=nil,giftItemDropdown=nil,giftItemMap={},autoGiftLoop=nil,autoGiftToggle=nil,autoGiftUnitLoop=nil,autoGiftUnitToggle=nil,giftUnitMinChance=1e12,giftUnitMaxChance=math.huge,giftUnitMaxIncome=math.huge,selectedRollUnitKeys={},rollUnitDropdown=nil,rollUnitOptionsMap={},gradeTargetDropdown=nil,traitTargetDropdown=nil,autoGradeLoop=nil,autoGradeToggle=nil,autoTraitLoop=nil,autoTraitToggle=nil,gradeInfoLabel=nil,traitInfoLabel=nil,selectedGradeTargets={},selectedTraitTargets={},autoClaimLoop=nil,autoClaimToggle=nil,autoBuyQuestLoop=nil,autoBuyQuestToggle=nil,questShopItems={},selectedShopItem=nil,questShopTicketsLabel=nil,questShopPriceLabel=nil,questShopBuyBtn=nil,slotInfoLabel=nil,slotDropdown=nil,stopAtRebirth=0,fpsBoostRunning=false,fpsBoostLoop=nil,webhookMentionEveryone=false,uiToggleKeybind="",uiEverythingHidden=false,uiMainVisible=true,towerAutoPlay=false,towerLoop=nil,towerStatus="Ready",towerCurrentFloor=0,towerCurrentName="",completeFloorDelay=1.5,playTowerDelay=3,infinityTarget=999999,towerCurrentCycle=0,dragonTarget=100,cursedTarget=100,pirateTarget=100,hiddenLeafTarget=100,slayerTarget=100,shadowTarget=100,autoUsePotion=false,autoUsePotionLoop=nil,selectedPotionCategories={},selectedPotionTowers={},autoUsePotionDelay=2,autoUsePotionThreshold=10,usePotionOnlyOnWeather=false,weatherWebhookLastSent=nil,antiLagActive=false,antiLagConnection=nil,autoUseSpinLoop=nil,selectedSpinTypes={},selectedSpinTriggerEvents={},spinPerEvent=5,spinStopAt=2,spinRequirePotion=true,spinUsedThisEvent={},spinLastEventStart=nil,bruteForceLoopA=nil,bruteForceLoopB=nil,bruteForceToggle=nil,playerDataLoop=nil,playerDataInterval=1,playerDataToggle=nil,playerDataSentCount=0,collectInterval=60,selectedConfig=nil,configName=nil,playerDataCounterLabel=nil,maxPotionTier="IV",fuseMinChance=0,fuseMaxChance=math.huge,fuseMaxIncome=math.huge,fuseMinChanceRaw="",fuseMaxChanceRaw="",fuseMaxIncomeRaw="",autoFuseLoop=nil,autoFuseToggle=nil,fuseInfoLabel=nil,fuseTotalLabel=nil,fuseReadyLabel=nil,fuseTotalCount=0,fuseWebhookSentCount=0,fuseWebhookLabel=nil,fuseWebhookMinIncome=0,fuseWebhookMinIncomeRaw="",fuseWebhookRarityFilter={},autoBuyDiceLoop=nil,autoBuyDiceToggle=nil,autoEquipGearLoop=nil,autoEquipGearToggle=nil,upgradeStatusLabel=nil,upgradeFailCooldown={},selectedGearBuff="Auto (Best Rarity+Total)",maxUnitSlots=32,targetWeatherList={},weatherFinderLoop=nil,weatherFinderToggle=nil,weatherFinderStatus=nil,weatherFinderCurrentLabel=nil,weatherFinderTargetLabel=nil,weatherFinderAttemptsLabel=nil,weatherFinderAttempts=0,weatherFinderHopDelay=10,hopDelaySlider=nil,hopDelayLabel=nil,selectedAutoLoadConfig=nil,autoLoadConfigDropdown=nil,autoLoadToggle=nil,triedServerIds={},teleportPending=false,lastTeleportAttempt=0,lastQueueTime=0,_pickingKeybind=false,_keybindCooldown=0}
State.quirksLoop=nil
State.quirksSelectedUnits={}
State.quirksTargets={}
State.quirksAutoToggle=nil
State.quirksInfoLabel=nil
State.quirksUnitDropdown=nil
State.quirksTargetDropdown=nil
State.quirksUnitOptionsMap={}
State.pumpkinDiceLoop=nil
State.pumpkinDiceAutoToggle=nil
State.pumpkinDiceMode=1
State.pumpkinDiceRolls=0
State.pumpkinDiceNewUnits=0
State.pumpkinPassLoop=nil
State.pumpkinPassAutoToggle=nil
State.candyShopLoop=nil
State.candyShopAutoToggle=nil
State.candyShopSelected={}
State.candyShopPriceLabel=nil
State.candyShopDropdown=nil
State.hauntedTowerAutoPlay=false
State.hauntedTowerLoop=nil
State.hauntedTowerToggle=nil
State.hauntedTargets={["Front Yard"]=50,["Foyer"]=50,["Crypt"]=50,["Attic"]=50,["Bell Tower"]=50,["The Abyss"]=1000}
State.autoTeleportIsland=false
State.trickOrTreatLoop=nil
State.trickOrTreatAutoToggle=nil
State.trickOrTreatDoorsKnocked=0
State.trickOrTreatDoorCooldown={}
State.trickOrTreatRewardStarted=false
State.trickOrTreatLastKnock=0
State.trickOrTreatSignalSetup=false
local isDestroyed=false
local requestFunc=request or http_request or (syn and syn.request) or (fluxus and fluxus.request)
local _isMobile=UIS.TouchEnabled and not UIS.KeyboardEnabled
local UIRegistry={} local ConfigManager={} ConfigManager.configs={}
if Network then
    pcall(function()Remotes.rollFunction=Network.ClientComm.new(RS.Network,false,"RollService"):GetFunction("RollDice")end)
    pcall(function()local c=Network.ClientComm.new(RS.Network,false,"DiceShopService") Remotes.buyDiceSignal=c:GetSignal("BuyDice") Remotes.equipDiceSignal=c:GetSignal("EquipDice")end)
    pcall(function()Remotes.rebirthSignal=Network.ClientComm.new(RS.Network,false,"RebirthService"):GetSignal("Rebirth")end)
    pcall(function()Remotes.addRebirthStatSignal=Network.ClientComm.new(RS.Network,false,"RebirthService"):GetSignal("AddStat")end)
    pcall(function()Remotes.useResetTokenSignal=Network.ClientComm.new(RS.Network,false,"RebirthService"):GetSignal("UseResetToken")end)
    pcall(function()local c=Network.ClientComm.new(RS.Network,false,"TradeService") Remotes.tradeRequestSignal=c:GetSignal("RequestTrade") Remotes.changeOfferSignal=c:GetSignal("ChangeOffer")end)
    pcall(function()Remotes.gradeRollSignal=Network.ClientComm.new(RS.Network,false,"GradeService"):GetSignal("Roll")end)
    pcall(function()Remotes.traitRollSignal=Network.ClientComm.new(RS.Network,false,"TraitService"):GetSignal("Roll")end)
    pcall(function()Remotes.buyUpgradeSignal=RS:WaitForChild("Network"):WaitForChild("RE"):WaitForChild("BuyUpgrade")end)
    pcall(function()Remotes.equipGearSignal=Network.ClientComm.new(RS.Network,false,"GearService"):GetSignal("Equip")end)
    pcall(function()Remotes.redeemCodeSignal=Network.ClientComm.new(RS.Network,false,"CodesService"):GetSignal("RedeemCode")end)
end
pcall(function()Remotes.equipBestRemote=RS:WaitForChild("Network",10):WaitForChild("PlotService",10):WaitForChild("RE",10):WaitForChild("EquipBest",10)end)
pcall(function()Remotes.sellRemote=RS:WaitForChild("Network",10):WaitForChild("SellService",10):WaitForChild("RF",10):WaitForChild("SellInventory",10)end)
pcall(function()Remotes.collectRemote=RS:WaitForChild("Network",10):WaitForChild("PlotService",10):WaitForChild("RE",10):WaitForChild("CollectBalance",10)end)
pcall(function()Remotes.levelUpRemote=RS:WaitForChild("Network",10):WaitForChild("PlotService",10):WaitForChild("RE",10):WaitForChild("LevelUpSlot",10)end)
pcall(function()Remotes.usePotion=RS:WaitForChild("Network",10):WaitForChild("BoostService",10):WaitForChild("RE",10):WaitForChild("Use",10)end)
pcall(function()Remotes.useSpin=RS:WaitForChild("Network",10):WaitForChild("SpinService",10):WaitForChild("RE",10):WaitForChild("Use",10)end)
pcall(function()Remotes.playTower=RS:WaitForChild("Network",10):WaitForChild("Towers",10):WaitForChild("RF",10):WaitForChild("PlayTower",10)end)
pcall(function()Remotes.completeFloor=RS:WaitForChild("Network",10):WaitForChild("Towers",10):WaitForChild("RF",10):WaitForChild("CompleteTowerFloor",10)end)
pcall(function()Remotes.cancelTower=RS:WaitForChild("Network",10):WaitForChild("Towers",10):WaitForChild("RF",10):WaitForChild("CancelTower",10)end)
pcall(function()Remotes.updateTowerTeamRemote=RS:WaitForChild("Network",10):WaitForChild("Towers",10):WaitForChild("RE",10):WaitForChild("UpdateTowerTeam",10)end)
pcall(function()Remotes.equipBestTowerTeamRemote=RS:WaitForChild("Network",10):WaitForChild("Towers",10):WaitForChild("RE",10):WaitForChild("EquipBestTowerTeam",10)end)
pcall(function()Remotes.fuseRemote=RS:WaitForChild("Network",10):WaitForChild("FusingService",10):WaitForChild("RE",10):WaitForChild("Fuse",10)end)
pcall(function()Remotes.buyUpgradeSignal=RS:WaitForChild("Network",10):WaitForChild("RE",10):WaitForChild("BuyUpgrade",10)end)
pcall(function()local c=Network.ClientComm.new(RS.Network,false,"PumpkinDiceService") Remotes.pumpkinRoll=c:GetFunction("Roll") Remotes.pumpkinSetAutoSell=c:GetSignal("SetAutoSell")end)
pcall(function()local c=Network.ClientComm.new(RS.Network,false,"QuirkService") Remotes.quirkRoll=c:GetSignal("Roll") Remotes.quirkSetProtected=c:GetSignal("SetQuirkProtected")end)
pcall(function()local c=Network.ClientComm.new(RS.Network,false,"HalloweenService") Remotes.halloweenClaimPath=c:GetSignal("ClaimPath") Remotes.halloweenClaimAllPath=c:GetSignal("ClaimAllPath") Remotes.halloweenBuyOffer=c:GetSignal("BuyOffer") Remotes.halloweenTeleport=c:GetFunction("Teleport")end)
pcall(function()local c=Network.ClientComm.new(RS.Network,false,"HalloweenQuestService") Remotes.halloweenQuestClaim=c:GetSignal("Claim")end)
task.spawn(function()
    local re pcall(function()re=RS:WaitForChild("Network"):WaitForChild("FusingService"):WaitForChild("RE"):WaitForChild("Result")end)
    if not re then return end
    re.OnClientEvent:Connect(function(data)if type(data)~="table" or not data.name then return end State.fuseTotalCount=(State.fuseTotalCount or 0)+1 task.spawn(function()F.sendFuseWebhook(data)end)end)
end)
if makefolder and isfolder and not isfolder(CFG.CONFIG_FOLDER) then pcall(makefolder,CFG.CONFIG_FOLDER) end
F.loadConfigsFromFile=function()if not isfile or not readfile then return{}end if not isfile(CFG.CONFIG_FILE) then return{}end local ok,d=pcall(function()return HS:JSONDecode(readfile(CFG.CONFIG_FILE))end) if ok and type(d)=="table" then return d end return{}end
F.saveConfigsToFile=function(c)if not writefile then return end pcall(function()writefile(CFG.CONFIG_FILE,HS:JSONEncode(c))end)end
F.saveAutoLoad=function(name)if not writefile then return end pcall(function()if makefolder and isfolder and not isfolder(CFG.CONFIG_FOLDER) then makefolder(CFG.CONFIG_FOLDER) end writefile(CFG.AUTOLOAD_FILE,name or "")end)end
F.loadAutoLoad=function()if not readfile then return nil end local ok,data=pcall(function()return readfile(CFG.AUTOLOAD_FILE)end) if ok and data and data~="" then return data end return nil end
F.clearAutoLoad=function()if not writefile then return end pcall(function()writefile(CFG.AUTOLOAD_FILE,"")end)end
F.loadState=function()
    if not readfile or not isfile then return {} end
    if not isfile(CFG.STATE_FILE) then return {} end
    local ok,d=pcall(function() return HS:JSONDecode(readfile(CFG.STATE_FILE)) end)
    if ok and type(d)=="table" then return d end
    return {}
end
F.saveState=function(d)
    if not writefile then return end
    pcall(function()
        if makefolder and isfolder and not isfolder(CFG.CONFIG_FOLDER) then makefolder(CFG.CONFIG_FOLDER) end
        writefile(CFG.STATE_FILE, HS:JSONEncode(d))
    end)
end
F.clearState=function()
    if not writefile then return end
    pcall(function() writefile(CFG.STATE_FILE, HS:JSONEncode({})) end)
end
local _weatherResumeState = F.loadState()
if _weatherResumeState.autoFindWeather == true then
    State.weatherFinderResume = true
    if type(_weatherResumeState.targetWeatherList) == "table" then
        State.targetWeatherList = _weatherResumeState.targetWeatherList
    end
    State.weatherFinderHopDelay = tonumber(_weatherResumeState.hopDelay) or State.weatherFinderHopDelay or 10
    State.weatherFinderAttempts = tonumber(_weatherResumeState.attempts) or 0
    if type(_weatherResumeState.tried) == "table" then
        for _, serverId in ipairs(_weatherResumeState.tried) do
            if type(serverId) == "string" then
                State.triedServerIds[serverId] = true
            end
        end
    end
end
F.saveLoaderToFile=function()
    if not writefile then return false end
    local ok=pcall(function() writefile(CFG.LOADER_FILE, CFG.LOADER_URL) end)
    if ok then print("[AutoHop] Loader saved") end
    return ok
end
F.getQueueFunc=function()
    local fn=queue_on_teleport
    if type(fn)~="function" and syn and type(syn.queue_on_teleport)=="function" then fn=syn.queue_on_teleport end
    if type(fn)~="function" and fluxus and type(fluxus.queue_on_teleport)=="function" then fn=fluxus.queue_on_teleport end
    if type(fn)~="function" and sirhurt and type(sirhurt.queue_on_teleport)=="function" then fn=sirhurt.queue_on_teleport end
    if type(fn)~="function" and delta and type(delta.queue_on_teleport)=="function" then fn=delta.queue_on_teleport end
    if type(fn)~="function" and codex and type(codex.queue_on_teleport)=="function" then fn=codex.queue_on_teleport end
    return fn
end
F.queueReload=function()
    F.saveLoaderToFile()
    local fn=F.getQueueFunc()
    if type(fn)~="function" then print("[AutoHop] queue TIDAK SUPPORT") return false end
    local qc='loadstring(readfile("'..CFG.LOADER_FILE..'"))()'
    local ok=pcall(function() fn(qc) end)
    if ok then print("[AutoHop] Queue OK") State.lastQueueTime=os.clock() else print("[AutoHop] Queue GAGAL") end
    return ok
end
F.RegisterUI=function(k,e)if not e then return end UIRegistry[k]=e end
ConfigManager.configs=F.loadConfigsFromFile()
ConfigManager.Save=function(name)
    if not name or name=="" then return false end
    local snap={}
    for k,e in pairs(UIRegistry) do
        local ok,v=pcall(function()return e.Value end)
        if ok and v~=nil then
            if e.Type=="Dropdown" and e.Multi and type(v)=="table" and e.Values then
                local n={} local isSeq=true
                for kk in pairs(e.Values) do if type(kk)~="number" then isSeq=false break end end
                if isSeq then for _,vv in ipairs(e.Values) do n[vv]=v[vv]==true end else for kk in pairs(e.Values) do n[kk]=v[kk]==true end end
                for kk,vv in pairs(v) do if n[kk]==nil then n[kk]=vv==true end end
                snap[k]=n
            else snap[k]=v end
        end
    end
    ConfigManager.configs[name]=snap F.saveConfigsToFile(ConfigManager.configs) return true
end
ConfigManager.Load=function(name)
    if not name or not ConfigManager.configs[name] then return false end
    local snap=ConfigManager.configs[name]
    for k,v in pairs(snap) do local e=UIRegistry[k] if e and e.Type=="Toggle" then pcall(function()if e.Value~=false then e:SetValue(false)end end) end end
    for k,v in pairs(snap) do local e=UIRegistry[k] if e and e.Type~="Toggle" then pcall(function() if e.Type=="Dropdown" and e.Multi and type(v)=="table" then local flt={} for kk,vv in pairs(v) do if vv==true then flt[kk]=true end end e:SetValue(flt) else e:SetValue(v) end end) end end
    task.wait(0.5)
    for k,v in pairs(snap) do local e=UIRegistry[k] if e and e.Type=="Toggle" then pcall(function()e:SetValue(v==true)end) end end
    return true
end
ConfigManager.Delete=function(name)if not name or not ConfigManager.configs[name] then return false end ConfigManager.configs[name]=nil F.saveConfigsToFile(ConfigManager.configs) return true end
ConfigManager.List=function()local l={} for n in pairs(ConfigManager.configs) do table.insert(l,n) end table.sort(l) return l end
F.ShowDropdownPopup=function(dd)
    if _ActivePopup then pcall(function()_ActivePopup:Destroy()end) _ActivePopup=nil end
    local gui=Library.ScreenGui if not gui then return end
    local O=Instance.new("TextButton") O.Size=UDim2.fromScale(1,1) O.BackgroundColor3=Color3.new(0,0,0) O.BackgroundTransparency=1 O.Text="" O.AutoButtonColor=false O.BorderSizePixel=0 O.ZIndex=8000 O.Parent=gui
    local P=Instance.new("Frame") P.AnchorPoint=Vector2.new(0.5,0.5) P.Position=UDim2.fromScale(0.5,0.5) P.Size=UDim2.fromScale(0.78,0.72) P.BackgroundColor3=(Library.Scheme and Library.Scheme.BackgroundColor) or Color3.fromRGB(20,20,20) P.BorderSizePixel=0 P.ZIndex=8001 P.Parent=O
    local c1=Instance.new("UICorner") c1.CornerRadius=UDim.new(0,8) c1.Parent=P
    local s1=Instance.new("UIStroke") s1.Color=Color3.fromRGB(80,80,80) s1.Thickness=1 s1.Parent=P
    local T=Instance.new("TextLabel") T.Size=UDim2.new(1,-80,0,40) T.Position=UDim2.fromOffset(15,10) T.BackgroundTransparency=1 T.Text=(dd.Text or "Select").." · Popup" T.TextColor3=Color3.new(1,1,1) T.TextSize=16 T.Font=Enum.Font.Code T.TextXAlignment=Enum.TextXAlignment.Left T.ZIndex=8003 T.Parent=P
    local X=Instance.new("TextButton") X.AnchorPoint=Vector2.new(1,0) X.Position=UDim2.new(1,-12,0,12) X.Size=UDim2.fromOffset(28,28) X.BackgroundColor3=Color3.fromRGB(200,60,60) X.Text="X" X.TextColor3=Color3.new(1,1,1) X.TextSize=16 X.Font=Enum.Font.Code X.BorderSizePixel=0 X.AutoButtonColor=false X.ZIndex=8003 X.Parent=P
    local c2=Instance.new("UICorner") c2.CornerRadius=UDim.new(0,6) c2.Parent=X
    local S=Instance.new("ScrollingFrame") S.Position=UDim2.fromOffset(12,55) S.Size=UDim2.new(1,-24,1,-70) S.BackgroundTransparency=1 S.BorderSizePixel=0 S.ScrollBarThickness=4 S.ScrollBarImageColor3=Color3.fromRGB(90,90,90) S.CanvasSize=UDim2.new(0,0,0,0) S.AutomaticCanvasSize=Enum.AutomaticSize.Y S.ZIndex=8002 S.Parent=P
    local L=Instance.new("UIListLayout") L.Padding=UDim.new(0,4) L.Parent=S
    local function close()pcall(function()O:Destroy()end) if _ActivePopup==O then _ActivePopup=nil end end
    X.MouseButton1Click:Connect(close) O.MouseButton1Click:Connect(close)
    local function uvis()
        for _,ch in ipairs(S:GetChildren()) do
            if ch:IsA("TextButton") and ch:GetAttribute("Val")~=nil then
                local val=ch:GetAttribute("Val") local isSel
                if dd.Multi then isSel=dd.Value and dd.Value[val]==true else isSel=dd.Value==val end
                ch.BackgroundTransparency=isSel and 0 or 1 ch.TextTransparency=isSel and 0 or 0.45
            end
        end
    end
    local function ref()
        for _,ch in ipairs(S:GetChildren()) do if ch:IsA("TextButton") then ch:Destroy() end end
        local vals=dd.Values or{} local isSeq=true
        for k in pairs(vals) do if type(k)~="number" then isSeq=false break end end
        local items={}
        if isSeq then for _,v in ipairs(vals) do table.insert(items,{value=v,label=tostring(v)}) end else for k,v in pairs(vals) do table.insert(items,{value=k,label=tostring(v)}) end end
        table.sort(items,function(a,b)return a.label<b.label end)
        for _,it in ipairs(items) do
            local b=Instance.new("TextButton") b.Size=UDim2.new(1,-8,0,34) b.BackgroundColor3=Color3.fromRGB(60,60,60) b.BackgroundTransparency=1 b.Text=it.label b.TextColor3=Color3.new(1,1,1) b.TextSize=14 b.Font=Enum.Font.Code b.TextTransparency=0.45 b.TextXAlignment=Enum.TextXAlignment.Left b.BorderSizePixel=0 b.AutoButtonColor=false b.ZIndex=8003 b.Parent=S
            b:SetAttribute("Val",it.value)
            local bp=Instance.new("UIPadding") bp.PaddingLeft=UDim.new(0,14) bp.Parent=b
            local cr=Instance.new("UICorner") cr.CornerRadius=UDim.new(0,6) cr.Parent=b
            b.MouseEnter:Connect(function()if b.TextTransparency==0 then return end b.BackgroundTransparency=0.7 end)
            b.MouseLeave:Connect(function()uvis()end)
            b.MouseButton1Click:Connect(function()
                if dd.Multi then
                    local nv={} for k,v in pairs(dd.Value or{}) do nv[k]=v end
                    if nv[it.value] then nv[it.value]=nil else nv[it.value]=true end
                    dd:SetValue(nv)
                else dd:SetValue(it.value) end
                uvis()
            end)
        end
        uvis()
    end
    ref() _ActivePopup=O
end
F.AddPopupButton=function(dd)
    if not dd or not dd.Holder then return end
    local D for _,c in ipairs(dd.Holder:GetChildren()) do if c:IsA("TextButton") then D=c break end end
    if not D then return end
    local B=Instance.new("TextButton") B.Name="PopupOpenBtn" B.AnchorPoint=Vector2.new(1,0.5) B.Position=UDim2.new(1,-22,0.5,0) B.Size=UDim2.fromOffset(16,16) B.BackgroundColor3=Color3.fromRGB(45,45,45) B.BackgroundTransparency=0.3 B.Text="-" B.TextColor3=Color3.fromRGB(200,200,200) B.TextSize=14 B.Font=Enum.Font.Code B.AutoButtonColor=false B.BorderSizePixel=0 B.ZIndex=50 B.Parent=D
    local cr=Instance.new("UICorner") cr.CornerRadius=UDim.new(0,4) cr.Parent=B
    local st=Instance.new("UIStroke") st.Color=Color3.fromRGB(80,80,80) st.Transparency=0.4 st.Parent=B
    B.MouseEnter:Connect(function()B.BackgroundTransparency=0 B.TextColor3=Color3.new(1,1,1)end)
    B.MouseLeave:Connect(function()B.BackgroundTransparency=0.3 B.TextColor3=Color3.fromRGB(200,200,200)end)
    B.MouseButton1Click:Connect(function() F.ShowDropdownPopup(dd) task.defer(function()if dd.Menu and dd.Menu.Active then pcall(function()dd.Menu:Close()end) end end) end)
end
F.refreshRarityDropdowns=function()
    for _,key in ipairs({"webhookRarityFilter","fuseWebhookRarityFilter","sellRarityFilter"}) do
        local e=UIRegistry[key]
        if e and e.SetValues then pcall(function() e:SetValues(CFG.rarityFilterOptions) end) end
    end
end
F.getMaxRebirth=function()if not Rebirths then return 16 end local m=0 for i=0,500 do if Rebirths.Get(i) then m=i else break end end return m end
local MAX_REBIRTH=F.getMaxRebirth() State.stopAtRebirth=MAX_REBIRTH
F.safeCall=function(f,...)local ok,r=pcall(f,...) return ok and r or nil end
F.getUnitIncome=function(it)
    if not EntryRegistry or not it or not it.name then return 0 end
    local c=EntryRegistry.getEntryConfig(it.name)
    if c and c.income then local a=it.attributes or{} local ok,r=pcall(c.income,a) if ok and type(r)=="number" then return r end end
    return 0
end
F.getUnitInfo=function(n,a)
    local i={unit=n,mutation=a and a.mutation or "None",rarity="Unknown",chance=0,income=0,level=a and a.level or 1}
    if EntryRegistry then
        local c=EntryRegistry.getEntryConfig(n)
        if c then
            if c.getRarity then i.rarity=F.safeCall(c.getRarity,a) or "Unknown" end
            if c.chance then local cv=F.safeCall(c.chance,a) if type(cv)=="number" and cv>0 then i.chance=cv end end
            if c.income then local iv=F.safeCall(c.income,a) if type(iv)=="number" then i.income=iv end end
        end
    end
    return i
end
F.formatNumber=function(n)
    if type(n)~="number" then return tostring(n) end
    if n == math.huge then return "inf" end
    if n ~= n then return "nan" end
    local neg = n < 0
    local abs = math.abs(n)
    if abs < 1000 then
        return tostring(math.floor(abs * 10 + 0.5) / 10):gsub("%.0$","")
    end
    for _, entry in ipairs(CFG.SUFFIX_LIST) do
        if abs >= entry[1] then
            local v = abs / entry[1]
            local s = string.format("%.2f", v):gsub("0+$",""):gsub("%.$","")
            return (neg and "-" or "") .. s .. entry[2]
        end
    end
    return tostring(n)
end
F.parseNumberString=function(s)
    if not s then return 0 end
    local ss=tostring(s):lower():gsub("%s+",""):gsub("%$",""):gsub(",","")
    local np,sx=ss:match("^(%-?%d+%.?%d*)(%a*)")
    if not np then return 0 end
    local n=tonumber(np) if not n then return 0 end
    if sx=="" then return n end
    local m=CFG.SUFFIX_TABLE[sx] if m then return n*m end
    return n
end
F.formatDuration=function(s)
    s=math.max(0,math.floor(tonumber(s) or 0))
    local h=math.floor(s/3600) local m=math.floor((s%3600)/60) local ss=s%60
    if h>0 then return string.format("%dh %dm %ds",h,m,ss) elseif m>0 then return string.format("%dm %ds",m,ss) else return string.format("%ds",ss) end
end
F.getPlottedUnitIds=function()
    local ids={}
    if DataController and DataController.Slots then
        local ok,sl=pcall(DataController.Slots)
        if ok and type(sl)=="table" then for _,s in pairs(sl) do if type(s)=="table" and s.unitId then ids[s.unitId]=true end end end
    end
    return ids
end
F.getItemAmount=function(n)
    if not DataController or not DataController.Inventory then return 0 end
    local inv=DataController.Inventory() if not inv or type(inv)~="table" then return 0 end
    for _,it in pairs(inv) do
        if type(it)=="function" then local ok,r=pcall(it) if ok and type(r)=="table" then it=r end end
        if type(it)=="table" and it.name==n then return it.amount or 0 end
    end
    return 0
end
F.getPotionAmount=F.getItemAmount
F.usePotion=function(n)
    if BoostController and BoostController.UseBoost then local ok=pcall(function()BoostController.UseBoost(n)end) if ok then return true end end
    if Remotes.usePotion then local ok=pcall(function()Remotes.usePotion:FireServer(n)end) if ok then return true end end
    return false
end
F.getActivePotionRemaining=function(n)
    if not DataController or not DataController.___C then return 0 end
    local ae=DataController.___C.ActiveEntries local C=ae and (rawget(ae,"___C") or ae.___C)
    if type(C)~="table" then return 0 end
    local now=workspace:GetServerTimeNow()
    for _,v in pairs(C) do
        if type(v)=="table" then
            local nD=v.___C and v.___C.name and v.___C.name.___X local rD=v.___C and v.___C.remaining and v.___C.remaining.___X
            if type(nD)=="table" and type(rD)=="table" and tostring(nD.name)==n then
                local r=tonumber(rD.remaining) or 0 local st=tonumber(rD.startedAt) or now
                return math.max(0,r-(now-st))
            end
        end
    end
    return 0
end
CFG._weatherPropCache=nil
F.getWeatherProperty=function()
    if CFG._weatherPropCache then return CFG._weatherPropCache end
    local ok,p=pcall(function()local N=require(RS:WaitForChild("Packages"):WaitForChild("Network")) return N.ClientComm.new(RS.Network,false,"WeatherService"):GetProperty("ActiveWeather")end)
    if ok and p then CFG._weatherPropCache=p return p end
    return nil
end
F.isWeatherActive=function()local p=F.getWeatherProperty() if not p then return false end local ok,c=pcall(function()return p:Get()end) return ok and c~=nil end
F.getWeatherInfo=function()
    local p=F.getWeatherProperty() if not p then return nil end
    local ok,c=pcall(function()return p:Get()end)
    if ok and c then
        local e=workspace:GetServerTimeNow()-c.startedAt
        return{name=c.name,remaining=math.max(0,300-e),startedAt=c.startedAt}
    end
    return nil
end
F.getCurrentWeatherName=function() local info=F.getWeatherInfo() return info and info.name or nil end
F.getUnitQuirk=function(k) return F.getUnitAttributeValue(k,"quirk") end
F.getUnitName=function(k)
    if not DataController or not DataController.Inventory then return nil end
    local inv=DataController.Inventory() if not inv then return nil end
    local it=inv[k] if type(it)=="function" then local ok,v=pcall(it) it=ok and v or nil end
    if type(it)=="table" then return it.name end
    return nil
end
F.isQuirkProtected=function(qn)
    if not qn or qn=="None" or not DataController or not DataController.ProtectedQuirks then return false end
    if not DataController.ProtectedQuirks[qn] then return false end
    local ok,v=pcall(function() return DataController.ProtectedQuirks[qn]() end)
    return ok and v==true
end
F.updateQuirksInfo=function()
    if not State.quirksInfoLabel then return end
    if #State.quirksSelectedUnits==0 then State.quirksInfoLabel:SetText("Select units to view quirks") return end
    local lines={}
    for _,k in ipairs(State.quirksSelectedUnits) do
        local nm=F.getUnitName(k) or tostring(k)
        local q=F.getUnitQuirk(k) or "None"
        local mark=""
        if q~="None" then
            if F.isQuirkProtected(q) then mark=mark.." [PROTECTED]" end
            for _,t in ipairs(State.quirksTargets) do if t==q then mark=mark.." [TARGET]" break end end
        end
        table.insert(lines,string.format("%s: %s%s",nm,q,mark))
    end
    State.quirksInfoLabel:SetText(table.concat(lines,"\n"))
end
F.refreshQuirkUnitDropdown=function()
    if not State.quirksUnitDropdown then return end
    local vals={} State.quirksUnitOptionsMap={}
    if not DataController or not DataController.Inventory then State.quirksUnitDropdown:SetValues(vals) return end
    local inv=DataController.Inventory() if not inv then return end
    local nc={} local ul={}
    for k,it in pairs(inv) do
        if type(it)=="function" then local ok,r=pcall(it) if ok and type(r)=="table" then it=r end end
        if type(it)=="table" and it.name then
            local c=EntryRegistry and EntryRegistry.getEntryConfig(it.name)
            if c and c.kind=="Unit" then nc[it.name]=(nc[it.name] or 0)+1 table.insert(ul,{key=k,name=it.name}) end
        end
    end
    table.sort(ul,function(a,b) return a.name<b.name end)
    local uc={}
    for _,d in ipairs(ul) do
        local disp=d.name
        if nc[d.name]>1 then uc[d.name]=(uc[d.name] or 0)+1 disp=d.name.." "..uc[d.name] end
        State.quirksUnitOptionsMap[disp]=d.key
        table.insert(vals,disp)
    end
    State.quirksUnitDropdown:SetValues(vals)
    local vd={}
    for _,k in ipairs(State.quirksSelectedUnits) do
        local ok=false
        for _,v in pairs(State.quirksUnitOptionsMap) do if v==k then ok=true break end end
        if ok then table.insert(vd,k) end
    end
    State.quirksSelectedUnits=vd
    F.updateQuirksInfo()
end
F.processQuirks=function()
    if not Remotes.quirkRoll then return false end
    if #State.quirksSelectedUnits==0 or #State.quirksTargets==0 then return false end
    local anyNeed=false
    for _,k in ipairs(State.quirksSelectedUnits) do
        local q=F.getUnitQuirk(k) or "None"
        local isTarget=false
        for _,t in ipairs(State.quirksTargets) do if t==q then isTarget=true break end end
        if not isTarget and not F.isQuirkProtected(q) then
            anyNeed=true
            pcall(function() Remotes.quirkRoll:Fire(k) end)
            task.wait(0.3)
        end
    end
    F.updateQuirksInfo()
    return anyNeed
end
F.startQuirksLoop=function()
    if State.quirksLoop then return end
    State.quirksLoop=task.spawn(function()
        while Toggles.quirksAuto and not isDestroyed do
            if #State.quirksTargets==0 then
                Toggles.quirksAuto=false
                if State.quirksAutoToggle then State.quirksAutoToggle:SetValue(false) end
                break
            end
            local need=F.processQuirks()
            if not need then
                local allDone=true
                for _,k in ipairs(State.quirksSelectedUnits) do
                    local q=F.getUnitQuirk(k) or "None"
                    local isTarget=false
                    for _,t in ipairs(State.quirksTargets) do if t==q then isTarget=true break end end
                    if not isTarget and not F.isQuirkProtected(q) then allDone=false break end
                end
                if allDone then
                    Toggles.quirksAuto=false
                    if State.quirksAutoToggle then State.quirksAutoToggle:SetValue(false) end
                    Library:Notify({Title="Quirks",Description="All units done!",Time=3})
                    break
                end
            end
            task.wait(need and 0.5 or 2)
        end
        State.quirksLoop=nil
    end)
end
F.stopQuirksLoop=function()
    Toggles.quirksAuto=false
    if State.quirksLoop then pcall(task.cancel,State.quirksLoop) State.quirksLoop=nil end
end
F.getPumpkinAmount=function() return F.getItemAmount("Pumpkins") end
F.processPumpkinDice=function()
    if not Remotes.pumpkinRoll then return false end
    local mode=State.pumpkinDiceMode or 1
    local cost=CFG.PUMPKIN_DICE_COST*mode
    if F.getPumpkinAmount()<cost then return false end
    local ok,res=pcall(Remotes.pumpkinRoll, mode)
    if not ok or type(res)~="table" or not res.ok then return false end
    State.pumpkinDiceRolls=State.pumpkinDiceRolls+(#(res.results or {}))
    for _,r in ipairs(res.results or {}) do
        if r.isNew then
            State.pumpkinDiceNewUnits=State.pumpkinDiceNewUnits+1
            Library:Notify({Title="Pumpkin Dice",Description="NEW: "..tostring(r.name),Time=4})
        end
    end
    return true
end
F.startPumpkinDiceLoop=function()
    if State.pumpkinDiceLoop then return end
    State.pumpkinDiceLoop=task.spawn(function()
        while Toggles.pumpkinDiceAuto and not isDestroyed do
            local did=F.processPumpkinDice()
            task.wait(did and 2.1 or 1)
        end
        State.pumpkinDiceLoop=nil
    end)
end
F.stopPumpkinDiceLoop=function()
    Toggles.pumpkinDiceAuto=false
    if State.pumpkinDiceLoop then pcall(task.cancel,State.pumpkinDiceLoop) State.pumpkinDiceLoop=nil end
end
F.processPumpkinPass=function()
    if not Remotes.halloweenClaimAllPath then return end
    pcall(function() Remotes.halloweenClaimAllPath:Fire() end)
end
F.startPumpkinPassLoop=function()
    if State.pumpkinPassLoop then return end
    State.pumpkinPassLoop=task.spawn(function()
        while Toggles.pumpkinPassAuto and not isDestroyed do
            F.processPumpkinPass()
            task.wait(5)
        end
        State.pumpkinPassLoop=nil
    end)
end
F.stopPumpkinPassLoop=function()
    Toggles.pumpkinPassAuto=false
    if State.pumpkinPassLoop then pcall(task.cancel,State.pumpkinPassLoop) State.pumpkinPassLoop=nil end
end
F.buyCandyShopItem=function(name)
    if not name or not Remotes.halloweenBuyOffer then return false end
    local idx=CFG.CANDY_SHOP_INDEX[name] if not idx then return false end
    local it=HalloweenShop and HalloweenShop[idx] if not it then return false end
    if F.getItemAmount("Candy")<it.candy then return false end
    pcall(function() Remotes.halloweenBuyOffer:Fire(idx) end)
    return true
end
F.processCandyShop=function()
    if #State.candyShopSelected==0 then return false end
    local candy=F.getItemAmount("Candy")
    for _,name in ipairs(State.candyShopSelected) do
        local idx=CFG.CANDY_SHOP_INDEX[name]
        if idx and HalloweenShop[idx] and candy>=HalloweenShop[idx].candy then
            F.buyCandyShopItem(name) return true
        end
    end
    return false
end
F.startCandyShopLoop=function()
    if State.candyShopLoop then return end
    State.candyShopLoop=task.spawn(function()
        while Toggles.candyShopAuto and not isDestroyed do
            local did=F.processCandyShop()
            task.wait(did and 0.5 or 1)
        end
        State.candyShopLoop=nil
    end)
end
F.stopCandyShopLoop=function()
    Toggles.candyShopAuto=false
    if State.candyShopLoop then pcall(task.cancel,State.candyShopLoop) State.candyShopLoop=nil end
end
F.updateCandyShopPrice=function()
    if not State.candyShopPriceLabel then return end
    if #State.candyShopSelected==0 then State.candyShopPriceLabel:SetText("Price: -") return end
    local lines={}
    for _,name in ipairs(State.candyShopSelected) do
        local idx=CFG.CANDY_SHOP_INDEX[name]
        if idx and HalloweenShop and HalloweenShop[idx] then
            table.insert(lines,name..": "..F.formatNumber(HalloweenShop[idx].candy).." Candy")
        end
    end
    if #lines==0 then State.candyShopPriceLabel:SetText("Price: -") else State.candyShopPriceLabel:SetText("Price:\n"..table.concat(lines,"\n")) end
end
F.teleportHalloween=function(dest)
    if not Remotes.halloweenTeleport then return false end
    local ok,res=pcall(Remotes.halloweenTeleport, dest or "Island")
    return ok and res==true
end
F.isOnHalloweenIsland=function()
    local Z=workspace:FindFirstChild("Zones")
    local zone=Z and Z:FindFirstChild("HalloweenWorld")
    local ch=Players.LocalPlayer and Players.LocalPlayer.Character
    local hrp=ch and ch:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    if zone and zone:IsA("BasePart") then
        local rel=zone.CFrame:PointToObjectSpace(hrp.Position)
        return math.abs(rel.X)<=zone.Size.X/2 and math.abs(rel.Z)<=zone.Size.Z/2
    end
    return false
end
F.getNearestDoor=function(maxDist)
    local Coll=game:GetService("CollectionService")
    local ch=Players.LocalPlayer and Players.LocalPlayer.Character
    local hrp=ch and ch:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end
    local now=os.clock() local best,bestDist=nil,maxDist or 300
    for _,door in ipairs(Coll:GetTagged("TrickOrTreatDoor")) do
        if door:IsA("BasePart") then
            local cd=State.trickOrTreatDoorCooldown[door] or 0
            if now>=cd then
                local d=(door.Position-hrp.Position).Magnitude
                if d<bestDist then bestDist=d best=door end
            end
        end
    end
    return best,bestDist
end
F.activeTweenConn=nil
F.tweenToPosition=function(targetPos, speed)
    local ch=Players.LocalPlayer and Players.LocalPlayer.Character
    local hrp=ch and ch:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    if F.activeTweenConn then pcall(function() F.activeTweenConn:Disconnect() end) F.activeTweenConn=nil end
    speed=speed or 58
    local startCF=hrp.CFrame
    local dist=(targetPos-hrp.Position).Magnitude
    local dur=math.max(dist/speed,0.05)
    local targetCF=CFrame.new(targetPos, targetPos+startCF.LookVector)
    local elapsed=0
    F.activeTweenConn=RunService.Heartbeat:Connect(function(dt)
        if isDestroyed or not hrp or not hrp.Parent or not Toggles.trickOrTreatAuto then
            if F.activeTweenConn then pcall(function() F.activeTweenConn:Disconnect() end) F.activeTweenConn=nil end
            return
        end
        elapsed=elapsed+dt
        local a=math.min(elapsed/dur,1)
        hrp.CFrame=startCF:Lerp(targetCF,a)
        if a>=1 then
            if F.activeTweenConn then pcall(function() F.activeTweenConn:Disconnect() end) F.activeTweenConn=nil end
        end
    end)
    local t0=os.clock()
    while os.clock()-t0<dur+0.05 and Toggles.trickOrTreatAuto and not isDestroyed do
        task.wait(0.05)
    end
    if F.activeTweenConn then pcall(function() F.activeTweenConn:Disconnect() end) F.activeTweenConn=nil end
    return true
end
F.setupTrickOrTreatSignal=function()
    if State.trickOrTreatSignalSetup then return end
    State.trickOrTreatSignalSetup=true
    pcall(function()
        local c=Network.ClientComm.new(RS.Network,false,"TrickOrTreatService")
        local sig=c:GetSignal("Knocked")
        if sig then
            sig:Connect(function(...)
                local args={...}
                local first=args[1]
                if typeof(first)=="Instance" and first:IsA("Player") then
                    if first==Players.LocalPlayer then State.trickOrTreatRewardStarted=true end
                else
                    State.trickOrTreatRewardStarted=true
                end
            end)
        end
    end)
end
F.processTrickOrTreat=function()
    F.setupTrickOrTreatSignal()
    if not F.isOnHalloweenIsland() then
        F.teleportHalloween("Island")
        task.wait(1)
        if not F.isOnHalloweenIsland() then task.wait(2) return false end
    end
    local door,dist=F.getNearestDoor(300)
    if not door then task.wait(1) return false end
    local ch=Players.LocalPlayer.Character
    local hrp=ch and ch:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    local candyBefore=F.getItemAmount("Candy")
    State.trickOrTreatRewardStarted=false
    local front=door.CFrame.LookVector
    F.tweenToPosition(door.Position+front*3, 58)
    if not Toggles.trickOrTreatAuto or isDestroyed then return false end
    local sinceLast=os.clock()-(State.trickOrTreatLastKnock or 0)
    if sinceLast<2 then
        local wt=2-sinceLast+0.05
        local wt0=os.clock()
        while os.clock()-wt0<wt and Toggles.trickOrTreatAuto and not isDestroyed do task.wait(0.05) end
    end
    if not Toggles.trickOrTreatAuto or isDestroyed then return false end
    local t0=os.clock()
    while os.clock()-t0<1.5 and Toggles.trickOrTreatAuto and not isDestroyed do
        if State.trickOrTreatRewardStarted then break end
        if F.getItemAmount("Candy")>candyBefore then break end
        task.wait(0.05)
    end
    State.trickOrTreatDoorCooldown[door]=os.clock()+30
    State.trickOrTreatDoorsKnocked=State.trickOrTreatDoorsKnocked+1
    State.trickOrTreatLastKnock=os.clock()
    return true
end
F.startTrickOrTreatLoop=function()
    if State.trickOrTreatLoop then return end
    State.trickOrTreatLoop=task.spawn(function()
        while Toggles.trickOrTreatAuto and not isDestroyed do
            F.processTrickOrTreat()
            task.wait(0.1)
        end
        State.trickOrTreatLoop=nil
    end)
end
F.stopTrickOrTreatLoop=function()
    Toggles.trickOrTreatAuto=false
    if F.activeTweenConn then pcall(function() F.activeTweenConn:Disconnect() end) F.activeTweenConn=nil end
    pcall(function()
        local ch=Players.LocalPlayer and Players.LocalPlayer.Character
        local hrp=ch and ch:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.AssemblyLinearVelocity=Vector3.zero end
    end)
    if State.trickOrTreatLoop then pcall(task.cancel,State.trickOrTreatLoop) State.trickOrTreatLoop=nil end
end
F.getHauntedTarget=function(n) return tonumber(State.hauntedTargets[n]) or 0 end
F.saveHopDelay=function(v) if not writefile then return end pcall(function() if makefolder and isfolder and not isfolder(CFG.CONFIG_FOLDER) then makefolder(CFG.CONFIG_FOLDER) end writefile(CFG.CONFIG_FOLDER.."/hop_delay.txt",tostring(v or 10)) end) end
F.loadHopDelay=function() if not readfile then return nil end local ok,data=pcall(function() return readfile(CFG.CONFIG_FOLDER.."/hop_delay.txt") end) if ok and data and data~="" then local n=tonumber(data) if n and n>=1 then return math.floor(n) end end return nil end
F.fetchServerList=function()
    local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100&sortOrder=Asc"
    local ok, res = pcall(function() return game:HttpGet(url) end)
    if not ok then return nil, "HttpGet gagal: " .. tostring(res) end
    local ok2, d = pcall(function() return HS:JSONDecode(res) end)
    if not ok2 or type(d) ~= "table" or type(d.data) ~= "table" then
        return nil, "respon tidak valid / rate limit: " .. tostring(res):sub(1, 80)
    end
    return d.data
end
F.pickServer=function()
    local tried = State.triedServerIds or {}
    local list, why = F.fetchServerList()
    if not list then return nil, why end
    local BUFFER = 3
    local function eligible(s)
        if type(s) ~= "table" or not s.id then return false end
        if s.id == game.JobId or tried[s.id] then return false end
        local playing = tonumber(s.playing) or 0
        local maxP = tonumber(s.maxPlayers) or 0
        if maxP <= 0 then return false end
        if (maxP - playing) < BUFFER then return false end
        return true
    end
    local c = {}
    for _, s in ipairs(list) do
        if eligible(s) then table.insert(c, s) end
    end
    if #c == 0 then
        State.triedServerIds = {}
        for _, s in ipairs(list) do
            if type(s) == "table" and s.id and s.id ~= game.JobId
                and (tonumber(s.maxPlayers) or 0) - (tonumber(s.playing) or 0) >= BUFFER then
                table.insert(c, s)
            end
        end
        if #c == 0 then return nil, "tidak ada kandidat server (semua sisa slot < " .. BUFFER .. ")" end
    end
    return c[math.random(1, #c)]
end
F.hopToServer=function()
    if not Toggles.autoFindWeather then return false end
    local pick, why = F.pickServer()
    if not pick then
        print("[AutoHop] gagal pilih server: " .. tostring(why))
        return false
    end
    State.triedServerIds[pick.id] = true
    local st = F.loadState()
    local triedArr = {}
    for id, _ in pairs(State.triedServerIds) do table.insert(triedArr, id) end
    st.tried = triedArr
    st.autoFindWeather = true
    st.targetWeatherList = State.targetWeatherList or {}
    st.hopDelay = State.weatherFinderHopDelay or 10
    st.attempts = (st.attempts or 0) + 1
    F.saveState(st)
    F.queueReload()
    State.teleportPending = true
    local playing = tonumber(pick.playing) or 0
    local maxP = tonumber(pick.maxPlayers) or 0
    print(string.format("[AutoHop] Hop ke %s (%d/%d, sisa %d slot)", pick.id, playing, maxP, maxP - playing))
    local TS = game:GetService("TeleportService")
    local opts = Instance.new("TeleportOptions")
    opts.ShouldReserveServer = false
    local ok, err = pcall(function()
        TS:TeleportToPlaceInstance(game.PlaceId, pick.id, Players.LocalPlayer, opts)
    end)
    if not ok then
        State.teleportPending = false
        print("[AutoHop] Teleport error: " .. tostring(err))
        State.triedServerIds[pick.id] = true
    end
    return ok
end
F.stopWeatherFinderLoop=function()
    Toggles.autoFindWeather=false
    if State.weatherFinderLoop then pcall(task.cancel,State.weatherFinderLoop) State.weatherFinderLoop=nil end
    if State.weatherFinderStatus then State.weatherFinderStatus:SetText("Status: Idle") end
end
F.startWeatherFinderLoop=function()
    if State.weatherFinderLoop then return end
    if not State.targetWeatherList or #State.targetWeatherList==0 then
        Library:Notify({Title="Weather Finder",Description="Pilih target dulu!",Time=3})
        Toggles.autoFindWeather=false
        if State.weatherFinderToggle then State.weatherFinderToggle:SetValue(false) end
        return
    end
    State.weatherFinderLoop=task.spawn(function()
        local function matchCurrent()
            local cur=F.getCurrentWeatherName()
            if not cur then return false,nil end
            for _,t in ipairs(State.targetWeatherList) do
                if cur==t then return true,cur end
            end
            return false,cur
        end
        local function stopFinder(foundName)
            Toggles.autoFindWeather=false
            if State.weatherFinderToggle then State.weatherFinderToggle:SetValue(false) end
            if State.weatherFinderStatus then State.weatherFinderStatus:SetText("Found: "..tostring(foundName)) end
            F.clearState()
            pcall(function()
                local fn=F.getQueueFunc()
                if type(fn)=="function" then fn("") end
            end)
            Library:Notify({Title="Weather Finder",Description="Ketemu "..tostring(foundName).."!",Time=5})
        end
        while Toggles.autoFindWeather and not isDestroyed do
            local matched,cur = matchCurrent()
            if matched then
                stopFinder(cur)
                break
            end
            local wait = F.getHopDelay()
            local elapsed = 0
            local matchedDuringWait = false
            local matchedName = nil
            while elapsed < wait and Toggles.autoFindWeather and not isDestroyed do
                task.wait(1)
                elapsed = elapsed + 1
                if State.weatherFinderStatus then
                    State.weatherFinderStatus:SetText("Current: "..tostring(F.getCurrentWeatherName() or "None").." | Hop in "..tostring(wait-elapsed).."s")
                end
                local m2,c2 = matchCurrent()
                if m2 then
                    matchedDuringWait = true
                    matchedName = c2
                    break
                end
            end
            if not Toggles.autoFindWeather or isDestroyed then break end
            if matchedDuringWait then
                stopFinder(matchedName)
                break
            end
            local m3,c3 = matchCurrent()
            if m3 then
                stopFinder(c3)
                break
            end
            local ok = F.hopToServer()
            if not ok then
                task.wait(5)
            else
                task.wait(15)
            end
        end
        State.weatherFinderLoop=nil
    end)
end
F.getHopDelay=function() if UI.hopDelaySlider then local ok,v=pcall(function() return UI.hopDelaySlider.Value end) if ok and v~=nil then local n=tonumber(v) if n and n>=1 then State.weatherFinderHopDelay=math.floor(n) return math.floor(n) end end end return tonumber(State.weatherFinderHopDelay) or 10 end
F.isCodeRedeemed=function(code) if not DataController or not DataController.RedeemedCodes then return false end local ok,v=pcall(function() return DataController.RedeemedCodes[code]() end) return ok and v==true end
F.redeemAllCodes=function() if not Remotes.redeemCodeSignal then return end for _,c in ipairs(CFG.KNOWN_CODES) do if isDestroyed then break end if not F.isCodeRedeemed(c) then pcall(function() Remotes.redeemCodeSignal:Fire(c) end) task.wait(0.6) end end end
F.getTiersUpTo=function(mt) local all=CFG.POTION_TIERS or{"I","II","III","IV"} local mi=#all for i,t in ipairs(all) do if t==mt then mi=i break end end local r={} for i=mi,1,-1 do table.insert(r,all[i]) end return r end
F.buildPotionList=function()
    local l={} local st=State.selectedPotionTowers or{} local sc=State.selectedPotionCategories or{}
    local tiers=F.getTiersUpTo(State.maxPotionTier)
    for _,tn in ipairs(CFG.POTION_TOWER_ORDER) do
        if not st[tn] then continue end
        local p=CFG.POTION_TOWER_PREFIX[tn] or ""
        local cats=CFG.POTION_TOWER_CATEGORIES[tn] or {"Luck","Damage","Income"}
        for _,c in ipairs(cats) do if not sc[c] then continue end for _,t in ipairs(tiers) do table.insert(l,p..c.." "..t) end end
    end
    return l
end
F.isAnySelectedLuckPotionActive=function()
    local st=State.selectedPotionTowers or{} local sc=State.selectedPotionCategories or{}
    if not sc["Luck"] then return false end
    local tiers=F.getTiersUpTo(State.maxPotionTier)
    for _,tn in ipairs(CFG.POTION_TOWER_ORDER) do
        if not st[tn] then continue end
        local p=CFG.POTION_TOWER_PREFIX[tn] or ""
        for _,t in ipairs(tiers) do local n=p.."Luck "..t if F.getItemAmount(n)>0 and F.getActivePotionRemaining(n)>0 then return true end end
    end
    return false
end
F.processAutoUsePotion=function()
    if not Toggles.autoUsePotion then return end
    if not Remotes.usePotion and not(BoostController and BoostController.UseBoost) then return end
    if State.usePotionOnlyOnWeather and not F.isWeatherActive() then return end
    local ps=F.buildPotionList() if #ps==0 then return end
    local th=State.autoUsePotionThreshold or 10
    for _,n in ipairs(ps) do
        if not Toggles.autoUsePotion then break end
        if F.getPotionAmount(n)>0 then local ar=F.getActivePotionRemaining(n) if ar<=0 or ar<=th then F.usePotion(n) task.wait(0.2) end end
    end
end
F.startAutoUsePotionLoop=function() if State.autoUsePotionLoop then return end State.autoUsePotionLoop=task.spawn(function() while Toggles.autoUsePotion and not isDestroyed do F.processAutoUsePotion() task.wait(1) end State.autoUsePotionLoop=nil end) end
F.stopAutoUsePotionLoop=function()Toggles.autoUsePotion=false if State.autoUsePotionLoop then task.cancel(State.autoUsePotionLoop) State.autoUsePotionLoop=nil end end
F.useSpin=function(t)if not Remotes.useSpin then return false end return pcall(function()Remotes.useSpin:FireServer(t)end) end
F.getSelectedSpinTypes=function()local l={} for _,t in ipairs(CFG.SPIN_TYPES) do if State.selectedSpinTypes[t] then table.insert(l,t) end end return l end
F.processAutoUseSpin=function()
    if not Toggles.autoUseSpin then return end
    local triggerEvents=State.selectedSpinTriggerEvents
    if not triggerEvents or #triggerEvents==0 then return end
    local allowNoWeather=false
    for _,ev in ipairs(triggerEvents) do if ev=="(No Weather)" then allowNoWeather=true break end end
    local w=F.getWeatherInfo()
    local eventKey
    if w then
        if not allowNoWeather then
            local matched=false
            for _,ev in ipairs(triggerEvents) do if ev==w.name then matched=true break end end
            if not matched then return end
        end
        eventKey=w.startedAt
    else
        if not allowNoWeather then return end
        eventKey="no_weather"
    end
    if eventKey~=State.spinLastEventStart then State.spinLastEventStart=eventKey State.spinUsedThisEvent={} end
    if State.spinRequirePotion and not F.isAnySelectedLuckPotionActive() then return end
    local sel=F.getSelectedSpinTypes() if #sel==0 then return end
    for _,t in ipairs(sel) do
        local u=State.spinUsedThisEvent[t] or 0
        if u<State.spinPerEvent then
            local r=F.getItemAmount(t)
            if r>State.spinStopAt then if F.useSpin(t) then State.spinUsedThisEvent[t]=u+1 end return end
        end
    end
end
F.startAutoUseSpinLoop=function() if State.autoUseSpinLoop then return end State.autoUseSpinLoop=task.spawn(function()while Toggles.autoUseSpin and not isDestroyed do F.processAutoUseSpin() task.wait(1) end State.autoUseSpinLoop=nil end) end
F.stopAutoUseSpinLoop=function()Toggles.autoUseSpin=false if State.autoUseSpinLoop then task.cancel(State.autoUseSpinLoop) State.autoUseSpinLoop=nil end end
F.printActivePotions=function()
    print("════ ACTIVE POTIONS ════")
    local ae=DataController and DataController.___C and DataController.___C.ActiveEntries
    local C=ae and (rawget(ae,"___C") or ae.___C)
    if type(C)~="table" then print("   (tidak tersedia)") print("═══════════════") return{} end
    local l={} local now=workspace:GetServerTimeNow()
    for k,v in pairs(C) do
        if k~="get" and type(v)=="table" then
            local nD=v.___C and v.___C.name and v.___C.name.___X local rD=v.___C and v.___C.remaining and v.___C.remaining.___X
            if type(nD)=="table" and type(rD)=="table" then
                local n=tostring(nD.name or"") local r=tonumber(rD.remaining) or 0 local st=tonumber(rD.startedAt) or now
                local lv=math.max(0,r-(now-st))
                if lv>0 and n~="" then table.insert(l,{name=n,remaining=lv}) end
            end
        end
    end
    table.sort(l,function(a,b)return a.name<b.name end)
    for _,p in ipairs(l) do print(string.format("   %-22s | %s",p.name,F.formatDuration(p.remaining))) end
    print("═══════════════") return l
end
F.shouldSendWebhook=function(i)if not State.webhookRarityFilters or next(State.webhookRarityFilters)==nil then return true end return State.webhookRarityFilters[i.rarity]==true end
F.sendWebhook=function(i)
    if not Toggles.webhook or State.webhookUrl=="" or not F.shouldSendWebhook(i) then return end
    State.webhookCounters[i.rarity]=(State.webhookCounters[i.rarity] or 0)+1
    local cs=i.chance>0 and F.formatNumber(i.chance) or "?"
    local is=i.income>0 and (F.formatNumber(i.income).."/s") or "Unknown"
    local mn=State.webhookMentionEveryone and "@everyone " or ""
    local d={username="Anime Dice Roller",content=mn,embeds={{title="Roll Result",color=0x9B59B6,fields={{name="Unit",value="```"..i.unit.."```",inline=true},{name="Rarity",value="```"..i.rarity.."```",inline=true},{name="Chance",value="```1 in "..cs.."```",inline=true},{name="Mutation",value="```"..i.mutation.."```",inline=true},{name="Income",value="```"..is.."```",inline=true},{name="Total Rolls",value="```"..(State.webhookCounters[i.rarity] or 0).."```",inline=false}},footer={text="Server: "..game.JobId},timestamp=DateTime.now():ToIsoDate()}},allowed_mentions={parse={"everyone"}}}
    if not State.webhookMentionEveryone then d.allowed_mentions=nil end
    local e=HS:JSONEncode(d)
    if requestFunc then pcall(function()requestFunc({Url=State.webhookUrl,Method="POST",Headers={["Content-Type"]="application/json"},Body=e})end) else pcall(function()HS:PostAsync(State.webhookUrl,e)end) end
    if State.webhookCounterLabel then local t=0 for _,c in pairs(State.webhookCounters) do t=t+c end State.webhookCounterLabel:SetText("Rolls sent: "..tostring(t)) end
end
F.sendWeatherWebhook=function(i)
    if State.webhookUrl=="" then return end
    local mn=State.webhookMentionEveryone and "@everyone" or ""
    local p={username="Anime Dice Weather",content=mn,embeds={{title=i.name.." Started!",description="Weather event aktif!",color=0xFFD700,fields={{name="Sisa",value="```"..F.formatDuration(i.remaining).."```",inline=true},{name="Event",value="```"..i.name.."```",inline=true}},footer={text="Server: "..game.JobId},timestamp=DateTime.now():ToIsoDate()}},allowed_mentions=State.webhookMentionEveryone and{parse={"everyone"}} or nil}
    local e=HS:JSONEncode(p)
    if requestFunc then pcall(function()requestFunc({Url=State.webhookUrl,Method="POST",Headers={["Content-Type"]="application/json"},Body=e})end) else pcall(function()HS:PostAsync(State.webhookUrl,e)end) end
end
F.collectPlayerData=function()
    local o={playerName=Players.LocalPlayer and Players.LocalPlayer.DisplayName or "Unknown",money=0,rebirth=0,dice="Unknown",totalRolls=0,totalUnits=0,plottedUnits=0,bestUnit=nil,rarityBreakdown={},topUnits={},totalRebirthsMax=MAX_REBIRTH}
    if DataController then
        pcall(function()if DataController.Money then o.money=DataController.Money() or 0 end end)
        pcall(function()if DataController.Rebirth then o.rebirth=DataController.Rebirth() or 0 end end)
        pcall(function()if DataController.Dice then o.dice=DataController.Dice() or "Unknown" end end)
        pcall(function()if DataController.Rolls then o.totalRolls=DataController.Rolls() or 0 end end)
    end
    if DataController and DataController.Inventory then
        local pi=F.getPlottedUnitIds()
        local ok,inv=pcall(DataController.Inventory)
        if ok and type(inv)=="table" then
            local ul={}
            for k,it in pairs(inv) do
                if type(it)=="function" then local ok2,r=pcall(it) if ok2 and type(r)=="table" then it=r end end
                if type(it)=="table" and it.name then
                    local c=EntryRegistry and EntryRegistry.getEntryConfig(it.name)
                    if c and c.kind=="Unit" then
                        o.totalUnits=o.totalUnits+1 if pi[k] then o.plottedUnits=o.plottedUnits+1 end
                        local a=it.attributes or{} local info=F.getUnitInfo(it.name,a) local inc=F.getUnitIncome(it)
                        o.rarityBreakdown[info.rarity]=(o.rarityBreakdown[info.rarity] or 0)+1
                        local en={name=it.name,rarity=info.rarity,chance=info.chance,income=inc,mutation=info.mutation,level=info.level}
                        table.insert(ul,en)
                        if not o.bestUnit or inc>o.bestUnit.income then o.bestUnit=en end
                    end
                end
            end
            table.sort(ul,function(a,b)return a.income>b.income end)
            for i=1,math.min(5,#ul) do table.insert(o.topUnits,ul[i]) end
        end
    end
    return o
end
F.sendPlayerDataWebhook=function()
    if State.webhookUrl=="" then return false end
    local d=F.collectPlayerData()
    local function fn(n)if type(n)~="number" then return tostring(n) end if n>=1e6 then return F.formatNumber(n)..string.format(" (%.0f)",n) end return tostring(math.floor(n)) end
    local bu="None" local bn="-" local bc="-" local bi="-" local bm="-" local bl="-"
    if d.bestUnit then
        bn=d.bestUnit.name bc=d.bestUnit.chance>0 and F.formatNumber(d.bestUnit.chance) or "?" bi=F.formatNumber(d.bestUnit.income) bm=d.bestUnit.mutation or "None" bl=tostring(d.bestUnit.level or 1)
        bu=string.format("%s (%s) | 1 in %s | %s/s",bn,d.bestUnit.rarity,bc,bi)
    end
    local tul={} for i,u in ipairs(d.topUnits) do table.insert(tul,string.format("%d. %s (%s) | %s/s",i,u.name,u.rarity,F.formatNumber(u.income))) end
    if #tul==0 then tul={"(kosong)"} end
    local rl={} for r,c in pairs(d.rarityBreakdown) do table.insert(rl,string.format("**%s**: %d",r,c)) end
    if #rl==0 then rl={"(kosong)"} end
    local rs=table.concat(rl," | ")
    local f={{name="💰 Money",value="```"..fn(d.money).."```",inline=true},{name="🔄 Rebirth",value="```"..tostring(d.rebirth).." / "..tostring(d.totalRebirthsMax).."```",inline=true},{name="🎲 Dice",value="```"..tostring(d.dice).."```",inline=true},{name="📊 Total Rolls",value="```"..fn(d.totalRolls).."```",inline=true},{name="🧩 Total Units",value="```"..tostring(d.totalUnits).."```",inline=true},{name="📍 Plotted Units",value="```"..tostring(d.plottedUnits).."```",inline=true},{name="🏆 Best Unit",value="```"..bu.."```",inline=false},{name="📛 Best Name",value="```"..bn.."```",inline=true},{name="🌟 Rarity",value="```"..(d.bestUnit and d.bestUnit.rarity or "-").."```",inline=true},{name="🎯 Chance",value="```1 in "..bc.."```",inline=true},{name="💵 Income",value="```"..bi.."/s```",inline=true},{name="🧬 Mutation",value="```"..bm.."```",inline=true},{name="📈 Level",value="```Lv "..bl.."```",inline=true},{name="🥇 Top 5",value="```"..table.concat(tul,"\n").."```",inline=false},{name="🔮 Rarity",value=rs,inline=false},{name="🕐 Sent",value="```"..os.date("%Y-%m-%d %H:%M:%S").."```",inline=true},{name="📨 Report #",value="```"..tostring(State.playerDataSentCount+1).."```",inline=true}}
    local mn=State.webhookMentionEveryone and "@everyone " or ""
    local p={username="Anime Dice Player Data",content=mn,embeds={{title="📋 Player Data · "..d.playerName,color=0x55AAFF,fields=f,footer={text="Server: "..game.JobId.." | "..d.playerName},timestamp=DateTime.now():ToIsoDate()}},allowed_mentions=State.webhookMentionEveryone and{parse={"everyone"}} or nil}
    local e=HS:JSONEncode(p) local ok=false
    if requestFunc then ok=pcall(function()requestFunc({Url=State.webhookUrl,Method="POST",Headers={["Content-Type"]="application/json"},Body=e})end) else ok=pcall(function()HS:PostAsync(State.webhookUrl,e)end) end
    State.playerDataSentCount=State.playerDataSentCount+1 return ok
end
F.startPlayerDataLoop=function() if State.playerDataLoop then return end State.playerDataLoop=task.spawn(function() while Toggles.sendPlayerData and not isDestroyed do pcall(F.sendPlayerDataWebhook) local wt=math.max(1,tonumber(State.playerDataInterval) or 1)*60 local el=0 while el<wt and Toggles.sendPlayerData and not isDestroyed do task.wait(0.5) el=el+0.5 end end State.playerDataLoop=nil end) end
F.stopPlayerDataLoop=function()Toggles.sendPlayerData=false if State.playerDataLoop then pcall(task.cancel,State.playerDataLoop) State.playerDataLoop=nil end end
F.getFusableUnits=function()
    local r={}
    if not DataController or not DataController.Inventory then return r end
    if (State.fuseMinChanceRaw or "")=="" and (State.fuseMaxChanceRaw or "")=="" and (State.fuseMaxIncomeRaw or "")=="" then return r end
    local pi=F.getPlottedUnitIds() local inv=DataController.Inventory()
    if not inv or type(inv)~="table" then return r end
    local mn=State.fuseMinChance or 0 local mx=State.fuseMaxChance or math.huge local mi=State.fuseMaxIncome or math.huge
    for k,it in pairs(inv) do
        if type(it)=="function" then local ok,rr=pcall(it) if ok and type(rr)=="table" then it=rr else continue end end
        if type(it)~="table" or type(it.name)~="string" then continue end
        local c=EntryRegistry and EntryRegistry.getEntryConfig(it.name)
        if not c or c.kind~="Unit" then continue end
        if pi[k] then continue end
        local a=it.attributes or{} local info=F.getUnitInfo(it.name,a) local ch=info.chance or 0 local inc=F.getUnitIncome(it)
        if ch>=mn and ch<=mx and inc<=mi then table.insert(r,{key=k,name=it.name,chance=ch,income=inc,rarity=info.rarity}) end
    end
    table.sort(r,function(a,b)return a.income<b.income end)
    return r
end
F.updateFuseInfo=function()
    if not State.fuseInfoLabel then return end
    local ae=(State.fuseMinChanceRaw or "")=="" and (State.fuseMaxChanceRaw or "")=="" and (State.fuseMaxIncomeRaw or "")==""
    local u=F.getFusableUnits()
    State.fuseInfoLabel:SetText(string.format("Eligible: %d unit",#u))
    if State.fuseTotalLabel then State.fuseTotalLabel:SetText(string.format("Fused total: %d",State.fuseTotalCount or 0)) end
    if State.fuseReadyLabel then
        if ae then State.fuseReadyLabel:SetText("Ready: NO (fill filter)")
        elseif #u>=3 then State.fuseReadyLabel:SetText("Ready: YES")
        else State.fuseReadyLabel:SetText("Ready: NO (need 3)") end
    end
end
F.processAutoFuse=function()
    if not Remotes.fuseRemote then return false end
    local u=F.getFusableUnits() if #u<3 then return false end
    local ok=pcall(function()Remotes.fuseRemote:FireServer(u[1].key,u[2].key,u[3].key)end)
    if ok then F.updateFuseInfo() end
    return ok
end
F.startAutoFuseLoop=function() if State.autoFuseLoop then return end State.autoFuseLoop=task.spawn(function() while Toggles.autoFuse and not isDestroyed do local d=F.processAutoFuse() F.updateFuseInfo() if d then task.wait(CFG.FUSE_DELAY) else task.wait(1) end end State.autoFuseLoop=nil end) end
F.stopAutoFuseLoop=function()Toggles.autoFuse=false if State.autoFuseLoop then pcall(task.cancel,State.autoFuseLoop) State.autoFuseLoop=nil end end
F.shouldSendFuseWebhook=function(i)
    if State.fuseWebhookRarityFilter and next(State.fuseWebhookRarityFilter)~=nil then if not State.fuseWebhookRarityFilter[i.rarity] then return false end end
    if i.income<(State.fuseWebhookMinIncome or 0) then return false end
    return true
end
F.sendFuseWebhook=function(d)
    if not Toggles.webhook or not Toggles.fuseWebhook or State.webhookUrl=="" then return end
    if type(d)~="table" or not d.name then return end
    local a=d.attributes or{} local n=d.name local i=F.getUnitInfo(n,a) i.income=F.getUnitIncome({name=n,attributes=a})
    if not F.shouldSendFuseWebhook(i) then return end
    local cs=i.chance>0 and F.formatNumber(i.chance) or "?" local is=i.income>0 and (F.formatNumber(i.income).."/s") or "Unknown"
    local mn=State.webhookMentionEveryone and "@everyone " or ""
    State.fuseWebhookSentCount=(State.fuseWebhookSentCount or 0)+1
    local p={username="Anime Dice Fuse",content=mn,embeds={{title="🧪 Fuse Result",color=0xFF6B35,fields={{name="Unit",value="```"..n.."```",inline=true},{name="Rarity",value="```"..i.rarity.."```",inline=true},{name="Chance",value="```1 in "..cs.."```",inline=true},{name="Mutation",value="```"..tostring(i.mutation).."```",inline=true},{name="Income",value="```"..is.."```",inline=true},{name="Total Fuse",value="```"..tostring(State.fuseTotalCount or 0).."```",inline=true},{name="Sent #",value="```"..tostring(State.fuseWebhookSentCount).."```",inline=true}},footer={text="Server: "..game.JobId},timestamp=DateTime.now():ToIsoDate()}},allowed_mentions=State.webhookMentionEveryone and{parse={"everyone"}} or nil}
    local e=HS:JSONEncode(p)
    if requestFunc then pcall(function()requestFunc({Url=State.webhookUrl,Method="POST",Headers={["Content-Type"]="application/json"},Body=e})end) else pcall(function()HS:PostAsync(State.webhookUrl,e)end) end
    if State.fuseWebhookLabel then State.fuseWebhookLabel:SetText("Fuse sent: "..tostring(State.fuseWebhookSentCount)) end
end
if BuffController then
    pcall(function()State.rollDelay=BuffController.GetBuff("Roll Duration")end)
    BuffController:ListenToBuff("Roll Duration",function(v)State.rollDelay=v end)
end
F.handleRollResult=function(d) if type(d)~="table" or not d.result then return end local a={mutation=d.mutation,level=1} local i=F.getUnitInfo(d.result,a) i.income=F.getUnitIncome({name=d.result,attributes=a}) F.sendWebhook(i) end
F.performRoll=function()
    if State.isRolling or isDestroyed then return end
    State.isRolling=true
    local ok,res=pcall(Remotes.rollFunction)
    if ok and type(res)=="table" and #res>0 then for _,d in ipairs(res) do F.handleRollResult(d) end end
    State.isRolling=false
end
F.processBruteRoll=function()
    if not Remotes.rollFunction then return end
    local ok,res=pcall(Remotes.rollFunction)
    if not ok or type(res)~="table" or #res==0 then return end
    for _,d in ipairs(res) do F.handleRollResult(d) end
end
F.startBruteForce=function()
    if State.bruteForceLoopA or State.bruteForceLoopB then return end
    State.bruteForceLoopA=task.spawn(function()while Toggles.bruteForce and not isDestroyed do task.spawn(F.processBruteRoll) task.wait(0.1) end State.bruteForceLoopA=nil end)
    State.bruteForceLoopB=task.spawn(function()while Toggles.bruteForce and not isDestroyed do for _=1,2 do if not Toggles.bruteForce or isDestroyed then break end task.spawn(F.processBruteRoll) end task.wait(0.1) end State.bruteForceLoopB=nil end)
end
F.stopBruteForce=function() Toggles.bruteForce=false if State.bruteForceLoopA then pcall(task.cancel,State.bruteForceLoopA) State.bruteForceLoopA=nil end if State.bruteForceLoopB then pcall(task.cancel,State.bruteForceLoopB) State.bruteForceLoopB=nil end end
F.fireEquipBest=function()if Remotes.equipBestRemote then pcall(function()Remotes.equipBestRemote:FireServer()end) end end
F.startEquipBestLoop=function() if State.equipBestLoop then return end State.equipBestLoop=task.spawn(function()while Toggles.equipBest and not isDestroyed do F.fireEquipBest() task.wait(State.equipBestDelay) end State.equipBestLoop=nil end) end
F.stopEquipBestLoop=function()Toggles.equipBest=false if State.equipBestLoop then task.cancel(State.equipBestLoop) State.equipBestLoop=nil end end
F.refreshDiceDropdown=function()
    if not State.diceDropdown or not Dice then return end
    local dl=Dice.GetAll() local vals={}
    for n,d in pairs(dl) do if d.price and not(DataController.OwnedDice and DataController.OwnedDice[n] and DataController.OwnedDice[n]()) then table.insert(vals,n) end end
    table.sort(vals) State.diceDropdown:SetValues(vals)
    if State.selectedDiceToBuy and not table.find(vals,State.selectedDiceToBuy) then State.selectedDiceToBuy=nil end
    if State.diceInfoLabel then
        local mn=DataController.Money and DataController.Money() or 0
        local ed=DataController.Dice and DataController.Dice() or "Basic"
        State.diceInfoLabel:SetText(string.format("Money: %s\nDice: %s",F.formatNumber(mn),ed))
    end
end
F.buySelectedDice=function()if not State.selectedDiceToBuy or not Remotes.buyDiceSignal then return end Remotes.buyDiceSignal:Fire(State.selectedDiceToBuy) task.wait(0.2) F.refreshDiceDropdown() end
F.buyAllDice=function()
    if not Dice or not Remotes.buyDiceSignal then return end
    for n,d in pairs(Dice.GetAll()) do
        if isDestroyed then break end
        if d.price and DataController.OwnedDice and not DataController.OwnedDice[n]() and DataController.Money()>=d.price then Remotes.buyDiceSignal:Fire(n) task.wait(0.3) end
    end
    F.refreshDiceDropdown()
end
F.processAutoBuyDice=function()
    if not Dice or not Remotes.buyDiceSignal or not DataController then return end
    local dl=Dice.GetAll() local mn=DataController.Money() or 0 local cand={}
    for n,d in pairs(dl) do if d.price then local owned=DataController.OwnedDice and DataController.OwnedDice[n] and DataController.OwnedDice[n]() if not owned then table.insert(cand,{name=n,price=d.price}) end end end
    table.sort(cand,function(a,b)return a.price<b.price end)
    for _,e in ipairs(cand) do
        if isDestroyed or not Toggles.autoBuyDice then break end
        if mn>=e.price then pcall(function()Remotes.buyDiceSignal:Fire(e.name)end) mn=mn-e.price task.wait(0.4) else break end
    end
    F.refreshDiceDropdown()
end
F.startAutoBuyDiceLoop=function() if State.autoBuyDiceLoop then return end State.autoBuyDiceLoop=task.spawn(function()while Toggles.autoBuyDice and not isDestroyed do pcall(F.processAutoBuyDice) task.wait(3) end State.autoBuyDiceLoop=nil end) end
F.stopAutoBuyDiceLoop=function()Toggles.autoBuyDice=false if State.autoBuyDiceLoop then pcall(task.cancel,State.autoBuyDiceLoop) State.autoBuyDiceLoop=nil end end
F.equipBestDice=function()
    if not Dice or not Remotes.equipDiceSignal then return end
    local bd,bl=nil,-1
    for n,d in pairs(Dice.GetAll()) do if DataController.OwnedDice[n]() and d.luck>bl then bl=d.luck bd=n end end
    if bd then Remotes.equipDiceSignal:Fire(bd) end
end
F.getOwnedGearList=function()
    local l={}
    if not DataController or not DataController.Inventory or not EntryRegistry then return l end
    local ok,inv=pcall(DataController.Inventory) if not ok or type(inv)~="table" then return l end
    for k,it in pairs(inv) do
        if type(it)=="table" and type(it.name)=="string" then
            local c=EntryRegistry.getEntryConfig(it.name)
            if c and c.kind=="Gear" and (it.amount or 0)>0 then table.insert(l,{key=k,name=it.name,slot=c.slot,rarity=c.rarity or "Common",buffs=c.buffs or{}}) end
        end
    end
    return l
end
F.pickBestGearForSlot=function(s,g)
    local b,bs=nil,-1
    local mode=State.selectedGearBuff or "Auto (Best Rarity+Total)"
    local maxRank=0
    for _,v in pairs(CFG.RARITY_RANK) do if v>maxRank then maxRank=v end end
    for _,gg in ipairs(g) do
        if gg.slot==s then
            if not CFG.RARITY_RANK[gg.rarity] then maxRank=maxRank+1 CFG.RARITY_RANK[gg.rarity]=maxRank end
            local sc=0
            if mode=="Auto (Best Rarity+Total)" then
                local r=CFG.RARITY_RANK[gg.rarity] or 0 local buf=0
                for _,bf in pairs(gg.buffs) do buf=buf+(tonumber(bf.amount) or 0) end
                sc=r*10000+buf
            else
                local bf=gg.buffs[mode]
                if bf then local amt=tonumber(bf.amount) or 0 local bucket=bf.bucket or "base" local bw=1 if bucket=="multiplier" then bw=100 elseif bucket=="percentage" then bw=50 end local r=CFG.RARITY_RANK[gg.rarity] or 0 sc=amt*bw+r*0.01 end
            end
            if sc>bs then bs=sc b=gg end
        end
    end
    return b
end
F.equipBestGearAll=function()
    if not Remotes.equipGearSignal then return 0 end
    if not DataController or not DataController.EquippedGear then return 0 end
    local l=F.getOwnedGearList() if #l==0 then return 0 end
    local cnt=0
    for _,s in ipairs(CFG.GEAR_SLOTS) do
        local b=F.pickBestGearForSlot(s,l)
        if b then
            local cur=nil pcall(function()cur=DataController.EquippedGear[s]()end)
            if cur~=b.name then pcall(function()Remotes.equipGearSignal:Fire(s,b.name)end) cnt=cnt+1 task.wait(0.1) end
        end
    end
    return cnt
end
F.showEquippedGear=function()
    if not DataController or not DataController.EquippedGear then return end
    print("════ EQUIPPED GEAR ════")
    for _,s in ipairs(CFG.GEAR_SLOTS) do local n="None" pcall(function()local v=DataController.EquippedGear[s]() if v then n=v end end) print(string.format("  %-8s : %s",s,n)) end
end
F.startAutoEquipGearLoop=function() if State.autoEquipGearLoop then return end State.autoEquipGearLoop=task.spawn(function()while Toggles.autoEquipGear and not isDestroyed do pcall(F.equipBestGearAll) task.wait(5) end State.autoEquipGearLoop=nil end) end
F.stopAutoEquipGearLoop=function()Toggles.autoEquipGear=false if State.autoEquipGearLoop then pcall(task.cancel,State.autoEquipGearLoop) State.autoEquipGearLoop=nil end end
F.processAutoSell=function()
    if not Toggles.autoSell or not Remotes.sellRemote or not DataController then return end
    local th=tonumber(State.sellIncomeThreshold) or 0
    local chth=tonumber(State.sellChanceThreshold) or 0
    local sel=State.selectedSellRarities
    local hrf=false
    if sel and type(sel)=="table" then for k,v in pairs(sel) do if v==true or (type(v)=="string" and v~="" and v~="nil" and v~="false") then hrf=true break end end end
    if not hrf and th<=0 and chth<=0 then return end
    local pi=F.getPlottedUnitIds() local tS={}
    local ok,inv=pcall(DataController.Inventory) if not ok or type(inv)~="table" then return end
    for k,it in pairs(inv) do
        if type(it)=="function" then local ok2,r=pcall(it) if ok2 and type(r)=="table" then it=r else continue end end
        if type(it)~="table" or type(it.name)~="string" then continue end
        local c=EntryRegistry and EntryRegistry.getEntryConfig(it.name)
        if not(c and c.kind=="Unit") then continue end
        if pi[k] then continue end
        local a=it.attributes or{} local info=F.getUnitInfo(it.name,a) local rar=info.rarity or "Unknown" local inc=F.getUnitIncome(it) local ch=info.chance or 0
        local pr=true
        if hrf then local m=false if sel[rar]==true then m=true else for kk,vv in pairs(sel) do if vv==rar then m=true break end if kk==rar and vv==true then m=true break end end end pr=m end
        local pinc=true
        if th>0 then if type(inc)~="number" or inc<=0 then pinc=false else pinc=inc<=th end end
        local pch=true
        if chth>0 then if type(ch)~="number" or ch<=0 then pch=false else pch=ch<=chth end end
        if pr and pinc and pch then table.insert(tS,k) end
    end
    if #tS>0 then pcall(function()Remotes.sellRemote:InvokeServer(tS)end) end
end
F.startAutoSellLoop=function() if State.autoSellLoop then return end State.autoSellLoop=task.spawn(function()while Toggles.autoSell and not isDestroyed do F.processAutoSell() task.wait(2) end State.autoSellLoop=nil end) end
F.stopAutoSellLoop=function()Toggles.autoSell=false if State.autoSellLoop then task.cancel(State.autoSellLoop) State.autoSellLoop=nil end end
F.collectAllPlots=function()if not Remotes.collectRemote then return end for i=1,State.maxUnitSlots do pcall(function()Remotes.collectRemote:FireServer(i)end) end end
F.startAutoCollectLoop=function() if State.autoCollectLoop then return end State.autoCollectLoop=task.spawn(function()while Toggles.autoCollect and not isDestroyed do F.collectAllPlots() task.wait(State.collectInterval or 60) end State.autoCollectLoop=nil end) end
F.stopAutoCollectLoop=function()Toggles.autoCollect=false if State.autoCollectLoop then task.cancel(State.autoCollectLoop) State.autoCollectLoop=nil end end
F.getRebirthPoints=function()
    if not DataController or not RebirthStatsConfig then return 0 end
    local ok,rem=pcall(function() return RebirthStatsConfig.GetRemaining(DataController.Rebirth(), DataController.RebirthStats()) end)
    return ok and rem or 0
end
F.spendRebirthPoints=function()
    if not Remotes.addRebirthStatSignal then return 0 end
    local rem=F.getRebirthPoints()
    if rem<=0 then return 0 end
    local order=State.autoRebirthStatsOrder or {"Luck","Money","Damage","Trait Luck","Grade Luck","Health"}
    local spent=0
    for _,stat in ipairs(order) do while rem>0 and Toggles.autoRebirthStats and not isDestroyed do pcall(function() Remotes.addRebirthStatSignal:Fire(stat) end) spent=spent+1 rem=rem-1 task.wait(0.15) end end
    return spent
end
F.startAutoRebirthStatsLoop=function() if State.autoRebirthStatsLoop then return end State.autoRebirthStatsLoop=task.spawn(function() while Toggles.autoRebirthStats and not isDestroyed do F.spendRebirthPoints() task.wait(1) end State.autoRebirthStatsLoop=nil end) end
F.stopAutoRebirthStatsLoop=function() Toggles.autoRebirthStats=false if State.autoRebirthStatsLoop then pcall(task.cancel,State.autoRebirthStatsLoop) State.autoRebirthStatsLoop=nil end end
F.updateRebirthInfo=function()
    if not DataController or not Rebirths then return end
    local cur=DataController.Rebirth() local nx=Rebirths.GetNext(cur) local mn=DataController.Money()
    if State.autoRebirthInfoLabel then State.autoRebirthInfoLabel:SetText("Rebirth: "..tostring(cur)) end
    if State.autoRebirthTargetLabel then State.autoRebirthTargetLabel:SetText("Target: "..tostring(State.stopAtRebirth)) end
    if State.autoRebirthMoneyLabel then if nx then State.autoRebirthMoneyLabel:SetText("Money: "..F.formatNumber(mn).." / "..F.formatNumber(nx.cost)) else State.autoRebirthMoneyLabel:SetText("Money: "..F.formatNumber(mn)) end end
    if State.autoRebirthStatusLabel then if nx then State.autoRebirthStatusLabel:SetText(mn>=nx.cost and "Status: Enough" or "Status: Not Enough") else State.autoRebirthStatusLabel:SetText("Status: MAX") end end
    if State.autoRebirthStatsInfoLabel then
        local rem=F.getRebirthPoints() local spent=0
        pcall(function() if RebirthStatsConfig and DataController.RebirthStats then spent=RebirthStatsConfig.GetSpent(DataController.RebirthStats()) end end)
        State.autoRebirthStatsInfoLabel:SetText("Points: "..tostring(rem).." | Spent: "..tostring(spent))
    end
end
F.startAutoRebirthLoop=function() if State.autoRebirthLoop then return end State.autoRebirthLoop=task.spawn(function() while Toggles.autoRebirth and not isDestroyed do local cur=DataController.Rebirth() if cur>=State.stopAtRebirth then Toggles.autoRebirth=false if State.autoRebirthToggle then State.autoRebirthToggle:SetValue(false) end break end local nx=Rebirths.GetNext(cur) if nx and DataController.Money()>=nx.cost then pcall(function()Remotes.rebirthSignal:Fire()end) task.wait(1.5) else task.wait(1) end F.updateRebirthInfo() end State.autoRebirthLoop=nil end) end
F.stopAutoRebirthLoop=function()Toggles.autoRebirth=false if State.autoRebirthLoop then task.cancel(State.autoRebirthLoop) State.autoRebirthLoop=nil end end
F.isUpgradeOwned=function(n) if not DataController or not DataController.Upgrades then return false end local ok,v=pcall(function() return DataController.Upgrades[n]() end) if not ok then return false end return v == true end
F.findBuyableUpgrade=function()
    if not DataController or not DataController.Upgrades or not Upgrades or not TreeStructure then return nil end
    local moneyOk, moneyVal = pcall(function() return DataController.Money() end)
    local money = moneyOk and (tonumber(moneyVal) or 0) or 0
    local now=os.clock() local best=nil
    local function walk(parent)
        if best then return end
        local okC, children = pcall(TreeStructure.GetChildren, parent)
        if not okC or not children then return end
        for _,child in ipairs(children) do
            if best then return end
            local owned=F.isUpgradeOwned(child)
            if owned then walk(child)
            else
                local cfg=Upgrades[child]
                if cfg and type(cfg.price)=="number" then
                    local cd=State.upgradeFailCooldown[child] or 0
                    if now>=cd and money>=cfg.price then best=child return end
                end
            end
        end
    end
    walk("Start")
    return best
end
F.performBulkUpgrade=function()
    if not Remotes.buyUpgradeSignal then return 0 end
    if not DataController then return 0 end
    local b=0 local g=0
    while g<200 do
        g=g+1
        local n=F.findBuyableUpgrade()
        if not n then break end
        pcall(function()Remotes.buyUpgradeSignal:FireServer(n)end)
        task.wait(0.8)
        if F.isUpgradeOwned(n) then b=b+1 State.upgradeFailCooldown[n]=nil else State.upgradeFailCooldown[n]=os.clock()+5 end
    end
    return b
end
F.startAutoUpgradeLoop=function() if State.autoUpgradeLoop then return end State.autoUpgradeLoop=task.spawn(function() while Toggles.autoUpgrade and not isDestroyed do local b=F.performBulkUpgrade() if State.upgradeStatusLabel then if b>0 then State.upgradeStatusLabel:SetText("Bought: "..b) else State.upgradeStatusLabel:SetText("Waiting...") end end if b>0 then task.wait(0.3) else task.wait(2) end end if State.upgradeStatusLabel then State.upgradeStatusLabel:SetText("Idle") end State.autoUpgradeLoop=nil end) end
F.stopAutoUpgradeLoop=function()Toggles.autoUpgrade=false if State.autoUpgradeLoop then task.cancel(State.autoUpgradeLoop) State.autoUpgradeLoop=nil end end
F.getUnitAttributeValue=function(k,an)
    if not DataController or not DataController.Inventory then return nil end
    local inv=DataController.Inventory() if not inv or not inv[k] then return nil end
    local it=inv[k] if type(it)=="function" then it=it() end
    if not it or type(it)~="table" or not it.attributes then return nil end
    local a=it.attributes[an]
    if a then
        local ok,v=pcall(a) if ok then return v end
        if type(a)=="table" then
            if a.get then local ok2,v2=pcall(a.get,a) if ok2 then return v2 end end
            if a.Value then return a.Value end
            if a[1] then return a[1] end
        end
        return a
    end
    return nil
end
F.getUnitDataFromSlot=function(sn)
    if not DataController or not DataController.Slots or not DataController.Inventory then return nil end
    local sl=DataController.Slots() if not sl or type(sl)~="table" then return nil end
    local sd=sl[tostring(sn)]
    if not sd then for k,v in pairs(sl) do if tonumber(k)==sn then sd=v break end end end
    if not sd or type(sd)~="table" or not sd.unitId then return nil end
    local uid=sd.unitId local ud=nil
    if type(DataController.Inventory[uid])=="function" then ud=DataController.Inventory[uid]() else local inv=DataController.Inventory() if inv and inv[uid] then if type(inv[uid])=="function" then ud=inv[uid]() else ud=inv[uid] end end end
    if ud and type(ud)=="table" and ud.name then
        local a=ud.attributes or{} local lv=a.level or 1
        if type(lv)~="number" then local ok,v=pcall(lv) if ok and type(v)=="number" then lv=v end end
        local inc=F.getUnitIncome({name=ud.name,attributes=a})
        local g=F.getUnitAttributeValue(uid,"grade") or "None" local t=F.getUnitAttributeValue(uid,"trait") or "None"
        if type(g)=="table" then g=g.Value or g[1] or "None" end
        if type(t)=="table" then t=t.Value or t[1] or "None" end
        return{name=ud.name,level=lv,income=inc,grade=tostring(g),trait=tostring(t),unitId=uid}
    end
    return nil
end
State.slotOptionsMap={} State._lastSlotValues=nil
F.refreshSlotDropdown=function()
    if not State.slotDropdown then return end
    local vals={} State.slotOptionsMap={}
    for i=1,State.maxUnitSlots do
        local d=F.getUnitDataFromSlot(i) local disp
        if d and d.name then disp=string.format("Slot %d: %s",i,d.name) else disp=string.format("Slot %d: (empty)",i) end
        State.slotOptionsMap[disp]=i table.insert(vals,disp)
    end
    local same=true
    if not State._lastSlotValues or #State._lastSlotValues~=#vals then same=false
    else for i=1,#vals do if vals[i]~=State._lastSlotValues[i] then same=false break end end end
    if not same then State._lastSlotValues=vals State.slotDropdown:SetValues(vals) end
    local vd={}
    for _,sn in ipairs(State.selectedLevelUpSlots) do local f=false for _,n in pairs(State.slotOptionsMap) do if n==sn then f=true break end end if f then table.insert(vd,sn) end end
    State.selectedLevelUpSlots=vd
    F.updateSlotInfoLabel()
end
F.updateSlotInfoLabel=function()
    if not State.slotInfoLabel then return end
    if #State.selectedLevelUpSlots==0 then State.slotInfoLabel:SetText("Select slots to view info") return end
    local lines={}
    for _,sn in ipairs(State.selectedLevelUpSlots) do
        local d=F.getUnitDataFromSlot(sn)
        if d then
            table.insert(lines,string.format("Slot %d: %s (Lv %d)",sn,d.name,d.level))
            table.insert(lines,string.format("   Income: %s",F.formatNumber(d.income)))
            table.insert(lines,string.format("   Grade: %s",tostring(d.grade)))
            table.insert(lines,string.format("   Trait: %s",tostring(d.trait)))
            table.insert(lines,"")
        else table.insert(lines,"Slot "..sn..": empty") table.insert(lines,"") end
    end
    State.slotInfoLabel:SetText(table.concat(lines,"\n"))
end
F.levelUpSelectedSlots=function()
    if not Remotes.levelUpRemote or #State.selectedLevelUpSlots==0 then return end
    for _,sn in ipairs(State.selectedLevelUpSlots) do local d=F.getUnitDataFromSlot(sn) if d and d.level<State.levelUpTarget then pcall(function()Remotes.levelUpRemote:FireServer(sn)end) task.wait(0.1) end end
end
F.startLevelUpLoop=function() if State.levelUpLoop then return end State.levelUpLoop=task.spawn(function()while Toggles.autoLevelUp and not isDestroyed do F.levelUpSelectedSlots() task.wait(0.3) end State.levelUpLoop=nil end) end
F.stopLevelUpLoop=function()Toggles.autoLevelUp=false if State.levelUpLoop then task.cancel(State.levelUpLoop) State.levelUpLoop=nil end end
F.refreshTradePlayerDropdown=function()
    if not State.tradePlayerDropdown then return end
    local vals={}
    for _,p in pairs(Players:GetPlayers()) do if p~=Players.LocalPlayer then table.insert(vals,p.DisplayName) end end
    table.sort(vals) State.tradePlayerDropdown:SetValues(vals)
    if State.selectedTradePlayer then local f=false for _,n in ipairs(vals) do if n==State.selectedTradePlayer.DisplayName then f=true break end end if not f then State.selectedTradePlayer=nil end end
end
F.getGiftableItems=function()
    local it={}
    if not DataController or not DataController.Inventory then return it end
    local inv=DataController.Inventory() if not inv or type(inv)~="table" then return it end
    for k,i in pairs(inv) do
        if type(i)=="table" and i.name then
            local c=EntryRegistry and EntryRegistry.getEntryConfig(i.name)
            if not c or c.kind~="Unit" then it[#it+1]={name=i.name,amount=i.amount or 1} end
        end
    end
    table.sort(it,function(a,b)return a.name<b.name end)
    return it
end
F.refreshGiftItemDropdown=function()
    if not State.giftItemDropdown then return end
    local it=F.getGiftableItems() local vals={} State.giftItemMap={}
    for _,i in ipairs(it) do local d=i.name.." x"..i.amount table.insert(vals,d) State.giftItemMap[d]=i.name end
    State.giftItemDropdown:SetValues(vals)
    if State.selectedGiftItem then local f=false for _,i in ipairs(it) do if i.name==State.selectedGiftItem then f=true break end end if not f then State.selectedGiftItem=nil end end
end
F.startAutoGiftLoop=function() if State.autoGiftLoop then return end State.autoGiftLoop=task.spawn(function() while Toggles.autoGift and not isDestroyed do if State.selectedGiftItem and Remotes.changeOfferSignal then local a=F.getItemAmount(State.selectedGiftItem) if a>0 then pcall(function()Remotes.changeOfferSignal:Fire(State.selectedGiftItem,1)end) task.wait(0.1) else Toggles.autoGift=false if State.autoGiftToggle then State.autoGiftToggle:SetValue(false) end break end else task.wait(0.1) end end pcall(F.refreshGiftItemDropdown) State.autoGiftLoop=nil end) end
F.stopAutoGiftLoop=function()Toggles.autoGift=false if State.autoGiftLoop then task.cancel(State.autoGiftLoop) State.autoGiftLoop=nil end pcall(F.refreshGiftItemDropdown) end
F.processGiftUnit=function(one)
    if not Remotes.changeOfferSignal or not DataController or not DataController.Inventory then return end
    local pi=F.getPlottedUnitIds() local inv=DataController.Inventory() if not inv or type(inv)~="table" then return end
    local mn=State.giftUnitMinChance or 0 local mx=State.giftUnitMaxChance or math.huge local mi=State.giftUnitMaxIncome or math.huge
    for k,it in pairs(inv) do
        if type(it)=="function" then local ok,r=pcall(it) if ok and type(r)=="table" then it=r else continue end end
        if type(it)~="table" or type(it.name)~="string" then continue end
        local c=EntryRegistry and EntryRegistry.getEntryConfig(it.name)
        if not c or c.kind~="Unit" then continue end
        if pi[k] then continue end
        local a=it.attributes or{} local info=F.getUnitInfo(it.name,a) local ch=info.chance or 0 local inc=F.getUnitIncome(it)
        if ch>=mn and ch<=mx and inc<=mi then pcall(function()Remotes.changeOfferSignal:Fire(k,1)end) task.wait(1) if one then return end end
    end
end
F.startAutoGiftUnitLoop=function() if State.autoGiftUnitLoop then return end State.autoGiftUnitLoop=task.spawn(function()while Toggles.autoGiftUnit and not isDestroyed do F.processGiftUnit(false) task.wait(1) end State.autoGiftUnitLoop=nil end) end
F.stopAutoGiftUnitLoop=function()Toggles.autoGiftUnit=false if State.autoGiftUnitLoop then task.cancel(State.autoGiftUnitLoop) State.autoGiftUnitLoop=nil end end
CFG.gradeTargetOptions={"None"} if Grades then for n in pairs(Grades) do table.insert(CFG.gradeTargetOptions,n) end end table.sort(CFG.gradeTargetOptions)
CFG.traitTargetOptions={"None"} if Traits then for n in pairs(Traits) do table.insert(CFG.traitTargetOptions,n) end end table.sort(CFG.traitTargetOptions)
F.updateRollUnitInfo=function()
    if State.gradeInfoLabel then
        if #State.selectedRollUnitKeys==0 then State.gradeInfoLabel:SetText("Grade: -")
        else
            local l={}
            for _,k in ipairs(State.selectedRollUnitKeys) do local g=F.getUnitAttributeValue(k,"grade") or "None" local it=DataController.Inventory()[k] if type(it)=="function" then it=it() end table.insert(l,(it and it.name or k)..": "..tostring(g)) end
            State.gradeInfoLabel:SetText(table.concat(l,"\n"))
        end
    end
    if State.traitInfoLabel then
        if #State.selectedRollUnitKeys==0 then State.traitInfoLabel:SetText("Trait: -")
        else
            local l={}
            for _,k in ipairs(State.selectedRollUnitKeys) do local t=F.getUnitAttributeValue(k,"trait") or "None" local it=DataController.Inventory()[k] if type(it)=="function" then it=it() end table.insert(l,(it and it.name or k)..": "..tostring(t)) end
            State.traitInfoLabel:SetText(table.concat(l,"\n"))
        end
    end
end
F.refreshRollUnitDropdown=function()
    if not State.rollUnitDropdown then return end
    local vals={} State.rollUnitOptionsMap={}
    if not DataController or not DataController.Inventory then State.rollUnitDropdown:SetValues(vals) return end
    local inv=DataController.Inventory() if not inv or type(inv)~="table" then State.rollUnitDropdown:SetValues(vals) return end
    local nc={} local ul={}
    for k,it in pairs(inv) do if type(it)=="table" and it.name then local c=EntryRegistry and EntryRegistry.getEntryConfig(it.name) if c and c.kind=="Unit" then nc[it.name]=(nc[it.name] or 0)+1 table.insert(ul,{key=k,name=it.name}) end end end
    table.sort(ul,function(a,b)return a.name<b.name end)
    local uc={}
    for _,d in ipairs(ul) do local disp=d.name if nc[d.name]>1 then uc[d.name]=(uc[d.name] or 0)+1 disp=d.name.." "..uc[d.name] end State.rollUnitOptionsMap[disp]=d.key table.insert(vals,disp) end
    State.rollUnitDropdown:SetValues(vals)
    local vd={}
    for _,k in ipairs(State.selectedRollUnitKeys) do local f=false for _,d in pairs(State.rollUnitOptionsMap) do if d==k then f=true break end end if f then table.insert(vd,k) end end
    State.selectedRollUnitKeys=vd
    F.updateRollUnitInfo()
end
F.startAutoGradeLoop=function() if State.autoGradeLoop then return end State.autoGradeLoop=task.spawn(function() while Toggles.autoGrade and not isDestroyed do if #State.selectedRollUnitKeys==0 or not Remotes.gradeRollSignal then task.wait(0.3) continue end local ad=true for _,k in ipairs(State.selectedRollUnitKeys) do local cg=F.getUnitAttributeValue(k,"grade") or "None" if next(State.selectedGradeTargets)==nil then ad=true else local ta=false for _,t in ipairs(State.selectedGradeTargets) do if cg==t then ta=true break end end if not ta then ad=false pcall(function()Remotes.gradeRollSignal:Fire(k,true)end) task.wait(0.2) end end end F.updateRollUnitInfo() if ad then Toggles.autoGrade=false if State.autoGradeToggle then State.autoGradeToggle:SetValue(false) end break end task.wait(0.3) end State.autoGradeLoop=nil end) end
F.stopAutoGradeLoop=function()Toggles.autoGrade=false if State.autoGradeLoop then task.cancel(State.autoGradeLoop) State.autoGradeLoop=nil end end
F.startAutoTraitLoop=function() if State.autoTraitLoop then return end State.autoTraitLoop=task.spawn(function() while Toggles.autoTrait and not isDestroyed do if #State.selectedRollUnitKeys==0 or not Remotes.traitRollSignal then task.wait(0.3) continue end local ad=true for _,k in ipairs(State.selectedRollUnitKeys) do local ct=F.getUnitAttributeValue(k,"trait") or "None" if next(State.selectedTraitTargets)==nil then ad=true else local ta=false for _,t in ipairs(State.selectedTraitTargets) do if ct==t then ta=true break end end if not ta then ad=false pcall(function()Remotes.traitRollSignal:Fire(k,true)end) task.wait(0.2) end end end F.updateRollUnitInfo() if ad then Toggles.autoTrait=false if State.autoTraitToggle then State.autoTraitToggle:SetValue(false) end break end task.wait(0.3) end State.autoTraitLoop=nil end) end
F.stopAutoTraitLoop=function()Toggles.autoTrait=false if State.autoTraitLoop then task.cancel(State.autoTraitLoop) State.autoTraitLoop=nil end end
F.claimCompletedQuests=function()
    if not DataController then return end
    if DataController.Quests and QuestConfig then
        local ps={"Daily","Weekly"} local cr=nil
        pcall(function()local qs=Network.ClientComm.new(RS.Network,false,"QuestService") cr=qs:GetSignal("Claim")end)
        if cr then
            for _,p in ipairs(ps) do
                local ok,d=pcall(function() return DataController.Quests[p]() end)
                if ok and d then
                    local c=QuestConfig.Periods[p]
                    if c then for _,q in ipairs(c.quests) do local pr=d.progress[q.id] or 0 local cl=d.claimed[q.id]==true if pr>=q.target and not cl then pcall(function()cr:Fire(p,q.id,d.expiresAt)end) task.wait(0.1) end end end
                end
            end
        end
    end
    if HalloweenQuests and Remotes.halloweenQuestClaim and DataController.Halloween then
        for _,period in ipairs({"Hourly","Daily"}) do
            local key=period.."Quests"
            local data
            pcall(function() if DataController.Halloween[key] then data=DataController.Halloween[key]() end end)
            if data and type(data)=="table" then
                local cfgPeriod=HalloweenQuests[period]
                if cfgPeriod and cfgPeriod.pool then
                    local qmap={} for _,q in ipairs(cfgPeriod.pool) do qmap[q.id]=q end
                    for _,qid in ipairs(data.ids or {}) do
                        local qcfg=qmap[qid]
                        if qcfg then
                            local prog=data.progress and data.progress[qid] or 0
                            if type(prog)=="function" then pcall(function() prog=prog() end) end
                            prog=tonumber(prog) or 0
                            local claimed=data.claimed and data.claimed[qid]
                            if type(claimed)=="function" then pcall(function() claimed=claimed() end) end
                            if prog>=qcfg.target and claimed~=true then
                                pcall(function() Remotes.halloweenQuestClaim:Fire(period, qid) end)
                                task.wait(0.15)
                            end
                        end
                    end
                end
            end
        end
    end
end
F.startAutoClaimLoop=function() if State.autoClaimLoop then return end State.autoClaimLoop=task.spawn(function()while Toggles.autoClaim and not isDestroyed do F.claimCompletedQuests() task.wait(1) end State.autoClaimLoop=nil end) end
F.stopAutoClaimLoop=function()Toggles.autoClaim=false if State.autoClaimLoop then task.cancel(State.autoClaimLoop) State.autoClaimLoop=nil end end
if QuestConfig and QuestConfig.Shop then for _,i in ipairs(QuestConfig.Shop) do table.insert(State.questShopItems,i.name) end end
F.updateQuestShopTickets=function()
    if not DataController or not DataController.Inventory then return end
    local t=0 local ti=DataController.Inventory.Tickets()
    if ti and ti.amount then t=ti.amount end
    State.questShopTicketsLabel:SetText("Tickets: "..F.formatNumber(t))
end
F.buyQuestShopItem=function()
    if not State.selectedShopItem then Library:Notify({Title="Quest Shop",Description="Select item first!",Time=2}) return end
    local br=nil pcall(function()local qs=Network.ClientComm.new(RS.Network,false,"QuestService") br=qs:GetSignal("Buy")end)
    if not br then Library:Notify({Title="Quest Shop",Description="Buy remote not available!",Time=2}) return end
    local t=0 local ti=DataController.Inventory.Tickets() if ti and ti.amount then t=ti.amount end
    local pr=0
    if QuestConfig and QuestConfig.Shop then for _,i in ipairs(QuestConfig.Shop) do if i.name==State.selectedShopItem then pr=i.tickets or 0 break end end end
    if t<pr then Library:Notify({Title="Quest Shop",Description="Not enough Tickets!",Time=2}) return end
    pcall(function()br:Fire(State.selectedShopItem)end)
    Library:Notify({Title="Quest Shop",Description="Bought "..State.selectedShopItem,Time=2})
    task.wait(0.5) F.updateQuestShopTickets()
end
F.startAutoBuyQuestLoop=function() if State.autoBuyQuestLoop then return end State.autoBuyQuestLoop=task.spawn(function() while Toggles.autoBuyQuest and not isDestroyed do if State.selectedShopItem then local t=0 local ti=DataController.Inventory.Tickets() if ti and ti.amount then t=ti.amount end local pr=0 if QuestConfig and QuestConfig.Shop then for _,i in ipairs(QuestConfig.Shop) do if i.name==State.selectedShopItem then pr=i.tickets or 0 break end end end if t>=pr then local br=nil pcall(function()local qs=Network.ClientComm.new(RS.Network,false,"QuestService") br=qs:GetSignal("Buy")end) if br then pcall(function()br:Fire(State.selectedShopItem)end) end task.wait(0.3) F.updateQuestShopTickets() else task.wait(1) end else task.wait(1) end end State.autoBuyQuestLoop=nil end) end
F.stopAutoBuyQuestLoop=function()Toggles.autoBuyQuest=false if State.autoBuyQuestLoop then task.cancel(State.autoBuyQuestLoop) State.autoBuyQuestLoop=nil end end
F.applyAntiLag=function()
    pcall(function()
        local T=workspace:FindFirstChildWhichIsA("Terrain")
        if T then T.WaterWaveSize=0 T.WaterWaveSpeed=0 T.WaterReflectance=0 T.WaterTransparency=1 end
        Lighting.GlobalShadows=false Lighting.FogEnd=9e9 Lighting.FogStart=9e9
        pcall(function()settings().Rendering.QualityLevel=1 end)
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then pcall(function()v.CastShadow=false v.Material="Plastic" v.Reflectance=0 v.BackSurface="SmoothNoOutlines" v.BottomSurface="SmoothNoOutlines" v.FrontSurface="SmoothNoOutlines" v.LeftSurface="SmoothNoOutlines" v.RightSurface="SmoothNoOutlines" v.TopSurface="SmoothNoOutlines" end)
            elseif v:IsA("Decal") then pcall(function()v.Transparency=1 v.Texture="" end)
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then pcall(function()v.Lifetime=NumberRange.new(0) end) end
        end
        for _,v in pairs(Lighting:GetDescendants()) do if v:IsA("PostEffect") then pcall(function()v.Enabled=false end) end end
    end)
end
F.startAntiLagListener=function()
    if State.antiLagConnection then return end
    State.antiLagConnection=workspace.DescendantAdded:Connect(function(c)
        if not State.antiLagActive then return end
        task.spawn(function()
            if c:IsA("ForceField") or c:IsA("Sparkles") or c:IsA("Smoke") or c:IsA("Fire") or c:IsA("Beam") then RunService.Heartbeat:Wait() pcall(function()c:Destroy()end)
            elseif c:IsA("BasePart") then pcall(function()c.CastShadow=false end) end
        end)
    end)
end
F.toggleAntiLag=function(e)
    State.antiLagActive=e
    if e then F.applyAntiLag() F.startAntiLagListener()
    elseif State.antiLagConnection then pcall(function()State.antiLagConnection:Disconnect()end) State.antiLagConnection=nil end
end
task.spawn(function()
    while not isDestroyed do
        task.wait(600)
        if isDestroyed then break end
        if not Toggles.antiAfk then continue end
        pcall(function()
            local c=WS.CurrentCamera
            if c then local x=c.ViewportSize.X/2 local y=c.ViewportSize.Y/2 VIM:SendMouseButtonEvent(x,y,0,true,game,1) task.wait(0.05) VIM:SendMouseButtonEvent(x,y,0,false,game,1) end
        end)
    end
end)
F.updateTowerUI=function(s,t,f,c)
    if UI.TowerStatusLabel then UI.TowerStatusLabel:SetText("Status: "..s) end
    if UI.TowerNameLabel then UI.TowerNameLabel:SetText("Tower: "..(t or "-")) end
    if UI.TowerFloorLabel then UI.TowerFloorLabel:SetText("Floor: "..tostring(f or "-")) end
    if c and UI.TowerCycleLabel then UI.TowerCycleLabel:SetText("Cycle: "..c) end
end
F.calculateTowerWaitTime=function(s)
    if not s or type(s)~="table" or #s==0 then return 0 end
    local t=0 local p=nil
    for i,a in ipairs(s) do
        if type(a)~="table" then continue end
        local ac=a.action
        if ac=="floorStarted" then
            local w
            if i==1 then w=(a.floor==1) and CFG.TOWER_FLOOR_STARTED_WAIT.initial or CFG.TOWER_FLOOR_STARTED_WAIT.transition
            elseif p=="memberDefeated" then w=CFG.TOWER_FLOOR_STARTED_WAIT.transition
            else w=CFG.TOWER_FLOOR_STARTED_WAIT.repeated end
            t=t+w
        else t=t+(CFG.TOWER_ACTION_WAIT[ac] or 0) end
        p=ac
    end
    return t
end
F.getTowerTarget=function(n)
    if n=="Dragon Tower" then return State.dragonTarget end
    if n=="Cursed Tower" then return State.cursedTarget end
    if n=="Pirate Tower" then return State.pirateTarget end
    if n=="Hidden Leaf Tower" then return State.hiddenLeafTarget end
    if n=="Slayer Tower" then return State.slayerTarget end
    if n=="Shadow Tower" then return State.shadowTarget end
    if n=="Infinity Tower" then return State.infinityTarget end
    return 100
end
F.fillTowerTeamManually=function()if not Remotes.equipBestTowerTeamRemote then return false end pcall(function()Remotes.equipBestTowerTeamRemote:FireServer()end) task.wait(0.3) return true end
F.tryStartTower=function(n) pcall(function()Remotes.cancelTower:InvokeServer()end) task.wait(0.1) pcall(Remotes.completeFloor.InvokeServer,Remotes.completeFloor) task.wait(0.1) return pcall(function()return Remotes.playTower:InvokeServer(n)end) end
F.callCompleteFloor=function(t)
    t=t or 10
    local r,d=nil,false
    local co=coroutine.create(function()local ok,s=pcall(Remotes.completeFloor.InvokeServer,Remotes.completeFloor) if ok and type(s)=="table" then r=s end d=true end)
    coroutine.resume(co)
    local st=os.clock()
    while not d and (os.clock()-st)<t do task.wait(0.1) end
    return r,d
end
UI.towerStopping=false
F.startTowerFarmLoop=function(cycle, isHaunted)
    if isHaunted and State.hauntedTowerAutoPlay then return end
    if not isHaunted and State.towerAutoPlay then return end
    if not Remotes.playTower or not Remotes.completeFloor or not Remotes.cancelTower then Library:Notify({Title="Tower",Description="Remote tidak ditemukan!",Time=3}) return end
    cycle=cycle or CFG.TOWER_CYCLE_NORMAL
    local targetGetter
    if isHaunted then
        targetGetter=function(n) return tonumber(State.hauntedTargets[n]) or 0 end
        State.hauntedTowerAutoPlay=true
    else
        targetGetter=function(n) return F.getTowerTarget(n) end
        State.towerAutoPlay=true
    end
    State.towerCurrentCycle=0
    local loop=task.spawn(function()
        pcall(function()Remotes.cancelTower:InvokeServer()end) task.wait(0.2)
        pcall(Remotes.completeFloor.InvokeServer,Remotes.completeFloor) task.wait(0.2)
        F.updateTowerUI("Filling team...","-",0,"0")
        F.fillTowerTeamManually()
        local alive=function() if isHaunted then return State.hauntedTowerAutoPlay else return State.towerAutoPlay end end
        while alive() and not isDestroyed do
            for ci,tn in ipairs(cycle) do
                if not alive() then break end
                local tg=targetGetter(tn) local cd=ci.."/"..#cycle
                if tg<=0 then F.updateTowerUI("Skipped",tn,"-",cd) task.wait(0.5) continue end
                F.updateTowerUI("Starting "..tn,tn,0,cd)
                local pok=false
                for at=1,3 do if not alive() then break end local ok,rs=F.tryStartTower(tn) if ok and rs==true then pok=true break end F.updateTowerUI("Retry ("..at.."/3)",tn,0,cd) task.wait(1) end
                if not pok then F.updateTowerUI("Gagal",tn,"-",cd) task.wait(0.5) continue end
                F.updateTowerUI("Playing "..tn,tn,0,cd) task.wait(0.5)
                local ie=false local fc=0 local ec=0
                while not ie and alive() and not isDestroyed do
                    local sq,cp=F.callCompleteFloor(10)
                    if not cp then F.updateTowerUI("Timeout",tn,fc,cd) ie=true break end
                    if not sq or type(sq)~="table" or #sq==0 then ec=ec+1 if ec>=2 then ie=true break else F.updateTowerUI("Empty",tn,fc,cd) task.wait(3) continue end else ec=0 end
                    local nf=fc local ge=false
                    for _,a in ipairs(sq) do if a.action=="floorStarted" and a.floor then nf=a.floor end if a.action=="ended" then ge=true end end
                    fc=nf State.towerCurrentFloor=fc
                    F.updateTowerUI("Playing "..tn,tn,fc,cd)
                    if fc>=tg then F.updateTowerUI("Target reached!",tn,fc,cd) ie=true break end
                    if ge then if ci==#cycle then State.towerCurrentCycle=State.towerCurrentCycle+1 end ie=true break end
                    local wt=F.calculateTowerWaitTime(sq)
                    if wt+0.1>0 then task.wait(wt+0.1) else task.wait(1) end
                end
                if alive() then pcall(function()Remotes.cancelTower:InvokeServer()end) task.wait(0.1) pcall(Remotes.completeFloor.InvokeServer,Remotes.completeFloor) task.wait(1) end
            end
            if alive() then F.updateTowerUI("Cycle complete","-","-","Cycle #"..State.towerCurrentCycle) task.wait(3) end
        end
        if isHaunted then State.hauntedTowerAutoPlay=false State.hauntedTowerLoop=nil else State.towerAutoPlay=false State.towerLoop=nil end
    end)
    if isHaunted then State.hauntedTowerLoop=loop else State.towerLoop=loop end
end
F.stopTowerFarmLoop=function(isHaunted)
    if isHaunted then
        if not State.hauntedTowerAutoPlay and not State.hauntedTowerLoop then return end
        State.hauntedTowerAutoPlay=false
        if State.hauntedTowerLoop then pcall(task.cancel,State.hauntedTowerLoop) State.hauntedTowerLoop=nil end
    else
        if not State.towerAutoPlay and not State.towerLoop then return end
        State.towerAutoPlay=false
        if State.towerLoop then pcall(task.cancel,State.towerLoop) State.towerLoop=nil end
    end
    if UI.towerStopping then return end
    UI.towerStopping=true
    task.spawn(function()
        pcall(function() if Remotes.cancelTower then Remotes.cancelTower:InvokeServer() end end) task.wait(0.1)
        pcall(function() if Remotes.completeFloor then Remotes.completeFloor.InvokeServer(Remotes.completeFloor) end end) task.wait(1)
        F.updateTowerUI("Stopped","-","-")
        UI.towerStopping=false
    end)
end
Library.OnUnload(function()
    if not UI.towerStopping then
        F.stopTowerFarmLoop(false)
        F.stopTowerFarmLoop(true)
    end
end)
local Window=Library:CreateWindow({Title="Najz Hub",Icon="dices",Footer="https://discord.gg/ks8dXztPf",AutoShow=true,Center=true,Size=UDim2.fromOffset(700,650),Resizable=true,AlwaysOnTop=false,Snapping=false,SnapDistance=24,SnapMargin=8,SnapAvoidCoreGui=true,ToggleKeybind=Enum.KeyCode.RightControl,Animations={ToggleWindow=true,TabSwitch=true,Groupbox=true,Dropdown=true,KeyPicker=true},TabSwipeFrom="auto",TabButtonsStyle={Gap=0,Padding=0,CornerRadius=4,Indicator=false}})
local TabMain=Window:AddTab({Name="Main",Icon="dices",Description="Auto roll, rebirth, collect, potion"}) task.wait(0.03)
local TabHalloween=Window:AddTab({Name="Halloween",Icon="ghost",Description="Pumpkin dice, pass, candy shop, trick or treat"}) task.wait(0.03)
local TabTower=Window:AddTab({Name="Tower",Icon="tower-control",Description="Auto farm tower loop"}) task.wait(0.03)
local TabShop=Window:AddTab({Name="Shop",Icon="shopping-cart",Description="Auto sell, upgrade, dice shop, quest"}) task.wait(0.03)
local TabUnit=Window:AddTab({Name="Unit",Icon="users",Description="Level up, grade, trait"}) task.wait(0.03)
local TabTrade=Window:AddTab({Name="Trade",Icon="arrow-up-down",Description="Trade & gift unit"}) task.wait(0.03)
local TabFuse=Window:AddTab({Name="Fuse",Icon="flask-conical",Description="Auto fuse unit dari backpack"}) task.wait(0.03)
local TabWebhook=Window:AddTab({Name="Webhook",Icon="webhook",Description="Discord webhook notify"}) task.wait(0.03)
local TabServer=Window:AddTab({Name="Server",Icon="server",Description="Auto find weather & hop server"}) task.wait(0.03)
local TabMisc=Window:AddTab({Name="Misc",Icon="wrench",Description="Config, anti-lag, keybind"}) task.wait(0.03)
local eIdx=0
local MainLeft1=TabMain:AddGroupbox({Side=1,Name="Auto Roll",PopOut=false})
local MainLeft2=TabMain:AddGroupbox({Side=1,Name="Auto Rebirth",PopOut=false})
local MainLeft3=TabMain:AddGroupbox({Side=1,Name="Auto Use Spin",PopOut=false})
local MainRight1=TabMain:AddGroupbox({Side=2,Name="Collect Cash",PopOut=false})
local MainRight2=TabMain:AddGroupbox({Side=2,Name="Rebirth Info",PopOut=false})
local MainRight3=TabMain:AddGroupbox({Side=2,Name="Auto Use Potion",PopOut=false})
local MainRight4=TabMain:AddGroupbox({Side=2,Name="Rebirth Upgrades",PopOut=false}) task.wait(0.03)
local WebhookGroup=TabWebhook:AddGroupbox({Side=1,Name="Webhook Settings",PopOut=false})
local FuseWebhookGroup=TabWebhook:AddGroupbox({Side=1,Name="Fuse Result Filter",PopOut=false})
local PlayerDataGroup=TabWebhook:AddGroupbox({Side=2,Name="Player Data Reporter",PopOut=false})
local ShopLeft1=TabShop:AddGroupbox({Side=1,Name="Auto Sell",PopOut=false})
local ShopLeft2=TabShop:AddGroupbox({Side=1,Name="Upgrade Tree",PopOut=false})
local ShopRight1=TabShop:AddGroupbox({Side=2,Name="Dice Shop",PopOut=false})
local ShopRight2=TabShop:AddGroupbox({Side=2,Name="Auto Claim",PopOut=false})
local ShopRight3=TabShop:AddGroupbox({Side=2,Name="Quest Shop",PopOut=false})
local UnitLeft1=TabUnit:AddGroupbox({Side=1,Name="Select Slots",PopOut=false})
local UnitRight1=TabUnit:AddGroupbox({Side=2,Name="Auto Level Up",PopOut=false})
local UnitLeft2=TabUnit:AddGroupbox({Side=1,Name="Slot Info",PopOut=false})
local UnitLeft3=TabUnit:AddGroupbox({Side=1,Name="Auto Grade",PopOut=false})
local UnitRight2=TabUnit:AddGroupbox({Side=2,Name="Auto Trait",PopOut=false})
local UnitRight3=TabUnit:AddGroupbox({Side=2,Name="Quirks",PopOut=false})
local TradeLeft1=TabTrade:AddGroupbox({Side=1,Name="Send Trade Request",PopOut=false})
local TradeLeft2=TabTrade:AddGroupbox({Side=1,Name="Player List",PopOut=false})
local TradeRight1=TabTrade:AddGroupbox({Side=2,Name="Add Item",PopOut=false})
local GiftUnitGroup=TabTrade:AddGroupbox({Side=1,Name="Gift Unit by Filter",PopOut=false})
local KeybindGroup=TabMisc:AddGroupbox({Side=2,Name="Keybind Setting",PopOut=false})
local ConfigGroup=TabMisc:AddGroupbox({Side=2,Name="Config",PopOut=false})
local AutoLoadGroup=TabMisc:AddGroupbox({Side=2,Name="Auto Load Config",PopOut=false})
local MiscLeft1=TabMisc:AddGroupbox({Side=1,Name="Danger",PopOut=false})
local MiscLeft2=TabMisc:AddGroupbox({Side=1,Name="Utility",PopOut=false})
local MiscRight1=TabMisc:AddGroupbox({Side=2,Name="Equip Best (Plot)",PopOut=false})
local HauntedTowerGroup=TabTower:AddGroupbox({Side=1,Name="Haunted House Tower",PopOut=false})
local GearEquipGroup=TabTower:AddGroupbox({Side=1,Name="Equip Best Gear",PopOut=false})
local TowerGroup=TabTower:AddGroupbox({Side=2,Name="Auto Farm Tower",PopOut=false})
local TowerInfoGroup=TabTower:AddGroupbox({Side=2,Name="Tower Info",PopOut=false}) task.wait(0.03)
local FuseLeft1=TabFuse:AddGroupbox({Side=1,Name="Fuse Filter",PopOut=false})
local FuseLeft2=TabFuse:AddGroupbox({Side=1,Name="Auto Fuse",PopOut=false})
local FuseRight1=TabFuse:AddGroupbox({Side=2,Name="Fuse Info",PopOut=false})
local ServerLeft1=TabServer:AddGroupbox({Side=1,Name="Weather Finder",PopOut=false})
local ServerRight1=TabServer:AddGroupbox({Side=2,Name="Status",PopOut=false})
local HLeft1=TabHalloween:AddGroupbox({Side=1,Name="Pumpkin Dice",PopOut=false})
local HLeft2=TabHalloween:AddGroupbox({Side=1,Name="Candy Shop",PopOut=false})
local HLeft3=TabHalloween:AddGroupbox({Side=1,Name="Teleport",PopOut=false})
local HRight1=TabHalloween:AddGroupbox({Side=2,Name="Pumpkin Pass",PopOut=false})
local HRight2=TabHalloween:AddGroupbox({Side=2,Name="Trick or Treat",PopOut=false}) task.wait(0.05)
eIdx=eIdx+1 F.RegisterUI("webhookEnabled",WebhookGroup.AddToggle(WebhookGroup,eIdx,{Text="Enable Webhook",Default=false,Callback=function(s)Toggles.webhook=s end}))
eIdx=eIdx+1 F.RegisterUI("webhookUrl",WebhookGroup.AddInput(WebhookGroup,eIdx,{Text="Webhook URL",Default="",Placeholder="https://discord.com/api/webhooks/...",Finished=true,Callback=function(v)State.webhookUrl=v end}))
eIdx=eIdx+1 F.RegisterUI("webhookRarityFilter",WebhookGroup.AddDropdown(WebhookGroup,eIdx,{Text="Webhook Rarity Filter",Values=CFG.rarityFilterOptions,Multi=true,Callback=function(s)State.webhookRarityFilters=s end}))
eIdx=eIdx+1 F.RegisterUI("webhookMention",WebhookGroup.AddToggle(WebhookGroup,eIdx,{Text="Mention @everyone",Default=false,Callback=function(s)State.webhookMentionEveryone=s end}))
WebhookGroup:AddButton({Text="Test Webhook",Callback=function()if State.webhookUrl=="" then return end local t={username="Anime Dice Roller",content="Test!",embeds={{title="Test",description="OK",color=65280}}} local e=HS:JSONEncode(t) if requestFunc then pcall(function()requestFunc({Url=State.webhookUrl,Method="POST",Headers={["Content-Type"]="application/json"},Body=e})end) else pcall(function()HS:PostAsync(State.webhookUrl,e)end) end end})
State.webhookCounterLabel=WebhookGroup:AddLabel("Rolls sent: 0")
State.fuseWebhookLabel=WebhookGroup:AddLabel("Fuse sent: 0")
eIdx=eIdx+1 F.RegisterUI("fuseWebhook",WebhookGroup.AddToggle(WebhookGroup,eIdx,{Text="Fuse Result Webhook",Default=true,Callback=function(s)Toggles.fuseWebhook=s end}))
WebhookGroup:AddButton({Text="Test Fuse Webhook",Callback=function()if State.webhookUrl=="" then Library:Notify({Title="Webhook",Description="Set URL first!",Time=2}) return end task.spawn(function()F.sendFuseWebhook({name="Titanic Yuju",attributes={level=1,mutation="Emerald"}}) Library:Notify({Title="Webhook",Description="Sent!",Time=2})end) end})
eIdx=eIdx+1 F.RegisterUI("fuseWebhookRarityFilter",FuseWebhookGroup.AddDropdown(FuseWebhookGroup,eIdx,{Text="Rarity Filter (Fuse)",Values=CFG.rarityFilterOptions,Multi=true,Placeholder="Any...",AllowNull=true,Callback=function(s)State.fuseWebhookRarityFilter={} if s and next(s)~=nil then for k,v in pairs(s) do if v==true then State.fuseWebhookRarityFilter[k]=true end if type(v)=="string" and v~="" then State.fuseWebhookRarityFilter[v]=true end end end end}))
F.AddPopupButton(UIRegistry.fuseWebhookRarityFilter)
eIdx=eIdx+1 F.RegisterUI("fuseWebhookMinIncome",FuseWebhookGroup.AddInput(FuseWebhookGroup,eIdx,{Text="Min Income",Default="",Placeholder="e.g. 1t",Finished=true,Callback=function(v)State.fuseWebhookMinIncomeRaw=v or "" if not v or v=="" then State.fuseWebhookMinIncome=0 else State.fuseWebhookMinIncome=F.parseNumberString(v) end end}))
eIdx=eIdx+1 F.RegisterUI("weatherWebhook",WebhookGroup.AddToggle(WebhookGroup,eIdx,{Text="Weather Webhook Notify",Default=false,Callback=function(s)Toggles.weatherWebhook=s end}))
State.playerDataCounterLabel=PlayerDataGroup:AddLabel("Reports sent: 0")
eIdx=eIdx+1 F.RegisterUI("playerDataInterval",PlayerDataGroup.AddInput(PlayerDataGroup,eIdx,{Text="Interval (min)",Default="1",Placeholder="1",Finished=true,Callback=function(v)local n=tonumber(v) if n and n>=1 then State.playerDataInterval=math.floor(n) else State.playerDataInterval=1 end end}))
eIdx=eIdx+1 State.playerDataToggle=PlayerDataGroup.AddToggle(PlayerDataGroup,eIdx,{Text="Send Player Data",Default=false,Callback=function(s)Toggles.sendPlayerData=s if s then F.startPlayerDataLoop() else F.stopPlayerDataLoop() end end})
F.RegisterUI("sendPlayerData",State.playerDataToggle)
PlayerDataGroup:AddButton({Text="Send Now",Callback=function()if not isDestroyed then task.spawn(function()F.sendPlayerDataWebhook() if State.playerDataCounterLabel then State.playerDataCounterLabel:SetText("Reports sent: "..tostring(State.playerDataSentCount)) end end) end end})
task.delay(2,function() task.spawn(function()while not isDestroyed do if State.playerDataCounterLabel then State.playerDataCounterLabel:SetText("Reports sent: "..tostring(State.playerDataSentCount)) end task.wait(5) end end) end)
task.delay(2,function() task.spawn(function()while not isDestroyed do if Toggles.weatherWebhook then local i=F.getWeatherInfo() if i and i.startedAt~=State.weatherWebhookLastSent then State.weatherWebhookLastSent=i.startedAt F.sendWeatherWebhook(i) end end task.wait(1) end end) end)
eIdx=eIdx+1 F.RegisterUI("autoRoll",MainLeft1.AddToggle(MainLeft1,eIdx,{Text="Auto Roll",Default=false,Callback=function(s)Toggles.autoRoll=s if s then F.stopBruteForce() if State.bruteForceToggle then State.bruteForceToggle:SetValue(false) end task.spawn(function()while Toggles.autoRoll and not isDestroyed do F.performRoll() task.wait(State.rollDelay) end end) end end}))
eIdx=eIdx+1 State.bruteForceToggle=MainLeft1.AddToggle(MainLeft1,eIdx,{Text="Brute Force [BETA]",Default=false,Callback=function(s)Toggles.bruteForce=s if s then Toggles.autoRoll=false if UIRegistry.autoRoll then UIRegistry.autoRoll:SetValue(false) end F.startBruteForce() else F.stopBruteForce() end end})
F.RegisterUI("bruteForce",State.bruteForceToggle)
State.rollDelayLabel=MainLeft1:AddLabel("Roll Delay: -")
task.delay(2,function() task.spawn(function()while not isDestroyed do if State.rollDelayLabel then State.rollDelayLabel:SetText(string.format("Roll Delay: %.2fs",tonumber(State.rollDelay) or 0)) end task.wait(1) end end) end)
eIdx=eIdx+1 State.autoRebirthToggle=MainLeft2.AddToggle(MainLeft2,eIdx,{Text="Auto Rebirth",Default=false,Callback=function(s)Toggles.autoRebirth=s if s then F.startAutoRebirthLoop() else F.stopAutoRebirthLoop() end end})
F.RegisterUI("autoRebirth",State.autoRebirthToggle)
eIdx=eIdx+1 F.RegisterUI("stopAtRebirth",MainLeft2.AddSlider(MainLeft2,eIdx,{Text="Stop at Rebirth",Default=MAX_REBIRTH,Min=0,Max=MAX_REBIRTH,Suffix="",Callback=function(v)State.stopAtRebirth=math.floor(v) F.updateRebirthInfo() end}))
eIdx=eIdx+1 F.RegisterUI("selectSpinType",MainLeft3.AddDropdown(MainLeft3,eIdx,{Text="Spin Type",Values=CFG.SPIN_TYPES,Multi=true,Placeholder="Select...",AllowNull=true,Callback=function(s)State.selectedSpinTypes={} if s and next(s)~=nil then for k,v in pairs(s) do if v==true then State.selectedSpinTypes[k]=true end if type(v)=="string" and v~="" then State.selectedSpinTypes[v]=true end end end end}))
eIdx=eIdx+1
local triggerEventsDropdown=MainLeft3.AddDropdown(MainLeft3,eIdx,{Text="Trigger On Weather",Values=CFG.SPIN_TRIGGER_EVENTS,Multi=true,Placeholder="Pick event(s)...",AllowNull=true,Callback=function(s)
    State.selectedSpinTriggerEvents={}
    if s and next(s)~=nil then
        for k,v in pairs(s) do
            if v==true then table.insert(State.selectedSpinTriggerEvents,k) end
            if type(k)=="number" and type(v)=="string" and v~="" then table.insert(State.selectedSpinTriggerEvents,v) end
        end
    end
end})
F.RegisterUI("spinTriggerEvents",triggerEventsDropdown)
F.AddPopupButton(triggerEventsDropdown)
task.defer(function()
    pcall(function() triggerEventsDropdown:SetValue({["Luck Event"]=true}) end)
end)
eIdx=eIdx+1 F.RegisterUI("spinPerEvent",MainLeft3.AddInput(MainLeft3,eIdx,{Text="Per Event",Default="5",Placeholder="5",Finished=true,Callback=function(v)local n=tonumber(v) if n and n>0 then State.spinPerEvent=math.floor(n) else State.spinPerEvent=5 end end}))
eIdx=eIdx+1 F.RegisterUI("spinStopAt",MainLeft3.AddInput(MainLeft3,eIdx,{Text="Stop At",Default="2",Placeholder="2",Finished=true,Callback=function(v)local n=tonumber(v) if n and n>=0 then State.spinStopAt=math.floor(n) else State.spinStopAt=2 end end}))
eIdx=eIdx+1 F.RegisterUI("spinRequirePotion",MainLeft3.AddToggle(MainLeft3,eIdx,{Text="Require Luck Potion",Default=true,Callback=function(s)State.spinRequirePotion=s end}))
eIdx=eIdx+1 F.RegisterUI("autoUseSpin",MainLeft3.AddToggle(MainLeft3,eIdx,{Text="Auto Use Spin",Default=false,Callback=function(s)Toggles.autoUseSpin=s if s then F.startAutoUseSpinLoop() else F.stopAutoUseSpinLoop() end end}))
MainRight1:AddButton({Text="Collect All (1-32)",Callback=function()if not isDestroyed then F.collectAllPlots() end end})
eIdx=eIdx+1 F.RegisterUI("autoCollect",MainRight1.AddToggle(MainRight1,eIdx,{Text="Auto Collect",Default=false,Callback=function(s)Toggles.autoCollect=s if s then F.startAutoCollectLoop() else F.stopAutoCollectLoop() end end}))
eIdx=eIdx+1 F.RegisterUI("collectInterval",MainRight1.AddSlider(MainRight1,eIdx,{Text="Interval",Default=State.collectInterval,Min=1,Max=60,Suffix="s",Callback=function(v)State.collectInterval=v end}))
eIdx=eIdx+1 F.RegisterUI("selectPotionCategory",MainRight3.AddDropdown(MainRight3,eIdx,{Text="Category",Values=CFG.POTION_CATEGORIES,Multi=true,Placeholder="Select...",AllowNull=true,Callback=function(s)State.selectedPotionCategories={} if s and next(s)~=nil then for k,v in pairs(s) do if v==true then State.selectedPotionCategories[k]=true end if type(v)=="string" and v~="" then State.selectedPotionCategories[v]=true end end end end}))
eIdx=eIdx+1 F.RegisterUI("selectPotionTower",MainRight3.AddDropdown(MainRight3,eIdx,{Text="Potion",Values=CFG.POTION_TOWER_ORDER,Multi=true,Placeholder="Select...",AllowNull=true,Callback=function(s)State.selectedPotionTowers={} if s and next(s)~=nil then for k,v in pairs(s) do if v==true then State.selectedPotionTowers[k]=true end if type(v)=="string" and v~="" then State.selectedPotionTowers[v]=true end end end end}))
eIdx=eIdx+1 F.RegisterUI("maxPotionTier",MainRight3.AddDropdown(MainRight3,eIdx,{Text="Max Tier",Values={"I","II","III","IV"},Default="IV",Multi=false,AllowNull=false,Callback=function(v)if type(v)=="table" then for k,vv in pairs(v) do if vv==true then State.maxPotionTier=k break end end elseif type(v)=="string" and v~="" then State.maxPotionTier=v else State.maxPotionTier="IV" end end}))
eIdx=eIdx+1 F.RegisterUI("autoUsePotionThreshold",MainRight3.AddSlider(MainRight3,eIdx,{Text="Re-use Threshold",Default=10,Min=1,Max=60,Suffix="s",Callback=function(v)State.autoUsePotionThreshold=math.floor(v) end}))
eIdx=eIdx+1 F.RegisterUI("usePotionOnlyOnWeather",MainRight3.AddToggle(MainRight3,eIdx,{Text="Only On Weather",Default=false,Callback=function(s)State.usePotionOnlyOnWeather=s end}))
eIdx=eIdx+1 F.RegisterUI("autoUsePotion",MainRight3.AddToggle(MainRight3,eIdx,{Text="Auto Use Potion",Default=false,Callback=function(s)Toggles.autoUsePotion=s if s then F.startAutoUsePotionLoop() else F.stopAutoUsePotionLoop() end end}))
State.autoRebirthInfoLabel=MainRight2:AddLabel("Rebirth: -")
State.autoRebirthTargetLabel=MainRight2:AddLabel("Target: -")
State.autoRebirthMoneyLabel=MainRight2:AddLabel("Money: - / -")
State.autoRebirthStatusLabel=MainRight2:AddLabel("Status: -")
task.delay(2,function() task.spawn(function()while not isDestroyed do F.updateRebirthInfo() task.wait(2) end end) end)
State.autoRebirthStatsInfoLabel=MainRight4:AddLabel("Points: - | Spent: -")
eIdx=eIdx+1 State.autoRebirthStatsToggle=MainRight4.AddToggle(MainRight4,eIdx,{Text="Auto Spend Points",Default=false,Callback=function(s)Toggles.autoRebirthStats=s if s then F.startAutoRebirthStatsLoop() else F.stopAutoRebirthStatsLoop() end end})
F.RegisterUI("autoRebirthStats",State.autoRebirthStatsToggle)
eIdx=eIdx+1 F.RegisterUI("rebirthStatsOrder",MainRight4.AddDropdown(MainRight4,eIdx,{Text="Priority Order",Values={"Luck","Money","Damage","Health","Trait Luck","Grade Luck"},Multi=true,Placeholder="Select...",AllowNull=true,Callback=function(s)
    if not s or next(s)==nil then State.autoRebirthStatsOrder={"Luck","Money","Damage","Trait Luck","Grade Luck","Health"} return end
    local sel={}
    for k,v in pairs(s) do if v==true then table.insert(sel,k) end if type(v)=="string" and v~="" then table.insert(sel,v) end end
    if #sel==0 then State.autoRebirthStatsOrder={"Luck","Money","Damage","Trait Luck","Grade Luck","Health"} else State.autoRebirthStatsOrder=sel end
end}))
F.AddPopupButton(UIRegistry.rebirthStatsOrder)
MainRight4:AddButton({Text="Spend Once",Callback=function()if not isDestroyed then local s=F.spendRebirthPoints() Library:Notify({Title="Rebirth Stats",Description="Spent: "..tostring(s),Time=2}) end end})
MainRight4:AddButton({Text="Use Reset Token",Callback=function()if not isDestroyed and Remotes.useResetTokenSignal then pcall(function()Remotes.useResetTokenSignal:Fire()end) Library:Notify({Title="Rebirth Stats",Description="Reset sent!",Time=2}) end end})
eIdx=eIdx+1 State.diceDropdown=ShopRight1.AddDropdown(ShopRight1,eIdx,{Text="Select Dice",Values={},Placeholder="Select...",AllowNull=true,Callback=function(n)State.selectedDiceToBuy=n end})
F.AddPopupButton(State.diceDropdown)
ShopRight1:AddButton({Text="Refresh Dice List",Callback=function() if not isDestroyed then F.refreshDiceDropdown() end end})
ShopRight1:AddButton({Text="Buy Selected",Callback=function()if not isDestroyed then F.buySelectedDice() end end})
eIdx=eIdx+1 State.autoBuyDiceToggle=ShopRight1.AddToggle(ShopRight1,eIdx,{Text="Auto Buy Dice",Default=false,Callback=function(s)Toggles.autoBuyDice=s if s then F.startAutoBuyDiceLoop() else F.stopAutoBuyDiceLoop() end end})
F.RegisterUI("autoBuyDice",State.autoBuyDiceToggle)
State.diceInfoLabel=ShopRight1:AddLabel("Money: -\nDice: -")
ShopRight1:AddButton({Text="Equip Best Dice",Callback=function()if not isDestroyed then F.equipBestDice() end end})
eIdx=eIdx+1 UI.dd_sellRarityFilter=ShopLeft1.AddDropdown(ShopLeft1,eIdx,{Text="Rarity Filter",Values=CFG.rarityFilterOptions,Multi=true,Callback=function(s)State.selectedSellRarities=s end})
F.RegisterUI("sellRarityFilter",UI.dd_sellRarityFilter)
F.AddPopupButton(UI.dd_sellRarityFilter)
eIdx=eIdx+1 F.RegisterUI("sellIncomeThreshold",ShopLeft1.AddInput(ShopLeft1,eIdx,{Text="Income Threshold",Default="",Placeholder="e.g. 1.5k",Finished=true,Callback=function(v)if not v or v=="" then State.sellIncomeThreshold=0 else State.sellIncomeThreshold=F.parseNumberString(v) end end}))
eIdx=eIdx+1 F.RegisterUI("sellChanceThreshold",ShopLeft1.AddInput(ShopLeft1,eIdx,{Text="Max 1 in X",Default="",Placeholder="e.g. 1t",Finished=true,Callback=function(v)State.sellChanceThresholdRaw=v or "" if not v or v=="" then State.sellChanceThreshold=0 else State.sellChanceThreshold=F.parseNumberString(v) end end}))
eIdx=eIdx+1 F.RegisterUI("autoSell",ShopLeft1.AddToggle(ShopLeft1,eIdx,{Text="Auto Sell",Default=false,Callback=function(s)Toggles.autoSell=s if s then F.startAutoSellLoop() else F.stopAutoSellLoop() end end}))
eIdx=eIdx+1 F.RegisterUI("autoUpgrade",ShopLeft2.AddToggle(ShopLeft2,eIdx,{Text="Auto Buy Tree",Default=false,Callback=function(s)Toggles.autoUpgrade=s if s then F.startAutoUpgradeLoop() else F.stopAutoUpgradeLoop() end end}))
State.upgradeStatusLabel=ShopLeft2:AddLabel("Status: Idle")
eIdx=eIdx+1 State.autoClaimToggle=ShopRight2.AddToggle(ShopRight2,eIdx,{Text="Auto Claim Quest",Default=false,Callback=function(s)Toggles.autoClaim=s if s then F.startAutoClaimLoop() else F.stopAutoClaimLoop() end end})
F.RegisterUI("autoClaim",State.autoClaimToggle)
ShopRight2:AddButton({Text="Claim Now",Callback=function()if not isDestroyed then F.claimCompletedQuests() Library:Notify({Title="Quest",Description="Claimed!",Time=2}) end end})
eIdx=eIdx+1 UI.shopDropdown=ShopRight3.AddDropdown(ShopRight3,eIdx,{Text="Select Item",Values=State.questShopItems,Placeholder="Select...",AllowNull=true,Callback=function(v)State.selectedShopItem=v if State.selectedShopItem and QuestConfig and QuestConfig.Shop then for _,i in ipairs(QuestConfig.Shop) do if i.name==State.selectedShopItem then State.questShopPriceLabel:SetText("Price: "..(i.tickets or 0).." Tickets") break end end else State.questShopPriceLabel:SetText("Price: -") end end})
F.AddPopupButton(UI.shopDropdown)
State.questShopTicketsLabel=ShopRight3:AddLabel("Tickets: -")
State.questShopPriceLabel=ShopRight3:AddLabel("Price: -")
State.questShopBuyBtn=ShopRight3:AddButton({Text="Buy 1x",Callback=function()if not isDestroyed then F.buyQuestShopItem() end end})
eIdx=eIdx+1 State.autoBuyQuestToggle=ShopRight3.AddToggle(ShopRight3,eIdx,{Text="Auto Buy",Default=false,Callback=function(s)Toggles.autoBuyQuest=s if s then if not State.selectedShopItem then Library:Notify({Title="Quest",Description="Select first!",Time=2}) Toggles.autoBuyQuest=false State.autoBuyQuestToggle:SetValue(false) return end F.startAutoBuyQuestLoop() else F.stopAutoBuyQuestLoop() end end})
F.RegisterUI("autoBuyQuest",State.autoBuyQuestToggle)
task.delay(2,function() task.spawn(function()while not isDestroyed do F.updateQuestShopTickets() task.wait(15) end end) end)
State.slotInfoLabel=UnitLeft2:AddLabel("Select slots",true)
eIdx=eIdx+1 State.slotDropdown=UnitLeft1.AddDropdown(UnitLeft1,eIdx,{Text="Select Slots",Values={},Multi=true,Placeholder="Select...",AllowNull=true,Callback=function(s)State.selectedLevelUpSlots={} if s and next(s)~=nil then for o,e in pairs(s) do if e and State.slotOptionsMap[o] then table.insert(State.selectedLevelUpSlots,State.slotOptionsMap[o]) end end end F.updateSlotInfoLabel() end})
F.AddPopupButton(State.slotDropdown)
UnitLeft1:AddButton({Text="Refresh Slots",Callback=function() F.refreshSlotDropdown() end})
eIdx=eIdx+1 F.RegisterUI("autoLevelUp",UnitRight1.AddToggle(UnitRight1,eIdx,{Text="Auto Level Up",Default=false,Callback=function(s)Toggles.autoLevelUp=s if s then if #State.selectedLevelUpSlots==0 then Toggles.autoLevelUp=false return end F.startLevelUpLoop() else F.stopLevelUpLoop() end end}))
eIdx=eIdx+1 F.RegisterUI("targetLevel",UnitRight1.AddSlider(UnitRight1,eIdx,{Text="Target Level",Default=State.levelUpTarget,Min=1,Max=100,Suffix="",Callback=function(v)State.levelUpTarget=math.floor(v) end}))
State.gradeInfoLabel=UnitLeft3:AddLabel("Grade: -")
eIdx=eIdx+1 State.rollUnitDropdown=UnitLeft3.AddDropdown(UnitLeft3,eIdx,{Text="Select Units",Values={},Multi=true,Placeholder="Select...",AllowNull=true,Callback=function(s)State.selectedRollUnitKeys={} if s and next(s)~=nil then for o,e in pairs(s) do if e and State.rollUnitOptionsMap[o] then table.insert(State.selectedRollUnitKeys,State.rollUnitOptionsMap[o]) end end end F.updateRollUnitInfo() end})
F.AddPopupButton(State.rollUnitDropdown)
UnitLeft3:AddButton({Text="Refresh Units",Callback=function() F.refreshRollUnitDropdown() end})
eIdx=eIdx+1 State.gradeTargetDropdown=UnitLeft3.AddDropdown(UnitLeft3,eIdx,{Text="Target Grade",Values=CFG.gradeTargetOptions,Multi=true,Default={},AllowNull=true,Callback=function(s)State.selectedGradeTargets={} if s then for k,v in pairs(s) do if v then table.insert(State.selectedGradeTargets,k) end end end end})
F.RegisterUI("targetGrade",State.gradeTargetDropdown)
F.AddPopupButton(State.gradeTargetDropdown)
eIdx=eIdx+1 State.autoGradeToggle=UnitLeft3.AddToggle(UnitLeft3,eIdx,{Text="Auto Roll Grade",Default=false,Callback=function(s)Toggles.autoGrade=s if s then if #State.selectedRollUnitKeys==0 then Toggles.autoGrade=false if State.autoGradeToggle then State.autoGradeToggle:SetValue(false) end return end F.startAutoGradeLoop() else F.stopAutoGradeLoop() end end})
F.RegisterUI("autoGrade",State.autoGradeToggle)
State.traitInfoLabel=UnitRight2:AddLabel("Trait: -")
eIdx=eIdx+1 State.traitTargetDropdown=UnitRight2.AddDropdown(UnitRight2,eIdx,{Text="Target Trait",Values=CFG.traitTargetOptions,Multi=true,Default={},AllowNull=true,Callback=function(s)State.selectedTraitTargets={} if s then for k,v in pairs(s) do if v then table.insert(State.selectedTraitTargets,k) end end end end})
F.RegisterUI("targetTrait",State.traitTargetDropdown)
F.AddPopupButton(State.traitTargetDropdown)
eIdx=eIdx+1 State.autoTraitToggle=UnitRight2.AddToggle(UnitRight2,eIdx,{Text="Auto Roll Trait",Default=false,Callback=function(s)Toggles.autoTrait=s if s then if #State.selectedRollUnitKeys==0 then Toggles.autoTrait=false if State.autoTraitToggle then State.autoTraitToggle:SetValue(false) end return end F.startAutoTraitLoop() else F.stopAutoTraitLoop() end end})
F.RegisterUI("autoTrait",State.autoTraitToggle)
local quirkOpts={}
if Quirks then for n in pairs(Quirks) do table.insert(quirkOpts,n) end end
table.sort(quirkOpts)
eIdx=eIdx+1
State.quirksUnitDropdown=UnitRight3.AddDropdown(UnitRight3,eIdx,{Text="Units",Values={},Multi=true,Placeholder="Select...",AllowNull=true,Callback=function(s)
    State.quirksSelectedUnits={}
    if s and next(s)~=nil then
        for o,e in pairs(s) do if e and State.quirksUnitOptionsMap[o] then table.insert(State.quirksSelectedUnits,State.quirksUnitOptionsMap[o]) end end
    end
    F.updateQuirksInfo()
end})
F.AddPopupButton(State.quirksUnitDropdown)
eIdx=eIdx+1
State.quirksTargetDropdown=UnitRight3.AddDropdown(UnitRight3,eIdx,{Text="Target Quirks",Values=quirkOpts,Multi=true,Placeholder="Select targets...",AllowNull=true,Callback=function(s)
    State.quirksTargets={}
    if s and next(s)~=nil then
        for k,v in pairs(s) do
            if v==true then table.insert(State.quirksTargets,k) end
            if type(k)=="number" and type(v)=="string" and v~="" then table.insert(State.quirksTargets,v) end
        end
    end
    F.updateQuirksInfo()
end})
F.AddPopupButton(State.quirksTargetDropdown)
State.quirksInfoLabel=UnitRight3:AddLabel("Select units to view quirks",true)
eIdx=eIdx+1
State.quirksAutoToggle=UnitRight3.AddToggle(UnitRight3,eIdx,{Text="Auto Roll Quirk",Default=false,Callback=function(s)
    Toggles.quirksAuto=s
    if s then
        if #State.quirksSelectedUnits==0 then Library:Notify({Title="Quirks",Description="Select units first!",Time=2}) Toggles.quirksAuto=false if State.quirksAutoToggle then State.quirksAutoToggle:SetValue(false) end return end
        if #State.quirksTargets==0 then Library:Notify({Title="Quirks",Description="Select target quirks first!",Time=2}) Toggles.quirksAuto=false if State.quirksAutoToggle then State.quirksAutoToggle:SetValue(false) end return end
        F.startQuirksLoop()
    else F.stopQuirksLoop() end
end})
F.RegisterUI("quirksAuto",State.quirksAutoToggle)
UnitRight3:AddButton({Text="Roll Once",Callback=function() if not isDestroyed then F.processQuirks() end end})
UnitRight3:AddButton({Text="Refresh Units",Callback=function() F.refreshQuirkUnitDropdown() end})
task.delay(1,function() pcall(F.refreshQuirkUnitDropdown) end)
TradeLeft2:AddLabel("Click Refresh")
eIdx=eIdx+1 State.tradePlayerDropdown=TradeLeft1.AddDropdown(TradeLeft1,eIdx,{Text="Select Player",Values={},Placeholder="Select...",AllowNull=true,Callback=function(dn)State.selectedTradePlayer=nil for _,p in pairs(Players:GetPlayers()) do if p.DisplayName==dn then State.selectedTradePlayer=p break end end end})
TradeLeft1:AddButton({Text="Send Trade Request",Callback=function()if State.selectedTradePlayer and Remotes.tradeRequestSignal then Remotes.tradeRequestSignal:Fire(State.selectedTradePlayer) end end})
TradeLeft2:AddButton({Text="Refresh Player",Callback=function()F.refreshTradePlayerDropdown() end})
eIdx=eIdx+1 State.giftItemDropdown=TradeRight1.AddDropdown(TradeRight1,eIdx,{Text="Select Item",Values={},Placeholder="Select...",AllowNull=true,Callback=function(v)if v and State.giftItemMap[v] then State.selectedGiftItem=State.giftItemMap[v] end end})
TradeRight1:AddButton({Text="Refresh Item",Callback=function()F.refreshGiftItemDropdown() end})
TradeRight1:AddButton({Text="Add Item (x1)",Callback=function()if not State.selectedGiftItem then return end if not Remotes.changeOfferSignal then return end pcall(function()Remotes.changeOfferSignal:Fire(State.selectedGiftItem,1)end) end})
eIdx=eIdx+1 State.autoGiftToggle=TradeRight1.AddToggle(TradeRight1,eIdx,{Text="Auto Gift",Default=false,Callback=function(s)Toggles.autoGift=s if s then if not State.selectedGiftItem then Toggles.autoGift=false if State.autoGiftToggle then State.autoGiftToggle:SetValue(false) end return end F.startAutoGiftLoop() else F.stopAutoGiftLoop() end end})
F.RegisterUI("autoGift",State.autoGiftToggle)
Players.PlayerAdded:Connect(function(p)if not isDestroyed then F.refreshTradePlayerDropdown() end end)
Players.PlayerRemoving:Connect(function(p)if not isDestroyed then F.refreshTradePlayerDropdown() end end)
eIdx=eIdx+1 F.RegisterUI("giftUnitMinChance",GiftUnitGroup.AddInput(GiftUnitGroup,eIdx,{Text="Min Chance (1 in X)",Default="1t",Placeholder="e.g. 10t",Finished=true,Callback=function(v)State.giftUnitMinChance=F.parseNumberString(v) end}))
eIdx=eIdx+1 F.RegisterUI("giftUnitMaxChance",GiftUnitGroup.AddInput(GiftUnitGroup,eIdx,{Text="Max Chance (1 in X)",Default="20t",Placeholder="e.g. 20t",Finished=true,Callback=function(v)State.giftUnitMaxChance=F.parseNumberString(v) end}))
eIdx=eIdx+1 F.RegisterUI("giftUnitMaxIncome",GiftUnitGroup.AddInput(GiftUnitGroup,eIdx,{Text="Max Income",Default="10t",Placeholder="e.g. 10t",Finished=true,Callback=function(v)State.giftUnitMaxIncome=F.parseNumberString(v) end}))
GiftUnitGroup:AddButton({Text="Gift Once",Callback=function()if not isDestroyed then F.processGiftUnit(true) end end})
eIdx=eIdx+1 State.autoGiftUnitToggle=GiftUnitGroup.AddToggle(GiftUnitGroup,eIdx,{Text="Auto Gift Unit",Default=false,Callback=function(s)Toggles.autoGiftUnit=s if s then F.startAutoGiftUnitLoop() else F.stopAutoGiftUnitLoop() end end})
F.RegisterUI("autoGiftUnit",State.autoGiftUnitToggle)
eIdx=eIdx+1 F.RegisterUI("fuseMinChance",FuseLeft1.AddInput(FuseLeft1,eIdx,{Text="Min 1 in X",Default="",Placeholder="e.g. 100, 1k",Finished=true,Callback=function(v)State.fuseMinChanceRaw=v or "" if not v or v=="" then State.fuseMinChance=0 else State.fuseMinChance=F.parseNumberString(v) end F.updateFuseInfo() end}))
eIdx=eIdx+1 F.RegisterUI("fuseMaxChance",FuseLeft1.AddInput(FuseLeft1,eIdx,{Text="Max 1 in X",Default="",Placeholder="e.g. 1t",Finished=true,Callback=function(v)State.fuseMaxChanceRaw=v or "" if not v or v=="" then State.fuseMaxChance=math.huge else State.fuseMaxChance=F.parseNumberString(v) end F.updateFuseInfo() end}))
eIdx=eIdx+1 F.RegisterUI("fuseMaxIncome",FuseLeft1.AddInput(FuseLeft1,eIdx,{Text="Max Income",Default="",Placeholder="e.g. 1t",Finished=true,Callback=function(v)State.fuseMaxIncomeRaw=v or "" if not v or v=="" then State.fuseMaxIncome=math.huge else State.fuseMaxIncome=F.parseNumberString(v) end F.updateFuseInfo() end}))
eIdx=eIdx+1 State.autoFuseToggle=FuseLeft2.AddToggle(FuseLeft2,eIdx,{Text="Auto Fuse",Default=false,Callback=function(s)Toggles.autoFuse=s if s then F.startAutoFuseLoop() local ae=(State.fuseMinChanceRaw or "")=="" and (State.fuseMaxChanceRaw or "")=="" and (State.fuseMaxIncomeRaw or "")=="" if ae then Library:Notify({Title="Fuse",Description="Fill 1 filter!",Time=3}) end else F.stopAutoFuseLoop() end end})
F.RegisterUI("autoFuse",State.autoFuseToggle)
FuseLeft2:AddButton({Text="Fuse Once",Callback=function()if isDestroyed then return end local ok=F.processAutoFuse() if not ok then Library:Notify({Title="Fuse",Description="Not enough (need 3)",Time=2}) end end})
eIdx=eIdx+1 F.RegisterUI("targetWeather",ServerLeft1.AddDropdown(ServerLeft1,eIdx,{Text="Target Weather",Values=CFG.WEATHER_LIST,Multi=true,AllowNull=true,Callback=function(v)State.targetWeatherList={} if type(v)=="table" then for k,vv in pairs(v) do if vv==true then table.insert(State.targetWeatherList,k) end if type(k)=="number" and type(vv)=="string" and vv~="" then table.insert(State.targetWeatherList,vv) end end elseif type(v)=="string" and v~="" then table.insert(State.targetWeatherList,v) end end}))
F.AddPopupButton(UIRegistry.targetWeather)
if State.weatherFinderResume and type(State.targetWeatherList)=="table" then
    local restoredTargets={}
    for _,weatherName in ipairs(State.targetWeatherList) do
        if type(weatherName)=="string" and weatherName~="" then restoredTargets[weatherName]=true end
    end
    pcall(function() UIRegistry.targetWeather:SetValue(restoredTargets) end)
end
ServerLeft1:AddButton({Text="Check Current Weather",Callback=function()
    local w=F.getWeatherInfo()
    if w then Library:Notify({Title="Weather",Description="Current: "..w.name.." ("..F.formatDuration(w.remaining)..")",Time=5})
    else Library:Notify({Title="Weather",Description="Tidak ada weather aktif",Time=3}) end
end})
eIdx=eIdx+1
UI.hopDelaySlider=ServerLeft1.AddSlider(ServerLeft1,eIdx,{Text="Hop Delay",Default=10,Min=3,Max=60,Suffix="s",Callback=function(v)local n=tonumber(v) if n and n>=1 then State.weatherFinderHopDelay=math.floor(n) F.saveHopDelay(math.floor(n)) end end})
F.RegisterUI("weatherFinderHopDelay",UI.hopDelaySlider)
local _savedWeatherHopDelay=tonumber(_weatherResumeState.hopDelay) or F.loadHopDelay() or 10
_savedWeatherHopDelay=math.clamp(math.floor(_savedWeatherHopDelay),3,60)
State.weatherFinderHopDelay=_savedWeatherHopDelay
pcall(function() UI.hopDelaySlider:SetValue(_savedWeatherHopDelay) end)
State.hopDelayLabel=ServerLeft1:AddLabel("Hop Delay: "..tostring(State.weatherFinderHopDelay).."s")
eIdx=eIdx+1
State.weatherFinderToggle=ServerLeft1.AddToggle(ServerLeft1,eIdx,{Text="Auto Find Weather",Default=false,Callback=function(s)
    Toggles.autoFindWeather=s
    if s then
        if not State.weatherFinderResume then
            State.triedServerIds = {}
            State.weatherFinderAttempts = 0
        end
        State.weatherFinderResume = false
        local triedArr = {}
        for serverId in pairs(State.triedServerIds) do
            table.insert(triedArr, serverId)
        end
        F.saveState({autoFindWeather=true,targetWeatherList=State.targetWeatherList or {},hopDelay=State.weatherFinderHopDelay or 10,attempts=State.weatherFinderAttempts or 0,tried=triedArr})
        F.startWeatherFinderLoop()
    else
        State.teleportPending=false
        F.stopWeatherFinderLoop()
        F.clearState()
        pcall(function()
            local fn=F.getQueueFunc()
            if type(fn)=="function" then fn("") end
        end)
    end
end})
F.RegisterUI("autoFindWeather",State.weatherFinderToggle)
if State.weatherFinderResume and State.targetWeatherList and #State.targetWeatherList > 0 then
    task.defer(function()
        if not isDestroyed and State.weatherFinderToggle then
            State.weatherFinderToggle:SetValue(true)
        end
    end)
end
State.weatherFinderStatus=ServerRight1:AddLabel("Status: Idle",true)
State.weatherFinderCurrentLabel=ServerRight1:AddLabel("Current: -",true)
State.weatherFinderTargetLabel=ServerRight1:AddLabel("Target: -",true)
State.weatherFinderAttemptsLabel=ServerRight1:AddLabel("Attempts: 0",true)
eIdx=eIdx+1 State.autoLoadConfigDropdown=AutoLoadGroup.AddDropdown(AutoLoadGroup,eIdx,{Text="Auto Load Config",Values=ConfigManager.List(),Placeholder="Select config...",AllowNull=true,Multi=false,Callback=function(v)if type(v)=="table" then for k,vv in pairs(v) do if vv==true then State.selectedAutoLoadConfig=k break end end elseif type(v)=="string" and v~="" then State.selectedAutoLoadConfig=v else State.selectedAutoLoadConfig=nil end if State.selectedAutoLoadConfig then F.saveAutoLoad(State.selectedAutoLoadConfig) Library:Notify({Title="Auto Load",Description="Saved: "..State.selectedAutoLoadConfig,Time=2}) else F.clearAutoLoad() Library:Notify({Title="Auto Load",Description="Cleared",Time=2}) end end})
eIdx=eIdx+1 State.autoLoadToggle=AutoLoadGroup.AddToggle(AutoLoadGroup,eIdx,{Text="Enable Auto Load",Default=false,Callback=function(s)Toggles.autoLoadConfig=s if s then if not State.selectedAutoLoadConfig or State.selectedAutoLoadConfig=="" then Library:Notify({Title="Auto Load",Description="Pilih config dulu!",Time=2}) Toggles.autoLoadConfig=false if State.autoLoadToggle then State.autoLoadToggle:SetValue(false) end return end F.saveAutoLoad(State.selectedAutoLoadConfig) Library:Notify({Title="Auto Load",Description="Enabled: "..State.selectedAutoLoadConfig,Time=2}) else F.clearAutoLoad() end end})
F.RegisterUI("autoLoadConfig",State.autoLoadToggle)
AutoLoadGroup:AddButton({Text="Load Now",Callback=function()if not State.selectedAutoLoadConfig or State.selectedAutoLoadConfig=="" then Library:Notify({Title="Auto Load",Description="Pilih config dulu!",Time=2}) return end ConfigManager.configs=F.loadConfigsFromFile() if ConfigManager.Load(State.selectedAutoLoadConfig) then Library:Notify({Title="Auto Load",Description="Loaded: "..State.selectedAutoLoadConfig,Time=2}) else Library:Notify({Title="Auto Load",Description="Failed!",Time=2}) end end})
AutoLoadGroup:AddButton({Text="Refresh List",Callback=function()ConfigManager.configs=F.loadConfigsFromFile() if State.autoLoadConfigDropdown and State.autoLoadConfigDropdown.SetValues then State.autoLoadConfigDropdown:SetValues(ConfigManager.List()) end Library:Notify({Title="Auto Load",Description="List refreshed!",Time=2}) end})
State.autoLoadStatusLabel=AutoLoadGroup:AddLabel("Status: -")
eIdx=eIdx+1
local keybindInput=KeybindGroup.AddInput(KeybindGroup,eIdx,{Text="Keybind",Default="",Placeholder="Click then press a key...",Finished=true,Callback=function(v)
    if not v or v=="" then State.uiToggleKeybind="" return end
    local c=tostring(v):gsub("%s+","")
    if c=="" then State.uiToggleKeybind="" return end
    State.uiToggleKeybind=""
    for _,key in ipairs(Enum.KeyCode:GetEnumItems()) do
        if key.Name:lower()==c:lower() then State.uiToggleKeybind=key.Name return end
    end
end})
F.RegisterUI("keybind",keybindInput)
local function keyDisplayName(name)
    local map={One="1",Two="2",Three="3",Four="4",Five="5",Six="6",Seven="7",Eight="8",Nine="9",Zero="0",
        Equals="=",Minus="-",Slash="/",Backslash="\\",Backspace="⌫",Return="⏎",Tab="⇥",Space="␣",
        LeftBracket="[",RightBracket="]",Semicolon=";",Quote="'",Comma=",",Period=".",Grave="`",
        LeftAlt="LAlt",RightAlt="RAlt",LeftControl="LCtrl",RightControl="RCtrl",
        LeftShift="LShift",RightShift="RShift",CapsLock="Caps"}
    return map[name] or name
end
local function nameToKeyCode(name)
    if not name or name=="" then return nil end
    local ok,kc=pcall(function() return Enum.KeyCode:FromName(name) end)
    if ok and kc then return kc end
    ok,kc=pcall(function() return Enum.KeyCode[name] end)
    if ok and kc then return kc end
    return nil
end
task.defer(function()
    local box
    for _, c in ipairs(keybindInput.Holder:GetDescendants()) do
        if c:IsA("TextBox") then box = c break end
    end
    if not box then return end
    pcall(function() box.TextEditable = false end)
    box.PlaceholderText = "Click then press a key..."
    box.Text = ""
    local picking = false
    local function enterPicking()
        if picking then return end
        picking = true
        State._pickingKeybind = true
        box.Text = ""
        box.PlaceholderText = "Press any key... (Esc = clear)"
        Library:Notify({Title="Keybind",Description="Press any key...",Time=2})
    end
    box.Focused:Connect(function()
        if picking then return end
        enterPicking()
    end)
    box.FocusLost:Connect(function()
        if picking then
            picking = false
            State._pickingKeybind = false
            box.PlaceholderText = "Click then press a key..."
            box.Text = State.uiToggleKeybind ~= "" and keyDisplayName(State.uiToggleKeybind) or ""
        end
    end)
    UIS.InputBegan:Connect(function(input)
        if not picking then return end
        if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
        if input.KeyCode == Enum.KeyCode.Unknown then return end
        local key = input.KeyCode
        picking = false
        State._pickingKeybind = false
        State._keybindCooldown = os.clock() + 0.5
        pcall(function() if box:IsFocused() then box:ReleaseFocus() end end)
        if key == Enum.KeyCode.Escape then
            State.uiToggleKeybind = ""
            keybindInput:SetValue("")
            box.Text = ""
            Library:Notify({Title="Keybind",Description="Cleared",Time=2})
            return
        end
        State.uiToggleKeybind = key.Name
        keybindInput:SetValue(key.Name)
        box.Text = keyDisplayName(key.Name)
        Library:Notify({Title="Keybind",Description="Set to: "..keyDisplayName(key.Name),Time=2})
    end)
    task.spawn(function()
        while not isDestroyed do
            task.wait(1)
            if picking then continue end
            local want = State.uiToggleKeybind ~= "" and keyDisplayName(State.uiToggleKeybind) or ""
            if box.Text ~= want then box.Text = want end
        end
    end)
end)
eIdx=eIdx+1 UI.configDropdown=ConfigGroup.AddDropdown(ConfigGroup,eIdx,{Text="Select Config",Values=ConfigManager.List(),Placeholder="Select...",AllowNull=true,Callback=function(v)State.selectedConfig=v end})
eIdx=eIdx+1 ConfigGroup.AddInput(ConfigGroup,eIdx,{Text="Config Name",Default="",Placeholder="my_config",Finished=true,Callback=function(v)State.configName=v end})
ConfigGroup:AddButton({Text="Create Config",Callback=function()if not State.configName or State.configName=="" then Library:Notify({Title="Config",Description="Enter name!",Time=2}) return end if ConfigManager.Save(State.configName) then if UI.configDropdown then UI.configDropdown:SetValues(ConfigManager.List()) end if State.autoLoadConfigDropdown and State.autoLoadConfigDropdown.SetValues then State.autoLoadConfigDropdown:SetValues(ConfigManager.List()) end Library:Notify({Title="Config",Description="Created!",Time=2}) else Library:Notify({Title="Config",Description="Failed!",Time=2}) end end})
ConfigGroup:AddButton({Text="Load Config",Callback=function()if not State.selectedConfig or State.selectedConfig=="" then Library:Notify({Title="Config",Description="Select first!",Time=2}) return end if ConfigManager.Load(State.selectedConfig) then Library:Notify({Title="Config",Description="Loaded!",Time=2}) else Library:Notify({Title="Config",Description="Failed!",Time=2}) end end})
ConfigGroup:AddButton({Text="Delete Config",Callback=function()if not State.selectedConfig or State.selectedConfig=="" then Library:Notify({Title="Config",Description="Select first!",Time=2}) return end if ConfigManager.Delete(State.selectedConfig) then State.selectedConfig=nil if UI.configDropdown then UI.configDropdown:SetValues(ConfigManager.List()) end if State.autoLoadConfigDropdown and State.autoLoadConfigDropdown.SetValues then State.autoLoadConfigDropdown:SetValues(ConfigManager.List()) end Library:Notify({Title="Config",Description="Deleted!",Time=2}) else Library:Notify({Title="Config",Description="Failed!",Time=2}) end end})
MiscLeft1:AddButton({Text="Destroy UI",Risky=true,Callback=function()isDestroyed=true State.isDestroyed=true Toggles.autoRoll=false F.stopBruteForce() F.stopPlayerDataLoop() F.stopEquipBestLoop() F.stopAutoSellLoop() F.stopAutoCollectLoop() F.stopAutoRebirthLoop() F.stopAutoRebirthStatsLoop() F.stopAutoUpgradeLoop() F.stopLevelUpLoop() F.stopAutoGiftLoop() F.stopAutoGiftUnitLoop() F.stopAutoGradeLoop() F.stopAutoTraitLoop() F.stopAutoClaimLoop() F.stopAutoBuyQuestLoop() F.stopAutoUsePotionLoop() F.stopAutoUseSpinLoop() F.stopAutoFuseLoop() F.stopAutoBuyDiceLoop() F.stopAutoEquipGearLoop() F.stopWeatherFinderLoop() F.stopQuirksLoop() F.stopPumpkinDiceLoop() F.stopPumpkinPassLoop() F.stopCandyShopLoop() F.stopTrickOrTreatLoop() Toggles.webhook=false task.delay(0.5,function()Library:Unload()end) end})
eIdx=eIdx+1 F.RegisterUI("antiAfk",MiscLeft2.AddToggle(MiscLeft2,eIdx,{Text="Anti-AFK",Default=true,Callback=function(s)Toggles.antiAfk=s end}))
eIdx=eIdx+1 F.RegisterUI("antiLagEnabled",MiscLeft2.AddToggle(MiscLeft2,eIdx,{Text="Anti-Lag (Aggressive)",Default=false,Callback=function(s)F.toggleAntiLag(s) if s then Library:Notify({Title="Anti-Lag",Description="Applied!",Time=3}) end end}))
MiscLeft2:AddButton({Text="Apply Anti-Lag Once",Callback=function()F.applyAntiLag() Library:Notify({Title="Anti-Lag",Description="Applied!",Time=3}) end})
MiscLeft2:AddButton({Text="Redeem All Codes",Callback=function()if isDestroyed then return end task.spawn(function()F.redeemAllCodes() Library:Notify({Title="Codes",Description="Done",Time=2}) end) end})
eIdx=eIdx+1 F.RegisterUI("equipBest",MiscRight1.AddToggle(MiscRight1,eIdx,{Text="Auto Equip Best",Default=false,Callback=function(s)Toggles.equipBest=s if s then F.startEquipBestLoop() else F.stopEquipBestLoop() end end}))
eIdx=eIdx+1 F.RegisterUI("equipBestDelay",MiscRight1.AddSlider(MiscRight1,eIdx,{Text="Delay",Default=State.equipBestDelay,Min=0.5,Max=10,Suffix="s",Callback=function(v)State.equipBestDelay=v end}))
eIdx=eIdx+1 F.RegisterUI("dragonTarget",TowerGroup.AddSlider(TowerGroup,eIdx,{Text="Dragon (0=skip)",Default=100,Min=0,Max=100,Suffix="",Callback=function(v)State.dragonTarget=math.floor(v) end}))
eIdx=eIdx+1 F.RegisterUI("cursedTarget",TowerGroup.AddSlider(TowerGroup,eIdx,{Text="Cursed (0=skip)",Default=100,Min=0,Max=100,Suffix="",Callback=function(v)State.cursedTarget=math.floor(v) end}))
eIdx=eIdx+1 F.RegisterUI("pirateTarget",TowerGroup.AddSlider(TowerGroup,eIdx,{Text="Pirate (0=skip)",Default=100,Min=0,Max=100,Suffix="",Callback=function(v)State.pirateTarget=math.floor(v) end}))
eIdx=eIdx+1 F.RegisterUI("hiddenLeafTarget",TowerGroup.AddSlider(TowerGroup,eIdx,{Text="Leaf (0=skip)",Default=100,Min=0,Max=100,Suffix="",Callback=function(v)State.hiddenLeafTarget=math.floor(v) end}))
eIdx=eIdx+1 F.RegisterUI("slayerTarget",TowerGroup.AddSlider(TowerGroup,eIdx,{Text="Slayer (0=skip)",Default=100,Min=0,Max=100,Suffix="",Callback=function(v)State.slayerTarget=math.floor(v) end}))
eIdx=eIdx+1 F.RegisterUI("shadowTarget",TowerGroup.AddSlider(TowerGroup,eIdx,{Text="Shadow (0=skip)",Default=100,Min=0,Max=100,Suffix="",Callback=function(v)State.shadowTarget=math.floor(v) end}))
eIdx=eIdx+1 F.RegisterUI("infinityTarget",TowerGroup.AddInput(TowerGroup,eIdx,{Text="Infinity (0=skip)",Default="999999",Placeholder="999999",Finished=true,Callback=function(v)local n=tonumber(v) if n and n>=0 then State.infinityTarget=math.floor(n) else State.infinityTarget=999999 end end}))
eIdx=eIdx+1 UI.towerToggle=TowerGroup.AddToggle(TowerGroup,eIdx,{Text="Auto Farm Tower",Default=false,Callback=function(s)
    if UI.towerStopping then return end
    if s then
        if State.hauntedTowerAutoPlay then
            F.stopTowerFarmLoop(true)
            if State.hauntedTowerToggle then State.hauntedTowerToggle:SetValue(false) end
        end
        F.startTowerFarmLoop(CFG.TOWER_CYCLE_NORMAL,false)
    else
        F.stopTowerFarmLoop(false)
    end
end})
F.RegisterUI("towerAutoPlay",UI.towerToggle)
UI.TowerStatusLabel=TowerInfoGroup:AddLabel("Status: Ready")
UI.TowerNameLabel=TowerInfoGroup:AddLabel("Tower: -")
UI.TowerFloorLabel=TowerInfoGroup:AddLabel("Floor: -")
UI.TowerCycleLabel=TowerInfoGroup:AddLabel("Cycle: -")
eIdx=eIdx+1 State.hauntedTowerToggle=HauntedTowerGroup.AddToggle(HauntedTowerGroup,eIdx,{Text="Auto Farm Haunted",Default=false,Callback=function(s)
    if UI.towerStopping then return end
    if s then
        if State.towerAutoPlay then
            F.stopTowerFarmLoop(false)
            if UI.towerToggle then UI.towerToggle:SetValue(false) end
        end
        F.startTowerFarmLoop(CFG.TOWER_CYCLE_HAUNTED,true)
    else
        F.stopTowerFarmLoop(true)
    end
end})
F.RegisterUI("hauntedTowerAuto",State.hauntedTowerToggle)
for _,wing in ipairs(CFG.HAUNTED_TOWER_ORDER) do
    eIdx=eIdx+1
    if wing=="The Abyss" then
        HauntedTowerGroup.AddInput(HauntedTowerGroup,eIdx,{Text=wing.." Floor",Default="1000",Placeholder="1000",Finished=true,Callback=function(v)
            local n=tonumber(v) if n and n>=0 then State.hauntedTargets[wing]=math.floor(n) else State.hauntedTargets[wing]=1000 end
        end})
    else
        HauntedTowerGroup.AddSlider(HauntedTowerGroup,eIdx,{Text=wing.." Floor",Default=50,Min=0,Max=50,Suffix="",Callback=function(v) State.hauntedTargets[wing]=math.floor(v) end})
    end
end
eIdx=eIdx+1
F.RegisterUI("gearBuffMode",GearEquipGroup.AddDropdown(GearEquipGroup,eIdx,{Text="Prioritize Buff",Values=CFG.GEAR_BUFF_OPTIONS,Default="Auto (Best Rarity+Total)",Multi=false,AllowNull=false,Callback=function(v)if type(v)=="table" then for k,vv in pairs(v) do if vv==true then State.selectedGearBuff=k break end end elseif type(v)=="string" and v~="" then State.selectedGearBuff=v else State.selectedGearBuff="Auto (Best Rarity+Total)" end end}))
eIdx=eIdx+1 F.RegisterUI("autoEquipGear",GearEquipGroup.AddToggle(GearEquipGroup,eIdx,{Text="Auto Equip Gear (5s)",Default=false,Callback=function(s)Toggles.autoEquipGear=s if s then F.startAutoEquipGearLoop() else F.stopAutoEquipGearLoop() end end}))
eIdx=eIdx+1
F.RegisterUI("pumpkinDiceMode",HLeft1.AddSlider(HLeft1,eIdx,{Text="Roll Mode (1 or 5)",Default=1,Min=1,Max=5,Suffix="x",Callback=function(v) if v>=3 then State.pumpkinDiceMode=5 else State.pumpkinDiceMode=1 end end}))
eIdx=eIdx+1
State.pumpkinDiceAutoToggle=HLeft1.AddToggle(HLeft1,eIdx,{Text="Auto Roll Pumpkin Dice",Default=false,Callback=function(s)
    Toggles.pumpkinDiceAuto=s
    if s then
        if State.autoTeleportIsland and not F.isOnHalloweenIsland() then F.teleportHalloween("Island") task.wait(3) end
        F.startPumpkinDiceLoop()
    else F.stopPumpkinDiceLoop() end
end})
F.RegisterUI("pumpkinDiceAuto",State.pumpkinDiceAutoToggle)
eIdx=eIdx+1
State.candyShopDropdown=HLeft2.AddDropdown(HLeft2,eIdx,{Text="Select Items",Values=CFG.CANDY_SHOP_NAMES,Multi=true,Placeholder="Select...",AllowNull=true,Callback=function(s)
    State.candyShopSelected={}
    if s and next(s)~=nil then
        for k,v in pairs(s) do
            if v==true then table.insert(State.candyShopSelected,k) end
            if type(k)=="number" and type(v)=="string" and v~="" then table.insert(State.candyShopSelected,v) end
        end
    end
    F.updateCandyShopPrice()
end})
F.AddPopupButton(State.candyShopDropdown)
State.candyShopPriceLabel=HLeft2:AddLabel("Price: -")
HLeft2:AddButton({Text="Buy Once",Callback=function()
    if isDestroyed then return end
    local ok=F.processCandyShop()
    if not ok then Library:Notify({Title="Candy Shop",Description="Not enough candy / no item",Time=2}) end
end})
eIdx=eIdx+1
State.candyShopAutoToggle=HLeft2.AddToggle(HLeft2,eIdx,{Text="Auto Buy",Default=false,Callback=function(s)
    Toggles.candyShopAuto=s
    if s then
        if #State.candyShopSelected==0 then Library:Notify({Title="Candy Shop",Description="Select items first!",Time=2}) Toggles.candyShopAuto=false if State.candyShopAutoToggle then State.candyShopAutoToggle:SetValue(false) end return end
        F.startCandyShopLoop()
    else F.stopCandyShopLoop() end
end})
F.RegisterUI("candyShopAuto",State.candyShopAutoToggle)
eIdx=eIdx+1
F.RegisterUI("autoTeleportIsland",HLeft3.AddToggle(HLeft3,eIdx,{Text="Auto Teleport Island",Default=false,Callback=function(s) State.autoTeleportIsland=s end}))
HLeft3:AddButton({Text="Teleport to Island",Callback=function() F.teleportHalloween("Island") end})
HLeft3:AddButton({Text="Return to Hub",Callback=function() F.teleportHalloween("Hub") end})
eIdx=eIdx+1
State.pumpkinPassAutoToggle=HRight1.AddToggle(HRight1,eIdx,{Text="Auto Claim Pass",Default=false,Callback=function(s)
    Toggles.pumpkinPassAuto=s
    if s then F.startPumpkinPassLoop() else F.stopPumpkinPassLoop() end
end})
F.RegisterUI("pumpkinPassAuto",State.pumpkinPassAutoToggle)
HRight1:AddButton({Text="Claim All Now",Callback=function() if not isDestroyed then F.processPumpkinPass() end end})
eIdx=eIdx+1
State.trickOrTreatAutoToggle=HRight2.AddToggle(HRight2,eIdx,{Text="Auto Trick or Treat",Default=false,Callback=function(s)
    Toggles.trickOrTreatAuto=s
    if s then F.startTrickOrTreatLoop() else F.stopTrickOrTreatLoop() end
end})
F.RegisterUI("totAuto",State.trickOrTreatAutoToggle)
F.refreshRarityDropdowns()
task.delay(3,function() task.spawn(function()while not isDestroyed do task.wait(180) pcall(F.buildRarityData) pcall(F.refreshRarityDropdowns) end end) end)
if not _isMobile then
    UI.ToggleBtn=Library:AddDraggableButton("Show/Hide",function()State.uiMainVisible=not State.uiMainVisible Library:Toggle() end,true,true)
    UI.LockBtn=Library:AddDraggableButton("Lock",function(btn)Library.CantDragForced=not Library.CantDragForced btn:SetText(Library.CantDragForced and "Unlock" or "Lock") end,true,true)
    if UI.ToggleBtn and UI.ToggleBtn.Button then UI.ToggleBtn.Button.Position=UDim2.fromOffset(6,6) end
    if UI.LockBtn and UI.LockBtn.Button then UI.LockBtn.Button.Position=UDim2.fromOffset((UI.ToggleBtn and UI.ToggleBtn.Button and UI.ToggleBtn.Button.Size.X.Offset or 80)+12,6) end
end
UIS.InputBegan:Connect(function(input,gp)
    if gp or isDestroyed or State._pickingKeybind then return end
    if State.uiToggleKeybind=="" then return end
    if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    if os.clock() < (State._keybindCooldown or 0) then return end
    local kc = nameToKeyCode(State.uiToggleKeybind)
    if not kc then return end
    if input.KeyCode ~= kc then return end
    State.uiEverythingHidden=not State.uiEverythingHidden
    local h=State.uiEverythingHidden
    if UI.ToggleBtn and UI.ToggleBtn.Button then UI.ToggleBtn.Button.Visible=not h end
    if UI.LockBtn and UI.LockBtn.Button then UI.LockBtn.Button.Visible=not h end
    if h then if Library.Toggled then Library:Toggle(false) end State.uiMainVisible=false
    else if not Library.Toggled then Library:Toggle(true) end State.uiMainVisible=true end
end)
task.delay(2,function()
    pcall(F.refreshDiceDropdown)
    pcall(F.refreshRollUnitDropdown)
    pcall(F.refreshSlotDropdown)
    pcall(F.refreshTradePlayerDropdown)
    pcall(F.refreshGiftItemDropdown)
end)
task.delay(2,function() task.spawn(function()while not isDestroyed do if DataController then pcall(F.updateSlotInfoLabel) end task.wait(5) end end) end)
Library:Notify({Title="Anime Dice",Description="Loaded!",Time=5})