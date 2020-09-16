-- [x] -- Название скрипта. -- [x] --
script_name("Admin Helper by Lox.")
script_author("Yamada.")

-- [x] -- Библиотеки. -- [x] --
										require "lib.moonloader"
local sampev							= require "lib.samp.events"
local font_admin_chat					= require ("moonloader").font_flag
local ev								= require ("moonloader").audiostream_state
local dlstat							= require ("moonloader").download_status
local ffi 								= require "ffi"
local getBonePosition 					= ffi.cast("int (__thiscall*)(void*, float*, int, bool)", 0x5E4280)
local mem 								= require "memory"
local imgui 							= require "imgui"
local encoding							= require "encoding"
local vkeys								= require "lib.vkeys"
local inicfg							= require "inicfg"
local notfy								= import 'lib/lib_imgui_notf.lua'
--local sc_board							= import 'lib/scoreboard.lua'
--local pie								= require "imgui_piemenu"
--local theme								= import "Module/imgui_themes.lua"
encoding.default 						= "CP1251"
u8 										= encoding.UTF8

imgui.ToggleButton = require('imgui_addons').ToggleButton
imgui.HotKey = require('imgui_addons').HotKey
imgui.Spinner = require('imgui_addons').Spinner
imgui.BufferingBar = require('imgui_addons').BufferingBar

function apply_custom_style()
	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4

	style.WindowRounding = 8.0
	style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
	style.ChildWindowRounding = 8.0
	style.FrameRounding = 8.0
	style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
	style.ScrollbarSize = 13.0
	style.ScrollbarRounding = 8.0
	style.GrabMinSize = 8.0
	style.GrabRounding = 8.0
	-- style.Alpha =
	-- style.WindowPadding =
	-- style.WindowMinSize =
	-- style.FramePadding =
	-- style.ItemInnerSpacing =
	-- style.TouchExtraPadding =
	-- style.IndentSpacing =
	-- style.ColumnsMinSpacing = ?
	-- style.ButtonTextAlign =
	-- style.DisplayWindowPadding =
	-- style.DisplaySafeAreaPadding =
	-- style.AntiAliasedLines =
	-- style.AntiAliasedShapes =
	-- style.CurveTessellationTol =

	colors[clr.WindowBg]              = ImVec4(0.14, 0.12, 0.16, 0.85);
	colors[clr.ChildWindowBg]         = ImVec4(0.30, 0.20, 0.39, 0.00);
	colors[clr.PopupBg]               = ImVec4(0.05, 0.05, 0.10, 0.90);
	colors[clr.Border]                = ImVec4(0.89, 0.85, 0.92, 0.30);
	colors[clr.BorderShadow]          = ImVec4(0.00, 0.00, 0.00, 0.00);
	colors[clr.FrameBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
	colors[clr.FrameBgHovered]        = ImVec4(0.41, 0.19, 0.63, 0.68);
	colors[clr.FrameBgActive]         = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.TitleBg]               = ImVec4(0.41, 0.19, 0.63, 0.45);
	colors[clr.TitleBgCollapsed]      = ImVec4(0.41, 0.19, 0.63, 0.35);
	colors[clr.TitleBgActive]         = ImVec4(0.41, 0.19, 0.63, 0.78);
	colors[clr.MenuBarBg]             = ImVec4(0.30, 0.20, 0.39, 0.57);
	colors[clr.ScrollbarBg]           = ImVec4(0.30, 0.20, 0.39, 1.00);
	colors[clr.ScrollbarGrab]         = ImVec4(0.41, 0.19, 0.63, 0.31);
	colors[clr.ScrollbarGrabHovered]  = ImVec4(0.41, 0.19, 0.63, 0.78);
	colors[clr.ScrollbarGrabActive]   = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.ComboBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
	colors[clr.CheckMark]             = ImVec4(0.56, 0.61, 1.00, 1.00);
	colors[clr.SliderGrab]            = ImVec4(0.41, 0.19, 0.63, 0.24);
	colors[clr.SliderGrabActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.Button]                = ImVec4(0.41, 0.19, 0.63, 0.44);
	colors[clr.ButtonHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
	colors[clr.ButtonActive]          = ImVec4(0.64, 0.33, 0.94, 1.00);
	colors[clr.Header]                = ImVec4(0.41, 0.19, 0.63, 0.76);
	colors[clr.HeaderHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
	colors[clr.HeaderActive]          = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.ResizeGrip]            = ImVec4(0.41, 0.19, 0.63, 0.20);
	colors[clr.ResizeGripHovered]     = ImVec4(0.41, 0.19, 0.63, 0.78);
	colors[clr.ResizeGripActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.CloseButton]           = ImVec4(1.00, 1.00, 1.00, 0.75);
	colors[clr.CloseButtonHovered]    = ImVec4(0.88, 0.74, 1.00, 0.59);
	colors[clr.CloseButtonActive]     = ImVec4(0.88, 0.85, 0.92, 1.00);
	colors[clr.PlotLines]             = ImVec4(0.89, 0.85, 0.92, 0.63);
	colors[clr.PlotLinesHovered]      = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.PlotHistogram]         = ImVec4(0.89, 0.85, 0.92, 0.63);
	colors[clr.PlotHistogramHovered]  = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.TextSelectedBg]        = ImVec4(0.41, 0.19, 0.63, 0.43);
	colors[clr.ModalWindowDarkening]  = ImVec4(0.20, 0.20, 0.20, 0.35);
end
apply_custom_style()

