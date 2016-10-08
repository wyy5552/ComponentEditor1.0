package com.gamehero.sxd2.core
{
	

	/**
	 * 游戏全局设置 
	 * @author Trey
	 * 
	 */
	public class GameConfig {
		
		
		/**
		 * 角色移动的总速度 
		 * 每秒钟250像素 = 每像素需要4毫秒
		 */		
		public static var SPEED:int = 1000 / 250;
		/**
		 * 双击的时间间隔 
		 */		
//		public static var MOUSE_DOUBLE_CLICK_TIME:int = 250;
		public static var MOUSE_DOUBLE_CLICK_TIME:int = 200;
		
		static public var RESOURCE_URL:String = "resource/";
		public static var NPCFACE_URL:String;
		public static var TASK_URL:String;
		public static var FATE_URL:String;
		public static var GOD_SHOW_URL:String;
		public static var FONT_URL:String;
		
		static public var LOGIN_URL:String;
		static public var GUI_URL:String;
		public static var CHESS_URL:String;
		public static var VIP_URL:String;
		
		static public var MAPS_URL:String;
		static public var MAP_THUMB_URL:String;
		static public var MAP_NAME_URL:String;
		
		
		
		/**
		 * 单帧动画的位置 
		 */		
		static public var MAP_DECO:String;
		/**
		 * 加载swf动画的位置（不需要渲染引擎的） 
		 */		
		static public var SWF:String;
		
		// 角色素材url
		static public var FIGURE_URL:String;

		/**
		 * 动画素材 
		 */		
		static public var SWF_FIGURE_URL:String; 
		static public var SWF_FIGURE_WORLDBOSS_URL:String; 
		
		
		static public var PLAYER_FIGURE_URL:String;
		static public var NPC_FIGURE_URL:String;
		static public var BATTLE_FIGURE_URL:String;
		static public var OTHER_FIGURE_URL:String;
		//static public var HERO_FIGURE_URL:String = FIGURE_URL + "hero/";
		
		// 伙伴UI资源
		static public var HERO_URL:String;
		//剧情副本导航界面
		static public var HURLDLE_URL:String;
		
		
		static public var ICON_URL:String;
		static public var ITEM_ICON_URL:String;
		static public var SKILL_ICON_URL:String;
		static public var PASSIVE_SKILL_ICON_URL:String;
		static public var FATE_ICON_URL:String;
		static public var BOSS_ICON_URL:String;
		static public var WORLDBOSS_ICON_URL:String;
		static public var GOD_ICON_URL:String;//天神icon
		static public var AVATAR_ICON_URL:String;//主角皮肤icon
		static public var PRESTIGE_ICON_URL:String;//声望
		static public var CHANGE_AVATAR:String;//主角换肤
		static public var PLAYER_ICON_URL:String;//主角皮肤静态图
		static public var MONSTER_SMALL_URL:String;//怪物小头像
		static public var BUFF_ICON_URL:String;//
		static public var FORMATION_ICON_URL:String;//
		//好友头像
		static public var FRIEND_ICON_URL:String;
		//六道轮回
		static public var SIX_DESTINIES_URL:String;
		//七星封魔
		static public var SEVEN_STAR_URL:String;
		//比武场头像url
		static public var SKY_LADDER_HEAD_URL:String;
		//鲜花礼物url
		static public var PRESENT_URL:String;
		
		static public var NPC_URL:String;
		static public var NPC_IMAGE_URL:String;
		
		static public var DRAMA_URL:String;
		// 剧情对话框头像
		static public var DRAMA_DIALOG_HEAD_URL:String;
		// 剧情过场动画
		static public var DRAMA_MOVIE_URL:String;
		// 剧情特效
		static public var DRAMA_EFFECT_URL:String;
		
		// 战斗素材url
		static public var BATTLE_URL:String;
		static public var BATTLE_SK_URL:String;
		static public var BATTLE_SE_URL:String;
		static public var BATTLE_UA_URL:String;
		static public var BATTLE_SK_SWF_URL:String;
		static public var BATTLE_SE_SWF_URL:String;
		static public var BATTLE_UA_SWF_URL:String;
		static public var BATTLE_SKILL_TEXT_URL:String;
		static public var BATTLE_NAME_TEXT_URL:String;
		static public var BATTLE_BUFF_EFFECT_URL:String;
		static public var BATTLE_PLAYER_EFFECT_URL:String;
		static public var BATTLE_GOD_EFFECT_URL:String;
		static public var BATTLE_NEW_PLAYER_URL:String;
		static public var BATTLE_LEADER_BODY_URL:String;// 主角半身像
		/**
		 * 命格 
		 */		
		static public var FATE_CELL_URL:String = "";
		
		// 引导素材
		static public var GUIDE_URL:String;
		
		// 主角形象资源
		static public var ROLE_URL:String;
		
		// 音效资源
		static public var SOUND_URL:String;
		
		
		
		/** 加载优先级 */
		public static const HIGHEST_LOAD_PRIORITY : int = 100;
		
		public static const XML_LOAD_PRIORITY : int = 51;
		public static const MAP_LOAD_PRIORITY : int = 41;
		public static const PLAYER_LOAD_PRIORITY : int = 31;
		public static const NPC_LOAD_PRIORITY : int = 21;
		public static const DECO_LOAD_PRIORITY : int = 11;
		

		
		
		
		/**
		 * 多语言选择
		 * */
		public static function init(lang:String):void
		{
			switch(lang)
			{
				// 简体
				case URI.CN:
					RESOURCE_URL = "resource/";
					break;
				
				// 繁体
				case URI.TW:
					RESOURCE_URL = "tw_resource/";
					break;
			}
			
			NPCFACE_URL = RESOURCE_URL + "npc/image/";
			TASK_URL = RESOURCE_URL + "task/"; 
			FATE_URL = RESOURCE_URL + "fate/";
			GOD_SHOW_URL = RESOURCE_URL + "godShow/";
			FONT_URL = RESOURCE_URL + "font/";
			
			LOGIN_URL = RESOURCE_URL + "login/";
			GUI_URL = RESOURCE_URL + "gui/";
			CHESS_URL = RESOURCE_URL + "chess/";
			VIP_URL = RESOURCE_URL + "vip/";
			
			MAPS_URL = RESOURCE_URL + "maps/";
			MAP_THUMB_URL = RESOURCE_URL + "maps/thumb/";
			MAP_NAME_URL = RESOURCE_URL + "maps_title/";
			MAP_DECO = RESOURCE_URL + "maps/deco/";
			
			SWF = RESOURCE_URL + "swf/";
			
			// 角色素材url
			FIGURE_URL = RESOURCE_URL + "figure/";
			SWF_FIGURE_URL = RESOURCE_URL + "swfFigure/";
			SWF_FIGURE_WORLDBOSS_URL = SWF_FIGURE_URL + "worldBoss/"
			PLAYER_FIGURE_URL = FIGURE_URL + "player/";
			NPC_FIGURE_URL = FIGURE_URL + "npc/";
			BATTLE_FIGURE_URL = FIGURE_URL + "battle/";
			OTHER_FIGURE_URL = FIGURE_URL + "other/";
			//HERO_FIGURE_URL:String = FIGURE_URL + "hero/";
			
			// 伙伴UI资源
			HERO_URL = RESOURCE_URL + "hero/";
			
			HURLDLE_URL = RESOURCE_URL + "hurdleGuide/";
			
			ICON_URL = RESOURCE_URL + "icon/";
			ITEM_ICON_URL = ICON_URL + "item/";
			SKILL_ICON_URL = ICON_URL + "skill/";
			PASSIVE_SKILL_ICON_URL = ICON_URL + "passiveSkill/";
			FATE_ICON_URL = ICON_URL + "fate/"; 
			BOSS_ICON_URL = ICON_URL + "battlehead/";
			GOD_ICON_URL = ICON_URL + "god/";
			AVATAR_ICON_URL = ICON_URL + "avatar/";
			FRIEND_ICON_URL = ICON_URL + "friend/";
			MONSTER_SMALL_URL = ICON_URL + "monsterSmallHead/";
			BUFF_ICON_URL = ICON_URL + "buff/";
			PRESTIGE_ICON_URL = ICON_URL + "prestige/";
			PLAYER_ICON_URL = ICON_URL + "player/";
			CHANGE_AVATAR = ICON_URL + "changeAvatar/";
			WORLDBOSS_ICON_URL = ICON_URL + "worldBoss/";
			FORMATION_ICON_URL = ICON_URL + "formation/";
			
			SIX_DESTINIES_URL = RESOURCE_URL + "sixDestinies/";
			
			SEVEN_STAR_URL = RESOURCE_URL + "sevenstar/";
			
			SKY_LADDER_HEAD_URL = ICON_URL + "skyLadderHead/";
			
			PRESENT_URL = ICON_URL + "present/";
			
			NPC_URL = RESOURCE_URL + "npc/";
			NPC_IMAGE_URL = NPC_URL + "image/";
			
			DRAMA_URL = RESOURCE_URL + "drama/";
			// 剧情对话框头像
			DRAMA_DIALOG_HEAD_URL = DRAMA_URL + "head/";
			// 剧情过场动画
			DRAMA_MOVIE_URL = DRAMA_URL + "movie/";
			// 剧情特效
			DRAMA_EFFECT_URL = DRAMA_URL + "effect/";
			
			// 战斗素材url
			BATTLE_URL = RESOURCE_URL + "battle/";
			BATTLE_SK_URL = BATTLE_URL + "skilleffect/png/sk/";
			BATTLE_SE_URL = BATTLE_URL + "skilleffect/png/se/";
			BATTLE_UA_URL = BATTLE_URL + "skilleffect/png/ua/";
			BATTLE_SK_SWF_URL = BATTLE_URL + "skilleffect/swf/sk/";
			BATTLE_SE_SWF_URL = BATTLE_URL + "skilleffect/swf/se/";
			BATTLE_UA_SWF_URL = BATTLE_URL + "skilleffect/swf/ua/";
			BATTLE_SKILL_TEXT_URL = BATTLE_URL + "skilleffect/text/";
			BATTLE_NAME_TEXT_URL = BATTLE_URL + "battlename/";
			BATTLE_BUFF_EFFECT_URL = BATTLE_URL + "buffeffect/";
			BATTLE_PLAYER_EFFECT_URL = BATTLE_URL + "playereffect/";
			BATTLE_GOD_EFFECT_URL = BATTLE_URL + "godeffect/";
			BATTLE_NEW_PLAYER_URL = BATTLE_URL + "newplayer/";
			BATTLE_LEADER_BODY_URL = BATTLE_URL + "leaderbody/";
			
			FATE_CELL_URL = RESOURCE_URL + "brith_chart/";
			
			// 引导素材
			GUIDE_URL = RESOURCE_URL + "guide/"
			
			// 主角形象资源
			ROLE_URL = RESOURCE_URL + "role/";
			
			// 音效资源
			SOUND_URL = RESOURCE_URL + "sound/";
			
			
		}
	}
}