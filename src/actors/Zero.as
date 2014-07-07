package actors
{
	import starling.display.Image;
	import starling.events.Event;
	
	public class Zero extends Digit
	{
			
		
		public function Zero()
		{
			create();
		}
		
		private function create():void
		{
			digitColor = new Image(Root.assets.getTexture( "00_color@2x.png" ));
			digitMono = new Image(Root.assets.getTexture( "00_mono@2x.png" ));
			
			digitColor.name = Constants.ZERO;
			digitMono.name = Constants.ZERO;
			
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