-- [x] -- Переменные. -- [x] --
update_state = false
local script_version = 8
local script_version_text = "2.4 BugFix ( Arman isportil :( )"
local update_url = "https://raw.githubusercontent.com/YamadaEnotic/AH-Script/master/update.ini"
local update_path = getWorkingDirectory() .. '/update.ini'
local script_url = "https://raw.githubusercontent.com/YamadaEnotic/AH-Script/master/AH_Bred.lua"
local script_path = thisScript().path
local tag = "{0777A3}[AH by Yamada.]: {CCCCCC}"
local sw, sh = getScreenResolution()
local directIni	= "AH_Setting\\config.ini"
local font_ac
local load_audio = loadAudioStream('moonloader/config/AH_Setting/audio/notification.mp3')
local defTable = {
	setting = {
		Tranparency = false,
		Auto_remenu = false,
		Fast_ans = false,
		Punishments = false,
		Index = 2.0,
		Admin_chat = false,
		Font = 10,
		Push_Report = false,
		Chat_Logger = false,
		hide_td = false,
		HelloAC = "hi"
	},
	keys = {
		Setting = "End",
		Re_menu = "None",
		Hello = "None",
		P_Log = "None",
		Hide_AChat = "None",
		Mouse = "None"
	}
}
local admin_chat_lines = {
	chat_line_1 = " ",
	chat_line_2 = " ",
	chat_line_3 = " ",
	chat_line_4 = " ",
	chat_line_5 = " ",
	chat_line_6 = " ",
	chat_line_7 = " ",
	chat_line_8 = " ",
	chat_line_9 = " ",
	chat_line_10 = " "
}
local punishments = {
	["ch"] = {
		cmd = "ban",
		time = 7,
		reason = "Использование запрещенного софта."
	},
	["sob"] = {
		cmd = "ban",
		time = 7,
		reason = "Использование запрещенного софта. (S0beit)"
	},
	["aim"] = {
		cmd = "ban",
		time = 7,
		reason = "Использование запрещенного софта. (Aim)"
	},
	["rvn"] = {
		cmd = "ban",
		time = 7,
		reason = "Использование запрещенного софта. (Rvanka)"
	},
	["cars"] = {
		cmd = "ban",
		time = 7,
		reason = "Использование запрещенного софта. (Car Shot)"
	},
	["ac"] = {
		cmd = "ban",
		time = 7,
		reason = "Использование запрещенного софта. (Auto +C)"
	},
	["ich"] = {
		cmd = "iban",
		time = 7,
		reason = "Использование запрещенного софта."
	},
	["isob"] = {
		cmd = "iban",
		time = 7,
		reason = "Использование запрещенного софта. (S0beit)"
	},
	["iaim"] = {
		cmd = "iban",
		time = 7,
		reason = "Использование запрещенного софта. (Aim)"
	},
	["irvn"] = {
		cmd = "iban",
		time = 7,
		reason = "Использование запрещенного софта. (Rvanka)"
	},
	["icars"] = {
		cmd = "iban",
		time = 7,
		reason = "Использование запрещенного софта. (Car Shot)"
	},
	["iac"] = {
		cmd = "iban",
		time = 7,
		reason = "Использование запрещенного софта. (Auto +C)"
	},
	["bn"] = {
		cmd = "ban",
		time = 3,
		reason = "Неадекватное поведение."
	},
	-- [x] -- Муты -- [x] --
	["um"] = {
		cmd = "unmute",
		time = 0,
		reason = "Размутить игрока."
	},
	["osk"] = {
		cmd = "mute",
		time = 400,
		reason = "Оскорбление/Унижение игрока(-ов)."
	},
	["mat"] = {
		cmd = "mute",
		time = 300,
		reason = "Нецензурная лексика."
	},
	["or"] = {
		cmd = "mute",
		time = 5000,
		reason = "Уопминание родителей."
	},
	["oa"] = {
		cmd = "mute",
		time = 2500,
		reason = "Оскорбление/Унижение администрации."
	},
	["ua"] = {
		cmd = "mute",
		time = 2500,
		reason = "Унижение прав администрации."
	},
	["va"] = {
		cmd = "mute",
		time = 2500,
		reason = "Выдача себя за администрацию."
	},
	["fld"] = {
		cmd = "mute",
		time = 120,
		reason = "Флуд в чат/pm."
	},
	["popr"] = {
		cmd = "mute",
		time = 120,
		reason = "Попрошайничество."
	},
	["nead"] = {
		cmd = "mute",
		time = 600,
		reason = "Неадекватное поведение."
	},
	["rek"] = {
		cmd = "mute",
		time = 600,
		reason = "Реклама сторонних ресурсов/сервера/сайта."
	},
	["rosk"] = {
		cmd = "rmute",
		time = 400,
		reason = "Оскорбление игрока в /report."
	},
	["rmat"] = {
		cmd = "rmute",
		time = 300,
		reason = "Мат в /report."
	},
	["rao"] = {
		cmd = "rmute",
		time = 2500,
		reason = "Оскорбление администрации в /report."
	},
	["otop"] = {
		cmd = "rmute",
		time = 120,
		reason = "/report не по назначению. (Offtop)"
	},
	["rcp"] = {
		cmd = "rmute",
		time = 120,
		reason = "Сообщение в /report CAPS'ом"
	},
	-- [x] -- Джайлы -- [x] --
	["cdm"] = {
		cmd = "jail",
		time = 300,
		reason = "Нанесение урона машиной в Зеленой зоне. (DB in ZZ)"
	},
	["pk"] = {
		cmd = "jail",
		time = 900,
		reason = "Использование запрещенного софта. (Parkour Mod)"
	},
	["ca"] = {
		cmd = "jail",
		time = 900,
		reason = "Использование запрещенного софта. (CLEO Animations)"
	},
	["np"] = {
		cmd = "jail",
		time = 300,
		reason = "Нарушение правил сервера."
	},
	["zv"] = {
		cmd = "jail",
		time = 3000,
		reason = "Злоупотребление VIP привилегией."
	},
	["dbp"] = {
		cmd = "jail",
		time = 300,
		reason = "Помеха игроку. (DB in passive)"
	},
	["bg"] = {
		cmd = "jail",
		time = 300,
		reason = "Исполтьзование запрещенных эксплойтов. (Bag Use)"
	},
	["dm"] = {
		cmd = "jail",
		time = 300,
		reason = "Нанесение урона в Зеленой зоне. (DM in ZZ)"
	},
	["sh"] = {
		cmd = "jail",
		time = 900,
		reason = "Использование запрещенного софта. (SpeedHack)"
	},
	["fly"] = {
		cmd = "jail",
		time = 900,
		reason = "Использование запрещенного софта. (Fly)"
	},
	["fcar"] = {
		cmd = "jail",
		time = 900,
		reason = "Использование запрещенного софта. (FlyCar)"
	},
	["pmp"] = {
		cmd = "jail",
		time = 300,
		reason = "Помеха мероприятию."
	},
	["sk"] = {
		cmd = "jail",
		time = 300,
		reason = "Убийство игроков на спавне."
	}
}
local cmd_punis_jail = { "cdm" , "pk" , "ca" , "np" , "zv" , "dbp" , "bg" , "dm" , "sh", "fly", "fcar", "pmp", "sk"}
local cmd_punis_mute = { "osk" , "mat" , "or" , "oa" , "ua" , "va" , "fld" , "popr" , "nead" , "rek" , "rosk" , "rmat" , "rao" , "otop" , "rcp", "um" }
local cmd_punis_ban = { "ch" , "sob" , "aim" , "rvn" , "cars" , "ac" , "ich" , "isob" , "iaim" , "irvn" , "icars" , "iac" , "bn" } 
local i_ans = {
	u8'/givemoney ID Сумма.',
	u8'/givescore ID Сумма (От Diamond VIP).',
	u8'/donate.',
	u8'/tp >> Разное >> Банк >> Ограбьте его.',
	u8'/rdscoin.',
	u8'/help - 13.',
	u8'/help - 7.',
	u8'/help.',
	u8'/menu.',
	u8'/menu >> Настройки.',
	u8'/menu >> Транспортное Средство.',
	u8'/menu >> Действия.',
	u8'Вы можете оставить жалобу в нашей группе в ВК > vk.com/dmdriftgta.',
	u8'Наша группа в ВК > vk.com/dmdriftgta.',
	u8'Уточните вопрос.',
	u8'Уточните суть жалобы.',
	u8'Уточните ID игрока.',
	u8'Да.',
	u8'Нет.',
	u8'Слежу.',
	u8'"/statpl" либо "TAB".',
	u8'/statpl',
	u8'Не знаем.',
	u8'Не запрещено.',
	u8'Наш сайт > myrds.ru',
	u8'GМ на сервере не работает.',
	u8'Скорее всего - это баг.',
	u8'/fleave, /gleave, /leave.',
	u8'Рынок и обменный функционал сервера по команде: "/trade".',
	u8'Данный игрок был наказан.',
	u8'Данный игрок находится вне сети.',
	u8'/car',
	u8'Вы можете уточнить данную информацию в интернете..',
	u8'Ожидайте.',
	u8'Проверим.',
	u8'/fpanel',
	u8'/tp >> Разное >> Автосалоны.',
	u8'Данный игрок чист.',
	u8'Приношу свои извинения, произошла ошибка ID.',
	u8'Чтобы попасть в банду: "/nab"',
	u8'Используйте "/dt 1 - 990"'
}
local translate = {
	["й"] = "q",
	["ц"] = "w",
	["у"] = "e",
	["к"] = "r",
	["е"] = "t",
	["н"] = "y",
	["г"] = "u",
	["ш"] = "i",
	["щ"] = "o",
	["з"] = "p",
	["х"] = "[",
	["ъ"] = "]",
	["ф"] = "a",
	["ы"] = "s",
	["в"] = "d",
	["а"] = "f",
	["п"] = "g",
	["р"] = "h",
	["о"] = "j",
	["л"] = "k",
	["д"] = "l",
	["ж"] = ";",
	["э"] = "'",
	["я"] = "z",
	["ч"] = "x",
	["с"] = "c",
	["м"] = "v",
	["и"] = "b",
	["т"] = "n",
	["ь"] = "m",
	["б"] = ",",
	["ю"] = "."
}
local download_aditional = {
	lib = {
		piemenu = "https://raw.githubusercontent.com/YamadaEnotic/AH-Script/master/imgui_piemenu.lua",
		directory_piemenu = getWorkingDirectory() .. "lib/imgui_piemenu.lua",
		imgui_addons = "https://raw.githubusercontent.com/YamadaEnotic/AH-Script/master/imgui_addons.lua",
		directory_imgui_addons = getWorkingDirectory() .. "lib/imgui_addons.lua",
		notification = "https://raw.githubusercontent.com/YamadaEnotic/AH-Script/master/lib_imgui_notf.lua",
		directory_notification = getWorkingDirectory() .. "lib/lib_imgui_notf.lua"
	}
}
local onscene = { "блять", "сука", "хуй", "нахуй" }
local log_onscene = {
	--[[["player_1"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_2"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_3"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_4"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_5"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_6"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_7"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_8"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_9"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_10"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_11"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_12"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_13"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_14"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_15"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_16"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_17"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_18"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_19"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	},
	["player_20"] = {
		id = nil,
		name = " ",
		text = " ",
		suspicion = " "
	}]]
}
local russian_characters = {
    [168] = 'Ё', [184] = 'ё', [192] = 'А', [193] = 'Б', [194] = 'В', [195] = 'Г', [196] = 'Д', [197] = 'Е', [198] = 'Ж', [199] = 'З', [200] = 'И', [201] = 'Й', [202] = 'К', [203] = 'Л', [204] = 'М', [205] = 'Н', [206] = 'О', [207] = 'П', [208] = 'Р', [209] = 'С', [210] = 'Т', [211] = 'У', [212] = 'Ф', [213] = 'Х', [214] = 'Ц', [215] = 'Ч', [216] = 'Ш', [217] = 'Щ', [218] = 'Ъ', [219] = 'Ы', [220] = 'Ь', [221] = 'Э', [222] = 'Ю', [223] = 'Я', [224] = 'а', [225] = 'б', [226] = 'в', [227] = 'г', [228] = 'д', [229] = 'е', [230] = 'ж', [231] = 'з', [232] = 'и', [233] = 'й', [234] = 'к', [235] = 'л', [236] = 'м', [237] = 'н', [238] = 'о', [239] = 'п', [240] = 'р', [241] = 'с', [242] = 'т', [243] = 'у', [244] = 'ф', [245] = 'х', [246] = 'ц', [247] = 'ч', [248] = 'ш', [249] = 'щ', [250] = 'ъ', [251] = 'ы', [252] = 'ь', [253] = 'э', [254] = 'ю', [255] = 'я',
}
local date_onscene = {}
local text_remenu = { "Очки:", "Здоровье:", "Броня:", "ХП машины:", "Скорость:", "Ping:", "Патроны:", "Выстрелы:", "Время выстрелов:", "Время АФК:", "P.Loss:", "VIP:", "Passive Мод:", "Turbo:", "Коллизия:" }
local player_info = {}
local player_to_streamed = {}
local control_recon_playerid = -1
local control_tab_playerid = -1
local control_recon_playernick = nil
local next_recon_playerid = nil
local control_recon = false
local control_info_load = false
local accept_load = false
local check_mouse = false
local check_cmd_re = false
local control_wallhack = false
local jail_or_ban_re
local check_cmd_punis = nil
local right_re_menu = true
local mouse_cursor = true
local control_onscene = false

