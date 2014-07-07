package actors
{
	import starling.display.Image;
	import starling.events.Event;
	
	public class Two extends Digit
	{
			
		
		public function Two()
		{
			create();
		}
		
		private function create():void
		{
			digitColor = new Image(Root.assets.getTexture( "02_color@2x.png" ));
			digitMono = new Image(Root.assets.getTexture( "02_mono@2x.png" ));
			
			digitColor.name = Constants.TWO;
			digitMono.name = Constants.TWO;
			
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