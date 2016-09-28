package com.gamehero.sxd2.gui.theme.ifstheme.skin
{
	import com.gamehero.sxd2.core.Global;
	
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.system.ApplicationDomain;
	
	/**
	 * 战斗UI皮肤
	 * @author xuwenyi
	 * @create 
	 **/
	public class BattleSkin
	{
		// 域
		private static var domain:ApplicationDomain;
		
		// 战斗切换动画
		static public var BATTLE_CHANGE:MovieClip;
		
		// 左上角组件
		static public var BATTLE_ROUND_BG:BitmapData;
		static public var BATTLE_ROUND_LB:BitmapData;
		
		// BOSS血条
		static public var BOSS_BLOOD_BG:BitmapData;
		static public var BOSS_BLOOD_MASK:BitmapData;
		static public var BOSS_BLOOD_RED:BitmapData;
		static public var BOSS_BLOOD_YELLOW:BitmapData;
		static public var BOSS_BLOOD_PURPLE:BitmapData;
		static public var BOSS_BLOOD_BLUE:BitmapData;
		static public var BOSS_BLOOD_GREEN:BitmapData;
		
		// 右下角按钮
		static public var PASS_BTN:SimpleButton;
		static public var SPEED_UP_1_BTN:SimpleButton;
		static public var SPEED_UP_2_BTN:SimpleButton;
		static public var SPEED_UP_3_BTN:SimpleButton;
		
		// 人物血条和怒气条(渲染层)
		static public var ROLE_BLOOD_BG:BitmapData;
		static public var ROLE_BLOOD_1:BitmapData;
		static public var ROLE_BLOOD_2:BitmapData;
		static public var ROLE_BLOOD_TWEEN:BitmapData;
		static public var ROLE_ANGER_1:BitmapData;
		static public var ROLE_ANGER_2:BitmapData;
		static public var ROLE_ANGER_GAP:BitmapData;
		static public var ROLE_ANGER_BG:BitmapData;
		
		// 暴击等文字
		static public var BLOOD:BitmapData;
		static public var CRT:BitmapData;
		static public var CRT2:BitmapData;
		static public var ABB:BitmapData;//吸收
		static public var PAY:Class;//格挡
		static public var AVD:Class;//闪避
		static public var PEN:Class;//穿透
		static public var IMM:Class;//免疫
		
		// 技能飘字
		static public var SKILL_TEXT_BG:BitmapData;
		static public var TOTAL_DMG:BitmapData;
		
		// pvp开场动画
		static public var PVP_OPENING:Class;
		
		// 天神场景切换闪屏
		static public var GOD_CHANGE_MAP:Class;
		
		// tips
		static public var TIPS_BLOOD_BG:BitmapData;
		static public var TIPS_BLOOD:BitmapData;
		static public var TIPS_ANGER:BitmapData;
		static public var TIPS_JOB_1:BitmapData;
		
		// 职业图标
		static public var JOB_1:BitmapData;
		static public var JOB_2:BitmapData;
		static public var JOB_3:BitmapData;
		static public var JOB_4:BitmapData;
		static public var JOB_5:BitmapData;
		static public var JOB_6:BitmapData;
		static public var JOB_7:BitmapData;
		static public var JOB_8:BitmapData;
		static public var JOB_9:BitmapData;
		static public var JOB_10:BitmapData;
		static public var JOB_11:BitmapData;
		static public var JOB_12:BitmapData;
		
		// 怪物职业图标
		static public var MONSTER_JOB_1:BitmapData;
		static public var MONSTER_JOB_2:BitmapData;
		static public var MONSTER_JOB_3:BitmapData;
		static public var MONSTER_JOB_4:BitmapData;
		static public var MONSTER_JOB_5:BitmapData;
		
		
		// 初始化
		public static function init(domain:ApplicationDomain):void
		{
			var global:Global = Global.instance;
			// 保存域
			BattleSkin.domain = domain;
			
			// 左上角组件
			BATTLE_ROUND_BG = global.getBD(domain , "BATTLE_ROUND_BG");
			BATTLE_ROUND_LB = global.getBD(domain , "BATTLE_ROUND_LB");
			
			// BOSS血条
			BOSS_BLOOD_BG = global.getBD(domain , "BOSS_BLOOD_BG");
			BOSS_BLOOD_MASK = global.getBD(domain , "BOSS_BLOOD_MASK");
			BOSS_BLOOD_RED = global.getBD(domain , "BOSS_BLOOD_RED");
			BOSS_BLOOD_YELLOW = global.getBD(domain , "BOSS_BLOOD_YELLOW");
			BOSS_BLOOD_PURPLE = global.getBD(domain , "BOSS_BLOOD_PURPLE");
			BOSS_BLOOD_BLUE = global.getBD(domain , "BOSS_BLOOD_BLUE");
			BOSS_BLOOD_GREEN = global.getBD(domain , "BOSS_BLOOD_GREEN");
			
			// 右下角按钮
			PASS_BTN = global.getRes(domain , "PASS_BTN") as SimpleButton;
			SPEED_UP_1_BTN = global.getRes(domain , "SPEED_UP_1_BTN") as SimpleButton;
			SPEED_UP_2_BTN = global.getRes(domain , "SPEED_UP_2_BTN") as SimpleButton;
			SPEED_UP_3_BTN = global.getRes(domain , "SPEED_UP_3_BTN") as SimpleButton;
			
			// 人物血条和怒气条(渲染层)
			ROLE_BLOOD_BG = global.getBD(domain , "ROLE_BLOOD_BG");
			ROLE_BLOOD_1 = global.getBD(domain , "ROLE_BLOOD_1");
			ROLE_BLOOD_2 = global.getBD(domain , "ROLE_BLOOD_2");
			ROLE_BLOOD_TWEEN = new BitmapData(58 , 4 , false , 0xffffff);
			ROLE_ANGER_1 = global.getBD(domain , "ROLE_ANGER_1");
			ROLE_ANGER_2 = global.getBD(domain , "ROLE_ANGER_2");
			ROLE_ANGER_GAP = global.getBD(domain , "ROLE_ANGER_GAP");
			ROLE_ANGER_BG = global.getBD(domain , "ROLE_ANGER_BG");
			
			// 战斗飘字相关
			BLOOD = global.getBD(domain , "BLOOD");
			CRT = global.getBD(domain , "CRT");
			CRT2 = global.getBD(domain , "CRT2");
			ABB = global.getBD(domain , "ABB");
			PAY = global.getClass(domain , "PAY");
			AVD = global.getClass(domain , "AVD");
			PEN = global.getClass(domain , "PEN");
			IMM = global.getClass(domain , "IMM");
			
			// 技能飘字
			SKILL_TEXT_BG = global.getBD(domain , "SKILL_TEXT_BG");
			// 总伤害
			TOTAL_DMG = global.getBD(domain , "TOTAL_DMG");
			
			// pvp开场动画
			PVP_OPENING = global.getClass(domain , "PVP_OPENING");
			
			// 天神场景切换闪屏
			GOD_CHANGE_MAP = global.getClass(domain , "GOD_CHANGE_MAP");
			
			// tips
			TIPS_BLOOD_BG = global.getBD(domain , "TIPS_BLOOD_BG");
			TIPS_BLOOD = global.getBD(domain , "TIPS_BLOOD");
			TIPS_ANGER = global.getBD(domain , "TIPS_ANGER");
			TIPS_JOB_1 = global.getBD(domain , "TIPS_JOB_1");
			
			// 职业图标
			JOB_1 = global.getBD(domain , "JOB_1");
			JOB_2 = global.getBD(domain , "JOB_2");
			JOB_3 = global.getBD(domain , "JOB_3");
			JOB_4 = global.getBD(domain , "JOB_4");
			JOB_5 = global.getBD(domain , "JOB_5");
			JOB_6 = global.getBD(domain , "JOB_6");
			JOB_7 = global.getBD(domain , "JOB_7");
			JOB_8 = global.getBD(domain , "JOB_8");
			JOB_9 = global.getBD(domain , "JOB_9");
			JOB_10 = global.getBD(domain , "JOB_10");
			JOB_11 = global.getBD(domain , "JOB_11");
			JOB_12 = global.getBD(domain , "JOB_12");
			
			// 怪物职业图标
			MONSTER_JOB_1 = global.getBD(domain , "MONSTER_JOB_1");
			MONSTER_JOB_2 = global.getBD(domain , "MONSTER_JOB_2");
			MONSTER_JOB_3 = global.getBD(domain , "MONSTER_JOB_3");
			MONSTER_JOB_4 = global.getBD(domain , "MONSTER_JOB_4");
			MONSTER_JOB_5 = global.getBD(domain , "MONSTER_JOB_5");
		}
	}
}