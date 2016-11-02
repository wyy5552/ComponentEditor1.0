/**Created by the Morn,do not modify.*/
package game.ui.shell {
	import morn.core.components.*;import moreui.view.*;
	public class GameWindowUI extends View {
		protected static var uiXML:XML =
			<View width="600" height="400">
			  <Image skin="png.comp.bg" x="-3" y="-4" sizeGrid="4,30,4,4" width="603" height="404"/>
			</View>;
		public function GameWindowUI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}