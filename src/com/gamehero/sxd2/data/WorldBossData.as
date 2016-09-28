package com.gamehero.sxd2.data
{	
	import com.gamehero.sxd2.pro.MSG_WORLD_BOSS_BASE_INFO_ACK;
	import com.gamehero.sxd2.pro.MSG_WORLD_BOSS_PLAYER_ACK;
	import com.gamehero.sxd2.pro.MSG_WORLD_BOSS_SORT_INFO_ACK;
	import com.gamehero.sxd2.pro.MSG_WORLD_BOSS_STATUS_ACK;
	import com.gamehero.sxd2.pro.PRO_PlayerVisible;
	import com.gamehero.sxd2.pro.PRO_WorldBossStatus;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	
	/**
	 *世界Boss数据存放 
	 * @author Administrator
	 * 
	 */	
	public class WorldBossData extends EventDispatcher
	{
		/**
		 *单例对象 
		 */		
		private static var _instance:WorldBossData;
		public var worldBossBaseInfo:MSG_WORLD_BOSS_BASE_INFO_ACK;//boss信息
		public var worldBossSortInfo:MSG_WORLD_BOSS_SORT_INFO_ACK;//排行榜信息
		public var worldBossPlayerInfo:MSG_WORLD_BOSS_PLAYER_ACK;//排行榜信息
		public var worldBossLogInfo:Array=[];//玩家动态
		public var isLoadComplete:Boolean;//是否已经加载
		public var isAutoPk:Boolean;//是否自动战斗
//		public var movePlayer:Object = new Object();
		public var activityStatus:int;//当前获得状态
		public var isShowKillRank:Boolean;//击杀榜显示状态
		private var isFirstUpdata:Boolean;//是否第一次加载标记
		public var playerVisibleList:Dictionary;//玩家显示状态集合
		private var items:Vector.<String> = new Vector.<String>;//玩家字典
		public var isEnroll:Boolean; //是否准备
		public var worldBossCountStatus:MSG_WORLD_BOSS_STATUS_ACK;//世界Boss次数状态数据
		
		public var WORLD_BOSS_NONE:int = 0;//等待
		public var WORLD_BOSS_READY:int = 1;//准备
		public var WORLD_BOSS_START:int = 2;//开始
		public var WORLD_BOSS_END:int = 3;//结束

		
		public function WorldBossData()
		{
			playerVisibleList = new Dictionary();
		}
		
		/**
		 *世界Boss是否自动战斗 
		 * @return 
		 * 
		 */		
		public function worldBossAutoPk():Boolean
		{
			if(WorldBossData.inst.isAutoPk && WorldBossData.inst.worldBossPlayerInfo.curStatus && WorldBossData.inst.activityStatus == PRO_WorldBossStatus.WORLDBOSS_OPEN)
				return true;
			return false;
		}
		
		/**
		 *获取玩家在世界Boss内的状态 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getPlayerVisivle(id:int):int
		{
			for each(var info:PRO_PlayerVisible in playerVisibleList)
			{
				if(info.id == id)
					return info.type
			}
			
			return 0;
		}
		
		/** 
		 * 更新玩家显示状态
		 * */
		public function updataPlayerVisibleList(list:Array):void
		{	
			var id:String;
			var index:int;
			var info:PRO_PlayerVisible

			if(!isFirstUpdata)
			{
				for each(info in list)
				{
					id = info.id.toString();
					playerVisibleList[id] = info;
				}
				isFirstUpdata = true;
			}
			else
			{
				for each(info in list)
				{
					id = info.id.toString();
					playerVisibleList[id] = info;
				}
			}
		}
		
		
		/**
		 *活动结束清理数据 
		 * 
		 */		
		public function clearInfo():void
		{
			//玩家显示状态集合
			for each(var info:PRO_PlayerVisible in playerVisibleList)
			{
				var id:String = info.id.toString();
				playerVisibleList[id] = null;
				delete playerVisibleList[id];
			}
			
			isLoadComplete = false;//是否已经加载
			isAutoPk = false;//是否自动战斗
			isShowKillRank = false;//击杀榜显示状态
			isFirstUpdata = false;//是否第一次加载标记
			isEnroll = false; //是否准备
		}
		
		/**
		 * 获取单例
		 * */
		public static function get inst():WorldBossData {
			return _instance ||= new WorldBossData();
		}
	}
}
