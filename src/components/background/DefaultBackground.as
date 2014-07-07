package components.background
{
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class DefaultBackground extends Sprite
	{
		
		private var sky:Image;
		private var ground:Image;
		private var bottomCloud:Image;
		private var cloudOne:Image;
		private var cloudTwo:Image;
		
		private var tween:Tween;
		
		public function DefaultBackground()
		{
			super();
			createChildren();			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
		}
		
		private function createChildren():void
		{
						
			
			if(!sky) {
				
				sky = new Image(EmbededAssets.getTexture("Sky"));
				sky.x = 0; 
				sky.y = 0;
				this.addChild(sky);
			}
			
			if(!bottomCloud) {				
				bottomCloud = new Image(Root.assets.getTexture("cloud_ground"));			
				this.addChild(bottomCloud);
			}
			
			if(!ground) {
				
				ground = new Image(EmbededAssets.getTexture("Ground"));
				ground.x = 0; 
				ground.y = sky.height - ground.height;
				this.addChild(ground);
			}
					
			
			bottomCloud.y = ground.y - bottomCloud.height + 35 ;
			
			if(!cloudOne) {
				
				cloudOne = new Image(Root.assets.getTexture("cloud_1"));
				cloudOne.x =  sky.x - cloudOne.width - 20;
				cloudOne.y = 200;
				this.addChild(cloudOne);
			}
			
			if(!cloudTwo) {
				
				cloudTwo = new Image(Root.assets.getTexture("cloud_2"));
				cloudTwo.x = sky.x - cloudTwo.width - 20;
				cloudTwo.y = 50;
				this.addChild(cloudTwo);
			}
						
		}
		
		private function onAddedToStage(event:Event):void
		{
			moveCloud(cloudOne, Constants.RIGHT, 25, 2);
			moveCloud(cloudTwo, Constants.RIGHT, 10, 1);
			
			
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function moveCloud(cloud:Image, direction:String, speed:int, delay:int):void
		{
			/*tween = new Tween(cloud, 0.5, Transitions.LINEAR);
			tween.moveTo(sky.x - cloud.width, cloud.y);
			tween.onComplete = onMoveCloudRighComplete();
			
			Starling.juggler*/
			
			var x:int; 
			
			if(direction == Constants.LEFT) {
				
				x = sky.x - cloud.width;
			}else if(direction == Constants.RIGHT) {
				
				x = sky.width;
			}
			
			Starling.juggler.tween(cloud, speed, {
				transition: Transitions.LINEAR,
				delay: delay,
				repeatCount: 0,
				reverse: false,
				onComplete: function():void { trace("move cloud complete") },
				x: x,
				y: cloud.y
			});
		}
		
				
		
		
		private function onMoveCloudRighComplete():Function
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		private function onRemovedFromStage(event:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
						
			//Starling.juggler.purge();
			tween = null;
			
			sky = null;
			ground = null;
			bottomCloud = null;
			cloudOne = null;
			cloudTwo = null;
		}
		
		
	}
}