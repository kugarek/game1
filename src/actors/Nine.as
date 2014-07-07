package actors
{
	import starling.display.Image;
	import starling.events.Event;
	
	public class Nine extends Digit
	{
			
		
		public function Nine()
		{
			create();
		}
		
		private function create():void
		{
			digitColor = new Image(Root.assets.getTexture( "09_color@2x.png" ));
			digitMono = new Image(Root.assets.getTexture( "09_mono@2x.png" ));
			
			digitColor.name = Constants.NINE;
			digitMono.name = Constants.NINE;
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onRemovedFromStage():void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			this.removeEventListeners();
			digitColor = null;
			digitMono = null;
		}

	}
}