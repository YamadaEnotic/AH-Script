-- [x] -- �������� �������. -- [x] --
script_name("Admin Helper by Lox.")
script_author("Yamada.")

-- [x] -- ����������. -- [x] --
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

-- [x] -- ����������. -- [x] --
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
		reason = "������������� ������������ �����."
	},
	["��"] = {
		cmd = "ban",
		time = 7,
		reason = "������������� ������������ �����."
	},
	["sob"] = {
		cmd = "ban",
		time = 7,
		reason = "������������� ������������ �����. (S0beit)"
	},
	["���"] = {
		cmd = "ban",
		time = 7,
		reason = "������������� ������������ �����. (S0beit)"
	},
	["aim"] = {
		cmd = "ban",
		time = 7,
		reason = "������������� ������������ �����. (Aim)"
	},
	["���"] = {
		cmd = "ban",
		time = 7,
		reason = "������������� ������������ �����. (Aim)"
	},
	["rvn"] = {
		cmd = "ban",
		time = 7,
		reason = "������������� ������������ �����. (Rvanka)"
	},
	["���"] = {
		cmd = "ban",
		time = 7,
		reason = "������������� ������������ �����. (Rvanka)"
	},
	["����"] = {
		cmd = "ban",
		time = 7,
		reason = "������������� ������������ �����. (Car Shot)"
	},
	["cars"] = {
		cmd = "ban",
		time = 7,
		reason = "������������� ������������ �����. (Car Shot)"
	},
	["ac"] = {
		cmd = "ban",
		time = 7,
		reason = "������������� ������������ �����. (Auto +C)"
	},
	["��"] = {
		cmd = "ban",
		time = 7,
		reason = "������������� ������������ �����. (Auto +C)"
	},
	["���"] = {
		cmd = "ban",
		time = 7,
		reason = "������������� ������������ �����. (S0beit)"
	},
	["���"] = {
		cmd = "ban",
		time = 7,
		reason = "������������� ������������ �����. (S0beit)"
	},
	-- [x] -- ���� -- [x] --
	["osk"] = {
		cmd = "mute",
		time = 400,
		reason = "����������� ������."
	},
	["���"] = {
		cmd = "mute",
		time = 400,
		reason = "����������� ������."
	},
	["mat"] = {
		cmd = "mute",
		time = 300,
		reason = "����������� �������."
	},
	["���"] = {
		cmd = "mute",
		time = 300,
		reason = "����������� �������."
	},
	["or"] = {
		cmd = "mute",
		time = 5000,
		reason = "���������� ���������."
	},
	["��"] = {
		cmd = "mute",
		time = 5000,
		reason = "���������� ���������."
	},
	["oa"] = {
		cmd = "mute",
		time = 2500,
		reason = "����������� �������������."
	},
	["��"] = {
		cmd = "mute",
		time = 2500,
		reason = "����������� �������������."
	},
	["ua"] = {
		cmd = "mute",
		time = 2500,
		reason = "�������� ���� �������������."
	},
	["��"] = {
		cmd = "mute",
		time = 2500,
		reason = "�������� ���� �������������."
	},
	["va"] = {
		cmd = "mute",
		time = 2500,
		reason = "������ ���� �� �������������."
	},
	["��"] = {
		cmd = "mute",
		time = 2500,
		reason = "������ ���� �� �������������."
	},
	["fld"] = {
		cmd = "mute",
		time = 120,
		reason = "���� � ���/pm."
	},
	["���"] = {
		cmd = "mute",
		time = 120,
		reason = "���� � ���/pm."
	},
	["popr"] = {
		cmd = "mute",
		time = 120,
		reason = "����������������."
	},
	["����"] = {
		cmd = "mute",
		time = 120,
		reason = "����������������."
	},
	["nead"] = {
		cmd = "mute",
		time = 600,
		reason = "������������ ���������."
	},
	["����"] = {
		cmd = "mute",
		time = 600,
		reason = "������������ ���������."
	},
	["rek"] = {
		cmd = "mute",
		time = 600,
		reason = "������� ��������� ��������/�������/�����."
	},
	["���"] = {
		cmd = "mute",
		time = 600,
		reason = "������� ��������� ��������/�������/�����."
	},
	["rek"] = {
		cmd = "mute",
		time = 600,
		reason = "������� ��������� ��������/�������/�����."
	},
	["���"] = {
		cmd = "mute",
		time = 600,
		reason = "������� ��������� ��������/�������/�����."
	},
	["rosk"] = {
		cmd = "rmute",
		time = 400,
		reason = "����������� ������ � /report."
	},
	["����"] = {
		cmd = "rmute",
		time = 400,
		reason = "����������� ������ � /report."
	},
	["rmat"] = {
		cmd = "rmute",
		time = 400,
		reason = "��� � /report."
	},
	["����"] = {
		cmd = "rmute",
		time = 400,
		reason = "��� � /report."
	},
	["raosk"] = {
		cmd = "rmute",
		time = 400,
		reason = "����������� ������������� � /report."
	},
	["�����"] = {
		cmd = "rmute",
		time = 400,
		reason = "����������� ������������� � /report."
	},
	["otop"] = {
		cmd = "rmute",
		time = 120,
		reason = "/report �� �� ����������. (Offtop)"
	},
	["����"] = {
		cmd = "rmute",
		time = 120,
		reason = "/report �� �� ����������. (Offtop)"
	},
	-- [x] -- ������ -- [x] --
	["sh"] = {
		cmd = "jail",
		time = 900,
		reason = "������������� ������������ �����. (SpeedHack)"
	},
	["��"] = {
		cmd = "jail",
		time = 900,
		reason = "������������� ������������ �����. (SpeedHack)"
	},
	["fly"] = {
		cmd = "jail",
		time = 900,
		reason = "������������� ������������ �����. (Fly)"
	},
	["���"] = {
		cmd = "jail",
		time = 900,
		reason = "������������� ������������ �����. (Fly)"
	},
	["fcar"] = {
		cmd = "jail",
		time = 900,
		reason = "������������� ������������ �����. (FlyCar)"
	},
	["����"] = {
		cmd = "jail",
		time = 900,
		reason = "������������� ������������ �����. (FlyCar)"
	},
	["pmp"] = {
		cmd = "jail",
		time = 300,
		reason = "������ �����������."
	},
	["���"] = {
		cmd = "jail",
		time = 300,
		reason = "������ �����������."
	},
	["sk"] = {
		cmd = "jail",
		time = 300,
		reason = "�������� ������� �� ������."
	},
	["��"] = {
		cmd = "jail",
		time = 300,
		reason = "�������� ������� �� ������."
	}
}
local i_ans = {
	u8'/givemoney ID �����.',
	u8'/givescore ID ����� (�� Diamond VIP).',
	u8'/donate.',
	u8'/tp >> ������ >> ���� >> �������� ���.',
	u8'/rdscoin.',
	u8'/help - 13.',
	u8'/help - 7.',
	u8'/help.',
	u8'/menu.',
	u8'/menu >> ���������.',
	u8'/menu >> ������������ ��������.',
	u8'/menu >> ��������.',
	u8'�� ������ �������� ������ � ����� ������ � �� > vk.com/dmdriftgta.',
	u8'���� ������ � �� > vk.com/dmdriftgta.',
	u8'�������� ������.',
	u8'�������� ���� ������.',
	u8'�������� ID ������.',
	u8'��.',
	u8'���.',
	u8'�����.',
	u8'"/statpl" ���� "TAB".',
	u8'/statpl',
	u8'�� �����.',
	u8'�� ���������.',
	u8'��� ���� > myrds.ru',
	u8'G� �� ������� �� ��������.',
	u8'������ ����� - ��� ���.',
	u8'/fleave, /gleave, /leave.',
	u8'����� � �������� ���������� ������� �� �������: "/trade".',
	u8'������ ����� ��� �������.',
	u8'������ ����� ��������� ��� ����.',
	u8'/car',
	u8'�� ������ �������� ������ ���������� � ���������..',
	u8'��������.',
	u8'��������.',
	u8'/fpanel',
	u8'/tp >> ������ >> ����������.',
	u8'������ ����� ����.',
	u8'������� ���� ���������, ��������� ������ ID.',
	u8'����� ������� � �����: "/nab"',
	u8'����������� "/dt 1 - 990"'
}
local translate = {
	["�"] = "q",
	["�"] = "w",
	["�"] = "e",
	["�"] = "r",
	["�"] = "t",
	["�"] = "y",
	["�"] = "u",
	["�"] = "i",
	["�"] = "o",
	["�"] = "p",
	["�"] = "[",
	["�"] = "]",
	["�"] = "a",
	["�"] = "s",
	["�"] = "d",
	["�"] = "f",
	["�"] = "g",
	["�"] = "h",
	["�"] = "j",
	["�"] = "k",
	["�"] = "l",
	["�"] = ";",
	["�"] = "'",
	["�"] = "z",
	["�"] = "x",
	["�"] = "c",
	["�"] = "v",
	["�"] = "b",
	["�"] = "n",
	["�"] = "m",
	["�"] = ",",
	["�"] = "."
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
	"6��", "6����", "6����", "b3�e�", "cock", "cunt",
	"e6a��", "ebal", "eblan", "e�a�", "e�a��", "e�y�",
	"e����", "e��", "e�������", "fuck", "fucker",
	"fucking", "xy��", "xy�", "xy�", "x��", "x��", "x��",
	"zaeb", "zaebal", "zaebali", "zaebat", "�����������",
	"�����", "������", "�������", "������", "�����", "������",
	"�����", "������", "�����", "�������", "�����", "�������",
	"������", "�������", "�������", "���", "�����", "�������",
	"����", "�����", "�������", "�������", "������",
	"���������", "��������", "������", "�������",
	"��������", "�����", "�������", "�����", "�����",
	"�����", "�������", "�������", "����������",
	"����", "��������", "�������", "�������",
	"���������", "��������", "��������", "����",
	"�������", "������", "���������", "������",
	"�����������", "���������", "���������",
	"���������", "������", "�����", "������",
	"��������", "�����", "������", "����", "�����",
	"�����", "�������", "��������", "�������",
	"��������", "�������", "�������", "�����",
	"�������", "���������", "���������", "������",
	"�������", "���������", "������", "��������",
	"�������", "������", "�����������", "�������",
	"������", "���������", "������", "�����",
	"����������", "��������", "�������", "��������",
	"��������", "�������", "�������", "��������", "���������",
	"�������", "������", "������", "�6��", "�6��", "��a�", 
	"��a��", "��y�", "����", "�����",
	"��������", "����", "���������", "������", "������",
	"������", "�����������", "�������", "�����������", "������",
	"�������", "���������", "������", "������", "�������",
	"�����", "����", "����", "��������", "�����", "�����-������",
	"�������", "�������", "����", "����", "���", "����", "����",
	"����", "�����", "���������", "����", "����", "�����", "�������",
	"������", "����", "������", "����", "���", "������", "��������",
	"����", "�������", "������", "������", "����������", "����",
	"����", "����", "�����", "������", "������", "������", "����",
	"�����", "����", "�����", "��������", "����", "����", "���������",
	"�����������", "����������", "�������", "���6", "��6",
	"����", "���", "�����", "������", "��������", "���������",
	"���������", "�������", "���������", "���������",
	"���������", "��������", "���������", "��������",
	"���������", "��������", "�������", "���������",
	"�����������", "�����", "������", "����������",
	"��������", "����������", "������������",
	"�����������", "��������", "�������", "������",
	"��������", "������", "���������", "���������",
	"�����", "���������", "���������", "���������",
	"��������", "������", "���������", "�����������",
	"�����������", "�����", "�������", "������",
	"��������������������", "�����", "�����",
	"���������", "���", "�����a", "������",
	"������", "�����", "�����", "�������", "�����",
	"����������", "����������", "����������",
	"������", "�������", "�������", "�������",
	"������", "�����", "������", "�����", "��������",
	"���������", "�����", "����������", "����������",
	"�����", "���ak", "���a�", "�����", "�����", "����",
	"������", "������", "����", "�����", "������", "��������",
	"�����", "������", "��������", "��������", "�� ���",
	"�� ���", "�������", "��������", "���������", "����������",
	"���������", "�������", "������", "��������", "����������",
	"���������", "��������", "���������", "���������",
	"���������", "�������", "������������", "�����", "������",
	"�����", "��������", "�� ����", "�� ���", "������������",
	"����������", "������", "������", "�����", "������������",
	"�������", "��������", "��������", "������", "�����",
	"������", "�����", "������������", "���������", "��������",
	"��������", "����������", "��������", "�������", "��������",
	"�������", "��������������", "�������", "������",
	"�������������", "�����������", "�����������",
	"����������", "���������", "�����������", "��������",
	"��������", "��������������", "��������", "����������",
	"�����", "�������", "���������", "������", "����������",
	"�����������", "���������", "����������", "��������",
	"�����", "�����", "�������", "�������", "�������", "�������",
	"�����", "������", "�������", "��������", "�������",
	"�������", "�������", "������", "�������", "�����", "������",
	"���������", "������", "��������", "�������", "����������",
	"��������", "�������", "������", "��������", "���������",
	"��������", "�������", "�����", "�������", "�������",
	"������", "��3�", "��3��", "��3��", "��z���", "�����", "�����a�",
	"�������", "��������", "������", "�����", "��������", "�������",
	"�������", "������", "������", "�����", "���������", "�����������",
	"�������������", "�������", "��������", "��������", "��������",
	"��������", "�������", "�������", "������", "������", "�������",
	"���������", "�������", "�������", "�������", "��������",
	"���������", "�����������", "����������", "����������",
	"��������", "����������", "�����������", "�����������",
	"���������������", "�����", "������", "������", "��������",
	"�����", "�������", "������", "���������", "�������", "������",
	"���������", "�������", "������", "����������������",
	"�����", "�������", "�� ���", "�� ���", "����������",
	"�������", "�������", "����������", "������������",
	"�������", "�������", "���������", "�������", "�������",
	"���������", "����������", "�����", "�������", "��������",
	"��������", "������", "������", "�������", "�����", "�������",
	"���������", "�����", "��������", "����������", "����������",
	"������������", "������������", "����������", "��������",
	"�����", "���������", "��������", "����������", "���������",
	"�����������", "����������", "������������", "���������",
	"����������", "������", "�������", "��������", "���������",
	"���������", "������������", "���������", "�������������",
	"���������", "�������", "�������", "��������", "������", "�����",
	"������", "��������", "������", "����", "������", "��������", "����",
	"�������", "��������", "�������", "��������", "��������", "�������",
	"��������", "�����", "�����", "������", "������", "�����", "����", "�����",
	"�����", "������", "�������������", "����", "����", "����������", "������",
	"�����", "�����", "�����", "�������", "�����", "������", "�����", "�����", "�����",
	"��������", "�����", "�����", "�����", "���������", "�����", "������6", "�������",
	"������", "���������", "�������", "������", "�����", "������", "�����",
	"��������", "�������", "����", "�����", "����", "�����", "����", "����",
	"��������", "�������", "�_�_�_�_�", "�y�", "�y�", "�y���", "�����", "���",
	"�����", "��������", "��������", "�������", "��������������", "����������",
	"��e�", "���", "��", "�������", "���������", "�������", "�����", "������", "�����",
	"����", "���", "����", "����", "�����", "������", "��������", "�������", "������",
	"���������������", "������", "�������", "������", "��������", "�����", "�������",
	"����", "���", "���", "������", "�����", "�����", "������", "�����", "����", "���", "����",
	"���", "����", "�������", "��������", "�����", "�����", "�������", "�����", "���",
	"�������", "�����", "������", "�������", "����������", "�����", "������", "������", "����", "����",
	"������"
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

-- [x] -- ImGUI ����������. -- [x] --
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

-- [x] -- ���� �������. -- [x] --
function main()
	-- [x] -- �������� �� ������ ����� � ��. -- [x] --
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
	
	sampAddChatMessage(tag .. "�������� ������ �������.")
	
	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstat.STATUS_ENDDOWNLOADDATA then
			updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.version) > script_version then
				showNotification("�������� ����������.", "������ ������ �������: {AA0000}" .. script_version_text .. "\n����� ������ �������: {33AA33}" .. updateIni.info.version_text)
				update_state = true
			end
			os.remove(update_path)
		end
	end)
	
	--imgui.SwitchContext()
	--theme.SwitchColorTheme(8)
	
	admin_chat:run()
	
	-- [x] -- ����. ����. -- [x] --
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

