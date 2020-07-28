-- [x] -- Название скрипта. -- [x] --
script_name("Admin Helper by Lox.")
script_author("Yamada.")

-- [x] -- Библиотеки. -- [x] --
										require "lib.moonloader"
local sampev							= require "lib.samp.events"
local font_admin_chat					= require ("moonloader").font_flag
local ev								= require ("moonloader").audiostream_state
local dlstat							= require ("moonloader").download_status
local imgui 							= require "imgui"
local encoding							= require "encoding"
local vkeys								= require "lib.vkeys"
local inicfg							= require "inicfg"
local notfy								= import 'lib/lib_imgui_notf.lua'
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

	colors[clr.WindowBg]              = ImVec4(0.14, 0.12, 0.16, 1.00);
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
local script_version = 2
local script_version_text = "1.1 bug-fix"
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
		Fast_ans = false,
		Punishments = false,
		Index = 2.0,
		Admin_chat = false,
		Font = 10
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
	["ср"] = {
		cmd = "ban",
		time = 7,
		reason = "Использование запрещенного софта."
	},
	["sob"] = {
		cmd = "ban",
		time = 7,
		reason = "Использование запрещенного софта. (S0beit)"
	},
	["ыщи"] = {
		cmd = "ban",
		time = 7,
		reason = "Использование запрещенного софта. (S0beit)"
	},
	["aim"] = {
		cmd = "ban",
		time = 7,
		reason = "Использование запрещенного софта. (Aim)"
	},
	["фшь"] = {
		cmd = "ban",
		time = 7,
		reason = "Использование запрещенного софта. (Aim)"
	},
	["rvn"] = {
		cmd = "ban",
		time = 7,
		reason = "Использование запрещенного софта. (Rvanka)"
	},
	["кмт"] = {
		cmd = "ban",
		time = 7,
		reason = "Использование запрещенного софта. (Rvanka)"
	},
	["сфкы"] = {
		cmd = "ban",
		time = 7,
		reason = "Использование запрещенного софта. (Car Shot)"
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
	["фс"] = {
		cmd = "ban",
		time = 7,
		reason = "Использование запрещенного софта. (Auto +C)"
	},
	["ыщи"] = {
		cmd = "ban",
		time = 7,
		reason = "Использование запрещенного софта. (S0beit)"
	},
	["ыщи"] = {
		cmd = "ban",
		time = 7,
		reason = "Использование запрещенного софта. (S0beit)"
	},
	-- [x] -- Муты -- [x] --
	["osk"] = {
		cmd = "mute",
		time = 400,
		reason = "Оскорбление игрока."
	},
	["щыл"] = {
		cmd = "mute",
		time = 400,
		reason = "Оскорбление игрока."
	},
	["mat"] = {
		cmd = "mute",
		time = 300,
		reason = "Нецензурная лексика."
	},
	["ьфе"] = {
		cmd = "mute",
		time = 300,
		reason = "Нецензурная лексика."
	},
	["or"] = {
		cmd = "mute",
		time = 5000,
		reason = "Уопминание родителей."
	},
	["щк"] = {
		cmd = "mute",
		time = 5000,
		reason = "Упоминание родителей."
	},
	["oa"] = {
		cmd = "mute",
		time = 2500,
		reason = "Оскорбление администрации."
	},
	["щф"] = {
		cmd = "mute",
		time = 2500,
		reason = "Оскорбление администрации."
	},
	["ua"] = {
		cmd = "mute",
		time = 2500,
		reason = "Унижение прав администрации."
	},
	["гф"] = {
		cmd = "mute",
		time = 2500,
		reason = "Унижение прав администрации."
	},
	["va"] = {
		cmd = "mute",
		time = 2500,
		reason = "Выдача себя за администрацию."
	},
	["мф"] = {
		cmd = "mute",
		time = 2500,
		reason = "Выдача себя за администрацию."
	},
	["fld"] = {
		cmd = "mute",
		time = 120,
		reason = "Флуд в чат/pm."
	},
	["адв"] = {
		cmd = "mute",
		time = 120,
		reason = "Флуд в чат/pm."
	},
	["popr"] = {
		cmd = "mute",
		time = 120,
		reason = "Попрошайничество."
	},
	["зщзк"] = {
		cmd = "mute",
		time = 120,
		reason = "Попрошайничество."
	},
	["nead"] = {
		cmd = "mute",
		time = 600,
		reason = "Неадекватное поведение."
	},
	["туфв"] = {
		cmd = "mute",
		time = 600,
		reason = "Неадекватное поведение."
	},
	["rek"] = {
		cmd = "mute",
		time = 600,
		reason = "Реклама сторонних ресурсов/сервера/сайта."
	},
	["кул"] = {
		cmd = "mute",
		time = 600,
		reason = "Реклама сторонних ресурсов/сервера/сайта."
	},
	["rek"] = {
		cmd = "mute",
		time = 600,
		reason = "Реклама сторонних ресурсов/сервера/сайта."
	},
	["кул"] = {
		cmd = "mute",
		time = 600,
		reason = "Реклама сторонних ресурсов/сервера/сайта."
	},
	["rosk"] = {
		cmd = "rmute",
		time = 400,
		reason = "Оскорбление игрока в /report."
	},
	["кщыл"] = {
		cmd = "rmute",
		time = 400,
		reason = "Оскорбление игрока в /report."
	},
	["rmat"] = {
		cmd = "rmute",
		time = 400,
		reason = "Мат в /report."
	},
	["кьфе"] = {
		cmd = "rmute",
		time = 400,
		reason = "Мат в /report."
	},
	["raosk"] = {
		cmd = "rmute",
		time = 400,
		reason = "Оскорбление администрации в /report."
	},
	["кфщыл"] = {
		cmd = "rmute",
		time = 400,
		reason = "Оскорбление администрации в /report."
	},
	["otop"] = {
		cmd = "rmute",
		time = 120,
		reason = "/report не по назначению. (Offtop)"
	},
	["щещз"] = {
		cmd = "rmute",
		time = 120,
		reason = "/report не по назначению. (Offtop)"
	},
	-- [x] -- Джайлы -- [x] --
	["sh"] = {
		cmd = "jail",
		time = 900,
		reason = "Использование запрещенного софта. (SpeedHack)"
	},
	["ыр"] = {
		cmd = "jail",
		time = 900,
		reason = "Использование запрещенного софта. (SpeedHack)"
	},
	["fly"] = {
		cmd = "jail",
		time = 900,
		reason = "Использование запрещенного софта. (Fly)"
	},
	["адн"] = {
		cmd = "jail",
		time = 900,
		reason = "Использование запрещенного софта. (Fly)"
	},
	["fcar"] = {
		cmd = "jail",
		time = 900,
		reason = "Использование запрещенного софта. (FlyCar)"
	},
	["асфк"] = {
		cmd = "jail",
		time = 900,
		reason = "Использование запрещенного софта. (FlyCar)"
	},
	["pmp"] = {
		cmd = "jail",
		time = 300,
		reason = "Помеха мероприятию."
	},
	["зьз"] = {
		cmd = "jail",
		time = 300,
		reason = "Помеха мероплиятию."
	},
	["sk"] = {
		cmd = "jail",
		time = 300,
		reason = "Убийство игроков на спавне."
	},
	["ыл"] = {
		cmd = "jail",
		time = 300,
		reason = "Убийство игроков на спавне."
	}
}
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
local onscene = {
	"6ля", "6лядь", "6лять", "b3ъeб", "cock", "cunt",
	"e6aль", "ebal", "eblan", "eбaл", "eбaть", "eбyч",
	"eбать", "eбёт", "eблантий", "fuck", "fucker",
	"fucking", "xyёв", "xyй", "xyя", "xуе", "xуй", "xую",
	"zaeb", "zaebal", "zaebali", "zaebat", "архипиздрит",
	"ахуел", "ахуеть", "бздение", "бздеть", "бздех", "бздецы",
	"бздит", "бздицы", "бздло", "бзднуть", "бздун", "бздунья",
	"бздюха", "бздюшка", "бздюшко", "бля", "блябу", "блябуду",
	"бляд", "бляди", "блядина", "блядище", "блядки",
	"блядовать", "блядство", "блядун", "блядуны",
	"блядунья", "блядь", "блядюга", "блять", "вафел",
	"вафлёр", "взъебка", "взьебка", "взьебывать",
	"въеб", "въебался", "въебенн", "въебусь",
	"въебывать", "выблядок", "выблядыш", "выеб",
	"выебать", "выебен", "выебнулся", "выебон",
	"выебываться", "выпердеть", "высраться",
	"выссаться", "вьебен", "гавно", "гавнюк",
	"гавнючка", "гамно", "гандон", "гнид", "гнида",
	"гниды", "говенка", "говенный", "говешка",
	"говназия", "говнецо", "говнище", "говно",
	"говноед", "говнолинк", "говночист", "говнюк",
	"говнюха", "говнядина", "говняк", "говняный",
	"говнять", "гондон", "доебываться", "долбоеб",
	"долбоёб", "долбоящер", "дрисня", "дрист",
	"дристануть", "дристать", "дристун", "дристуха",
	"дрочелло", "дрочена", "дрочила", "дрочилка", "дрочистый",
	"дрочить", "дрочка", "дрочун", "е6ал", "е6ут", "ёбaн", 
	"ебaть", "ебyч", "ебал", "ебало",
	"ебальник", "ебан", "ебанамать", "ебанат", "ебаная",
	"ёбаная", "ебанический", "ебанный", "ебанныйврот", "ебаное",
	"ебануть", "ебануться", "ёбаную", "ебаный", "ебанько",
	"ебарь", "ебат", "ёбат", "ебатория", "ебать", "ебать-копать",
	"ебаться", "ебашить", "ебёна", "ебет", "ебёт", "ебец", "ебик",
	"ебин", "ебись", "ебическая", "ебки", "ебла", "еблан", "ебливый",
	"еблище", "ебло", "еблыст", "ебля", "ёбн", "ебнуть", "ебнуться",
	"ебня", "ебошить", "ебская", "ебский", "ебтвоюмать", "ебун",
	"ебут", "ебуч", "ебуче", "ебучее", "ебучий", "ебучим", "ебущ",
	"ебырь", "елда", "елдак", "елдачить", "жопа", "жопу", "заговнять",
	"задрачивать", "задристать", "задрота", "зае6", "заё6",
	"заеб", "заёб", "заеба", "заебал", "заебанец", "заебастая",
	"заебастый", "заебать", "заебаться", "заебашить",
	"заебистое", "заёбистое", "заебистые", "заёбистые",
	"заебистый", "заёбистый", "заебись", "заебошить",
	"заебываться", "залуп", "залупа", "залупаться",
	"залупить", "залупиться", "замудохаться",
	"запиздячить", "засерать", "засерун", "засеря",
	"засирать", "засрун", "захуячить", "заябестая",
	"злоеб", "злоебучая", "злоебучее", "злоебучий",
	"ибанамат", "ибонех", "изговнять", "изговняться",
	"изъебнуться", "ипать", "ипаться", "ипаццо",
	"Какдвапальцаобоссать", "конча", "курва",
	"курвятник", "лох", "лошарa", "лошара",
	"лошары", "лошок", "лярва", "малафья", "манда",
	"мандавошек", "мандавошка", "мандавошки",
	"мандей", "мандень", "мандеть", "мандища",
	"мандой", "манду", "мандюк", "минет", "минетчик",
	"минетчица", "млять", "мокрощелка", "мокрощёлка",
	"мразь", "мудak", "мудaк", "мудаг", "мудак", "муде",
	"мудель", "мудеть", "муди", "мудил", "мудила", "мудистый",
	"мудня", "мудоеб", "мудозвон", "мудоклюй", "на хер",
	"на хуй", "набздел", "набздеть", "наговнять", "надристать",
	"надрочить", "наебать", "наебет", "наебнуть", "наебнуться",
	"наебывать", "напиздел", "напиздели", "напиздело",
	"напиздили", "насрать", "настопиздить", "нахер", "нахрен",
	"нахуй", "нахуйник", "не ебет", "не ебёт", "невротебучий",
	"невъебенно", "нехира", "нехрен", "Нехуй", "нехуйственно",
	"ниибацо", "ниипацца", "ниипаццо", "ниипет", "никуя",
	"нихера", "нихуя", "обдристаться", "обосранец", "обосрать",
	"обосцать", "обосцаться", "обсирать", "объебос", "обьебать",
	"обьебос", "однохуйственно", "опездал", "опизде",
	"опизденивающе", "остоебенить", "остопиздеть",
	"отмудохать", "отпиздить", "отпиздячить", "отпороть",
	"отъебись", "охуевательский", "охуевать", "охуевающий",
	"охуел", "охуенно", "охуеньчик", "охуеть", "охуительно",
	"охуительный", "охуяньчик", "охуячивать", "охуячить",
	"очкун", "падла", "падонки", "падонок", "паскуда", "педерас",
	"педик", "педрик", "педрила", "педрилло", "педрило",
	"педрилы", "пездень", "пездит", "пездишь", "пездо", "пездят",
	"пердануть", "пердеж", "пердение", "пердеть", "пердильник",
	"перднуть", "пёрднуть", "пердун", "пердунец", "пердунина",
	"пердунья", "пердуха", "пердь", "переёбок", "пернуть",
	"пёрнуть", "пи3д", "пи3де", "пи3ду", "пиzдец", "пидар", "пидарaс",
	"пидарас", "пидарасы", "пидары", "пидор", "пидорасы", "пидорка",
	"пидорок", "пидоры", "пидрас", "пизда", "пиздануть", "пиздануться",
	"пиздарваньчик", "пиздато", "пиздатое", "пиздатый", "пизденка",
	"пизденыш", "пиздёныш", "пиздеть", "пиздец", "пиздит", "пиздить",
	"пиздиться", "пиздишь", "пиздища", "пиздище", "пиздобол",
	"пиздоболы", "пиздобратия", "пиздоватая", "пиздоватый",
	"пиздолиз", "пиздонутые", "пиздорванец", "пиздорванка",
	"пиздострадатель", "пизду", "пиздуй", "пиздун", "пиздунья",
	"пизды", "пиздюга", "пиздюк", "пиздюлина", "пиздюля", "пиздят",
	"пиздячить", "писбшки", "писька", "писькострадатель",
	"писюн", "писюшка", "по хуй", "по хую", "подговнять",
	"подонки", "подонок", "подъебнуть", "подъебнуться",
	"поебать", "поебень", "поёбываает", "поскуда", "посрать",
	"потаскуха", "потаскушка", "похер", "похерил", "похерила",
	"похерили", "похеру", "похрен", "похрену", "похуй", "похуист",
	"похуистка", "похую", "придурок", "приебаться", "припиздень",
	"припизднутый", "припиздюлина", "пробзделся", "проблядь",
	"проеб", "проебанка", "проебать", "промандеть", "промудеть",
	"пропизделся", "пропиздеть", "пропиздячить", "раздолбай",
	"разхуячить", "разъеб", "разъеба", "разъебай", "разъебать",
	"распиздай", "распиздеться", "распиздяй", "распиздяйство",
	"распроеть", "сволота", "сволочь", "сговнять", "секель", "серун",
	"серька", "сестроеб", "сикель", "сила", "сирать", "сирывать", "соси",
	"спиздел", "спиздеть", "спиздил", "спиздила", "спиздили", "спиздит",
	"спиздить", "срака", "сраку", "сраный", "сранье", "срать", "срун", "ссака",
	"ссышь", "стерва", "страхопиздище", "сука", "суки", "суходрочка", "сучара",
	"сучий", "сучка", "сучко", "сучонок", "сучье", "сцание", "сцать", "сцука", "сцуки",
	"сцуконах", "сцуль", "сцыха", "сцышь", "съебаться", "сыкун", "трахае6", "трахаеб",
	"трахаёб", "трахатель", "ублюдок", "уебать", "уёбища", "уебище", "уёбище",
	"уебищное", "уёбищное", "уебк", "уебки", "уёбки", "уебок", "уёбок", "урюк",
	"усраться", "ушлепок", "х_у_я_р_а", "хyё", "хyй", "хyйня", "хамло", "хер",
	"херня", "херовато", "херовина", "херовый", "хитровыебанный", "хитрожопый",
	"хуeм", "хуе", "хуё", "хуевато", "хуёвенький", "хуевина", "хуево", "хуевый", "хуёвый",
	"хуек", "хуёк", "хуел", "хуем", "хуенч", "хуеныш", "хуенький", "хуеплет", "хуеплёт",
	"хуепромышленник", "хуерик", "хуерыло", "хуесос", "хуесоска", "хуета", "хуетень",
	"хуею", "хуи", "хуй", "хуйком", "хуйло", "хуйня", "хуйрик", "хуище", "хуля", "хую", "хуюл",
	"хуя", "хуяк", "хуякать", "хуякнуть", "хуяра", "хуясе", "хуячить", "целка", "чмо",
	"чмошник", "чмырь", "шалава", "шалавой", "шараёбиться", "шлюха", "шлюхой", "шлюшка", "мать", "мама",
	"матери"
}
local log_onscene = {
	["player_1"] = {
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
	}
}
local date_onscene = {}

