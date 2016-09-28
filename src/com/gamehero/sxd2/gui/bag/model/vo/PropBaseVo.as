package com.gamehero.sxd2.gui.bag.model.vo
{
	import com.gamehero.sxd2.data.GameDictionary;
	import com.gamehero.sxd2.gui.core.money.ItemCostVo;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.RandomItemManager;
	import com.gamehero.sxd2.vo.GiftBoxItemVo;

	/**
	 * 道具基类
	 * @author weiyanyu
	 * 创建时间：2015-8-5 下午8:01:00
	 * 
	 */
	public class PropBaseVo
	{
		
		// 配置表属性
		public var id:String;
		
		public var job:int;
		
		public var race:String;
		
		public var name:String;
		
		public var icon:String;//成品伙伴对应的item
		
		public var type:int;
		
		/**
		 * 道具ico路径 
		 */		
		public var ico:String;
		
		/**
		 * 子类 
		 */		
		public var subType:int;
		/**
		 * 等级限制 
		 */		
		public var levelLimited:int;
		/**
		 * 品质 
		 */		
		public var quality:int;
		/**
		 * 堆叠数量 
		 */		
		public var pileNum:int;
		
		public var tips:String;
		/**
		 * 出售/回购消耗货币
		 */		
		public var cost:ItemCostVo;
		/**
		 * 元宝价格 
		 */		
		public var goldCost:ItemCostVo;
		/**
		 * 能否出售 
		 */		
		public var price_limit:Boolean;
		/**
		 *  <h1>切记！不要用此字段作为标志位！！！！这个字段可以是任意类型！</h1><br>
		 * 属性值 ,额外的配置，比如 伙伴 道具就配置伙伴id；<br>
		 * 碎片也配置相应的伙伴id，以后还有其他用处；<br>
		 * 等级礼包用来配置掉落的伙伴id;<br>
		 * 用来处理一些特殊的字段;<br>
		 */		
		public var proValue:String;
		/**
		 * 属性加成类型 
		 */		
		public var propertyType:Array;
		/**
		 * 基础属性 
		 */		
		public var propertyBase:Array;
		/**
		 * 镀金属性 
		 */		
		public var propertyGilt:Array;
		/**
		 * 是否弹出快速使用框 
		 */		
		public var canQuick:Boolean;
		/**
		 * 是否在主背包显示 
		 */		
		public var showMain:Boolean;

		/**
		 * 礼包对应掉落 
		 */		
		public var giftTips:Vector.<Vector.<GiftBoxItemVo>>
		/**
		 *  下一阶装备
		 */		
		public var nextEquip:int;
		/**
		 * 可用于制作 
		 */		
		public var nextItem:int;
		/**
		 * 2016年6月23日20:14:47 装备强化的等级限制  (sh)<br>
		 * 2016年9月2日14:30:46  等级礼包，配置获取的伙伴<br>
		 */		
		public var sundryValue:String;
		/**
		 * 合成材料 //<br>
		 *  如果可合成的话，则长度必然有两个以上，其中：<br>
		 *  最后一个id是消耗品;<br>
		 *  如果是装备，倒数第二个id是消耗的卷轴<br>
		 * 
		 */		
		public var combineItemsId:Array;
		/**
		 *  合成材料 所需数量
		 */		
		public var combineItemsNum:Array;
		/**
		 *  产出章节入口
		 */		
		public var entranceId:String;
		/**
		 *  产出副本Id
		 */		
		public var hurdleId:String;
		/**
		 * 是否弹出引导窗口 
		 */		
		public var isShowGuide:Boolean;
		/**
		 * 镀金材料 
		 */		
		public var goldItems:Array;
		/**
		 * 道具跳转功能 id
		 *  http://10.1.29.87:8080/browse/SXD-4381
		 */		
		public var useFunctionId:int;
		
		public var goldPrice:String;
		public var tongqianPrice:String;
		
		
		public function PropBaseVo()
		{
		}
		
		public function fromXML(xml:XML):void
		{
			id = xml.@item_id;
			type = xml.@type;
			subType = xml.@sub_type;
			name = Lang.instance.trans(xml.@item_name);
			levelLimited = xml.@level_limit;
			tips = Lang.instance.trans(xml.@item_tips);
			ico = xml.@icon;
			job = xml.@job;
			cost = new ItemCostVo(xml.@remove_item);
			goldCost = new ItemCostVo(xml.@gold_cost);
			price_limit = xml.@price_limit == 1 ? true:false;
			proValue = String(xml.@proValue);
			quality = xml.@quality;
			
			pileNum = xml.@pile_num;
			
			entranceId = xml.@entranceId;
			hurdleId = xml.@hurdleId;
			
			var arr:Array;
			var i:int;
			//下面是把配置表里面复杂的多维度配置，转换为简单的单维度
			var splitArr:Array;
			if(String(xml.@property) != "")
			{
				propertyType = new Array();
				propertyBase = new Array();
				
				arr = String(xml.@property).split(GameDictionary.splitHat);
				for(i = 0; i < arr.length; i++)
				{
					splitArr = String(arr[i]).split(GameDictionary.splitWave);
					propertyType.push(splitArr[0]);
					propertyBase.push(splitArr[1]);
				}
			}
			if(String(xml.@gilt_property) != "")
			{
				propertyGilt = new Array();
				arr = String(xml.@gilt_property).split(GameDictionary.splitHat);
				for(i = 0; i < arr.length; i++)
				{
					splitArr = String(arr[i]).split(GameDictionary.splitWave);
					propertyGilt.push(splitArr[1]);
				}
			}
			
			
			canQuick = xml.@canQuick == 1 ? true : false;
			showMain = xml.@show_main == 1 ? true : false;
			
			
			giftTips = RandomItemManager.inst.getDrop(xml.@mustDrops,xml.@propDrops);
			
			nextEquip = xml.@next_equip;
			nextItem = xml.@nextItem;
			sundryValue = xml.@sundryValue;
			
			if(String(xml.@combine_items) != "")
			{
				
				arr = String(xml.@combine_items).split(GameDictionary.splitHat);
				combineItemsId = new Array();
				combineItemsNum = new Array();
				
				var combineItem:Array;
				for(i = 0; i < arr.length; i ++)
				{
					combineItem = String(arr[i]).split(GameDictionary.splitWave);
					combineItemsId.push(combineItem[0]);
					combineItemsNum.push(combineItem[1]);
				}
			}
			
			isShowGuide = xml.@isChoose == 1 ? true : false;
			
			goldItems = String(xml.@giltItems).split(GameDictionary.splitWave);
			
			useFunctionId = xml.@useFunctionId;
			
			
			goldPrice = xml.@goldPrice;
			tongqianPrice = xml.@tongqianPrice;
		}
		
	}
}