-- [x] -- ���. ������� -- [x] --
function sampev.onSendChat(message)
	-- [x] -- ������ ������ ��� ���������� ���������. -- [x] --
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
	elseif check_string == '(������/������)' then
		showNotification("�����������", "�������� ����� ������.")
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
				showNotification("��������!", "�������� ��������� ���������! \n����������� �����: {FF0000}" .. value .. "\n{FFFFFF}��� ����������: {FF0000}" .. sampGetPlayerNickname(tonumber(check_mat_id)))
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

-- [x] -- ImGUI ����. -- [x] --
local W_Windows = sw/1.145
local H_Windows = 1
local text_dialog
function imgui.OnDrawFrame()
	if i_ans_window.v then
		imgui.SetNextWindowPos(imgui.ImVec2(W_Windows, H_Windows), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(280, 700), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"������ �� ANS", i_ans_window)
		local btn_size = imgui.ImVec2(-0.1, 0)
		imgui.Checkbox(u8"��������� � �����.", i_back_prefix)
		imgui.Separator()
		if imgui.Button(i_ans[1], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[1]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[1]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[2], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[2]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[2]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[3], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[3]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[3]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[4], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[4]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[4]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[5], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[5]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[5]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[6], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[6]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[6]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[7], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[7]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[7]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[8], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[8]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[8]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[9], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[9]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[9]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[10], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[10]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[10]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[11], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[11]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[11]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[12], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[12]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[12]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[13], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[13]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[13]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[14], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[14]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[14]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[15], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[15]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[15]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[16], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[16]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[16]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[17], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[17]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[17]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[18], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[18]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[18]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[19], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[19]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[19]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[20], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[20]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[20]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[21], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[21]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[21]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[22], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[22]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[22]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[23], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[23]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[23]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[24], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[24]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[24]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[25], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[25]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[25]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[26], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[26]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[26]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[27], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[27]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[27]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[28], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[28]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[28]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[29], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[29]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[29]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[30], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[30]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[30]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[31], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[31]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[31]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[32], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[32]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[32]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[33], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[33]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[33]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[34], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[34]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[34]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[35], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[35]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[35]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[36], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[36]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[36]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[37], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[37]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[37]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[38], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[38]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[38]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[39], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[39]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[39]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[40], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[40]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[40]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		if imgui.Button(i_ans[41], btn_size) then
			if not i_back_prefix.v then
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[41]))
			else
				sampSetCurrentDialogEditboxText('{FFFFFF}' .. u8:decode(i_ans[41]) .. ' {AAAAAA}// �������� ���� �� "RDS"!')
			end
		end
		imgui.End()
	end
	if i_setting_items.v then
		imgui.SetNextWindowPos(imgui.ImVec2(W_Windows, H_Windows), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(300, 400), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"��������� �������.", i_setting_items)
		imgui.Text(u8"������� ������ �� ANS.")
		imgui.SameLine()
		imgui.SetCursorPosX(imgui.GetWindowWidth() - 35)
		imgui.ToggleButton("##1", setting_items.Fast_ans)
		--[[imgui.Text(u8"����������� ������� ���������.")
		imgui.SameLine()
		imgui.SetCursorPosX(imgui.GetWindowWidth() - 35)
		imgui.ToggleButton("##3", setting_items.Punishments)]]
		imgui.Text(u8"����� ���.")
		imgui.SameLine()
		imgui.SetCursorPosX(imgui.GetWindowWidth() - 35)
		imgui.ToggleButton("##2", setting_items.Admin_chat)
		imgui.Text(u8"������������ ����� ����.")
		imgui.SameLine()
		imgui.SetCursorPosX(imgui.GetWindowWidth() - 35)
		imgui.ToggleButton("##4", setting_items.Transparency)		
		imgui.PushItemWidth(50)
		if imgui.InputText(u8"������ ����.", font_size_ac) then
			if font_size_ac.v == nil then font_size_ac.v = 1 end
			font_ac = renderCreateFont("Arial", tonumber(font_size_ac.v), font_admin_chat.BOLD + font_admin_chat.SHADOW)
		end
		imgui.PopItemWidth()
		imgui.Text(u8"������ ����: " .. config.setting.Index)
		if imgui.Button(u8" ���� ") then
			config.setting.Index = config.setting.Index + 0.05
		end
		if imgui.Button(u8" ���� ") then
			config.setting.Index = config.setting.Index - 0.05
		end
		imgui.Separator()
		if imgui.Button(u8"���������.") then
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
			imgui.Text(u8"������ �������: " .. script_version_text)
			imgui.Text(u8"�������� ����������!\n����� ������ �������: " .. updateIni.info.version_text)
			imgui.SameLine()
			imgui.SetCursorPosX(imgui.GetWindowWidth() - 80)
			if imgui.Button(u8"��������.") then
				showNotification("����������!", "�������� ���������� �������.")
				downloadUrlToFile(script_url, script_path, function(id, status)
					if status == dlstat.STATUS_ENDDOWNLOADDATA then
						showNotification("����������!", "������ ������� ��������!")
						thisScript():reload()
					end
				end)
			end
		else
			imgui.SetCursorPosY(imgui.GetWindowHeight() - 25)
			imgui.Separator()
			imgui.Text(u8"������ �������: " .. script_version_text)
		end
		imgui.End()
	end
	if i_log_onscene.v then
		imgui.SetNextWindowPos(imgui.ImVec2(10, 10), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
		imgui.SetNextWindowSize(imgui.ImVec2(sw - 10, 400), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"��������� �� ��������� � ����.", i_log_onscene)
		imgui.Text(u8"���� ������������ ������, ������� �������� ������� ����.")
		if log_onscene["player_1"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_1"].name) .. " ID: " .. u8:encode(log_onscene["player_1"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_1"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_1"].text) .. 
			u8"\n����: " .. date_onscene[1] ..
			u8"\n���������:")
			if imgui.Button(u8"���. ##1", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_1"].id .. " 300 ����������� �������.")
				log_onscene["player_1"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##1", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_1"].id .. " 400 ����������� ������.")
				log_onscene["player_1"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##1", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_1"].id .. " 400 �������� ������ ������.")
				log_onscene["player_1"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##1", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_1"].id .. " 5000 ���������� ���������.")
				log_onscene["player_1"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##1", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_1"].id .. " 2500 ����������� �������������.")
				log_onscene["player_1"].id = nil
				controlOnscene()
			end 
			if imgui.Button(u8"��������. ##1", imgui.ImVec2(90, 0)) then
				log_onscene["player_1"].id = nil
				controlOnscene()
			end 
		end
		if log_onscene["player_2"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_2"].name) .. " ID: " .. u8:encode(log_onscene["player_2"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_2"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_2"].text) .. 
			u8"\n����: " .. date_onscene[2] ..
			u8"\n���������:")
			if imgui.Button(u8"���. ##2", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_2"].id .. " 300 ����������� �������.")
				log_onscene["player_2"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##2", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_2"].id .. " 400 ����������� ������.")
				log_onscene["player_2"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##2", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_2"].id .. " 400 �������� ������ ������.")
				log_onscene["player_2"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##2", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_2"].id .. " 5000 ���������� ���������.")
				log_onscene["player_2"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##2", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_2"].id .. " 2500 ����������� �������������.")
				log_onscene["player_2"].id = nil
				controlOnscene()
			end 
			if imgui.Button(u8"��������. ##2", imgui.ImVec2(90, 0)) then
				log_onscene["player_2"].id = nil
				controlOnscene()
			end 
		end
		if log_onscene["player_3"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_3"].name) .. " ID: " .. u8:encode(log_onscene["player_3"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_3"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_3"].text) .. 
			u8"\n����: " .. date_onscene[3] ..
			u8"\n���������:")
			if imgui.Button(u8"���. ##3", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_3"].id .. " 300 ����������� �������.")
				log_onscene["player_3"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##3", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_3"].id .. " 400 ����������� ������.")
				log_onscene["player_3"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##3", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_3"].id .. " 400 �������� ������ ������.")
				log_onscene["player_3"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##3", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_3"].id .. " 5000 ���������� ���������.")
				log_onscene["player_3"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##3", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_3"].id .. " 2500 ����������� �������������.")
				log_onscene["player_3"].id = nil
				controlOnscene()
			end 
			if imgui.Button(u8"��������. ##3", imgui.ImVec2(90, 0)) then
				log_onscene["player_3"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_4"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_4"].name) .. " ID: " .. u8:encode(log_onscene["player_4"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_4"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_4"].text) .. 
			u8"\n����: " .. date_onscene[4] ..
			u8"\n���������:")
			if imgui.Button(u8"���. ##4", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_4"].id .. " 300 ����������� �������.")
				log_onscene["player_4"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##4", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_4"].id .. " 400 ����������� ������.")
				log_onscene["player_4"].id = nil
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##4", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_4"].id .. " 400 �������� ������ ������.")
				log_onscene["player_4"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##4", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_4"].id .. " 5000 ���������� ���������.")
				log_onscene["player_4"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##4", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_4"].id .. " 2500 ����������� �������������.")
				log_onscene["player_4"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"��������. ##4", imgui.ImVec2(90, 0)) then
				log_onscene["player_4"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_5"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_5"].name) .. " ID: " .. u8:encode(log_onscene["player_5"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_5"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_5"].text) .. 
			u8"\n����: " .. date_onscene[5] ..
			u8"\n���������:")
			if imgui.Button(u8"���. ##5", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_5"].id .. " 300 ����������� �������.")
				log_onscene["player_5"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##5", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_5"].id .. " 400 ����������� ������.")
				log_onscene["player_5"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##5", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_5"].id .. " 400 �������� ������ ������.")
				log_onscene["player_5"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##5", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_5"].id .. " 5000 ���������� ���������.")
				log_onscene["player_5"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##5", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_5"].id .. " 2500 ����������� �������������.")
				log_onscene["player_5"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"��������. ##5", imgui.ImVec2(90, 0)) then
				log_onscene["player_5"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_6"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_6"].name) .. " ID: " .. u8:encode(log_onscene["player_6"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_6"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_6"].text) .. 
			u8"\n����: " .. date_onscene[6] ..
			u8"\n���������:")
			if imgui.Button(u8"���. ##6", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_6"].id .. " 300 ����������� �������.")
				log_onscene["player_6"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##6", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_6"].id .. " 400 ����������� ������.")
				log_onscene["player_6"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##6", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_6"].id .. " 400 �������� ������ ������.")
				log_onscene["player_6"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##6", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_6"].id .. " 5000 ���������� ���������.")
				log_onscene["player_6"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##6", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_6"].id .. " 2500 ����������� �������������.")
				log_onscene["player_6"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"��������. ##6", imgui.ImVec2(90, 0)) then
				log_onscene["player_6"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_7"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_7"].name) .. " ID: " .. u8:encode(log_onscene["player_7"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_7"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_7"].text) .. 
			u8"\n����: " .. date_onscene[7] ..
			u8"\n���������:")
			if imgui.Button(u8"���. ##7", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_7"].id .. " 300 ����������� �������.")
				log_onscene["player_7"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##7", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_7"].id .. " 400 ����������� ������.")
				log_onscene["player_7"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##7", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_7"].id .. " 400 �������� ������ ������.")
				log_onscene["player_7"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##7", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_7"].id .. " 5000 ���������� ���������.")
				log_onscene["player_7"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##7", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_7"].id .. " 2500 ����������� �������������.")
				log_onscene["player_7"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"��������. ##7", imgui.ImVec2(90, 0)) then
				log_onscene["player_7"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_8"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_8"].name) .. " ID: " .. u8:encode(log_onscene["player_8"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_8"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_8"].text) .. 
			u8"\n����: " .. date_onscene[8] ..
			u8"\n���������:")
			if imgui.Button(u8"���. ##8", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_8"].id .. " 300 ����������� �������.")
				log_onscene["player_8"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##8", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_8"].id .. " 400 ����������� ������.")
				log_onscene["player_8"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##8", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_8"].id .. " 400 �������� ������ ������.")
				log_onscene["player_8"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##8", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_8"].id .. " 5000 ���������� ���������.")
				log_onscene["player_8"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##8", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_8"].id .. " 2500 ����������� �������������.")
				log_onscene["player_8"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"��������. ##8", imgui.ImVec2(90, 0)) then
				log_onscene["player_8"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_9"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_9"].name) .. " ID: " .. u8:encode(log_onscene["player_9"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_9"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_9"].text) .. 
			u8"\n����: " .. date_onscene[9] ..
			u8"\n���������:")
			if imgui.Button(u8"���. ##9", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_9"].id .. " 300 ����������� �������.")
				log_onscene["player_9"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##9", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_9"].id .. " 400 ����������� ������.")
				log_onscene["player_9"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##9", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_9"].id .. " 400 �������� ������ ������.")
				log_onscene["player_9"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##9", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_9"].id .. " 5000 ���������� ���������.")
				log_onscene["player_9"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##9", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_9"].id .. " 2500 ����������� �������������.")
				log_onscene["player_9"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"��������. ##9", imgui.ImVec2(90, 0)) then
				log_onscene["player_9"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_10"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_10"].name) .. " ID: " .. u8:encode(log_onscene["player_10"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_10"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_10"].text) .. 
			u8"\n����: " .. date_onscene[10] ..
			u8"\n���������:")
			if imgui.Button(u8"���. ##10", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_10"].id .. " 300 ����������� �������.")
				log_onscene["player_10"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##10", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_10"].id .. " 400 ����������� ������.")
				log_onscene["player_10"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##10", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_10"].id .. " 400 �������� ������ ������.")
				log_onscene["player_10"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##10", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_10"].id .. " 5000 ���������� ���������.")
				log_onscene["player_10"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##10", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_10"].id .. " 2500 ����������� �������������.")
				log_onscene["player_10"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"��������. ##10", imgui.ImVec2(90, 0)) then
				log_onscene["player_10"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_11"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_11"].name) .. " ID: " .. u8:encode(log_onscene["player_11"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_11"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_11"].text) .. 
			u8"\n����: " .. date_onscene[11] ..
			u8"\n���������:")
			if imgui.Button(u8"���. ##11", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_11"].id .. " 300 ����������� �������.")
				log_onscene["player_11"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##11", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_11"].id .. " 400 ����������� ������.")
				log_onscene["player_11"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##11", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_11"].id .. " 400 �������� ������ ������.")
				log_onscene["player_11"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##11", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_11"].id .. " 5000 ���������� ���������.")
				log_onscene["player_11"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##11", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_11"].id .. " 2500 ����������� �������������.")
				log_onscene["player_11"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"��������. ##11", imgui.ImVec2(90, 0)) then
				log_onscene["player_11"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_12"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_12"].name) .. " ID: " .. u8:encode(log_onscene["player_12"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_12"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_12"].text) ..
			u8"\n����: " .. date_onscene[12] .. 
			u8"\n���������:")
			if imgui.Button(u8"���. ##12", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_12"].id .. " 300 ����������� �������.")
				log_onscene["player_12"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##12", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_12"].id .. " 400 ����������� ������.")
				log_onscene["player_12"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##12", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_12"].id .. " 400 �������� ������ ������.")
				log_onscene["player_12"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##12", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_12"].id .. " 5000 ���������� ���������.")
				log_onscene["player_12"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##12", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_12"].id .. " 2500 ����������� �������������.")
				log_onscene["player_12"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"��������. ##12", imgui.ImVec2(90, 0)) then
				log_onscene["player_12"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_13"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_13"].name) .. " ID: " .. u8:encode(log_onscene["player_13"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_13"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_13"].text) .. 
			u8"\n����: " .. date_onscene[13] ..
			u8"\n���������:")
			if imgui.Button(u8"���. ##13", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_13"].id .. " 300 ����������� �������.")
				log_onscene["player_13"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##13", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_13"].id .. " 400 ����������� ������.")
				log_onscene["player_13"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##13", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_13"].id .. " 400 �������� ������ ������.")
				log_onscene["player_13"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##13", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_13"].id .. " 5000 ���������� ���������.")
				log_onscene["player_13"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##13", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_13"].id .. " 2500 ����������� �������������.")
				log_onscene["player_13"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"��������. ##13", imgui.ImVec2(90, 0)) then
				log_onscene["player_13"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_14"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_14"].name) .. " ID: " .. u8:encode(log_onscene["player_14"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_14"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_14"].text) .. 
			u8"\n����: " .. date_onscene[14] ..
			u8"\n���������:")
			if imgui.Button(u8"���. ##14", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_14"].id .. " 300 ����������� �������.")
				log_onscene["player_14"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##14", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_14"].id .. " 400 ����������� ������.")
				log_onscene["player_14"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##14", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_14"].id .. " 400 �������� ������ ������.")
				log_onscene["player_14"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##14", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_14"].id .. " 5000 ���������� ���������.")
				log_onscene["player_14"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##14", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_14"].id .. " 2500 ����������� �������������.")
				log_onscene["player_14"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"��������. ##14", imgui.ImVec2(90, 0)) then
				log_onscene["player_14"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_15"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_15"].name) .. " ID: " .. u8:encode(log_onscene["player_15"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_15"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_15"].text) .. 
			u8"\n����: " .. date_onscene[15] ..
			u8"\n���������:")
			if imgui.Button(u8"���. ##15", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_15"].id .. " 300 ����������� �������.")
				log_onscene["player_15"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##15", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_15"].id .. " 400 ����������� ������.")
				log_onscene["player_15"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##15", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_15"].id .. " 400 �������� ������ ������.")
				log_onscene["player_15"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##15", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_15"].id .. " 5000 ���������� ���������.")
				log_onscene["player_15"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##15", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_15"].id .. " 2500 ����������� �������������.")
				log_onscene["player_15"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"��������. ##15", imgui.ImVec2(90, 0)) then
				log_onscene["player_15"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_16"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_16"].name) .. " ID: " .. u8:encode(log_onscene["player_16"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_16"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_16"].text) .. 
			u8"\n����: " .. date_onscene[16] ..
			u8"\n���������:")
			if imgui.Button(u8"���. ##16", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_16"].id .. " 300 ����������� �������.")
				log_onscene["player_16"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##16", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_16"].id .. " 400 ����������� ������.")
				log_onscene["player_16"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##16", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_16"].id .. " 400 �������� ������ ������.")
				log_onscene["player_16"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##16", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_16"].id .. " 5000 ���������� ���������.")
				log_onscene["player_16"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##16", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_16"].id .. " 2500 ����������� �������������.")
				log_onscene["player_16"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"��������. ##16", imgui.ImVec2(90, 0)) then
				log_onscene["player_16"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_17"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_17"].name) .. " ID: " .. u8:encode(log_onscene["player_17"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_17"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_17"].text) .. 
			u8"\n����: " .. date_onscene[17] ..
			u8"\n���������:")
			if imgui.Button(u8"���. ##17", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_17"].id .. " 300 ����������� �������.")
				log_onscene["player_17"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##17", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_17"].id .. " 400 ����������� ������.")
				log_onscene["player_17"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##17", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_17"].id .. " 400 �������� ������ ������.")
				log_onscene["player_17"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##17", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_17"].id .. " 5000 ���������� ���������.")
				log_onscene["player_17"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##17", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_17"].id .. " 2500 ����������� �������������.")
				log_onscene["player_17"].id = nil
				controlOnscene()
			end 	
			if imgui.Button(u8"��������. ##17", imgui.ImVec2(90, 0)) then
				log_onscene["player_17"].id = nil
				controlOnscene()
			end 	
		end
		if log_onscene["player_18"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_18"].name) .. " ID: " .. u8:encode(log_onscene["player_18"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_18"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_18"].text) .. 
			u8"\n����: " .. date_onscene[18] ..
			u8"\n���������:")
			if imgui.Button(u8"���. ##18", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_18"].id .. " 300 ����������� �������.")
				log_onscene["player_18"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##18", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_18"].id .. " 400 ����������� ������.")
				log_onscene["player_18"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##18", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_18"].id .. " 400 �������� ������ ������.")
				log_onscene["player_18"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##18", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_18"].id .. " 5000 ���������� ���������.")
				log_onscene["player_18"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##18", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_18"].id .. " 2500 ����������� �������������.")
				log_onscene["player_18"].id = nil
				controlOnscene()
			end		
			if imgui.Button(u8"��������. ##18", imgui.ImVec2(90, 0)) then
				log_onscene["player_18"].id = nil
				controlOnscene()
			end 
		end
		if log_onscene["player_19"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_19"].name) .. " ID: " .. u8:encode(log_onscene["player_19"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_19"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_19"].text) ..
			u8"\n����: " .. date_onscene[19] .. 
			u8"\n���������:")
			if imgui.Button(u8"���. ##19", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_19"].id .. " 300 ����������� �������.")
				log_onscene["player_19"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##19", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_19"].id .. " 400 ����������� ������.")
				log_onscene["player_19"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##19", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_19"].id .. " 400 �������� ������ ������.")
				log_onscene["player_19"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##19", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_19"].id .. " 5000 ���������� ���������.")
				log_onscene["player_19"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##19", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_19"].id .. " 2500 ����������� �������������.")
				log_onscene["player_19"].id = nil
				controlOnscene()
			end		
			if imgui.Button(u8"��������. ##19", imgui.ImVec2(90, 0)) then
				log_onscene["player_19"].id = nil
				controlOnscene()
			end 
		end
		if log_onscene["player_20"].id ~= nil then
			imgui.Separator()
			imgui.Text(u8"��� ������: " .. u8:encode(log_onscene["player_20"].name) .. " ID: " .. u8:encode(log_onscene["player_20"].id) .. 
			u8"\n�����, ������� ������ ��� ����������: " .. u8:encode(log_onscene["player_20"].suspicion) .. 
			u8"\n����� �� ����: " .. u8:encode(log_onscene["player_20"].text) ..
			u8"\n����: " .. date_onscene[20] .. 
			u8"\n���������:")
			if imgui.Button(u8"���. ##20", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_20"].id .. " 300 ����������� �������.")
				log_onscene["player_20"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ##20", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_20"].id .. " 400 ����������� ������.")
				log_onscene["player_20"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"����. ##20", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_20"].id .. " 400 �������� ������ ������.")
				log_onscene["player_20"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##20", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_20"].id .. " 5000 ���������� ���������.")
				log_onscene["player_20"].id = nil
				controlOnscene()
			end
			imgui.SameLine()
			if imgui.Button(u8"���. ���. ##20", imgui.ImVec2(90, 0)) then
				sampSendChat("/mute " .. log_onscene["player_20"].id .. " 2500 ����������� �������������.")
				log_onscene["player_20"].id = nil
				controlOnscene()
			end	
			if imgui.Button(u8"��������. ##20", imgui.ImVec2(90, 0)) then
				log_onscene["player_20"].id = nil
				controlOnscene()
			end 
		end
		imgui.Separator()
		imgui.End()
	end
end