-- [x] -- ImGUI переменные. -- [x] --
local i_ans_window = imgui.ImBool(false)
local i_setting_items = imgui.ImBool(false)
local i_back_prefix = imgui.ImBool(false)
local i_info_update = imgui.ImBool(false)
local i_re_menu = imgui.ImBool(false)
local i_cmd_helper = imgui.ImBool(false)
local font_size_ac = imgui.ImBuffer(16)
local HelloAC = imgui.ImBuffer(300)
local logo_image
local setting_items = {
	Fast_ans = imgui.ImBool(false),
	Punishments = imgui.ImBool(false),
	Admin_chat = imgui.ImBool(false),
	Transparency = imgui.ImBool(true),
	Auto_remenu = imgui.ImBool(false),
	Push_Report = imgui.ImBool(false),
	Chat_Logger = imgui.ImBool(false),
	hide_td = imgui.ImBool(false)
}
-- [x] -- Тело скрипта. -- [x] --
function main()
	-- [x] -- Проверка на запуск сампа и СФ. -- [x] --
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(0) end
	
	if not doesDirectoryExist(getWorkingDirectory() .. "/config/AH_Setting") then
		createDirectory(getWorkingDirectory() .. "/config/AH_Setting")
	end
	if not doesDirectoryExist(getWorkingDirectory() .. "/config/AH_Setting/audio") then
		createDirectory(getWorkingDirectory() .. "/config/AH_Setting/audio")
	end
	
	sampRegisterChatCommand('ah_setting', function()
		i_setting_items.v = not i_setting_items.v
		imgui.Process = i_setting_items.v
	end)
	local file_read, c_line = io.open(getWorkingDirectory() .. "\\config\\AH_Setting\\mat\\mat.txt", "r"), 1
	if file_read ~= nil then
		file_read:seek("set", 0)
		for line in file_read:lines() do
			onscene[c_line] = line
			c_line = c_line + 1
		end
		file_read:close()
	end
	sampRegisterChatCommand('save_mat', function(param)
		if param == nil then
			return false
		end
		for _, val in ipairs(onscene) do
			if string.rlower(param) == val then
				sampAddChatMessage(tag .. "Слово \"" .. val .. "\" уже присутствует в списке.")
				return false
			end
		end
		local file_write, c_line = io.open(getWorkingDirectory() .. "\\config\\AH_Setting\\mat\\mat.txt", "w"), 1
		onscene[#onscene + 1] = string.rlower(param)
		for _, val in ipairs(onscene) do
			file_write:write(val .. "\n")
		end
		file_write:close()
		sampAddChatMessage(tag .. "Слово \"" .. string.rlower(param) .. "\" успешно добавленно в список.")
	end)
	sampRegisterChatCommand('del_mat', function(param)
		if param == nil then
			return false
		end
		local file_write, c_line = io.open(getWorkingDirectory() .. "\\config\\AH_Setting\\mat\\mat.txt", "w"), 1
		for i, val in ipairs(onscene) do
			if val == string.rlower(param) then
				onscene[i] = nil
				control_onscene = true
			else
				file_write:write(val .. "\n")
			end
		end
		file_write:close()
		if control_onscene then
			sampAddChatMessage(tag .. "Слово \"" .. string.rlower(param) .. "\" было успешно удалено из спискат мата.")
			control_onscene = false
		else
			sampAddChatMessage(tag .. "Слова \"" .. string.rlower(param) .. "\" нет в списке мата.")
		end
	end)
	
	
	config = inicfg.load(defTable, directIni)
	setting_items.Fast_ans.v = config.setting.Fast_ans
	setting_items.Punishments.v = config.setting.Punishments
	setting_items.Admin_chat.v = config.setting.Admin_chat
	setting_items.Transparency.v = config.setting.Tranparency
	setting_items.Auto_remenu.v = config.setting.Auto_remenu
	setting_items.Push_Report.v = config.setting.Push_Report
	setting_items.Chat_Logger.v = config.setting.Chat_Logger
	setting_items.hide_td.v = config.setting.hide_td
	HelloAC.v = config.setting.HelloAC
	font_size_ac.v = tostring(config.setting.Font)
	index_text_pos = config.setting.Index
	font_ac = renderCreateFont("Arial", config.setting.Font, font_admin_chat.BOLD + font_admin_chat.SHADOW)
	
	admin_chat = lua_thread.create_suspended(drawAdminChat)
	check_dialog_active = lua_thread.create_suspended(checkIsDialogActive)
	draw_re_menu = lua_thread.create_suspended(drawRePlayerInfo)
	load_info_player = lua_thread.create_suspended(loadPlayerInfo)
	wallhack = lua_thread.create(drawWallhack)
	check_cmd = lua_thread.create_suspended(function()
		wait(1000)
		check_cmd_re = false
	end)
	sampAddChatMessage(tag .. "Загрузка прошла успешно.")
	
	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstat.STATUS_ENDDOWNLOADDATA then
			updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.version) > script_version then
				showNotification("Доступно обновление.", "Старая версия скрипта: {AA0000}" .. script_version_text .. "\nНовая версия скрипта: {33AA33}" .. updateIni.info.version_text)
				update_state = true
			end
			os.remove(update_path)
		end
	end)
	
	--imgui.SwitchContext()
	--theme.SwitchColorTheme(8)
	
	admin_chat:run()
	
	logo_image = imgui.CreateTextureFromFile(getWorkingDirectory() .. "\\config\\AH_Setting\\1.png")
	
	-- [x] -- Беск. цикл. -- [x] --
	while true do
		if isKeysDown(strToIdKeys(config.keys.Setting)) and (sampIsChatInputActive() == false) and (sampIsDialogActive() == false) then
			i_setting_items.v = not i_setting_items.v
			imgui.Process = true
		end
		if control_recon and recon_to_player then
			if control_info_load then
				control_info_load = false
				load_info_player:run()
				i_re_menu.v = true
				imgui.Process = true
				jail_or_ban_re = 0
			end
		else
			i_re_menu.v = false
		end
		if isKeysDown(strToIdKeys(config.keys.Hide_AChat)) and (sampIsChatInputActive() == false) and (sampIsDialogActive() == false) then
			setting_items.Admin_chat.v = not setting_items.Admin_chat.v
		end
		if not i_setting_items.v and not i_ans_window.v and not i_info_update.v and not i_re_menu.v and not i_cmd_helper.v then
			imgui.Process = false
		end
		if sampGetCurrentDialogId() == 2351 and setting_items.Fast_ans.v and sampIsDialogActive() then
			i_ans_window.v = true
			imgui.Process = true
		else 
			i_ans_window.v = false
		end
		if not i_re_menu.v then
			check_mouse = true
		end
		if isKeysDown(strToIdKeys(config.keys.P_Log)) and setting_items.Chat_Logger.v and (sampIsChatInputActive() == false) and (sampIsDialogActive() == false) then
			i_info_update.v = not i_info_update.v
			imgui.Process = true
		end
		if isKeyJustPressed(VK_RBUTTON) and (sampIsChatInputActive() == false) and (sampIsDialogActive() == false) and control_recon and recon_to_player then
			check_mouse = not check_mouse
		end
		if isKeysDown(strToIdKeys(config.keys.Re_menu)) and (sampIsChatInputActive() == false) and (sampIsDialogActive() == false) and control_recon and recon_to_player then
			right_re_menu = not right_re_menu	
		end
		if isKeysDown(strToIdKeys(config.keys.Hello)) and (sampIsDialogActive() == false) then
			sampSendChat("/a " .. u8:decode(HelloAC.v))	
		end
		if not sampIsPlayerConnected(control_recon_playerid) then
			i_re_menu.v = false
			control_recon_playerid = -1
		end
		if sampIsChatInputActive() then
			if sampGetChatInputText():find("-") == 1 then
				i_cmd_helper.v = true
				imgui.Process = true
				if sampGetChatInputText():match("-(.+)") ~= nil then
					check_cmd_punis = sampGetChatInputText():match("-(.+)")
				else
					check_cmd_punis = nil
				end
			else
				i_cmd_helper.v = false
			end
		else
			i_cmd_helper.v = false
		end
		wait(0)
	end
end

-- [x] -- Доп. функции -- [x] --
-- {0777A3}[AH by Yamada.]: {CCCCCC} ID: 2067 Text: 190~n~100.000000~n~100.000000~n~-1~n~0 / 28~n~74~n~0 : 0 ~n~0 / 0 : 0~n~0 / 0 : 0~n~0~n~0.00 ~n
function sampev.onTextDrawSetString(id, text)
	--sampAddChatMessage(tag .. " ID: " .. id .. " Text: " .. text)
	if id == 2074 and setting_items.hide_td.v then
		player_info = textSplit(text, "~n~")
	end
end
-- {0777A3}[AH by Yamada.]: {CCCCCC} ID: 199 Text: Score: Health: Armour: CarHP: Speed: Ping: Ammo: Shot: TimeShot: AFKTime: P.Loss: VIP: Passive Mode: Turbo: Collision:
function sampev.onShowTextDraw(id, data)
	--sampAddChatMessage(tag .. " ID: " .. id .. " Text: " .. data.text)
	if (id >= 406 and id <= 441 or id == 187 or id == 2074 or id == 2107) and setting_items.hide_td.v then
		
		return false
	end
end
function sampev.onSendCommand(command)
	--sampAddChatMessage(tag .. " " .. command)
	local id = string.match(command, "/re (%d+)")
	if id ~= nil and not check_cmd_re and setting_items.hide_td.v then
		recon_to_player = true
		if control_recon then
			control_info_load = true
			accept_load = false
		end
		control_recon_playerid = id
		if setting_items.hide_td.v then
			check_cmd_re = true
			sampSendChat("/re " .. id)
			check_cmd:run()
			sampSendChat("/remenu")
		end
	end
	if command == "/reoff" then
		recon_to_player = false
		check_mouse = false
		control_recon_playerid = -1
	end
