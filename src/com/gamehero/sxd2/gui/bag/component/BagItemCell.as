package com.gamehero.sxd2.gui.bag.component
{
	import com.gamehero.sxd2.core.SoundConfig;
	import com.gamehero.sxd2.data.GameData;
	import com.gamehero.sxd2.gui.bag.model.ItemTypeDict;
	import com.gamehero.sxd2.gui.buyback.BuybackWindow;
	import com.gamehero.sxd2.gui.buyback.model.BuyBackDict;
	import com.gamehero.sxd2.gui.core.WindowManager;
	import com.gamehero.sxd2.gui.menu.MenuPanel;
	import com.gamehero.sxd2.gui.menu.OptionData;
	import com.gamehero.sxd2.gui.player.hero.model.HeroModel;
	import com.gamehero.sxd2.gui.quickUse.QuickUseManager;
	import com.gamehero.sxd2.local.Lang;
	import com.gamehero.sxd2.manager.DialogManager;
	import com.gamehero.sxd2.manager.SoundManager;
	import com.gamehero.sxd2.pro.HERO_EQUIP_OPT_TYPE;
	import com.gamehero.sxd2.pro.MSGID;
	import com.gamehero.sxd2.pro.MSGID_STORE_OPT_REQ;
	import com.gamehero.sxd2.pro.PRO_Item;
	import com.gamehero.sxd2.proxy.GameProxy;
	import com.gamehero.sxd2.services.GameService;
	
	import flash.events.MouseEvent;

	public class BagItemCell extends ItemCell
	{
		public function BagItemCell(itemSize:int=0)
		{
			super(itemSize);
		}
		override public function onDoubleClick(e:MouseEvent = null):void 
		{
			if(data)
			{
				if(WindowManager.inst.isWindowOpened(BuybackWindow))
				{
					var sellMsg:MSGID_STORE_OPT_REQ = new MSGID_STORE_OPT_REQ();
					sellMsg.opt = BuyBackDict.SELL;
					sellMsg.id = [data.id];
					GameService.instance.send(MSGID.MSGID_STORE_OPT,sellMsg);
				}
				//道具跳转功能
				else if(QuickUseManager.inst.itemFunc(data as PRO_Item) == false)//
				{
					if(propVo.levelLimited <= GameData.inst.playerInfo.level)
					{
						if(itemType == ItemTypeDict.EQUIP)//如果装备，默认是穿戴
						{
							GameProxy.inst.itemHeroEquip(data.id,HERO_EQUIP_OPT_TYPE.HERO_EQUIP_PUT_ON,HeroModel.instance.curSelectedId,true);
						}
						else if(itemType == ItemTypeDict.GIFT_BOX)//如果是礼包，则双击使用
						{
							GameProxy.inst.itemUse(data.id,1);
						}
					}
					else
					{
						DialogManager.inst.showPrompt("还未达到使用等级");
					}
				}
				
			}
		}	
		override public function onClick(e:MouseEvent = null):void 
		{
			if(data == null) return;
			var options:Array = [];
			if(WindowManager.inst.isWindowOpened(BuybackWindow))//回购窗口开启
			{
				if(propVo.price_limit)
				{
					options.push(new OptionData(MenuPanel.OPTION_SELL ,  "出售"));
				}
				else
				{
					return;
				}
			}
			else
			{
				if(itemType == ItemTypeDict.EQUIP)
				{
					options.push(new OptionData(MenuPanel.OPTION_HERO_EQUIP ,  Lang.instance.trans("file_10003")));
				}
				else if(itemType == ItemTypeDict.GIFT_BOX)
				{
					options.push(new OptionData(MenuPanel.OPTION_USE , Lang.instance.trans("file_10001")));
					if(data.num > 1)
						options.push(new OptionData(MenuPanel.OPTION_USE_All , Lang.instance.trans("批量使用")));
				}
				options.push(new OptionData(MenuPanel.OPTION_SHOW ,  Lang.instance.trans("file_10002")));
			}
			
			
			MenuPanel.instance.initOptions(options,60);
			MenuPanel.instance.showLater(this , App.topUI);
			SoundManager.inst.play(SoundConfig.ITEM_CLICK);
		}
	}
}