-- [x] -- ImGUI переменные. -- [x] --
local i_ans_window = imgui.ImBool(false)
local i_setting_items = imgui.ImBool(false)
local i_back_prefix = imgui.ImBool(false)
local i_log_onscene = imgui.ImBool(false)
local font_size_ac = imgui.ImBuffer(16)
local setting_items = {
	Fast_ans = imgui.ImBool(false),
	Punishments = imgui.ImBool(false),
	Admin_chat = imgui.ImBool(false),
	Transparency = imgui.ImBool(true)
}

-- [x] -- Тело скрипта. -- [x] --
function main()
	-- [x] -- Проверка на запуск сампа и СФ. -- [x] --
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(0) end
	
	sampRegisterChatCommand('ah_setting', function()
		i_setting_items.v = not i_setting_items.v
		imgui.Process = i_setting_items.v
	end)
	
	if not doesDirectoryExist(getWorkingDirectory() .. "/config/AH_Setting") then
		createDirectory(getWorkingDirectory() .. "/config/AH_Setting")
	end
	if not doesDirectoryExist(getWorkingDirectory() .. "/config/AH_Setting/audio") then
		createDirectory(getWorkingDirectory() .. "/config/AH_Setting/audio")
	end
	
	config = inicfg.load(defTable, directIni)
	setting_items.Fast_ans.v = config.setting.Fast_ans
	setting_items.Punishments.v = config.setting.Punishments
	setting_items.Admin_chat.v = config.setting.Admin_chat
	font_size_ac.v = tostring(config.setting.Font)
	index_text_pos = config.setting.Index
	font_ac = renderCreateFont("Arial", config.setting.Font, font_admin_chat.BOLD + font_admin_chat.SHADOW)
	
	admin_chat = lua_thread.create_suspended(drawAdminChat)
	check_dialog_active = lua_thread.create_suspended(checkIsDialogActive)
	
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
	
	-- [x] -- Беск. цикл. -- [x] --
	while true do
		if isKeyJustPressed(VK_END) and (sampIsChatInputActive() == false) and (sampIsDialogActive() == false) then
			i_setting_items.v = not i_setting_items.v
			imgui.Process = i_setting_items.v
		end
		if isKeyJustPressed(VK_X) and (sampIsChatInputActive() == false) and (sampIsDialogActive() == false) then
			setting_items.Admin_chat.v = not setting_items.Admin_chat.v
		end
		if not i_setting_items.v and not i_ans_window.v and not i_log_onscene.v then
			imgui.Process = false
		end
		if sampGetCurrentDialogId() == 2351 and setting_items.Fast_ans.v and sampIsDialogActive() then
			i_ans_window.v = true
			imgui.Process = true
		else 
			i_ans_window.v = false
		end
		if --[[isKeyDown(VK_MENU) and ]]isKeyJustPressed(VK_B) and (sampIsChatInputActive() == false) and (sampIsDialogActive() == false) then
			i_log_onscene.v = not i_log_onscene.v
			imgui.Process = i_log_onscene.v
		end
		wait(0)
	end
