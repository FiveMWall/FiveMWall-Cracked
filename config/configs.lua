ConfigCS = {}

ConfigCS['Locale'] = "es"
ConfigCS['webhook'] = ""
ConfigCS['CustomMSG'] = " Fuiste baneado del Servidor por FiveMWall Cracked"

ConfigCS['AntiCarControl'] = true
ConfigCS['AntiGiveWeapons'] = true
ConfigCS['ExplosionProtection'] = true
ConfigCS['AntiVPN'] = false
ConfigCS['AntiFakeChatMessages'] = true
ConfigCS['ReloadBanListTime'] = 600000

ConfigCS['MaxPedsPerUser'] = 3
ConfigCS['MaxPropsPerUser'] = 15
ConfigCS['MaxVehiclesPerUser'] = 5
ConfigCS['MaxEntitiesPerUser'] = 20
ConfigCS['MaxParticlesPerUser'] = 3


ConfigCS.DangerousTriggers = {
	"redst0nia:checking",
	"esx_mafiajob:confiscatePlayerItem",
	"lscustoms:payGarage",
	"vrp_slotmachine:server:2",
	"esx_fueldelivery:pay",
	"AdminMenu:giveBank",
	"AdminMenu:giveCash",
	"NB:recruterplayer",
	"js:jailuser",
	"OG_cuffs:cuffCheckNearest",
	"cuffServer",
	"cuffGranted",
	"esx_mechanicjob:startCraft",
	"esx_vehicletrunk:giveDirty",
	"gambling:spend",
	"AdminMenu:giveDirtyMoney",
	"mission:completed",
	"truckerJob:success",
	"99kr-burglary:addMoney",
	"esx_jailer:unjailTime",
	"DiscordBot:playerDied",
	"hentailover:xdlol",
	"antilynx8:anticheat",
	"antilynxr6:detection",
	"antilynx8r4a:anticheat",
	"antilynxr4:detect",
	"js:jailuser", 
	"ynx8:anticheat",
	"lynx8:anticheat",
	"adminmenu:allowall",
	"h:xd",
	"ljail:jailplayer",
	"adminmenu:setsalary",
	"adminmenu:cashoutall",
	"HCheat:TempDisableDetection",
	"esx_drugs:pickedUpCannabis",
	"esx_drugs:processCannabis",
	"esx-qalle-hunting:reward",
	"esx-qalle-hunting:sell",
	"esx_mecanojob:onNPCJobCompleted",
	"BsCuff:Cuff696999",
	"veh_SR:CheckMoneyForVeh",
	"mellotrainer:adminTempBan",
	"mellotrainer:adminKick",
	"d0pamine_xyz:getFuckedNigger",
	"esx_communityservice:sendToCommunityService",
	"crown_xyz:getFuckedNigger",
	"kashactersS:DeleteCharacter",
	"NB:destituerplayer",
}

-- Coches prohibidos
ConfigCS.CarsBL = {
	{ name = `vigilante`, logName = "vigilante", ban = false },
	{ name = `hydra`, logName = "hydra", ban = false },
	{ name = `buzzard`, logName = "buzzard", ban = false },
	{ name = `deluxo`, logName = "deluxo", ban = false },
	{ name = `barrage`, logName = "barrage", ban = false },
	{ name = `caracara`, logName = "caracara", ban = false },
	{ name = `hunter`, logName = "hunter", ban = false },
	{ name = `starling`, logName = "starling", ban = false },
	{ name = `bombushka`, logName = "bombushka", ban = false },
	{ name = `savage`, logName = "savage", ban = false },
	{ name = `rhino`, logName = "rhino", ban = false },
	{ name = `khanjali`, logName = "khanjali", ban = false },
	{ name = `blimp2`, logName = "blimp2", ban = false },
	{ name = `jet`, logName = "jet", ban = false },
	{ name = `cargoplane`, logName = "cargoplane", ban = false },
	{ name = `miljet`, logName = "miljet", ban = false },
	{ name = `nimbus`, logName = "nimbus", ban = false },
	{ name = `stunt`, logName = "stunt", ban = false },
	{ name = `kuruma2`, logName = "kuruma2", ban = false },
	{ name = `titan`, logName = "titan", ban = false },
}