package actors
{
	import starling.display.Image;
	import starling.events.Event;
	
	public class One extends Digit
	{
			
		
		public function One()
		{
			create();
		}
		
		private function create():void
		{
			digitColor = new Image(Root.assets.getTexture( "01_color@2x.png" ));						
			digitMono = new Image(Root.assets.getTexture( "01_mono@2x.png" ));
			
			digitColor.name = Constants.ONE;
			digitMono.name = Constants.ONE;
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
//			/digitColor.addEventListener(Event.TRIGGERED, onCoulourDigitClick);
		}
		
		private function onRemovedFromStage():void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			this.removeEventListeners();
			digitColor = null;
			digitMono = null;
		}
		
		/*private function onCoulourDigitClick(event:TouchEvent):void
		{
			trace("Digit clicked");
		}*/

	}
}