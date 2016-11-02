/**Created by the Morn,do not modify.*/
package game.ui.shell {
	import morn.core.components.*;import moreui.view.*;
	public class Main2UI extends View {
		protected static var uiXML:XML =
			<View width="600" height="400">
			  <Container width="99" height="77" right="10" bottom="10">
			    <Image skin="png.comp.bg"/>
			  </Container>
			</View>;
		public function Main2UI(){}
		override protected function createChildren():void {
			super.createChildren();
			createView(uiXML);
		}
	}
}