end
function sampev.onSendChat(message)
	-- [x] -- Захват строки для дальнейшей обработки. -- [x] --
	if setting_items.Punishments.v then
		if string.match(message, "-(.+) (.+)") == nil then
			if string.match(message, "-(.+)") ~= nil then
				local checkstr = string.match(message, "-(.+)")
				if punishments[checkstr] ~= nil or punishments[string.lower(RusToEng(checkstr))] ~= nil then
					if punishments[checkstr] == nil then
						sampAddChatMessage(tag .. "Используйте: -" .. string.lower(RusToEng(checkstr)) .. " [ИД игрока] (Множител наказания)")
						return false
					else
						sampAddChatMessage(tag .. "Используйте: -" .. checkstr .. " [ИД игрока] (Множител наказания)")
						return false
					end
				else
					return true
				end
			end
			return true
		else
			if string.match(message, "-(.+) (.+) (.+)") == nil and string.match(message, "-(.+) (.+)") ~= nil then
				local checkstr, id = string.match(message, "-(.+) (.+)")
				if punishments[checkstr] ~= nil then
					--if string.match(id, "(.+) (.+)") == nil then
						--sampSendChat("/ans " .. id .. " Если Вы не согласны с верностью выданного наказания, Вы можете оставить жалобу...")
						--sampSendChat("/ans " .. id .. " ...в нашей группе с Скриншотом наказания. Наша группа VK >> vk.com/dmdriftgta")
						sampSendChat("/" .. punishments[checkstr].cmd .. " " .. id .. " " .. punishments[checkstr].time .. " " .. punishments[checkstr].reason)
						return false
					--[[else
						local pid, mno = string.match(id, "(.+) (.+)")
						sampSendChat("/" .. punishments[checkstr].cmd .. " " .. id .. " " .. tonumber(punishments[checkstr].time)*tonumber(mno) .. " " .. punishments[checkstr].reason .. " x" .. mno)
						return false
					end]]
				elseif punishments[string.lower(RusToEng(checkstr))] ~= nil then
					checkstr = string.lower(RusToEng(checkstr))
					--if string.match(id, "(.+) (.+)") == nil then
						--sampSendChat("/ans " .. id .. " Если Вы не согласны с верностью выданного наказания, Вы можете оставить жалобу...")
						--sampSendChat("/ans " .. id .. " ...в нашей группе с Скриншотом наказания. Наша группа VK >> vk.com/dmdriftgta")
						sampSendChat("/" .. punishments[checkstr].cmd .. " " .. id .. " " .. punishments[checkstr].time .. " " .. punishments[checkstr].reason)
						return false
					--[[else
						local pid, mno = string.match(id, "(.+) (.+)")
						sampSendChat("/" .. punishments[checkstr].cmd .. " " .. id .. " " .. tonumber(punishments[checkstr].time)*tonumber(mno) .. " " .. punishments[checkstr].reason .. " x" .. mno)
						return false
					end]]
				else
					return true
				end
			elseif string.match(message, "-(.+) (.+) (.+)") ~= nil then
				local checkstr, id, mno = string.match(message, "-(.+) (.+) (.+)")
				if punishments[checkstr] ~= nil then
					--sampSendChat("/ans " .. id .. " Если Вы не согласны с верностью выданного наказания, Вы можете оставить жалобу...")
					--sampSendChat("/ans " .. id .. " ...в нашей группе с Скриншотом наказания. Наша группа VK >> vk.com/dmdriftgta")
					sampSendChat("/" .. punishments[checkstr].cmd .. " " .. id .. " " .. tonumber(punishments[checkstr].time)*tonumber(mno) .. " " .. punishments[checkstr].reason .. " x" .. mno)
					return false
				elseif punishments[string.lower(RusToEng(checkstr))] ~= nil then
					checkstr = string.lower(RusToEng(checkstr))
					--sampSendChat("/ans " .. id .. " Если Вы не согласны с верностью выданного наказания, Вы можете оставить жалобу...")
					--sampSendChat("/ans " .. id .. " ...в нашей группе с Скриншотом наказания. Наша группа VK >> vk.com/dmdriftgta")
					sampSendChat("/" .. punishments[checkstr].cmd .. " " .. id .. " " .. tonumber(punishments[checkstr].time)*tonumber(mno) .. " " .. punishments[checkstr].reason .. " x" .. mno)
					return false
				else
					return true
				end
			end
		end
	end
end
function RusToEng(text)
    result = text == '' and nil or ''
    if result then
        for i = 0, #text do
            letter = string.sub(text, i, i)
            if letter then
                result = (letter:find('[А-Я/{/}/</>]') and string.upper(translate[string.rlower(letter)]) or letter:find('[а-я/,]') and translate[letter] or letter)..result
            end
        end
    end
    return result and result:reverse() or result
end
function sampev.onServerMessage(color, text)
	local check_string = string.match(text, "[^%s]+")
	local _, check_mat_id, _, check_mat = string.match(text, "(.+)%((.+)%): {(.+)}(.+)")
	if setting_items.Admin_chat.v and check_string ~= nil and string.find(check_string, "%[A%-(%d+)%]") ~= nil then
		admin_chat_lines.chat_line_10 = admin_chat_lines.chat_line_9
		admin_chat_lines.chat_line_9 = admin_chat_lines.chat_line_8
		admin_chat_lines.chat_line_8 = admin_chat_lines.chat_line_7
		admin_chat_lines.chat_line_7 = admin_chat_lines.chat_line_6
		admin_chat_lines.chat_line_6 = admin_chat_lines.chat_line_5
		admin_chat_lines.chat_line_5 = admin_chat_lines.chat_line_4
		admin_chat_lines.chat_line_4 = admin_chat_lines.chat_line_3
		admin_chat_lines.chat_line_3 = admin_chat_lines.chat_line_2
		admin_chat_lines.chat_line_2 = admin_chat_lines.chat_line_1
		admin_chat_lines.chat_line_1 = text
		return false
	elseif check_string == '(Жалоба/Вопрос)' and setting_items.Push_Report.v then
		showNotification("Уведомление", "Поступил новый репорт.")
		return true
	end
	if check_mat ~= nil and check_mat_id ~= nil and setting_items.Chat_Logger.v then
		local string_os = string.split(check_mat, " ")
		for i, value in ipairs(onscene) do
			for j, val in ipairs(string_os) do
				val = val:match("(%P+)")
				if val ~= nil then
					if value == string.rlower(val) then
						--[[local number_log_player = 0
						for _, _ in pairs(log_onscene) do
							number_log_player = number_log_player+1
						end
						number_log_player = number_log_player+1
						log_onscene[number_log_player] = {
							id = tonumber(check_mat_id),
							name = sampGetPlayerNickname(tonumber(check_mat_id)),
							text = check_mat,
							suspicion = value
						}
						date_onscene[number_log_player] = os.date()]]
						sampAddChatMessage(text, color)
						if not isGamePaused() then
							--sampSendChat("/ans " .. check_mat_id .. " Если Вы не согласны с верностью выданного наказания, Вы можете оставить жалобу...")
							--sampSendChat("/ans " .. check_mat_id .. " ...в нашей группе с Скриншотом наказания. Наша группа VK >> vk.com/dmdriftgta")
							sampSendChat("/mute " .. check_mat_id .. " 300 Нецензурная лексика.")
							showNotification("Детектор обнаружил нарушение!", "Запрещенное слово: {FF0000}" .. value .. "\n {FFFFFF}Ник нарушителя: {FF0000}" .. sampGetPlayerNickname(tonumber(check_mat_id)))
						end
						break
						break
					end
				end
			end
		end
		return true
	end
	if text == "Вы отключили меню при наблюдении" and setting_items.hide_td.v then
		sampSendChat("/remenu")
		return false
	end
	if text == "Вы включили меню при наблюдении" then
		control_recon = true
		if recon_to_player then
			control_info_load = true
			accept_load = false
		end
		return false
	end
	if text == "Вы отключили меню при наблюдении" and not setting_items.hide_td.v then
		control_recon = false
		return false
	end
	if (text == "Игрок не в сети" and recon_to_player) or (text == "[Информация] {ffeabf}Вы не можете следить за администратором который выше уровнем." and recon_to_player) then
		recon_to_player = false
		sampSendChat("/reoff")
	end
end
function sampev.onShowDialog(dialogid, _, _, _, _, _)
	--sampAddChatMessage(tag .. dialogid)
end
function sampev.onDisplayGameText(_, _, text)
	if text == "~y~REPORT++" then
		return false
	end
end
function drawAdminChat()
	while true do
		if setting_items.Admin_chat.v then
			if setting_items.Transparency.v then
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_10, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4), 0x66AAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_9, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*2, 0x77AAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_8, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*3, 0x88AAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_7, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*4, 0x99AAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_6, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*5, 0xAAAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_5, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*6, 0xBBAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_4, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*7, 0xCCAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_3, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*8, 0xDDAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_2, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*9, 0xEEAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_1, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*10, 0xFFAAAAAA)
			else
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_10, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4), 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_9, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*2, 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_8, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*3, 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_7, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*4, 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_6, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*5, 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_5, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*6, 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_4, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*7, 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_3, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*8, 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_2, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*9, 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_1, sw/28, sh/config.setting.Index+((tonumber(font_size_ac.v) or 10)+4)*10, 0xFFAAAAAA)
			end
		end
		wait(1)
	end
end
function showNotification(handle, text_not)
	notfy.addNotify("{6930A1}" .. handle, " \n " .. text_not, 2, 1, 10)
	setAudioStreamState(load_audio, ev.PLAY)
end
function controlOnscene()
	local number_log_player_2
	for number_log_player, value in ipairs(log_onscene) do
		number_log_player_2 = number_log_player + 1
		if log_onscene[number_log_player].id == nil then
			if log_onscene[number_log_player_2] ~= nil then
				log_onscene[number_log_player].id = log_onscene[number_log_player_2].id
				log_onscene[number_log_player_2].id = nil
				log_onscene[number_log_player].name = log_onscene[number_log_player_2].name
				log_onscene[number_log_player_2].name = nil
				log_onscene[number_log_player].text = log_onscene[number_log_player_2].text
				log_onscene[number_log_player_2].text = nil
				log_onscene[number_log_player].suspicion = log_onscene[number_log_player_2].suspicion
				log_onscene[number_log_player_2].suspicion = nil
				date_onscene[number_log_player] = date_onscene[number_log_player_2]
				date_onscene[number_log_player_2] = nil
			end
		end
	end
