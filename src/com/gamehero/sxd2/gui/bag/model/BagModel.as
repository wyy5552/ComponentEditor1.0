package com.gamehero.sxd2.gui.bag.model
{
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.gui.bag.events.BagEvent;
	import com.gamehero.sxd2.gui.bag.manager.GameItemEffect;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.core.money.MoneyDict;
	import com.gamehero.sxd2.gui.core.util.TimeUtil;
	import com.gamehero.sxd2.gui.quickUse.QuickUseManager;
	import com.gamehero.sxd2.gui.tips.FloatTips;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.MSG_UPDATE_ITEM_ACK;
	import com.gamehero.sxd2.pro.PRO_Item;
	
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	
	/**
	 * 背包道具
	 * @author weiyanyu
	 * 创建时间：2015-8-7 下午1:49:47
	 * 
	 */
	public class BagModel extends EventDispatcher
	{
		private static var _instance:BagModel;
		
		public static function get inst():BagModel
		{
			if(_instance == null)
				_instance = new BagModel();
			return _instance;
		}
		public function BagModel()
		{
			if(_instance != null)
				throw "BagModel.as" + "is a SingleTon Class!!!";
			_instance = this;
		}
		
		public var domain:ApplicationDomain;
		/**
		 * 背包格子字典，方便查找 ,key id; value  pro_item
		 * 绑定的是格子内的数据
		 */		
		private var itemCellsDict:Dictionary = new Dictionary();
		/**
		 * 主背包数据，包括未装备的 装备。 
		 */		
		private var mainItemCellDict:Dictionary = new Dictionary();
		/**
		 * 装备背包数据 <br>
		 * 装备背包里面的都是已经装备到人身上的，
		 */		
		private var equipItemCellDict:Dictionary = new Dictionary();
		/**
		 * 碎片背包 
		 */		
		private var chipsItemCellDict:Dictionary = new Dictionary();
		/**
		 *杂项背包 材料类
		 */		
		private var sundryItemDict:Dictionary = new Dictionary();
		/**
		 * 经验变化的命格字典<br>
		 * 保留变化前的信息
		 */		
		private var fateCellDict:Dictionary = new Dictionary();
		
		/**
		 *特殊道具存放，如货比，经验等 
		 */		
		private var specialItemDict:Dictionary = new Dictionary();
		
		/**
		 * 查看其他玩家信息的道具背包
		 * */
		private var otherPlayerItemDic:Dictionary = new Dictionary();
		
		/**
		 * 主背包物品 数据
		 */
		public function get mainItemArr():Array
		{
			var itemArr:Array = [];
			
			var propBaseVo:PropBaseVo;
			var num:int;
			for each(var item:PRO_Item in mainItemCellDict)
			{
				propBaseVo = ItemManager.instance.getPropById(item.itemId);
				if(propBaseVo.showMain == false) continue;//不在主背包显示
				itemArr.push(item);
			}
			itemArr.sort(sortBagItem);
			return itemArr;
		}
		
		/**
		 * 根据配置道具tpe 获取该类道具
		 * @param tpe
		 * */
		public function getItemArrByType(tpe:int):Array
		{
			var itemArr:Array = [];
			
			var propBaseVo:PropBaseVo;
			var num:int;
			for each(var item:PRO_Item in mainItemCellDict)
			{
				propBaseVo = ItemManager.instance.getPropById(item.itemId);
				if(propBaseVo.type == tpe)
				{
					itemArr.push(item);
				}
			}
			itemArr.sort(sortBagItem);
			
			return itemArr;
		}
		
		
		private function sortBagItem(paraA:PRO_Item,paraB:PRO_Item):int
		{
			if(paraA.itemId > paraB.itemId)
			{
				return 1;
			}
			else if(paraA.itemId < paraB.itemId)
			{
				return -1;
			}
			else 
			{
				if(paraA.num > paraB.num)
				{
					return -1;
				}
				else if(paraA.num < paraB.num)
				{
					return 1;
				}
				else
				{
					return 0;	
				}
			}
		}
		
		/**
		 * 更新背包道具 
		 * @param data
		 * 
		 */		
		public function updata(data:MSG_UPDATE_ITEM_ACK):void
		{
			
			if(data.init)//第一次刷新背包，记录所有的数据，
			{
				var id:String;
				for each(var item:PRO_Item in data.item)
				{
					id = item.id.toString();//必须 toString，因为id是个uint64（复杂数据类型）
					itemCellsDict[id] = item;
					switch(item.type)
					{
						case BagTypeDict.MAIN_BAG:
							mainItemCellDict[id] = item;
							break;
						case BagTypeDict.EQUIP_WEAPON:
							equipItemCellDict[id] = item;
							break;
						case BagTypeDict.CHIPS:
							chipsItemCellDict[id] = item;
							break;
						case BagTypeDict.SUNDRY:
							sundryItemDict[id] = item;
							break;
						default:
							break;
					}
				}
			}
			else
			{
				var isMainUpdata:Boolean;//主背包是否更新
				for each(var item1:PRO_Item in data.item)
				{
					searchFateExp(item1);//顺序必须放到第一位，因为要记录是否有吞噬操作，以方便播放吞噬动画
					updataMainBag(item1);
					updataEquipBag(item1);
					updataOtherBag(item1,chipsItemCellDict,BagTypeDict.CHIPS);
					updataOtherBag(item1,sundryItemDict,BagTypeDict.SUNDRY);
					updataBag(item1);//要最后刷，因为一些来源判断需要用到刷新之前的数据； 比如脱装备,装备要进入主背包，而装备并不是新获得的
				}
				dispatchEvent(new BagEvent(BagEvent.ITEM_UPDATA,data.item));//背包更新
			}
		}
		
		
		/**
		 * 更新其他玩家道具信息
		 * */
		public function upDataOtherItem(items:Array):void
		{
			//每次查看其他玩家的时候字典重置
			otherPlayerItemDic = new Dictionary();
			var proItem:PRO_Item;
			for(var i:int = 0 ;i < items.length ; i++)
			{
				proItem = items[i] as PRO_Item;
				if(proItem)
				{
					otherPlayerItemDic[proItem.id] = proItem;
				}
			}
		}
		
		/**
		 * 查找其他玩家某个道具
		 * */
		public function getOtherItem(id:int):PRO_Item
		{
			var proItem:PRO_Item = otherPlayerItemDic[id];
			if(proItem)
			{
				return proItem;
			}
			return null;
		}
		
		
		/**
		 * 刷新总背包 
		 */		
		private function updataBag(item:PRO_Item):void
		{
			var id:String = item.id.toString();
			if(item.num == 0)//删除道具
			{
				itemCellsDict[id] = null;
				delete itemCellsDict[id];
			}
			else//修改道具数量或者添加道具
			{
				itemCellsDict[id] = item;
			}
		}
		
		/**
		 * 找到信息变化的命格
		 * <br>经验增加证明被合成过 
		 * 
		 */		
		private function searchFateExp(item:PRO_Item):void
		{
			var id:String = item.id.toString();
			if(itemCellsDict[id] == null)
			{//如果是增加命格，则不处理
				return
			}
			else //信息变化（经验变化，表示吞噬了其他命格）
			{
				if(item.num == 0)
				{//删掉
					fateCellDict[id] = null;
					delete fateCellDict[id];
				}
				else
				{//保留操作之前的数据
					fateCellDict[id] = itemCellsDict[id];//itemCellsDict此时不是最新的数据
				}
			}
		}
		/**
		 * 获取吞噬前的命格 
		 * @param id
		 * @return 
		 * 
		 */		
		public function getFateCellPre(id:String):PRO_Item
		{
			return fateCellDict[id];
		}
		/**
		 * 命格界面关闭后删除经验变化的命格字典 
		 * 
		 */		
		public function clearFateExpDict():void
		{
			for each(var item:PRO_Item in fateCellDict)
			{
				fateCellDict[item.id.toString()] = null;
				delete fateCellDict[item.id.toString()];
			}
		}
		/**
		 * 根据类型找到背包 <br>
		 * 物品唯一id的数组
		 * @param value 不会为null，如果长度为0，则表示该类型背包没有物品
		 * 
		 */		
		public function getItemsByType(value:int):Array
		{
			var arr:Array = new Array();
			for each(var pro:PRO_Item in itemCellsDict)
			{
				if(pro.type == value)
				{
					arr.push(pro.id);
				}
			}
			return arr;
		}
		/**
		 * 刷新主背包 
		 */		
		private function updataMainBag(item:PRO_Item):void
		{
			var id:String = item.id.toString();
			var isUpdata:Boolean;//有些时候并不关心数据具体是怎么变化的，只关心是否有变化
			
			if((item.num == 0 &&item.type == BagTypeDict.MAIN_BAG)//如果该道具是在当前背包，并且该道具数量变成 0
				|| (item.type != BagTypeDict.MAIN_BAG && mainItemCellDict[id] != null))//
				//是其他道具，并且该背包里有，则表示该道具是从该背包 “转移到” 其他背包，应该从该背包里删除
			{
				mainItemCellDict[id] = null;
				delete mainItemCellDict[id];
				dispatchEvent(new BagEvent(BagEvent.MAIN_ITEM_DELETE,item));//
				isUpdata = true;
			}
			else if(item.type == BagTypeDict.MAIN_BAG)//如果
			{
				var itemPro:PRO_Item = mainItemCellDict[id];
				if(itemPro)//背包中有这个道具
				{
					if(itemPro.num < item.num)//道具数量增加
					{
						showTips(itemPro,item.num - itemPro.num);
					}
					mainItemCellDict[id] = item;//需要先改变数据，然后通知别人改
					dispatchEvent(new BagEvent(BagEvent.MAIN_ITEM_CHANGE,item));//
				}
				else//背包中本来不存在这个道具，添加进来
				{
					if(itemCellsDict[item.id.toString()] == null)
					{
						//表示该道具其实是存在人物身上的。比如拖装备的时候，只是将道具从主背包转移到装备背包；
						showTips(item,item.num);
					}
					mainItemCellDict[id] = item;
					dispatchEvent(new BagEvent(BagEvent.MAIN_ITEM_ADD,item));//
				}
				isUpdata = true;
			}
			if(isUpdata)
			{
				dispatchEvent(new BagEvent(BagEvent.MAIN_ITEM_UPDATA,item));//
			}
		}
		/**
		 * 刷新装备背包 <br>
		 * 只需要关心 增删 关系就行了；
		 * 
		 */		
		private function updataEquipBag(item:PRO_Item):void
		{
			var id:String = item.id.toString();
			if((item.num == 0 &&item.type == BagTypeDict.EQUIP_WEAPON)//如果该道具是在当前背包，并且该道具数量变成 0
				|| (item.type != BagTypeDict.EQUIP_WEAPON && equipItemCellDict[id] != null))//
				//是其他道具，并且该背包里有，则表示该道具是从该背包 “转移到” 其他背包，应该从该背包里删除
			{
				equipItemCellDict[id] = null;
				delete equipItemCellDict[id];
			}
			else if(item.type == BagTypeDict.EQUIP_WEAPON)//如果
			{
				equipItemCellDict[id] = item;
			}
		}
		
		/**
		 * ps：其他背包的刷新逻辑其实跟背包的差不多,需要展示一些动画，所以重用一部分 
		 * @param item 
		 * @param dict
		 * @param type
		 * 
		 */		
		private function updataOtherBag(item:PRO_Item,dict:Dictionary,type:int):void
		{
			var id:String = item.id.toString();
			
			if((item.num == 0 &&item.type == type)//如果该道具是在当前背包，并且该道具数量变成 0
				|| (item.type != type && dict[id] != null))//
				//是其他道具，并且该背包里有，则表示该道具是从该背包 “转移到” 其他背包，应该从该背包里删除
			{
				dict[id] = null;
				delete dict[id];
			}
			else if(item.type == type)//如果
			{
				var itemPro:PRO_Item = dict[id];
				if(itemPro)//背包中有这个道具
				{
					if(itemPro.num < item.num)//道具数量增加
					{
						showTips(itemPro,item.num - itemPro.num);
					}
					dict[id] = item;//需要先改变数据，然后通知别人改
				}
				else//背包中本来不存在这个道具，添加进来
				{
					if(itemCellsDict[item.id.toString()] == null)
					{
						//表示该道具其实是存在人物身上的。比如拖装备的时候，只是将道具从主背包转移到装备背包；
						showTips(item,item.num);
					}
					dict[id] = item;
				}
			}
		}
		
		private function showTips(itemPro:PRO_Item,num:int):void
		{
			var propBaseVo:PropBaseVo = ItemManager.instance.getPropById(itemPro.itemId);
			if(MoneyDict.isMoney(itemPro.itemId) == false && propBaseVo.type != ItemTypeDict.HERO_GIFT)//不是钱，而且不是伙伴礼物
			{
				GameItemEffect.inst.show(itemPro.itemId);
			}
			FloatTips.inst.showRoleTopItem(itemPro.itemId,num);
			
			if(propBaseVo.canQuick)
				QuickUseManager.inst.show(itemPro);
		}
		
		/**
		 * 获得当前位置的可穿戴装备
		 * @param loc
		 * @return 
		 * 
		 */		
		public function getLocEquip(loc:int):Array
		{
			var propVo:PropBaseVo;
			var canEquipList:Array  = new Array();
			for each(var item:PRO_Item in mainItemCellDict)
			{
				propVo = ItemManager.instance.getPropById(item.itemId);
				if(propVo.subType != loc || propVo.type != ItemTypeDict.EQUIP)//如果非对应位置  或者 非装备 ，则跳过去
				{
					continue;
				}
				if(propVo.levelLimited > GameData.inst.playerInfo.level)//等级限制
				{
					continue;
				}
				if(item.type != BagTypeDict.MAIN_BAG)
					continue;
				canEquipList.push(item);
			}
			return canEquipList;
		}
		
		/**
		 * 获得物品数量
		 * */
		public function getNumByItemId(itemId:int):Number
		{
			var num:Number = 0;
			if(itemId == MoneyDict.YUANBAO)
			{
				return GameData.inst.playerExtraInfo.bindGold;
			}
			else if(itemId == MoneyDict.YIN_PIAO)
			{
				return GameData.inst.playerExtraInfo.gold;
			}
			else if(itemId == MoneyDict.TONG_QIAN)
			{
				return GameData.inst.playerExtraInfo.coin;
			}
			else if(itemId == MoneyDict.LING_YUN)
			{
				return GameData.inst.playerExtraInfo.spirit;
			}
			else if(itemId == MoneyDict.BANG_GONG)
			{
				return GameData.inst.playerExtraInfo.guildExp;
			}
			else if(itemId == MoneyDict.LING_SHI)
			{
				return GameData.inst.roleInfo.extra.spritStone;
			}
			var item:PRO_Item;
			for each(item in mainItemCellDict)
			{
				if(item.itemId == itemId)
				{
					if(TimeUtil.isTimeOut(item.endTime) == false)
						num += item.num;
				}
			}
			for each(item in chipsItemCellDict)
			{
				if(item.itemId == itemId)
				{
					if(TimeUtil.isTimeOut(item.endTime) == false)
						num += item.num;
				}
			}
			for each(item in sundryItemDict)
			{
				if(item.itemId == itemId)
				{
					if(TimeUtil.isTimeOut(item.endTime) == false)
						num += item.num;
				}
			}
			
			return num;
		}
		
		/**
		 * 获取有相同物品id的格子 
		 * @return 
		 * 
		 */		
		public function getHasSameItemId(itemId:int):Array
		{
			var arr:Array = new Array();
			for each(var item:PRO_Item in mainItemCellDict)
			{
				if(item.itemId == itemId)
				{
					arr.push(item);
				}
			}
			return arr;
		}
		/**
		 * 获取 该物品 最大堆叠数量的格子</br>
		 * 在一些情况下使用道具，希望使用的是最大数量，而非本身格子数量；如快速使用功能。
		 * @return 
		 * 
		 */		
		public function getMaxPileItem(itemId:int):PRO_Item
		{
			var returnItem:PRO_Item;
			var arr:Array = getHasSameItemId(itemId);
			var prop:PropBaseVo = ItemManager.instance.getPropById(itemId);
			for each(var item:PRO_Item in arr)
			{
				if(item.num == prop.pileNum)
				{
					return item;//如果找到最大堆叠的物品，则返回
				}
				else
				{
					returnItem = item;
				}
			}
			return returnItem;
		}
		
		/**
		 * 根据唯一id来拿到物品 自己
		 * @param id
		 * @return 
		 * 
		 */		
		public function getItemById(id:uint):PRO_Item
		{
			return itemCellsDict[id.toString()];
		}
		
		/**
		 * 从背包中获取推荐装备 
		 * @param equipLoc
		 * @return 
		 * 
		 */		
		public function getRecommend(equipLoc:int):PRO_Item
		{
			var propVo:PropBaseVo;//`
			var canEquipList:Array  = getLocEquip(equipLoc);
			if(canEquipList.length > 0)
			{
				canEquipList.sortOn("addLevel" , Array.DESCENDING);
				var addlevel:int = (canEquipList[0] as PRO_Item).addLevel;//最高的强化等级
				var addLvList:Array = new Array();//强化等级最高的列表
				var proPropVo:ProPropVo;
				for each(var pro:PRO_Item in canEquipList)//找到高强化等级的装备
				{
					if(pro.addLevel == addlevel)
					{
						propVo = ItemManager.instance.getPropById(pro.itemId);
						proPropVo = new ProPropVo();
						proPropVo.pro = pro;
						proPropVo.quality = propVo.quality;
						proPropVo.levelLimited = propVo.levelLimited;
						addLvList.push(proPropVo);
					}
				}
				addLvList.sortOn("levelLimited" , Array.DESCENDING);
				var maxLevelLimited:int = addLvList[0].levelLimited;
				var lvList:Array = new Array();//等级限制最高的列表
				for each(var pp:ProPropVo in addLvList)//在高强化的装备里找到高等级的装备
				{
					if(pp.levelLimited == maxLevelLimited)
					{
						lvList.push(pp);
					}
				}
				lvList.sortOn("quality" , Array.DESCENDING);
				var maxQuily:int = lvList[0].quality;
				var quilyList:Array = new Array();//品质最高的列表
				for each(pp in lvList)//在高等级的装备里面找到高品质的
				{
					if(pp.quality == maxQuily)
					{
						quilyList.push(pp);
					}
				}
				return quilyList[0].pro;
			}
			else
			{
				return null;
			}
		}
		
		/**
		 * 获取背包中某一类型的物品数据
		 * @param type 参考BagTypeDict
		 * @return [PRO_Item...]
		 * 
		 */
		public function getProItemsByType(type:int):Array{
			var result:Array = [];
			for each(var item:PRO_Item in itemCellsDict){
				if(item.type == type){
					result.push(item);
				}
			}
			return result;
		}
		/**
		 * 获取对应类型可交易的物品列表 
		 * @param type
		 * @return 
		 * 
		 */		
		public function getTradeProItemByType(type:int):Array
		{
			var result:Array = [];
			for each(var item:PRO_Item in itemCellsDict){
				if(item.type == type){
					if(item.bind == 0)
						result.push(item);
				}
			}
			result.sort(sortBagItem);
			return result;
		}
		
		/**
		 *通过itemId 获取PRo_item数据 
		 * @param itemId
		 * @return 
		 * 
		 */		
		public function getProItemByItemId(itemId:int):PRO_Item
		{
			var item:PRO_Item;
			for each(item in chipsItemCellDict)
			{
				if(item.itemId == itemId)
				{
					if(TimeUtil.isTimeOut(item.endTime) == false)
						break;
				}
			}
			return item;
		}
	}
}

import com.gamehero.sxd2.pro.PRO_Item;

class ProPropVo
{
	/**
	 * 物品
	 */	
	public var pro:PRO_Item;
	/**
	 * 品质 
	 */	
	public var quality:int;
	/**
	 * 等级限制 
	 */	
	public var levelLimited:int;
}