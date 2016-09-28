package com.gamehero.sxd2.gui.bag.manager
{
	import com.gamehero.sxd2.core.GameConfig;
	import com.gamehero.sxd2.gui.bag.component.ItemCell;
	import com.gamehero.sxd2.gui.bag.model.ItemTypeDict;
	import com.gamehero.sxd2.gui.bag.model.vo.PropBaseVo;
	import com.gamehero.sxd2.gui.main.MainUI;
	import com.gamehero.sxd2.gui.main.menuBar.MenuButton;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.ItemSkin;
	import com.gamehero.sxd2.manager.FunctionManager;
	import com.gamehero.sxd2.manager.ItemManager;
	import com.gamehero.sxd2.pro.PRO_FunctionID;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import bowser.loader.BulkLoaderSingleton;
	import bowser.utils.MovieClipPlayer;
	
	import br.com.stimuli.loading.loadingtypes.ImageItem;

	/**
	 * 获取背包道具的动画展示
	 * @author weiyanyu
	 * 创建时间：2015-8-26 下午6:12:27
	 * 
	 */
	public class GameItemEffect extends Sprite
	{
		
		private static var _instance:GameItemEffect;
		
		public static function get inst():GameItemEffect
		{
			if(_instance == null)
			{
				_instance = new GameItemEffect();
			}
			return _instance;
		}
		/**
		 * 动画对象池 
		 */		
		private var mcPool:Vector.<MovieClip> = new Vector.<MovieClip>();
		/**
		 * 对象队列 
		 */		
		private var itemList:Vector.<int> = new Vector.<int>();
		/**
		 * 道具动画播放间隔控制Timer 
		 */
		private var _timer:Timer;
		public function GameItemEffect()
		{
			_timer = new Timer(100);
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			// TODO Auto-generated method stub
			if(itemList.length > 0)
			{
				var id:int = itemList.shift();
				var propBaseVo:PropBaseVo = ItemManager.instance.getPropById(id);
				BulkLoaderSingleton.instance.addWithListener(GameConfig.ITEM_ICON_URL + propBaseVo.ico + ".swf", {id:propBaseVo.id}, onIconLoaded);
				BulkLoaderSingleton.instance.start();
			}else{
				stop();
			}
		}		
		
		public function stop():void
		{
			_timer.removeEventListener(TimerEvent.TIMER,onTimer);
			_timer.stop();
		}
		
		public function start():void
		{
			_timer.addEventListener(TimerEvent.TIMER,onTimer);
			_timer.start();
		}

		/**
		 * 展示道具飞 
		 * @param itemId
		 * 
		 */		
		public function show(itemId:int):void
		{
			if(itemList.indexOf(itemId) == -1)
			{
				itemList.push(itemId);
				if(!_timer.running){
					start();
				}
			}
		}
		
		private function onIconLoaded(event:Event):void
		{
			var imageItem:ImageItem = event.currentTarget as ImageItem;
			imageItem.removeEventListener(Event.COMPLETE, onIconLoaded);
			
			var propBaseVo:PropBaseVo = ItemManager.instance.getPropById(int(imageItem.id));
			
			var item:ItemCell = new ItemCell();
			item.name = "bmp";
			item.propVo = propBaseVo;
			
			var mc:MovieClip = getMc();
			var mp:MovieClipPlayer = new MovieClipPlayer();
			mp.play(mc , mc.totalFrames/24 , 0 , mc.totalFrames);
			mp.addEventListener(Event.COMPLETE , over);
			
			function over(e:Event):void
			{
				mp.removeEventListener(Event.COMPLETE , over);
				
				var sp:ItemCell = mc._Icon.getChildByName("bmp");
				if(sp)
					mc._Icon.removeChild(sp);
				sp.clear();
				App.topUI.removeChild(mc);
				pushPool(mc);
			}
			
			//直接加在swf到舞台
			mc._Icon.addChildAt(item,0);
			//mc.play();
			item.x = -22;
			item.y = -22;
			App.topUI.addChildAt(mc,0);
			
			
			var btn:MenuButton;//需要飞入的btn
			if(propBaseVo.type == ItemTypeDict.HERO_CHIPS)//碎片道具要放入到图鉴里面
			{
				btn = FunctionManager.inst.getFuncBtn1(10050);
			}
			else if(propBaseVo.type == ItemTypeDict.HERO)//伙伴飞入布阵
			{
				btn = FunctionManager.inst.getFuncBtn1(10030);
			}
			else if(propBaseVo.type == ItemTypeDict.SUI_HUN || propBaseVo.type == ItemTypeDict.JING_PO)//精魄碎魂到降魔之路上
			{
				btn = MainUI.inst.mainLeaderBar;
			}
			else if(propBaseVo.type == ItemTypeDict.PASSIVE_SKILL)//被动技能 神通
			{
				btn = FunctionManager.inst.getFuncBtn1(10150);
			}
			else
			{
				item.setBackGroud(ItemSkin.BAG_ITEM_NORMAL_BG);
				btn = FunctionManager.inst.getFuncBtn1(10020);
			}
			if(btn)
			{
				var pos:Point = btn.parent.localToGlobal(new Point(btn.x , btn.y));
				mc.x = pos.x + (btn.width >> 1);
				mc.y = pos.y;
				if(btn == MainUI.inst.mainLeaderBar)
				{
					mc.x -= 20;
				}
			}

		}
		
		
		
		private function pushPool(mc:MovieClip):void
		{
			mcPool.push(mc);
		}
		
		private function getMc():MovieClip
		{
			if(mcPool.length > 0)
			{
				return mcPool.pop() as MovieClip;
			}
			else
			{
				return new ItemSkin.ITEM_GET_EFFECT() as MovieClip;
			}
		}
	}
}