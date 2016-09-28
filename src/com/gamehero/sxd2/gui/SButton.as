package com.gamehero.sxd2.gui
{
		import com.gamehero.sxd2.data.GameDictionary;
		import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
		import com.gamehero.sxd2.gui.theme.ifstheme.skin.CommonSkin;
		import com.gamehero.sxd2.gui.theme.ifstheme.skin.NumericConst;
		
		import flash.display.Bitmap;
		import flash.display.DisplayObject;
		import flash.display.MovieClip;
		import flash.display.SimpleButton;
		import flash.display.Sprite;
		import flash.events.MouseEvent;
		
		import alternativa.gui.base.ActiveObject;
		import alternativa.gui.mouse.CursorManager;
		
		
		
		/**
		 * 用于包装simplebutton
		 * */
		public class SButton extends Sprite
		{
			public static const Status_Up:uint = 0;
			public static const Status_Down:uint = 1;
			public static const Status_Over:uint = 2;
			public static const Status_HitTest:uint = 3;
			
			
			protected var _statuses:Vector.<Object>;
			protected var _status:int = -1;
			public var _simpleButton:SimpleButton;

			private var hitAreaSprite:ActiveObject;
			public var isResponse:Boolean;
			
			public var label:Label;
			public var icon:Bitmap;
			
			/**
			 * 默认文本颜色
			 * */
			protected var _defaultColor:uint;
			/**
			 * 锁定文本颜色
			 * */
			protected var _lockColor:uint;
			
			/**
			 * 按钮特效
			 * */
			protected var _btnMc:MovieClip;
			
			/**
			 * 构造函数
			 * */
			public function SButton(btn:SimpleButton,_lab:String="",_icon:DisplayObject=null,defaultColor:uint = GameDictionary.WINDOW_BTN,lockColor:uint = GameDictionary.WINDOW_BTN_GRAY)
			{
				_defaultColor = defaultColor;
				_lockColor = lockColor;
				_simpleButton = btn;
				
				if(_simpleButton)
				{
					//确保状态全部不为空
					_statuses = new Vector.<Object>(4);
					_statuses[Status_Up]	= _simpleButton.upState;
					_statuses[Status_Over] = _simpleButton.overState;
					_statuses[Status_Down] = _simpleButton.downState;
					_statuses[Status_HitTest] = _simpleButton.hitTestState;
		
					this.addChild(_simpleButton.upState);
					this.addChild(_simpleButton.overState);
					this.addChild(_simpleButton.downState);
					this.addChild(_simpleButton.hitTestState);
					
					//默认全部不显示
					var len:int = _statuses.length;
					for(var i:int = 0;i <len;i++)
					{
						_statuses[i].visible = false;
						
						if(_statuses[i] is MovieClip)
							(_statuses[i] as MovieClip).gotoAndStop(1);
					}
					status = Status_Up;
					
					//按钮添加label
					if(_lab != "")
					{
						label = new Label();
						label.color = _defaultColor;//GameDictionary.WINDOW_BTN;
						label.text = _lab;
						addChild(label);
					}
					
					//按钮添加图标
					if(_icon)
						icon = _icon as Bitmap;
					else
						icon = new Bitmap();
					
					addChild(icon);
					
					setPosition();//设置label和icon位置
				
					/*
					trace("upState---" + _simpleButton.upState.width + "---" + _simpleButton.upState.height + "---" + _simpleButton.upState.x + "---" + _simpleButton.upState.y);
					trace("upState---" + _simpleButton.overState.width + "---" + _simpleButton.overState.height + "---" + _simpleButton.overState.x + "---" + _simpleButton.overState.y);
					trace("upState---" + _simpleButton.downState.width + "---" + _simpleButton.downState.height + "---" + _simpleButton.downState.x + "---" + _simpleButton.downState.y);
					trace("hitTestState---" + _simpleButton.hitTestState.width + "---" + _simpleButton.hitTestState.height + "---" + _simpleButton.hitTestState.x + "---" + _simpleButton.hitTestState.y);
					trace("===============分隔符=======================");
					*/
					// 点击区域 , hint区域
					hitAreaSprite = new ActiveObject();
					hitAreaSprite.graphics.beginFill(0,0);
					hitAreaSprite.graphics.drawRect(_simpleButton.hitTestState.x, _simpleButton.hitTestState.y, _simpleButton.hitTestState.width , _simpleButton.upState.height);
					hitAreaSprite.graphics.endFill();
					hitAreaSprite.cursorActive = true;
					hitAreaSprite.mouseEnabled = true;
					hitAreaSprite.cursorType = CursorManager.HAND;
					addChild(hitAreaSprite);
					
					//this.enabledUI = true;
					this.abledUI(true);
				}
				else
				{
					this.graphics.beginFill(0xff0000);
					this.graphics.drawRect(0,0,50,30);
					this.graphics.endFill();
				}
			}
			/**
			 * 设置icon，<br>
			 * 方便动态改变按钮上的图标 
			 * @param ico
			 * 
			 */			
			public function setIcon(ico:DisplayObject,iconPos:String = "left"):void
			{
				/*
				if(icon != null)
				{
					if(icon.parent)
						icon.parent.removeChild(icon);
				}
				*/
				icon.bitmapData = (ico as Bitmap).bitmapData;
				/*
				if(icon != null)
					addChild(icon);
				*/
				setPosition(iconPos);
			}
			
			
			//设置label和icon位置  
			public function setPosition(iconPos:String = "left"):void
			{
				if (label != null) {
					if(_simpleButton is CommonSkin.spanelBtnClass)
					{
						//小按钮
						label.x = int(_simpleButton.upState.width - label.width >> 1) + 1;
					}
					else
					{
						label.x = int(_simpleButton.upState.width - label.width >> 1);
					}
					label.y = int(_simpleButton.upState.height - label.height >> 1) - 1;
				}
				// 增加bitmapdata判断，否则这段逻辑永远能走进去   by xuwenyi 2016-09-10
				if (icon && icon.bitmapData) 
				{
					if (label != null) {
						if(iconPos == "left")
						{
							icon.x = int(_simpleButton.upState.width - icon.width - label.width - NumericConst.baseIconPadding >> 1);
							label.x = icon.x + int(icon.width) + NumericConst.baseIconPadding;
							label.y = int(_simpleButton.upState.height - label.height >> 1) - 1;
						}
						else if(iconPos == "right")
						{
							label.x = int(_simpleButton.upState.width - icon.width - label.width - NumericConst.baseIconPadding >> 1);
							label.y = int(_simpleButton.upState.height - label.height >> 1) - 1;
							icon.x = label.x + int(label.width) + NumericConst.baseIconPadding;
						}
						
					} else {
						icon.x = int(_simpleButton.upState.width - icon.width >> 1);
					}
					icon.y = int(_simpleButton.upState.height - icon.height >> 1);	
				}
			}
			
			
			public function set hint(value:String):void 
			{
				if(hitAreaSprite == null) 
				{	
					hitAreaSprite = new ActiveObject();
					hitAreaSprite.graphics.beginFill(0,0);
					hitAreaSprite.graphics.drawRect(0, 0, width , height);
					addChild(hitAreaSprite);
					
					hitAreaSprite.cursorType = CursorManager.HAND;
				}
				
				hitAreaSprite.hint = value;
			}
			
			
			public function overHd(event:MouseEvent):void
			{
				if(_status != Status_Down)
				{
					status = Status_Over;
					
					// 悬浮音效
					//SoundManager.instance.play(SoundConfig.BTN_MOUSE_OVER);
					
					// 更改鼠标手型
					CursorManager.cursorType = CursorManager.HAND;
				}
			}
			
			
			
			
			public function outHd(event:MouseEvent):void
			{
				if(_status != Status_Down)
				{
					status = Status_Up;
					
					// 更改鼠标手型
					CursorManager.reset();
				}
			}
			
			
			
			
			public function downHd(event:MouseEvent):void
			{
				status = Status_Down;
				
				this.addEventListener(MouseEvent.MOUSE_UP,inUpHd);
				App.stage.addEventListener(MouseEvent.MOUSE_UP,outUpHd);
				
				
				// 点击音效
				//SoundManager.instance.play(SoundConfig.BTN_MOUSE_CLICK);
			}
			
			
			
			private function inUpHd(event:MouseEvent):void
			{
				if(status != Status_HitTest)
					status = Status_Over;
				
				this.removeEventListener(MouseEvent.MOUSE_UP,inUpHd);
				App.stage.removeEventListener(MouseEvent.MOUSE_UP,outUpHd);
			}
			
			
			
			private function outUpHd(event:MouseEvent):void
			{
				if(status != Status_HitTest)
					status = Status_Up;
				
				this.removeEventListener(MouseEvent.MOUSE_UP,inUpHd);
				App.stage.removeEventListener(MouseEvent.MOUSE_UP,outUpHd);
			}
			
			
			
			public function get status():int
			{
				return _status;
			}
			
			
			
			public function set status(value:int):void
			{

				if(isResponse) return;
				if(_status >= 0 && _status < 4)
				{
					_statuses[_status].visible = false;
				}
				
				_status = value;
				
				if(value >= 0 && value < 4)
				{
					_statuses[_status].visible = true;
					if(_statuses[_status] is MovieClip) 
					{	
						(_statuses[_status] as MovieClip).gotoAndPlay(1);
					}
					
					var len:int = _statuses.length;
					for(var i:int = 0; i < len; i++)
					{ 
						if(i != _status && _statuses[i] is MovieClip)
							(_statuses[i] as MovieClip).gotoAndStop(1);
					}
				}
			}
			
			
			/**
			 * @param value 按钮解锁 (true 可用 ; false 不可用)
			 * */
			/*public function set enabledUI(value:Boolean):void
			{
				this.mouseChildren = value;
				this.mouseEnabled = value;
				hitAreaSprite.mouseEnabled = value;
				hitAreaSprite.mouseChildren = value;
				
				if(value)
				{
					this.status = Status_Up;
					if(!hitAreaSprite.hasEventListener(MouseEvent.MOUSE_DOWN))
					{
						hitAreaSprite.addEventListener(MouseEvent.MOUSE_DOWN, downHd);
					}
					if(!hitAreaSprite.hasEventListener(MouseEvent.ROLL_OUT))
					{
						hitAreaSprite.addEventListener(MouseEvent.ROLL_OUT, outHd);
					}
					if(!hitAreaSprite.hasEventListener(MouseEvent.ROLL_OVER))
					{
						hitAreaSprite.addEventListener(MouseEvent.ROLL_OVER, overHd);
					}
					if(icon)
						icon.alpha = 1;
					if(label)
						label.alpha = 1;
				}
				else
				{
					this.clear();
					this.status = Status_HitTest;
					
					if(icon)
						icon.alpha = 0.2;
					if(label)
						label.alpha = 0.15;
				}
			}*/
			
			/**
			 * @param bool 按钮解锁  (true 可用  ; false 不可用)
			 * */
			public function abledUI(bool:Boolean):void
			{
				//trace("open--" + open + "---status---" + this.status)
				
				this.mouseChildren = bool;
				this.mouseEnabled = bool;
				this.hitAreaSprite.mouseEnabled = bool;
				this.hitAreaSprite.mouseChildren = bool;
			
				if(bool)
				{
					this.status = Status_Up;
					if(!hitAreaSprite.hasEventListener(MouseEvent.MOUSE_DOWN))
					{
						hitAreaSprite.addEventListener(MouseEvent.MOUSE_DOWN, downHd);
					}
					if(!hitAreaSprite.hasEventListener(MouseEvent.ROLL_OUT))
					{
						hitAreaSprite.addEventListener(MouseEvent.ROLL_OUT, outHd);
					}
					if(!hitAreaSprite.hasEventListener(MouseEvent.ROLL_OVER))
					{
						hitAreaSprite.addEventListener(MouseEvent.ROLL_OVER, overHd);
					}
				}
				else
				{
					this.clear();
					this.status = Status_HitTest;

				}
				
				initAlphaColor = bool;
			}
			
			protected function set initAlphaColor(value:Boolean):void
			{
				if(value)
				{
					if(label)
					{
//						label.alpha = 1.0;
						label.color = _defaultColor;
					}
					if(icon)
					{
						icon.alpha = 1.0;
					}
				}
				else
				{
					if(icon)
						icon.alpha = 0.5;
//					if(label)
//						label.alpha = 0.7;
					if(label)
						label.color = _lockColor;
				}
				
			
			}
			public function set lab(value:String):void{
				if (label != null) {
					label.text = value;
					setPosition();
				}
			}
			
			public function clear():void
			{
				hitAreaSprite.removeEventListener(MouseEvent.MOUSE_DOWN, downHd);
				hitAreaSprite.removeEventListener(MouseEvent.ROLL_OUT, outHd);
				hitAreaSprite.removeEventListener(MouseEvent.ROLL_OVER, overHd);
			}
			
		}
	}