end
function playersToStreamZone()
	local peds = getAllChars()
	local streaming_player = {}
	local _, pid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	for key, v in pairs(peds) do
		local result, id = sampGetPlayerIdByCharHandle(v)
		if result and id ~= pid and id ~= tonumber(control_recon_playerid) then
			streaming_player[key] = id
		end
	end
	return streaming_player
end
function loadPlayerInfo()
	wait(3000)
	accept_load = true
end
function convert3Dto2D(x, y, z)
    local result, wposX, wposY, wposZ, w, h = convert3DCoordsToScreenEx(x, y, z, true, true)
    local fullX = readMemory(0xC17044, 4, false)
    local fullY = readMemory(0xC17048, 4, false)
    wposX = wposX * (640.0 / fullX)
    wposY = wposY * (448.0 / fullY)
    return result, wposX, wposY
end
function drawWallhack()
	local peds = getAllChars()
	local _, pid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	while true do
		wait(10)
		for i = 0, sampGetMaxPlayerId() do
			if sampIsPlayerConnected(i) and control_wallhack then
				local result, cped = sampGetCharHandleBySampPlayerId(i)
				local color = sampGetPlayerColor(i)
				local aa, rr, gg, bb = explode_argb(color)
				local color = join_argb(255, rr, gg, bb)
				if result then
					if doesCharExist(cped) and isCharOnScreen(cped) then
						local t = {3, 4, 5, 51, 52, 41, 42, 31, 32, 33, 21, 22, 23, 2}
						for v = 1, #t do
							pos1X, pos1Y, pos1Z = getBodyPartCoordinates(t[v], cped)
							pos2X, pos2Y, pos2Z = getBodyPartCoordinates(t[v] + 1, cped)
							pos1, pos2 = convert3DCoordsToScreen(pos1X, pos1Y, pos1Z)
							pos3, pos4 = convert3DCoordsToScreen(pos2X, pos2Y, pos2Z)
							renderDrawLine(pos1, pos2, pos3, pos4, 1, color)
						end
						for v = 4, 5 do
							pos2X, pos2Y, pos2Z = getBodyPartCoordinates(v * 10 + 1, cped)
							pos3, pos4 = convert3DCoordsToScreen(pos2X, pos2Y, pos2Z)
							renderDrawLine(pos1, pos2, pos3, pos4, 1, color)
						end
						local t = {53, 43, 24, 34, 6}
						for v = 1, #t do
							posX, posY, posZ = getBodyPartCoordinates(t[v], cped)
							pos1, pos2 = convert3DCoordsToScreen(posX, posY, posZ)
						end
					end
				end
			end
		end
	end
end
function getBodyPartCoordinates(id, handle)
  local pedptr = getCharPointer(handle)
  local vec = ffi.new("float[3]")
  getBonePosition(ffi.cast("void*", pedptr), vec, id, true)
  return vec[0], vec[1], vec[2]
end
function join_argb(a, r, g, b)
  local argb = b  -- b
  argb = bit.bor(argb, bit.lshift(g, 8))  -- g
  argb = bit.bor(argb, bit.lshift(r, 16)) -- r
  argb = bit.bor(argb, bit.lshift(a, 24)) -- a
  return argb
end
function explode_argb(argb)
  local a = bit.band(bit.rshift(argb, 24), 0xFF)
  local r = bit.band(bit.rshift(argb, 16), 0xFF)
  local g = bit.band(bit.rshift(argb, 8), 0xFF)
  local b = bit.band(argb, 0xFF)
  return a, r, g, b
end
function nameTagOn()
	local pStSet = sampGetServerSettingsPtr();
	NTdist = mem.getfloat(pStSet + 39)
	NTwalls = mem.getint8(pStSet + 47)
	NTshow = mem.getint8(pStSet + 56)
	mem.setfloat(pStSet + 39, 1488.0)
	mem.setint8(pStSet + 47, 0)
	mem.setint8(pStSet + 56, 1)
	nameTag = true
end
function nameTagOff()
	local pStSet = sampGetServerSettingsPtr();
	mem.setfloat(pStSet + 39, NTdist)
	mem.setint8(pStSet + 47, NTwalls)
	mem.setint8(pStSet + 56, NTshow)
	nameTag = false
end
function textSplit(str, delim, plain)
    local tokens, pos, plain = {}, 1, not (plain == false) --[[ delimiter is plain text by default ]]
    repeat
        local npos, epos = string.find(str, delim, pos, plain)
        table.insert(tokens, string.sub(str, pos, npos and npos - 1))
        pos = epos and epos + 1
    until not pos
    return tokens
end
function string.rlower(s)
    s = s:lower()
    local strlen = s:len()
    if strlen == 0 then return s end
    s = s:lower()
    local output = ''
    for i = 1, strlen do
        local ch = s:byte(i)
        if ch >= 192 and ch <= 223 then -- upper russian characters
            output = output .. russian_characters[ch + 32]
        elseif ch == 168 then -- Ё
            output = output .. russian_characters[184]
        else
            output = output .. string.char(ch)
        end
    end
    return output
end
function string.rupper(s)
    s = s:upper()
    local strlen = s:len()
    if strlen == 0 then return s end
    s = s:upper()
    local output = ''
    for i = 1, strlen do
        local ch = s:byte(i)
        if ch >= 224 and ch <= 255 then -- lower russian characters
            output = output .. russian_characters[ch - 32]
        elseif ch == 184 then -- ё
            output = output .. russian_characters[168]
        else
            output = output .. string.char(ch)
        end
    end
    return output
end
function getDownKeys()
    local curkeys = ""
    local bool = false
    for k, v in pairs(vkeys) do
        if isKeyDown(v) and (v == VK_MENU or v == VK_CONTROL or v == VK_SHIFT or v == VK_LMENU or v == VK_RMENU or v == VK_RCONTROL or v == VK_LCONTROL or v == VK_LSHIFT or v == VK_RSHIFT) then
            if v ~= VK_MENU and v ~= VK_CONTROL and v ~= VK_SHIFT then
                curkeys = v
            end
        end
    end
    for k, v in pairs(vkeys) do
        if isKeyDown(v) and (v ~= VK_MENU and v ~= VK_CONTROL and v ~= VK_SHIFT and v ~= VK_LMENU and v ~= VK_RMENU and v ~= VK_RCONTROL and v ~= VK_LCONTROL and v ~= VK_LSHIFT and v ~= VK_RSHIFT) then
            if tostring(curkeys):len() == 0 then
                curkeys = v
            else
                curkeys = curkeys .. " " .. v
            end
            bool = true
        end
    end
    return curkeys, bool
end
function getDownKeysText()
	tKeys = string.split(getDownKeys(), " ")
	if #tKeys ~= 0 then
		for i = 1, #tKeys do
			if i == 1 then
				str = vkeys.id_to_name(tonumber(tKeys[i]))
			else
				str = str .. "+" .. vkeys.id_to_name(tonumber(tKeys[i]))
			end
		end
		return str
	else
		return "None"
	end