end

-- [x] -- Доп. функции -- [x] --
function sampev.onSendChat(message)
	-- [x] -- Захват строки для дальнейшей обработки. -- [x] --
	if setting_items.Punishments.v then
		local checkstr, id = string.match(message, "-(.+) (.+)")
		if punishments[checkstr] == nil then return true end
		sampSendChat("/" .. punishments[checkstr].cmd .. " " .. id .. " " .. punishments[checkstr].time .. " " .. punishments[checkstr].reason)
		return false
	end
end
function sampev.onServerMessage(color, text)
	local check_string = string.match(text, "[^%s]+")
	local _, check_mat_id, check_mat = string.match(text, "(.+)%((.+)%): (.+)")
	if setting_items.Admin_chat.v and (check_string == '[A-1]' 
	or check_string == '[A-2]' 
	or check_string == '[A-3]' 
	or check_string == '[A-4]' 
	or check_string == '[A-5]' 
	or check_string == '[A-6]' 
	or check_string == '[A-7]' 
	or check_string == '[A-8]' 
	or check_string == '[A-9]' 
	or check_string == '[A-10]' 
	or check_string == '[A-11]' 
	or check_string == '[A-12]' 
	or check_string == '[A-13]' 
	or check_string == '[A-14]' 
	or check_string == '[A-15]' 
	or check_string == '[A-16]' 
	or check_string == '[A-17]' 
	or check_string == '[A-18]' 
	or check_string == '[A-19]') then
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
	elseif check_string == '(Жалоба/Вопрос)' then
		showNotification("Уведомление", "Поступил новый репорт.")
		return true
	end
	if check_mat ~= nil and check_mat_id ~= nil then
		for key, value in pairs(onscene) do
			if string.find(check_mat, value) ~= nil then
				local number_log_player
				for i = 1, 20, 1 do
					if log_onscene["player_" .. i].id == nil then
						number_log_player = i
					end
				end
				sampAddChatMessage(tag .. " Number: " .. number_log_player .. " Value: "  .. value)
				log_onscene["player_" .. number_log_player].id = tonumber(check_mat_id)
				log_onscene["player_" .. number_log_player].name = sampGetPlayerNickname(tonumber(check_mat_id))
				log_onscene["player_" .. number_log_player].text = check_mat
				log_onscene["player_" .. number_log_player].suspicion = value
				date_onscene[number_log_player] = os.date()
				showNotification("Детектор!", "Детектор обнаружил нарушение! \nЗапрещенное слово: {FF0000}" .. value .. "\n{FFFFFF}Ник нарушителя: {FF0000}" .. sampGetPlayerNickname(tonumber(check_mat_id)))
				break
			end
		end
		return true
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
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_10, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4), 0x66AAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_9, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*2, 0x77AAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_8, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*3, 0x88AAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_7, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*4, 0x99AAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_6, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*5, 0xAAAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_5, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*6, 0xBBAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_4, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*7, 0xCCAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_3, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*8, 0xDDAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_2, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*9, 0xEEAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_1, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*10, 0xFFAAAAAA)
			else
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_10, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4), 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_9, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*2, 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_8, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*3, 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_7, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*4, 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_6, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*5, 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_5, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*6, 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_4, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*7, 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_3, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*8, 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_2, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*9, 0xFFAAAAAA)
				renderFontDrawText(font_ac, admin_chat_lines.chat_line_1, sw/28, sh/config.setting.Index+(tonumber(font_size_ac.v)+4)*10, 0xFFAAAAAA)
			end
		end
		wait(1)
	end
