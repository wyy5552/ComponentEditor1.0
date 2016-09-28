package com.gamehero.sxd2.gui {
	
    import com.gamehero.sxd2.data.GameDictionary;
    import com.gamehero.sxd2.gui.core.GameWindow;
    import com.gamehero.sxd2.gui.core.WindowManager;
    import com.gamehero.sxd2.gui.theme.ifstheme.controls.text.Label;
    import com.gamehero.sxd2.gui.theme.ifstheme.skin.DialogSkin;
    import com.gamehero.sxd2.local.Lang;
    import com.greensock.TweenLite;
    
    import flash.display.Bitmap;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    import org.bytearray.display.ScaleBitmap;
	
	
	
	/**
	 * Global Prompte Window 
	 * @author Trey
	 * @create-date 2013-9-2
	 */
	public class GlobalPrompt extends GameWindow implements IAlert {
		
		private const WINDOW_WIDTH:int = 250;
		private const WINDOW_HEIGHT:int = 78;
		
		
		private const HIDE_DELAY:int = 3;// 秒
		
		
		private var _showTimer:Timer;
//		private var _hideTweenLite:TweenLite;
		private var _tipLabel:Label;
		private var _promptlabel:Label;
		
		private var exclamationBP:Bitmap;
		private var rightBP:Bitmap;
		
		
		/**
		 * Constructor 
		 * @param windonPosition
		 * @param resourceURL
		 * 
		 */
		public function GlobalPrompt(windonPosition:int, resourceURL:String = null) {
			/*
			this.mouseEnabled = false;
			this.tabEnabled = false;
			*/
			super(windonPosition, resourceURL, WINDOW_WIDTH, WINDOW_HEIGHT);
			
			canOpenTween = false;
			
			this.initWindow();
		}
		
		
		
		/**
		 * Init Window  
		 */
		override protected function initWindow():void 
		{	
			
			var bg:ScaleBitmap;
			bg = new ScaleBitmap(DialogSkin.DIALOG_BG);
			bg.scale9Grid = DialogSkin.DIALOG_BG_9GRID;
			bg.width = this.width;
			bg.height = this.height;
			addChild(bg);
			
			
			// 惊叹号
			exclamationBP = new Bitmap(DialogSkin.EXCLAMATION);
			exclamationBP.x = 20;
			exclamationBP.y = this.height - exclamationBP.height >> 1;
			addChild(exclamationBP);
			exclamationBP.visible = false;
			
			// 惊叹号
			rightBP = new Bitmap(DialogSkin.RIGHT);
			rightBP.x = 20;
			rightBP.y = this.height - rightBP.height >> 1;
			addChild(rightBP);
			rightBP.visible = false;
			
			// 提示文字
			_promptlabel = new Label();
			_promptlabel.color = GameDictionary.WINDOW_BLUE;
			_promptlabel.size = 14;
			_promptlabel.x = 92;
			_promptlabel.y = 18;
			addChild(_promptlabel);
			
			
			_tipLabel = new Label();
			_tipLabel.x = 96;
			_tipLabel.y = 42;
			_tipLabel.width = 200;
			_tipLabel.color = GameDictionary.WINDOW_UNSELECT_BTN;
			addChild(_tipLabel);
			
			
			_showTimer = new Timer(1000, HIDE_DELAY);
			_showTimer.addEventListener(TimerEvent.TIMER, showTimerHandler);
			
			_loaded = true;
		}
		
		
		/**
		 * Override onShow
		 * 
		 */
		override protected function onShow():void {
			
			this.alpha = 1;
			
			_tipLabel.text = HIDE_DELAY + "秒后系统自动返回";
			
			_showTimer.reset();
			_showTimer.start();
			
			// 显示
			TweenLite.from(this, WindowManager.WINDOW_MOVE_DURATION, {y: this.y + 50});
			
			addEventListener(MouseEvent.CLICK,clickHandle);
		}
		
		
		
		/**
		 * Show Message
		 * @param text
		 * @param title
		 * @param buttonFlags
		 * @param maxChars 可输入字符数
		 * 
		 */
		public function setMessage(text:String = "", isRight:Boolean = false, text2:String = "", buttonFlags:uint = 0x4, maxChars:int = 20):void
		{	
			_promptlabel.text = text;
			if(isRight)
			{
				exclamationBP.visible = false;
				rightBP.visible = true;
			}
			else
			{
				exclamationBP.visible = true;
				rightBP.visible = false;
			}
		}
		
		
		
		/**
		 * 关闭窗口效果 
		 */
		private function showTimerHandler(e:TimerEvent = null):void 
		{	
			if(_showTimer.currentCount < HIDE_DELAY)
			{	
				_tipLabel.text = (HIDE_DELAY - _showTimer.currentCount) + Lang.instance.trans("err_time");
			}
			else 
			{
				showTimerComplete();
			}
		}

		
		/**
		 *关闭 
		 * 
		 */		
		private function showTimerComplete():void
		{
			TweenLite.to(this, WindowManager.WINDOW_MOVE_DURATION, 
				{
					alpha:0, 
					y: y - 50,
					onComplete:function():void {close();}
				}
			);
			
			_showTimer.stop();
			
			removeEventListener(MouseEvent.CLICK,clickHandle);
		}
		
		
		/**
		 *窗口点击 
		 * @param e
		 * 
		 */		
		private function clickHandle(e:MouseEvent):void
		{
			showTimerComplete();
		}
		
	}
}