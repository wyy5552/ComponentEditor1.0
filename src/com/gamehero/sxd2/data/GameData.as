package com.gamehero.sxd2.data {
	
	import com.gamehero.sxd2.event.GameDataEvent;
	import com.gamehero.sxd2.event.WindowEvent;
	import com.gamehero.sxd2.gui.bag.model.RoleBuffTypeDict;
	import com.gamehero.sxd2.gui.hurdleGuide.model.vo.HurdleVo;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.local.GlobalFun;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.DialogManager;
	import com.gamehero.sxd2.manager.SystemSettingsManager;
	import com.gamehero.sxd2.pro.BuyCount;
	import com.gamehero.sxd2.pro.PRO_Map;
	import com.gamehero.sxd2.pro.PRO_Player;
	import com.gamehero.sxd2.pro.PRO_PlayerBase;
	import com.gamehero.sxd2.pro.PRO_PlayerBuf;
	import com.gamehero.sxd2.pro.PRO_PlayerExtra;
	import com.gamehero.sxd2.pro.PRO_Skill;
	import com.gamehero.sxd2.vo.PlayerNameVo;
	import com.gamehero.sxd2.vo.ScheduleVO;
	import com.gamehero.sxd2.vo.SystemSettingsVO;
	
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	
	
	/**
	 * 游戏数据存放类,存放游戏客户端运行时的临时数据 
	 */
	public class GameData extends EventDispatcher 
	{	
		static private var _instance:GameData;
		
		//用户信息
		private var _roleInfo:PRO_Player;
		/**
		 * 主角buff
		 * */
		private var _buffDic:Dictionary = new Dictionary();
		//游戏全局设置(音乐音效,消费提示等)
		public var gameConfig:Object = new Object();
		//登录时开放的功能
		public var functions:Array = [];
		//开服时间(时间戳)
		public var openServerTime:int;//精确到秒
		public var openServerDay:int;//精确到天
		//合服时间(时间戳)
		public var mergeServerTime:int;//精确到秒
		public var mergeServerDay:int;//精确到天
		//主角是否在移动 
		public var isMove:int;
		//主角是否在战斗中
		public var isBattle:Boolean;
		//上一次发起战斗的时间点
		public var lastCreateBattleTime:int = 0;
		//主角是否在剧情中
		public var isDrama:Boolean;
		//主角是否在全屏界面
		public var isFullView:Boolean;
		//玩家技能信息
		public var roleSkill:PRO_Skill;
		/**天神id**/
		public var godId:int = 0;
		//天神
		public var godList:Array = [];
		//当前所在副本id		
		private var _curHurdleVo:HurdleVo;
		//已加载的地图ID
		public var loadCompleteMapId:Array = [];
		//购买道具计数
		public var buyItems:Dictionary = new Dictionary();
		// 当前进入的时限活动vo
		public var cuurentScheduleVO:ScheduleVO;
		/**
		 *副本中升级标识 
		 */
//		public var isUpgrade:Boolean = false;
		/**
		 *用于自适应屏幕，记录alert弹出框内容 
		 */		
		public var golbalAlertObj:Object;
		
		public var isHurdleMove:Boolean;
		
		/**
		 * 临时用标记 用于解决 同一场景反复使用
		 */
		public var isLoadScene:Boolean = false;
		
		public var isLoadHurdle:Boolean = false;
		
		public var testBool:Boolean;
		
		/**
		 * 当前爬塔层数 
		 */		
		public var curTowerFloor:int ;
		/**
		 * 主角名称
		 */		
		private var _roleName:PlayerNameVo;
		
		public var guildLevel:uint;//帮会等级
		/**
		 * 是否领取过微端奖励 
		 */		
		public var isGetMicroClientReward:Boolean;
		/**
		 *改名次数 
		 */		
		public var renameCount:int; 
		
		/**
		 *特权卡状态 
		 */		
		public var foreverCard:int;//永久卡
		public var monthCard:int;//yue卡
		/**
		 * Constructor 
		 * @param singleton
		 * 
		 */
		public function GameData(singleton:Singleton) {

		}
		/**
		 * 当前所在的副本 
		 * @return 
		 * 
		 */		
		public function get curHurdleVo():HurdleVo
		{
			return _curHurdleVo;
		}
		
		/**
		 *设置当前所在副本 
		 * @param value
		 * 
		 */		
		public function set curHurdleVo(value:HurdleVo):void
		{
			_curHurdleVo = value;
		}

		/**
		 * 获取单例
		 * */
		static public function get inst():GameData {
			return _instance ||= new GameData(new Singleton());
		}
		
		/**
		 * 获取用户信息
		 * */
		public function get roleInfo():PRO_Player
		{
			return _roleInfo;
		}
		
		/**
		 * 获取用户基础信息
		 * */
		public function get playerExtraInfo():PRO_PlayerExtra
		{
			return _roleInfo.extra;
		}
		
		/**
		 * 获取用户属性信息
		 * */
		public function get playerInfo():PRO_PlayerBase
		{
			return _roleInfo.base;
		}
		
		/**
		 * 设置用户属性信息
		 * */
		public function set playerInfo(value:PRO_PlayerBase):void
		{
			_roleInfo.base = value;
		}
		
		/**
		 * 设置用户地址信息
		 * */
		public function set mapInfo(mapInfo:PRO_Map):void
		{
			_roleInfo.map = mapInfo;
		}
		
		/**
		 * 获取用户地址信息
		 * */
		public function get mapInfo():PRO_Map
		{
			return _roleInfo.map;
		}

		/**
		 * 设置用户信息
		 * */
		public function set roleInfo(user:PRO_Player):void
		{
			if(_roleInfo)
			{
				if(user.base)
				{
					_roleInfo.base = user.base;
				}
				if(user.extra)
				{
					var extra1:PRO_PlayerExtra = _roleInfo.extra;
					var extra2:PRO_PlayerExtra = user.extra;
					var moneyChanged:Boolean = false;
					if(extra1)
					{
						if(extra1.coin != extra2.coin)
						{
							moneyChanged = true;
						}
						else if(extra1.gold != extra2.gold)
						{
							moneyChanged = true;
						}
						else if(extra1.stamina != extra2.stamina)
						{
							moneyChanged = true;
						}
						else if(extra1.bindGold != extra2.bindGold)
						{
							moneyChanged = true;
						}
					}
					
					_roleInfo.extra = extra2;
					
					if(moneyChanged == true)
					{
						this.dispatchEvent(new GameDataEvent(GameDataEvent.MONEY_UPDATE));
					}
				}
				if(user.map)
				{
					_roleInfo.map = user.map;
					try
					{
						SXD2Main.inst.enterMap(_roleInfo.map);
					}catch(e:Error)
					{
						
					}
				}
				if(user.age)
				{
					_roleInfo.age = user.age;
				}
				if(user.city)
				{
					_roleInfo.city = user.city;
				}
				if(user.mood)
				{
					_roleInfo.mood = user.mood;
				}
				if(user.picSex)
				{
					_roleInfo.picSex = user.picSex;
				}
			}
			else
			{
				_roleInfo = user;
			}

		}
		
		/** 
		 * 判断某个id是否是主角id
		 * */
		public function checkLeader(id:int):Boolean
		{
			if(_roleInfo != null)
			{
				var base:PRO_PlayerBase = _roleInfo.base;
				var myID:int = base.id;
				return myID == id;
			}
			return false;
		}
		
		/** 
		 * 判断某个配置是否开启
		 * */
		public function checkConfigOpen(key:Object):Boolean
		{
			// 应小马哥要求，该字段不存在默认为开启
			var bol:Boolean;
			if(gameConfig.hasOwnProperty(key) == false)
			{
				var value:int = int(key);
				if(value > 0)
				{
					var vo:SystemSettingsVO = SystemSettingsManager.inst.getSetting(value);
					//有对应配置
					if(vo)
						bol = vo.defStatus;
				}
				else
				{
					bol = true;
				}
			}
			else if(gameConfig[key] == true)
			{
				bol = true;
			}
			return bol;
		}
		
		/** 
		 * 获取某个配置的值
		 * */
		public function getConfigValue(key:Object):Object
		{
			return gameConfig[key];
		}
		
		/**
		 *保存快速购买记录 
		 * @param list
		 * 
		 */		
		public function setBuyItems(list:Array):void
		{
			for(var i:int;i<list.length;i++)
			{
				var item:BuyCount = list[i] as BuyCount;
				if(item.itemId == 10010004)
					MainUI.inst.leaderPanel.quickBuyConut = item.buyCount;
				if(buyItems[item.itemId.toString()])
				{
					buyItems[item.itemId.toString()].buyCount = item.buyCount
				}
				else
				{
					buyItems[item.itemId.toString()] = item;
				}
			}
		}
		
		/**
		 *根据itemId获取已购买次数 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getItemCount(id:int):int
		{
			if(buyItems[id.toString()])
				return buyItems[id.toString()].buyCount;
			else
				return 0;
		}
		
		
		/**
		 *设置主角名称 
		 * @param str
		 * 
		 */		
		public function set roleName(str:String):void
		{
			_roleName = getOtherPlayerName(str);
		}
		
		
		/**
		 *获取主角名称 
		 * @return 
		 * 
		 */		
		public function getRoleName():PlayerNameVo
		{
			return _roleName;
		}
		
		
		/**
		 *获取玩家名称 
		 * @param name
		 * @return 
		 * 
		 */		
		public function getOtherPlayerName(name:String):PlayerNameVo
		{
			var list:Array = name.split(".");
			var nameVo:PlayerNameVo = new PlayerNameVo();
			nameVo.pName = list[0];
			nameVo.sName = list[1] + "." + list[2];
			
			return nameVo;
		}
		/**
		 * 根据服务器名字获得"短"名字 
		 * @param name
		 * @return 
		 * 
		 */		
		public static function getName(name:String):String
		{
			var list:Array = name.split(".");
			return list[0];
		}
		
		
		/**
		 *获取帮会名 
		 * @param name
		 * @return 
		 * 
		 */		
		public function getGuildName(name:String):PlayerNameVo
		{
			var list:Array = name.split(".");
			var nameVo:PlayerNameVo = new PlayerNameVo();
			if(list.length == 3)
			{
				nameVo.sName = list[0] + "." + list[1];
				nameVo.pName = list[2];
			}
			else
			{
				nameVo.pName = name;
			}
			
			
			return nameVo;
		}
		
		/**
		 * 保存buff
		 * */
		public function setBuff(buf:PRO_PlayerBuf):void
		{
			_buffDic[buf.type] = buf;
		}
		
		/**
		 * 获取buff
		 * */
		public function getBuff(type:int):PRO_PlayerBuf
		{
			var buf:PRO_PlayerBuf = _buffDic[type];
			return buf;
		}
		/**
		 * 酒足饭饱的体力 
		 * @return 
		 */		
		public function get buffTili():int
		{
			var pro:PRO_PlayerBuf = getBuff(RoleBuffTypeDict.TILI);
			if(pro)
			{
				return pro.value;
			}
			return 0;
		}
		
		/**
		 * 移出的buff
		 * */
		public function clearBuff():void
		{
			_buffDic = new Dictionary();
		}
		
		/**
		 * 当前vip
		 * */
		public function get vip():int
		{
			return _roleInfo.extra.vip;
		}
		
		/**
		 * 元宝加绑定元宝
		 * */	
		public function get showGold():int{
			return _roleInfo.extra.gold + _roleInfo.extra.bindGold;
		}
		
		/**
		 *开放 条件 
		 * @param funcName 窗口名
		 * @param showPrompt 是否显示tip
		 * @return 
		 * 
		 */		
		public function getOpenFuncByName(funcName:String,showPrompt:Boolean = true):Boolean
		{
			var isOpen:Boolean;
			var openParam:int;
			var lang:String;
			switch(funcName)
			{
				case WindowEvent.FRIEND_WINDOW://好友功能
				{
					lang = "friends_errcode_5";
					openParam = int(GlobalFun.instance.trans("OPEN_FRIENDCHAT_LEVEL"));
					break;
				}
				case WindowEvent.CHAT_WINDOW://私聊功能
				{
					lang = "friends_errcode_6";
					openParam = int(GlobalFun.instance.trans("OPEN_FRIENDCHAT_LEVEL"));
					break;
				}
				case WindowEvent.FLOWER_SEND_WINDOW://鲜花
				{
					lang = "flower_tips3";
					openParam = int(GlobalFun.instance.trans("OPEN_FRIENDCHAT_LEVEL"));
					break;
				}
					
				default:
				{
					break;
				}
			}
			isOpen = openParam <= playerInfo.level;
			if(!isOpen && showPrompt)
			{
				lang = Lang.instance.trans2(lang,[openParam]);
				DialogManager.inst.showPrompt(lang);
			}
			return isOpen;
		}
		
	}
}

class Singleton{}