end
function showNotification(handle, text_not)
	notfy.addNotify("{6930A1}" .. handle, " \n " .. text_not .. " \n", 2, 1, 10)
	setAudioStreamState(load_audio, ev.PLAY)
end
function controlOnscene()
	local number_log_player
	for i = 1, 20, 1 do
		number_log_player = i
		if log_onscene["player_" .. number_log_player].id == nil
		then
			
			log_onscene["player_" .. number_log_player].id = log_onscene["player_" .. number_log_player+1].id
			log_onscene["player_" .. number_log_player+1].id = nil
			log_onscene["player_" .. number_log_player].name = log_onscene["player_" .. number_log_player+1].name
			log_onscene["player_" .. number_log_player+1].name = " "
			log_onscene["player_" .. number_log_player].text = log_onscene["player_" .. number_log_player+1].text
			log_onscene["player_" .. number_log_player+1].text = " "
			log_onscene["player_" .. number_log_player].suspicion = log_onscene["player_" .. number_log_player+1].suspicion
			log_onscene["player_" .. number_log_player+1].suspicion = " "
			date_onscene[i] = date_onscene[number_log_playe+1]
			date_onscene[i] = " "
		end
	end
end

-- [x] -- ImGUI тело. -- [x] --
local W_Windows = sw/1.145
local H_Windows = 1
local text_dialog
function imgui.OnDrawFrame()
	if i_ans_window.v then
		imgui.SetNextWindowPos(imgui.ImVec2(W_Windows, H_Windows), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(280, 700), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"Ответы на ANS", i_ans_window)
		local btn_size = imgui.ImVec2(-0.1, 0)
		imgui.Checkbox(u8"Пожелание в конце.", i_back_prefix)
		imgui.Separator()
		if imgui.Button(i_ans[1], btn_size) then
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
		end
		imgui.End()
	end
	if i_setting_items.v then
		imgui.SetNextWindowPos(imgui.ImVec2(W_Windows, H_Windows), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(300, 400), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"Настройки скрипта.", i_setting_items)
		imgui.Text(u8"Быстрые ответы на ANS.")
		imgui.SameLine()
		imgui.SetCursorPosX(imgui.GetWindowWidth() - 35)
		imgui.ToggleButton("##1", setting_items.Fast_ans)
		--[[imgui.Text(u8"Сокращенные команды наказаний.")
		imgui.SameLine()
		imgui.SetCursorPosX(imgui.GetWindowWidth() - 35)
		imgui.ToggleButton("##3", setting_items.Punishments)]]
		imgui.Text(u8"Админ чат.")
		imgui.SameLine()
		imgui.SetCursorPosX(imgui.GetWindowWidth() - 35)
		imgui.ToggleButton("##2", setting_items.Admin_chat)
		imgui.Text(u8"Прозрачность админ чата.")
		imgui.SameLine()
		imgui.SetCursorPosX(imgui.GetWindowWidth() - 35)
		imgui.ToggleButton("##4", setting_items.Transparency)		
		imgui.PushItemWidth(50)
		if imgui.InputText(u8"Размер чата.", font_size_ac) then
			if font_size_ac.v == nil then font_size_ac.v = 1 end
			font_ac = renderCreateFont("Arial", tonumber(font_size_ac.v), font_admin_chat.BOLD + font_admin_chat.SHADOW)
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
		if imgui.Button(u8"Сохранить.") then
			config.setting.Fast_ans = setting_items.Fast_ans.v
			config.setting.Admin_chat = setting_items.Admin_chat.v
			config.setting.Punishments = setting_items.Punishments.v
			config.setting.Font = font_size_ac.v
			config.setting.Tranparency = setting_items.Transparency.v
			inicfg.save(config, directIni)
		end	
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
			imgui.SetCursorPosY(imgui.GetWindowHeight() - 25)
			imgui.Separator()
			imgui.Text(u8"Версия скрипта: " .. script_version_text)
		end
		imgui.End()
	end
	if i_log_onscene.v then
		imgui.SetNextWindowPos(imgui.ImVec2(10, 10), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(sw - 10, 400), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"Наказания за нарушение в чате.", i_log_onscene)
		imgui.Text(u8"Ниже представлены игроки, которые нарушили правила чата.")
		if log_onscene["player_1"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_1"].name) .. " ID: " .. u8:encode(log_onscene["player_1"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_1"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_1"].text) .. 
			u8"\nДата: " .. date_onscene[1] ..
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##1", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_1"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_1"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##1", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_1"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_1"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##1", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_1"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_1"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##1", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_1"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_1"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##1", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_1"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_1"].id = nil
				controlOnscene()
			end 
			if imgui.Button(u8"Очистить. ##1", imgui.ImVec2(90, 0)) then
				log_onscene["player_1"].id = nil
				controlOnscene()
			end 
		end
		if log_onscene["player_2"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_2"].name) .. " ID: " .. u8:encode(log_onscene["player_2"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_2"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_2"].text) .. 
			u8"\nДата: " .. date_onscene[2] ..
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##2", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_2"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_2"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##2", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_2"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_2"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##2", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_2"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_2"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##2", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_2"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_2"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##2", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_2"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_2"].id = nil
				controlOnscene()
			end 
			if imgui.Button(u8"Очистить. ##2", imgui.ImVec2(90, 0)) then
				log_onscene["player_2"].id = nil
				controlOnscene()
			end 
		end
		if log_onscene["player_3"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_3"].name) .. " ID: " .. u8:encode(log_onscene["player_3"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_3"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_3"].text) .. 
			u8"\nДата: " .. date_onscene[3] ..
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##3", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_3"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_3"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##3", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_3"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_3"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##3", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_3"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_3"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##3", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_3"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_3"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##3", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_3"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_3"].id = nil
				controlOnscene()
			end 
			if imgui.Button(u8"Очистить. ##3", imgui.ImVec2(90, 0)) then
				log_onscene["player_3"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_4"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_4"].name) .. " ID: " .. u8:encode(log_onscene["player_4"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_4"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_4"].text) .. 
			u8"\nДата: " .. date_onscene[4] ..
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##4", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_4"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_4"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##4", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_4"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_4"].id = nil
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##4", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_4"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_4"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##4", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_4"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_4"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##4", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_4"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_4"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"Очистить. ##4", imgui.ImVec2(90, 0)) then
				log_onscene["player_4"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_5"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_5"].name) .. " ID: " .. u8:encode(log_onscene["player_5"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_5"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_5"].text) .. 
			u8"\nДата: " .. date_onscene[5] ..
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##5", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_5"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_5"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##5", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_5"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_5"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##5", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_5"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_5"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##5", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_5"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_5"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##5", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_5"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_5"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"Очистить. ##5", imgui.ImVec2(90, 0)) then
				log_onscene["player_5"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_6"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_6"].name) .. " ID: " .. u8:encode(log_onscene["player_6"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_6"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_6"].text) .. 
			u8"\nДата: " .. date_onscene[6] ..
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##6", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_6"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_6"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##6", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_6"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_6"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##6", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_6"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_6"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##6", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_6"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_6"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##6", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_6"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_6"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"Очистить. ##6", imgui.ImVec2(90, 0)) then
				log_onscene["player_6"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_7"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_7"].name) .. " ID: " .. u8:encode(log_onscene["player_7"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_7"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_7"].text) .. 
			u8"\nДата: " .. date_onscene[7] ..
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##7", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_7"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_7"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##7", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_7"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_7"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##7", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_7"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_7"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##7", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_7"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_7"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##7", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_7"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_7"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"Очистить. ##7", imgui.ImVec2(90, 0)) then
				log_onscene["player_7"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_8"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_8"].name) .. " ID: " .. u8:encode(log_onscene["player_8"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_8"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_8"].text) .. 
			u8"\nДата: " .. date_onscene[8] ..
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##8", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_8"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_8"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##8", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_8"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_8"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##8", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_8"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_8"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##8", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_8"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_8"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##8", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_8"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_8"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"Очистить. ##8", imgui.ImVec2(90, 0)) then
				log_onscene["player_8"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_9"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_9"].name) .. " ID: " .. u8:encode(log_onscene["player_9"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_9"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_9"].text) .. 
			u8"\nДата: " .. date_onscene[9] ..
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##9", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_9"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_9"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##9", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_9"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_9"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##9", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_9"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_9"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##9", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_9"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_9"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##9", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_9"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_9"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"Очистить. ##9", imgui.ImVec2(90, 0)) then
				log_onscene["player_9"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_10"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_10"].name) .. " ID: " .. u8:encode(log_onscene["player_10"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_10"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_10"].text) .. 
			u8"\nДата: " .. date_onscene[10] ..
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##10", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_10"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_10"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##10", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_10"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_10"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##10", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_10"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_10"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##10", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_10"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_10"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##10", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_10"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_10"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"Очистить. ##10", imgui.ImVec2(90, 0)) then
				log_onscene["player_10"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_11"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_11"].name) .. " ID: " .. u8:encode(log_onscene["player_11"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_11"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_11"].text) .. 
			u8"\nДата: " .. date_onscene[11] ..
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##11", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_11"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_11"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##11", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_11"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_11"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##11", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_11"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_11"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##11", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_11"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_11"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##11", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_11"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_11"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"Очистить. ##11", imgui.ImVec2(90, 0)) then
				log_onscene["player_11"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_12"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_12"].name) .. " ID: " .. u8:encode(log_onscene["player_12"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_12"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_12"].text) ..
			u8"\nДата: " .. date_onscene[12] .. 
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##12", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_12"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_12"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##12", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_12"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_12"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##12", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_12"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_12"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##12", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_12"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_12"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##12", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_12"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_12"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"Очистить. ##12", imgui.ImVec2(90, 0)) then
				log_onscene["player_12"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_13"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_13"].name) .. " ID: " .. u8:encode(log_onscene["player_13"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_13"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_13"].text) .. 
			u8"\nДата: " .. date_onscene[13] ..
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##13", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_13"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_13"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##13", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_13"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_13"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##13", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_13"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_13"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##13", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_13"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_13"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##13", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_13"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_13"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"Очистить. ##13", imgui.ImVec2(90, 0)) then
				log_onscene["player_13"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_14"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_14"].name) .. " ID: " .. u8:encode(log_onscene["player_14"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_14"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_14"].text) .. 
			u8"\nДата: " .. date_onscene[14] ..
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##14", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_14"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_14"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##14", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_14"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_14"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##14", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_14"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_14"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##14", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_14"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_14"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##14", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_14"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_14"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"Очистить. ##14", imgui.ImVec2(90, 0)) then
				log_onscene["player_14"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_15"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_15"].name) .. " ID: " .. u8:encode(log_onscene["player_15"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_15"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_15"].text) .. 
			u8"\nДата: " .. date_onscene[15] ..
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##15", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_15"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_15"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##15", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_15"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_15"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##15", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_15"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_15"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##15", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_15"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_15"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##15", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_15"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_15"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"Очистить. ##15", imgui.ImVec2(90, 0)) then
				log_onscene["player_15"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_16"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_16"].name) .. " ID: " .. u8:encode(log_onscene["player_16"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_16"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_16"].text) .. 
			u8"\nДата: " .. date_onscene[16] ..
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##16", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_16"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_16"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##16", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_16"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_16"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##16", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_16"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_16"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##16", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_16"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_16"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##16", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_16"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_16"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"Очистить. ##16", imgui.ImVec2(90, 0)) then
				log_onscene["player_16"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_17"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_17"].name) .. " ID: " .. u8:encode(log_onscene["player_17"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_17"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_17"].text) .. 
			u8"\nДата: " .. date_onscene[17] ..
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##17", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_17"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_17"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##17", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_17"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_17"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##17", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_17"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_17"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##17", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_17"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_17"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##17", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_17"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_17"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"Очистить. ##17", imgui.ImVec2(90, 0)) then
				log_onscene["player_17"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_18"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_18"].name) .. " ID: " .. u8:encode(log_onscene["player_18"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_18"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_18"].text) .. 
			u8"\nДата: " .. date_onscene[18] ..
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##18", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_18"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_18"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##18", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_18"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_18"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##18", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_18"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_18"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##18", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_18"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_18"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##18", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_18"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_18"].id = nil
				controlOnscene()
			end		
			if imgui.Button(u8"Очистить. ##18", imgui.ImVec2(90, 0)) then
				log_onscene["player_18"].id = nil
				controlOnscene()
			end 
		end
		if log_onscene["player_19"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_19"].name) .. " ID: " .. u8:encode(log_onscene["player_19"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_19"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_19"].text) ..
			u8"\nДата: " .. date_onscene[19] .. 
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##19", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_19"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_19"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##19", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_19"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_19"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##19", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_19"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_19"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##19", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_19"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_19"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##19", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_19"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_19"].id = nil
				controlOnscene()
			end		
			if imgui.Button(u8"Очистить. ##19", imgui.ImVec2(90, 0)) then
				log_onscene["player_19"].id = nil
				controlOnscene()
			end 
		end
		if log_onscene["player_20"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"Ник игрока: " .. u8:encode(log_onscene["player_20"].name) .. " ID: " .. u8:encode(log_onscene["player_20"].id) .. 
			u8"\nСлово, которое попало под подозрения: " .. u8:encode(log_onscene["player_20"].suspicion) .. 
			u8"\nТекст из чата: " .. u8:encode(log_onscene["player_20"].text) ..
			u8"\nДата: " .. date_onscene[20] .. 
			u8"\nНаказание:")
			if imgui.Button(u8"Мат. ##20", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_20"].id .. " 300 Нецензурная лексика.")
				log_onscene["player_20"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. ##20", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_20"].id .. " 400 Оскорбление игрока.")
				log_onscene["player_20"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Униж. ##20", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_20"].id .. " 400 Унижение игрока игрока.")
				log_onscene["player_20"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Род. ##20", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_20"].id .. " 5000 Упоминание родителей.")
				log_onscene["player_20"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"Оск. Адм. ##20", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_20"].id .. " 2500 Оскорбление администрации.")
				log_onscene["player_20"].id = nil
				controlOnscene()
			end	
			if imgui.Button(u8"Очистить. ##20", imgui.ImVec2(90, 0)) then
				log_onscene["player_20"].id = nil
				controlOnscene()
			end 
		end
		imgui.Separator()
		imgui.End()
	end
end