end
function string.split(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            t[i] = str
            i = i + 1
    end
    return t
end
function strToIdKeys(str)
	tKeys = string.split(str, "+")
	if #tKeys ~= 0 then
		for i = 1, #tKeys do
			if i == 1 then
				str = vkeys.name_to_id(tKeys[i], false)
			else
				str = str .. " " .. vkeys.name_to_id(tKeys[i], false)
			end
		end
		return tostring(str)
	else
		return "(("
	end
end
function isKeysDown(keylist, pressed)
    local tKeys = string.split(keylist, " ")
    if pressed == nil then
        pressed = false
    end
    if tKeys[1] == nil then
        return false
    end
    local bool = false
    local key = #tKeys < 2 and tonumber(tKeys[1]) or tonumber(tKeys[2])
    local modified = tonumber(tKeys[1])
    if #tKeys < 2 then
        if not isKeyDown(VK_RMENU) and not isKeyDown(VK_LMENU) and not isKeyDown(VK_LSHIFT) and not isKeyDown(VK_RSHIFT) and not isKeyDown(VK_LCONTROL) and not isKeyDown(VK_RCONTROL) then
            if wasKeyPressed(key) and not pressed then
                bool = true
            elseif isKeyDown(key) and pressed then
                bool = true
            end
        end
    else
        if isKeyDown(modified) and not wasKeyReleased(modified) then
            if wasKeyPressed(key) and not pressed then
                bool = true
            elseif isKeyDown(key) and pressed then
                bool = true
            end
        end
    end
    if nextLockKey == keylist then
        if pressed and not wasKeyReleased(key) then
            bool = false
        else
            bool = false
            nextLockKey = ""
        end
    end
    return bool
end

-- [x] -- ImGUI тело. -- [x] --
local W_Windows = sw/1.145
local H_Windows = 1
local text_dialog
function imgui.OnDrawFrame()
	imgui.ShowCursor = check_mouse
	if i_ans_window.v then
		imgui.SetNextWindowPos(imgui.ImVec2(W_Windows, H_Windows), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(280, 700), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"Ответы на ANS", i_ans_window)
		local btn_size = imgui.ImVec2(-0.1, 0)
		imgui.Checkbox(u8"Пожелание в конце.", i_back_prefix)
		imgui.Separator()
		for key, v in pairs(i_ans) do
			if imgui.Button(v, btn_size) then
				if not i_back_prefix.v then
					sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(v))
				else
					sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(v) .. ' {AAAAAA}// Приятной игры на "RDS"!')
				end
			end
		end
		--[[if imgui.Button(i_ans[1], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[1]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[1]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[2], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[2]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[2]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[3], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[3]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[3]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[4], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[4]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[4]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[5], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[5]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[5]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[6], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[6]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[6]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[7], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[7]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[7]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[8], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[8]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[8]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[9], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[9]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[9]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[10], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[10]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[10]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[11], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[11]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[11]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[12], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[12]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[12]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[13], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[13]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[13]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[14], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[14]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[14]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[15], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[15]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[15]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[16], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[16]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[16]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[17], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[17]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[17]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[18], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[18]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[18]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[19], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[19]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[19]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[20], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[20]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[20]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[21], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[21]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[21]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[22], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[22]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[22]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[23], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[23]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[23]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[24], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[24]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[24]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[25], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[25]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[25]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[26], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[26]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[26]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[27], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[27]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[27]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[28], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[28]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[28]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[29], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[29]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[29]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[30], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[30]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[30]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[31], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[31]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[31]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[32], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[32]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[32]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[33], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[33]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[33]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[34], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[34]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[34]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[35], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[35]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[35]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[36], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[36]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[36]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[37], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[37]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[37]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[38], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[38]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[38]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[39], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[39]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[39]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[40], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[40]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[40]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end
		if imgui.Button(i_ans[41], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[41]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[41]) .. ' {AAAAAA}// Приятной игры на "RDS"!')
			end
		end]]
		imgui.End()
	end
	if i_setting_items.v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw-10, 10), imgui.Cond.FirstUseEver, imgui.ImVec2(1, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(300, sh/1.15), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"Настройки скрипта.", i_setting_items)
		imgui.Text(u8"Кастомное наблюдение за игроком.")
		imgui.SameLine()
		imgui.SetCursorPosX(imgui.GetWindowWidth() - 35)
		imgui.ToggleButton("##1", setting_items.hide_td)
		imgui.Text(u8"Быстрые ответы на ANS.")
		imgui.SameLine()
		imgui.SetCursorPosX(imgui.GetWindowWidth() - 35)
		imgui.ToggleButton("##2", setting_items.Fast_ans)
		imgui.Text(u8"Уведомления о репорте.")
		imgui.SameLine()
		imgui.SetCursorPosX(imgui.GetWindowWidth() - 35)
		imgui.ToggleButton("##3", setting_items.Push_Report)
		imgui.Text(u8"Чат-логгер.")
		imgui.SameLine()
		imgui.SetCursorPosX(imgui.GetWindowWidth() - 35)
		imgui.ToggleButton("##4", setting_items.Chat_Logger)
		imgui.Text(u8"Сокращенные команды наказаний.")
		imgui.SameLine()
		imgui.SetCursorPosX(imgui.GetWindowWidth() - 35)
		imgui.ToggleButton("##5", setting_items.Punishments)
		imgui.Text(u8"Админ чат.")
		imgui.SameLine()
		imgui.SetCursorPosX(imgui.GetWindowWidth() - 35)
		imgui.ToggleButton("##6", setting_items.Admin_chat)
		imgui.Text(u8"Прозрачность админ чата.")
		imgui.SameLine()
		imgui.SetCursorPosX(imgui.GetWindowWidth() - 35)
		imgui.ToggleButton("##7", setting_items.Transparency)		
		imgui.PushItemWidth(50)
		if imgui.InputText(u8"Размер чата.", font_size_ac) then
			font_ac = renderCreateFont("Arial", tonumber(font_size_ac.v) or 10, font_admin_chat.BOLD + font_admin_chat.SHADOW)
		end
		imgui.PopItemWidth()
		imgui.Text(u8"Высота чата: " .. config.setting.Index)
		if imgui.Button(u8" Выше ") then
			config.setting.Index = config.setting.Index + 0.05
		end
		if imgui.Button(u8" Ниже ") then
			config.setting.Index = config.setting.Index - 0.05
		end
		imgui.Separator()
		imgui.InputText(u8"Приветствие.", HelloAC)
		imgui.Separator()
		if imgui.Button(u8"Настройка клавиш скрипта.") then
			setting_keys = true
		end
		imgui.Separator()
		if imgui.Button(u8"Сохранить.") then
			config.setting.Fast_ans = setting_items.Fast_ans.v
			config.setting.Admin_chat = setting_items.Admin_chat.v
			config.setting.Punishments = setting_items.Punishments.v
			config.setting.Font = font_size_ac.v
			config.setting.Tranparency = setting_items.Transparency.v
			config.setting.Auto_remenu = setting_items.Auto_remenu.v
			config.setting.Push_Report = setting_items.Push_Report.v
			config.setting.Chat_Logger = setting_items.Chat_Logger.v
			config.setting.hide_td = setting_items.hide_td.v
			config.setting.HelloAC = HelloAC.v
			inicfg.save(config, directIni)
		end	
		imgui.Separator()
		imgui.SetCursorPosX(imgui.GetWindowWidth()/2-100)
		imgui.Image(logo_image, imgui.ImVec2(200, 200))
		if update_state then
			imgui.SetCursorPosY(imgui.GetWindowHeight() - 55)
			imgui.Separator()
			imgui.Text(u8"Версия скрипта: " .. script_version_text)
			imgui.Text(u8"Доступно обновление!\nНовая версия скрипта: " .. updateIni.info.version_text)
			imgui.SameLine()
			imgui.SetCursorPosX(imgui.GetWindowWidth() - 80)
			if imgui.Button(u8"Обновить.") then
				showNotification("Обновление!", "Началось обновление скрипта.")
				downloadUrlToFile(script_url, script_path, function(id, status)
					if status == dlstat.STATUS_ENDDOWNLOADDATA then
						showNotification("Обновление!", "Скрипт успешно обновлен!")
						thisScript():reload()
					end
				end)
			end
		else
			imgui.SetCursorPosY(imgui.GetWindowHeight() - 50)
			imgui.Separator()
			imgui.Text(u8"Версия скрипта: " .. script_version_text)
			if imgui.Button(u8"Чего нового в скрипте ##Info", imgui.ImVec2(-0.1, 0)) then
				i_info_update.v = true
				i_setting_items.v = false
			end
		end
		imgui.End()
		if setting_keys then
			imgui.SetNextWindowPos(imgui.ImVec2(10, 10), imgui.Cond.FirstUseEver, imgui.ImVec2(1, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(300, sh/1.15), imgui.Cond.FirstUseEver)
			imgui.Begin(u8"Настройка клавиш.")
			imgui.Text(u8"Зажатые кнопки: ")
			imgui.SameLine()
			imgui.TextColored(imgui.ImVec4(0.71, 0.59, 1.0, 1.0), getDownKeysText())
			imgui.Separator()
			imgui.Text(u8"Открытие настроек: ")
			imgui.SameLine()
			imgui.TextColored(imgui.ImVec4(0.71, 0.59, 1.0, 1.0), config.keys.Setting)
			imgui.SetCursorPosX(imgui.GetWindowWidth() - 84)
			if imgui.Button(u8"Записать. ## 1", imgui.ImVec2(75, 0)) then
				config.keys.Setting = getDownKeysText()
				inicfg.save(config, directIni)
			end
			imgui.Separator()
			imgui.Text(u8"Статистика игрока при слежке: ")
			imgui.SameLine()
			imgui.TextColored(imgui.ImVec4(0.71, 0.59, 1.0, 1.0), config.keys.Re_menu)
			imgui.SetCursorPosX(imgui.GetWindowWidth() - 84)
			if imgui.Button(u8"Записать. ## 2", imgui.ImVec2(75, 0)) then
				config.keys.Re_menu = getDownKeysText()
				inicfg.save(config, directIni)
			end
			imgui.Separator()
			imgui.Text(u8"Приветствие в админ-чат: ")
			imgui.SameLine()
			imgui.TextColored(imgui.ImVec4(0.71, 0.59, 1.0, 1.0), config.keys.Hello)
			imgui.SetCursorPosX(imgui.GetWindowWidth() - 84)
			if imgui.Button(u8"Записать. ## 3", imgui.ImVec2(75, 0)) then
				config.keys.Hello = getDownKeysText()
				inicfg.save(config, directIni)
			end
			imgui.Separator()
			imgui.Text(u8"Открытие лога мата: ")
			imgui.SameLine()
			imgui.TextColored(imgui.ImVec4(0.71, 0.59, 1.0, 1.0), config.keys.P_Log)
			imgui.SetCursorPosX(imgui.GetWindowWidth() - 84)
			if imgui.Button(u8"Записать. ## 4", imgui.ImVec2(75, 0)) then
				config.keys.P_Log = getDownKeysText()
				inicfg.save(config, directIni)
			end
			imgui.Separator()
			imgui.Text(u8"Скрытие админ-чата: ")
			imgui.SameLine()
			imgui.TextColored(imgui.ImVec4(0.71, 0.59, 1.0, 1.0), config.keys.Hide_AChat)
			imgui.SetCursorPosX(imgui.GetWindowWidth() - 84)
			if imgui.Button(u8"Записать. ## 5", imgui.ImVec2(75, 0)) then
				config.keys.Hide_AChat = getDownKeysText()
				inicfg.save(config, directIni)
			end
			imgui.Separator()
			imgui.Text(u8"Курсор мышки при слежке: ")
			imgui.SameLine()
			imgui.TextColored(imgui.ImVec4(0.71, 0.59, 1.0, 1.0), config.keys.Mouse)
			imgui.SetCursorPosX(imgui.GetWindowWidth() - 84)
			if imgui.Button(u8"Записать. ## 6", imgui.ImVec2(75, 0)) then
				config.keys.Mouse = getDownKeysText()
				inicfg.save(config, directIni)
			end
			imgui.Separator()
			if imgui.Button(u8"Назад.", imgui.ImVec2(-0.1, 0)) then
				setting_keys = false
			end
			
			imgui.End()
		end
	end
	if i_info_update.v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 1))
		imgui.SetNextWindowSize(imgui.ImVec2(sw/1.3, -0.1), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"Чего нового в скрипте.", i_info_update)
		--[[imgui.Text(u8"Ниже представлены игроки, которые нарушили правила чата.")
		for i, v in ipairs(log_onscene) do
			if v.id ~= nil then
				imgui.Separator()
				imgui.Text(u8"Ник игрока: " .. u8:encode(v.name) .. " ID: " .. u8:encode(v.id) .. 
				u8"\nСлово, которое попало под подозрения: " .. u8:encode(v.suspicion) .. 
				u8"\nТекст из чата: " .. u8:encode(v.text) .. 
				u8"\nДата: " .. date_onscene[i] ..
				u8"\nНаказание:")
				if imgui.Button(u8"Мат. ##" .. i, imgui.ImVec2(90, 0)) then
					sampSendChat("/mute " .. v.id .. " 300 Нецензурная лексика.")
					v.id = nil
					controlOnscene()
				end
				imgui.SameLine()
				if imgui.Button(u8"Оск. ##" .. i, imgui.ImVec2(90, 0)) then
					sampSendChat("/mute " .. v.id .. " 400 Оскорбление игрока.")
					v.id = nil
					controlOnscene()
				end
				imgui.SameLine()
				if imgui.Button(u8"Униж. ##" .. i, imgui.ImVec2(90, 0)) then
					sampSendChat("/mute " .. v.id .. " 400 Унижение игрока игрока.")
					v.id = nil
					controlOnscene()
				end
				imgui.SameLine()
				if imgui.Button(u8"Оск. Род. ##" .. i, imgui.ImVec2(90, 0)) then
					sampSendChat("/mute " .. v.id .. " 5000 Упоминание родителей.")
					v.id = nil
					controlOnscene()
				end
				imgui.SameLine()
				if imgui.Button(u8"Оск. Адм. ##" .. i, imgui.ImVec2(90, 0)) then
					sampSendChat("/mute " .. v.id .. " 2500 Оскорбление администрации.")
					v.id = nil
					controlOnscene()
				end 
				imgui.SameLine()
				if imgui.Button(u8"Очистить. ##" .. i, imgui.ImVec2(90, 0)) then
					v.id = nil
					controlOnscene()
				end 
			end
		end
		imgui.Separator()]]
		imgui.Text(u8"Что было добавленно:\n")
		imgui.SetCursorPosX(20)
		imgui.Text(u8"- Было добавлена система авто-мута. Можно добавить в систему запрещенные слова,\n и скрипт, при обноружении данных слов в чате, мутит человека.")
		imgui.SetCursorPosX(20)
		imgui.TextColored(imgui.ImVec4(1.00, 0.10, 0.10, 1.00), u8"ПРЕДУПРЕЖДЕНИЕ! ")
		imgui.SameLine()
		imgui.Text(u8"Система мутит исключительно за мат! Такие слова, как \"Пидор\", \"Еблан\", добавлять не нужно.\n\tКоманды:\n/save_mat - добавить слово в базу.\n/del_mat - удалить слово из базы.")
		imgui.Separator()
		imgui.SetCursorPosX(20)
		imgui.Text(u8"- Было поправлено меню слежки. Так как наш \"Любимый\" скриптер добавил новое меню слежки,\n в скрипте начались перебои меню.")
		imgui.Separator()
		imgui.SetCursorPosX(20)
		imgui.Text(u8"- Добавил свой текст приветствия. Теперь вы можете изменить текст приветствия на клвишу.")
		imgui.Separator()
		imgui.SetCursorPosX(20)
		imgui.Text(u8"- Изменил переключатель на /remenu. Теперь это переключатель между интерфейсами (серверным и скриптовым). ")
		imgui.Separator()
		imgui.SetCursorPosX(imgui.GetWindowWidth()/2)
		if imgui.Button(u8"Выход.", imgui.ImVec2(100, 0)) then
			i_info_update.v = false
		end
		imgui.End()
	end
	if i_re_menu.v and control_recon and recon_to_player and setting_items.hide_td.v then
		imgui.SetNextWindowPos(imgui.ImVec2(sw/2, sh/1.06), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 1))
		imgui.SetNextWindowSize(imgui.ImVec2(80+80+80+80+80+10, sh-sh-10), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"Наказания игрока.", false, 2+4+32)
			imgui.SetCursorPosX(imgui.GetWindowWidth()/2.43-160)
			if imgui.Button(u8"Обновить.", imgui.ImVec2(75, 0)) then
				sampSendClickTextdraw(435)
			end
			imgui.SameLine()
			imgui.SetCursorPosX(imgui.GetWindowWidth()/2.43-80)
			if imgui.Button(u8"Посадить.", imgui.ImVec2(75, 0)) then
				jail_or_ban_re = 1
			end
			imgui.SameLine()
			imgui.SetCursorPosX(imgui.GetWindowWidth()/2.41)
			if imgui.Button(u8"Забанить.", imgui.ImVec2(75, 0)) then
				jail_or_ban_re = 2
			end
			imgui.SameLine()
			imgui.SetCursorPosX(imgui.GetWindowWidth()/2.43+80)
			if imgui.Button(u8"Кикнуть.", imgui.ImVec2(75, 0)) then
				jail_or_ban_re = 3
			end
			imgui.SameLine()
			imgui.SetCursorPosX(imgui.GetWindowWidth()/2.43+160)
			if imgui.Button(u8"Выйти.", imgui.ImVec2(75, 0)) then
				sampSendChat("/reoff")
				control_recon_playerid = -1
			end
		imgui.End()
		imgui.SetNextWindowPos(imgui.ImVec2(sw-10, 10), imgui.Cond.FirstUseEver, imgui.ImVec2(1, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(250, sh/1.15), imgui.Cond.FirstUseEver)
		if right_re_menu then
			imgui.Begin(u8"Информация об игроке.", false, 2+4+32)
			if accept_load then
				if not sampIsPlayerConnected(control_recon_playerid) then
					control_recon_playernick = "-"
				else
					control_recon_playernick = sampGetPlayerNickname(control_recon_playerid)
				end
				imgui.Text(u8"Игрок: " .. control_recon_playernick .. "[" .. control_recon_playerid .. "]")
				imgui.Separator()
				--[[local i = 1
				while i <= 14 do
					if i == 3 or i == 4 then
						if i == 3 and tonumber(player_info[3]) ~= 0 then
							imgui.Text(u8:encode(text_remenu[i]) .. " " .. player_info[i])
						end
						if i == 4 and tonumber(player_info[4]) ~= -1 then
							imgui.Text(u8:encode(text_remenu[i]) .. " " .. player_info[i])
						end
					else
						imgui.Text(u8:encode(text_remenu[i]) .. " " .. player_info[i])
					end
					if i == 3 then
						if tonumber(player_info[3]) ~= 0 then
							imgui.BufferingBar(tonumber(player_info[i])/100, imgui.ImVec2(imgui.GetWindowWidth()-10, 10), false)
						end
					end
					if i == 2 then
						imgui.BufferingBar(tonumber(player_info[i])/100, imgui.ImVec2(imgui.GetWindowWidth()-10, 10), false)
					end
					if i == 4 and tonumber(player_info[4]) ~= -1 then
						imgui.BufferingBar(tonumber(player_info[4])/1000, imgui.ImVec2(imgui.GetWindowWidth()-10, 10), false)
					end
					if i == 5 then
						local speed, const = string.match(player_info[5], "(%d+) / (%d+)")
						if tonumber(speed) > tonumber(const) then
							speed = const
						end
						imgui.BufferingBar((tonumber(speed)*100/tonumber(const))/100, imgui.ImVec2(imgui.GetWindowWidth()-10, 10), false)
					end
				i = i + 1
				end]]
				for key, v in pairs(player_info) do
					if key == 2 then
						imgui.Text(u8:encode(text_remenu[2]) .. " " .. player_info[2])
						imgui.BufferingBar(tonumber(player_info[2])/100, imgui.ImVec2(imgui.GetWindowWidth()-10, 10), false)
					end
					if key == 3 and tonumber(player_info[3]) ~= 0 then
						imgui.Text(u8:encode(text_remenu[3]) .. " " .. player_info[3])
						imgui.BufferingBar(tonumber(player_info[3])/100, imgui.ImVec2(imgui.GetWindowWidth()-10, 10), false)
					end
					if key == 4 and tonumber(player_info[4]) ~= -1 then
						imgui.Text(u8:encode(text_remenu[4]) .. " " .. player_info[4])
						imgui.BufferingBar(tonumber(player_info[4])/1000, imgui.ImVec2(imgui.GetWindowWidth()-10, 10), false)
					end
					if key == 5 then
						imgui.Text(u8:encode(text_remenu[5]) .. " " .. player_info[5])
						local speed, const = string.match(player_info[5], "(%d+) / (%d+)")
						if tonumber(speed) > tonumber(const) then
							speed = const
						end
						imgui.BufferingBar((tonumber(speed)*100/tonumber(const))/100, imgui.ImVec2(imgui.GetWindowWidth()-10, 10), false)
					end
					if key ~= 2 and key ~= 3 and key ~= 4 and key ~= 5 then
						imgui.Text(u8:encode(text_remenu[key]) .. " " .. player_info[key])
					end
				end
				--[[imgui.Text(u8:encode(text_remenu[1]) .. " " .. player_info[1])
				imgui.Text(u8:encode(text_remenu[2]) .. " " .. player_info[2])
				imgui.BufferingBar(tonumber(player_info[2])/100, imgui.ImVec2(imgui.GetWindowWidth()-10, 10), false)
				if tonumber(player_info[3]) ~= 0 then
					imgui.Text(u8:encode(text_remenu[3]) .. " " .. player_info[3])
				end
				if tonumber(player_info[3]) ~= 0 then
					imgui.BufferingBar(tonumber(player_info[3])/100, imgui.ImVec2(imgui.GetWindowWidth()-10, 10), false)
				end
				if tonumber(player_info[4]) ~= -1 then
					imgui.Text(u8:encode(text_remenu[4]) .. " " .. player_info[4])
					imgui.BufferingBar(tonumber(player_info[4])/1000, imgui.ImVec2(imgui.GetWindowWidth()-10, 10), false)
				end
				imgui.Text(u8:encode(text_remenu[5]) .. " " .. player_info[5])
				local speed, const = string.match(player_info[5], "(%d+) / (%d+)")
					if tonumber(speed) > tonumber(const) then
						speed = const
					end
				imgui.BufferingBar((tonumber(speed)*100/tonumber(const))/100, imgui.ImVec2(imgui.GetWindowWidth()-10, 10), false)
				imgui.Text(u8:encode(text_remenu[6]) .. " " .. player_info[6])
				imgui.Text(u8:encode(text_remenu[7]) .. " " .. player_info[7])
				imgui.Text(u8:encode(text_remenu[8]) .. " " .. player_info[8])
				imgui.Text(u8:encode(text_remenu[9]) .. " " .. player_info[9])
				imgui.Text(u8:encode(text_remenu[10]) .. " " .. player_info[10])
				imgui.Text(u8:encode(text_remenu[11]) .. " " .. player_info[11])
				imgui.Text(u8:encode(text_remenu[12]) .. " " .. player_info[12])
				imgui.Text(u8:encode(text_remenu[13]) .. " " .. player_info[13])
				imgui.Text(u8:encode(text_remenu[14]) .. " " .. player_info[14])
				imgui.Text(u8:encode(text_remenu[15]) .. " " .. player_info[15])]]
				imgui.Separator()
				if imgui.Button("WallHack", imgui.ImVec2(-0.1, 0)) then
					if control_wallhack then
						nameTagOff()
						control_wallhack = false
					else
						nameTagOn()
						control_wallhack = true
					end
				end
				imgui.Separator()
				imgui.Text(u8"Игроки рядом:")
				local playerid_to_stream = playersToStreamZone()
				for _, v in pairs(playerid_to_stream) do
					if imgui.Button(" - " .. sampGetPlayerNickname(v) .. "[" .. v .. "] - ", imgui.ImVec2(-0.1, 0)) then
						sampSendChat("/re " .. v)
					end
				end
				imgui.Separator()
				imgui.Text(u8"Что бы убрать курсор для\n осмотра камерой: Зажмите ПКМ.")
			else
				imgui.SetCursorPosX(imgui.GetWindowWidth()/2.3)
				imgui.SetCursorPosY(imgui.GetWindowHeight()/2.3)
				imgui.Spinner(20, 7)
			end
			imgui.End()
		end
		if jail_or_ban_re > 0 then
			imgui.SetNextWindowPos(imgui.ImVec2(10, 10), imgui.Cond.FirstUseEver, imgui.ImVec2(1, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(250, sh/1.15), imgui.Cond.FirstUseEver)
			imgui.Begin(u8"Наказания игрока. ##Nak", false, 2+4+32)
			if jail_or_ban_re == 1 then
				if imgui.Button("Speed Hack", imgui.ImVec2(-0.1, 0)) then
					sampSendChat("/jail " .. control_recon_playerid .. " 900 Использование запрещенного софта. (Speed Hack)")
				end
				if imgui.Button("Fly", imgui.ImVec2(-0.1, 0)) then
					sampSendChat("/jail " .. control_recon_playerid .. " 900 Использование запрещенного софта. (Fly)")
				end
				if imgui.Button("Fly Car", imgui.ImVec2(-0.1, 0)) then
					sampSendChat("/jail " .. control_recon_playerid .. " 900 Использование запрещенного софта. (Fly Car)")
				end
				if imgui.Button(u8"Помеха MP", imgui.ImVec2(-0.1, 0)) then
					sampSendChat("/jail " .. control_recon_playerid .. " 300 Помеха мероприятию.")
				end
				if imgui.Button("Spawn Kill", imgui.ImVec2(-0.1, 0)) then
					sampSendChat("/jail " .. control_recon_playerid .. " 300 Spawn Kill")
				end
				if imgui.Button(u8"Назад. ##1", imgui.ImVec2(-0.1, 0)) then
					jail_or_ban_re = 0
				end
			elseif jail_or_ban_re == 2 then
				if imgui.Button("S0beit", imgui.ImVec2(-0.1, 0)) then
					sampSendChat("/ban " .. control_recon_playerid .. " 7 Использование запрещенного софта. (S0beit)")
				end
				if imgui.Button("Aim", imgui.ImVec2(-0.1, 0)) then
					sampSendChat("/iban " .. control_recon_playerid .. " 7 Использование запрещенного софта. (Aim)")
				end
				if imgui.Button("Auto +C", imgui.ImVec2(-0.1, 0)) then
					sampSendChat("/iban " .. control_recon_playerid .. " 7 Использование запрещенного софта. (Auto +C)")
				end
				if imgui.Button("Rvanka", imgui.ImVec2(-0.1, 0)) then
					sampSendChat("/iban " .. control_recon_playerid .. " 7 Использование запрещенного софта. (Rvanka)")
				end
				if imgui.Button("Car Shot", imgui.ImVec2(-0.1, 0)) then
					sampSendChat("/iban " .. control_recon_playerid .. " 7 Использование запрещенного софта. (Car Shot)")
				end
				if imgui.Button("Cheat", imgui.ImVec2(-0.1, 0)) then
					sampSendChat("/iban " .. control_recon_playerid .. " 7 Использование запрещенного софта.")
				end
				if imgui.Button(u8"Неадекватное поведение.", imgui.ImVec2(-0.1, 0)) then
					sampSendChat("/iban " .. control_recon_playerid .. " 3 Неадекватное поведение.")
				end
				if imgui.Button("Nick 3/3", imgui.ImVec2(-0.1, 0)) then
					sampSendChat("/ban " .. control_recon_playerid .. " 3 Nick 3/3")
				end
				if imgui.Button(u8"Назад. ##2", imgui.ImVec2(-0.1, 0)) then
					jail_or_ban_re = 0
				end
			elseif jail_or_ban_re == 3 then
				if imgui.Button("Nick 1/3", imgui.ImVec2(-0.1, 0)) then
					sampSendChat("/kick " .. control_recon_playerid .. " Nick 1/3")
				end
				if imgui.Button("Nick 2/3", imgui.ImVec2(-0.1, 0)) then
					sampSendChat("/kick " .. control_recon_playerid .. " Nick 2/3")
				end
				if imgui.Button(u8"Назад. ##3", imgui.ImVec2(-0.1, 0)) then
					jail_or_ban_re = 0
				end
			end
			imgui.End()
		end
	end
	if i_cmd_helper.v then
		local in1 = sampGetInputInfoPtr()
		local in1 = getStructElement(in1, 0x8, 4)
		local in2 = getStructElement(in1, 0x8, 4)
		local in3 = getStructElement(in1, 0xC, 4)
		fib = in3 + 41
		fib2 = in2 + 10
		imgui.SetNextWindowPos(imgui.ImVec2(fib2, fib), imgui.Cond.FirstUseEver, imgui.ImVec2(0, -0.1))
		imgui.SetNextWindowSize(imgui.ImVec2(590, 250), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"Быстрые команды наказаний.", false, 2+4+32)
		if check_cmd_punis ~= nil then
			for key, v in pairs(cmd_punis_mute) do
				if v:find(string.lower(check_cmd_punis)) ~= nil or v:find(string.lower(RusToEng(check_cmd_punis))) ~= nil or v == string.lower(check_cmd_punis):match("(.+) (.+) ") or v == string.lower(RusToEng(check_cmd_punis)):match("(.+) (.+) ")  or v == string.lower(check_cmd_punis):match("(.+) ") or v == string.lower(RusToEng(check_cmd_punis)):match("(.+) ") then
					imgui.Text("Mute: -" .. v .. u8" [PlayerID] (Множитель наказания.) - " .. u8:encode(punishments[v].reason))
				end
			end
			for key, v in pairs(cmd_punis_ban) do
				if v:find(string.lower(check_cmd_punis)) ~= nil or v:find(string.lower(RusToEng(check_cmd_punis))) ~= nil or v == string.lower(check_cmd_punis):match("(.+) (.+) ") or v == string.lower(RusToEng(check_cmd_punis)):match("(.+) (.+) ")  or v == string.lower(check_cmd_punis):match("(.+) ") or v == string.lower(RusToEng(check_cmd_punis)):match("(.+) ") then
					imgui.Text("Ban: -" .. v .. u8" [PlayerID] - " .. u8:encode(punishments[v].reason))
				end
			end
			for key, v in pairs(cmd_punis_jail) do
				if v:find(string.lower(check_cmd_punis)) ~= nil or v:find(string.lower(RusToEng(check_cmd_punis))) ~= nil or v == string.lower(check_cmd_punis):match("(.+) (.+) ") or v == string.lower(RusToEng(check_cmd_punis)):match("(.+) (.+) ")  or v == string.lower(check_cmd_punis):match("(.+) ") or v == string.lower(RusToEng(check_cmd_punis)):match("(.+) ") then
					imgui.Text("Jail: -" .. v .. u8" [PlayerID] - " .. u8:encode(punishments[v].reason))
				end
			end
		else
			for key, v in pairs(cmd_punis_mute) do
				imgui.Text("Mute: -" .. v .. u8" [PlayerID] (Множитель наказания.) - " .. u8:encode(punishments[v].reason))
			end
			for key, v in pairs(cmd_punis_ban) do
				imgui.Text("Ban: -" .. v .. u8" [PlayerID] - " .. u8:encode(punishments[v].reason))
			end
			for key, v in pairs(cmd_punis_jail) do
				imgui.Text("Jail: -" .. v .. u8" [PlayerID] - " .. u8:encode(punishments[v].reason))
			end
		end
		imgui.End()
	end
end