package com.gamehero.sxd2.gui.core.gossip
{
	import com.gamehero.sxd2.gui.core.util.SpAddUtil;
	import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
	import com.gamehero.sxd2.gui.theme.ifstheme.skin.MapSkin;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import bowser.utils.effect.TextEf;
	
	
	/**
	 * 用于显示人物对话<br>
	 * <li> 宽203 高124
	 * @author weiyanyu
	 * 创建时间：2016-6-30 下午2:25:30
	 **/
	public class GossipBase extends Sprite
	{
		// 闲话泡泡
		protected var _bubbleBg:Bitmap;
		/**
		 * 文字渐出的文本 
		 */		
		protected var textItem:TextEf;
		protected var lb:Label;
		/**
		 * 展示的文本（当前说的话）; 
		 */		
		protected var message:String;
		
		protected var _msgArr:Array; 
		/**
		 * 当前冒泡的语句索引 
		 */		
		protected var _bubbleArrIndex:int;
		/**
		 * 每隔一段时间的interValId 
		 */		
		protected var _gossipTimeId:uint;
		/**
		 * 对话持续时间 
		 */		
		public var delayTime:int = 10;
		
		private var _direct:int = 1;
		/**
		 * 构造函数
		 * */
		public function GossipBase(direct:int = 1)
		{
			super();
			_bubbleBg = new Bitmap(MapSkin.NPC_DIALOGUE_1,"auto",true);
			SpAddUtil.add(this,_bubbleBg);
			// 对话内容
			lb = new Label(false);
			lb.width = 120;
			lb.height = 60;
			lb.leading = 0.4;
			lb.color = 0x000000;
			textItem = new TextEf();
			this.addChild(textItem);
			this.direct = direct;
			initLoc();
		}
		
		/**
		 * 显示全部文字
		 * */
		public function showFullText():void
		{
			if(textItem.isStart == false)
			{
				textItem.show(lb , message);
			}
			textItem.showFull();
			
		}
		
		/**
		 * 需要弹出的会话数组 
		 */
		public function get msgArr():Array
		{
			return _msgArr;
		}
		
		/**
		 * @private
		 */
		public function set msgArr(value:Array):void
		{
			_msgArr = value;
		}
	
		/**
		 * 开始冒泡<br>
		 * 从语言列表里随机找到开始的话，然后依次往后说 
		 * @param index 开始索引
		 */		
		public function start(index:int = -1):void
		{
			clear();
			if(index == -1)
			{
				_bubbleArrIndex = Math.random() * msgArr.length;//从
			}
			else
			{
				_bubbleArrIndex = index;
			}
			intervalShow();
			_gossipTimeId = setInterval(intervalShow,delayTime * 1000);
		}
		/**
		 * 显示冒泡 
		 */		
		protected function intervalShow():void
		{
			if(_bubbleArrIndex >= msgArr.length)
			{
				_bubbleArrIndex = 0;
			}
			showDialog(msgArr[_bubbleArrIndex++]);
		}
		/**
		 * 设置文本内容 
		 * @param dialog
		 * 
		 */		
		public function showDialog(dialog:String):void
		{
			this.message = dialog;
			// 立即显示文字
			textItem.show(lb , message);
			// html文本
			if(message.indexOf("|") >= 0)
			{
				textItem.showFull();
			}
		}
		
		private function initLoc():void
		{
			_bubbleBg.y = -124;
			textItem.y = -108;
			// 正向
			if(_direct == 1)
			{
				textItem.x = 35;
				_bubbleBg.scaleX = 1;
			}
			else
			{
				textItem.x = -168;
				_bubbleBg.scaleX = -1;
			}
		}

		/**
		 * 清空
		 */
		public function clear():void
		{
			if(_gossipTimeId > 0)
			{
				clearInterval(_gossipTimeId);
				_gossipTimeId = 0;
			}
			
			lb.text = "";
			textItem.clear();
		}
		/**
		 * 设置方向 1 右侧/ 2 左侧 
		 * @return 
		 * 
		 */
		public function get direct():int
		{
			return _direct;
		}

		public function set direct(value:int):void
		{
			_direct = value;
		}

	}
}

