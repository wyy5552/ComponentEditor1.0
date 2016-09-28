package com.gamehero.sxd2.manager
{
	import com.gamehero.sxd2.data.WorldBossData;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSG_WORLD_BOSS_JOIN_WAIT_REQ;
	import com.gamehero.sxd2.services.GameService;
	import com.gamehero.sxd2.world.model.MapModel;
	import com.gamehero.sxd2.world.model.MapTypeDict;
    
	
	/**
	 * js调用as
	 * @author xuwenyi
	 * @create 2014-12-03
	 **/
	public class Js2AsManager
	{
		/**
		 * 离开游戏时的弹出框
		 * */
		public static function leaveGame():String
		{
			/*var dailyTaskNum:int;
			var mercTaskNum:int;
			var stamina:int;
			var funcforeVO:FuncforeVO;
			try
			{
				dailyTaskNum = TaskManager.inst.getDailyTaskRestNum();
				mercTaskNum = FunctionsManager.instance.getFuncNum(GS_Func_Name_Pro.MercenaryMeauBtn)
				stamina = GameData.inst.roleInfo.stamina;
				funcforeVO = FuncforeManager.instance.getFirstFuncfore();
			}
			catch(e:Error)
			{
				return "";
			}
			
			var str:String = Lang.instance.trans("AS_1582");
			if(dailyTaskNum > 0)
			{
				str += "\n---------\n";
				str += Lang.instance.trans("AS_1452") + dailyTaskNum +  "个\n";
			}
			if(mercTaskNum > 0)
			{
				str += "---------\n";
				str += Lang.instance.trans("AS_1453") + mercTaskNum + "个\n";
			}
			if(stamina > 0)
			{
				str += "---------\n";
				str += Lang.instance.trans("AS_1454") + stamina + "\n";
			}
			if(funcforeVO != null)
			{
				str += "---------\n";
				str += Lang.instance.trans("AS_1455") + funcforeVO.text1 + "\n";
			}*/
			
			//return str;
			//如果是世界Boss地图 关闭页面时 退出活动
			if(MapModel.inst.mapVo.type == MapTypeDict.BOSS_MAP)
				SXD2Main.inst.enterWorldBoss(0);
			
			//已经开始匹配 发送结束匹配
			if(WorldBossData.inst.worldBossCountStatus && WorldBossData.inst.worldBossCountStatus.status == WorldBossData.inst.WORLD_BOSS_NONE && WorldBossData.inst.worldBossCountStatus.roomCreate)
			{
				var req:MSG_WORLD_BOSS_JOIN_WAIT_REQ = new MSG_WORLD_BOSS_JOIN_WAIT_REQ();
				req.wait = 0;
				GameService.instance.send(MSGID.MSGID_WORLD_BOSS_JOIN_WAIT,req);
			}
			
			return "";
		}
	}
}