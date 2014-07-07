package utils
{
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.errors.AbstractClassError;
	import starling.utils.deg2rad;

	public class Animations
	{
		
		public function Animations() { throw new AbstractClassError(); }
		
		
		
		public static function moveUpEndDown(value:Object):void {
			
			/*var currentDate:Date = new Date();
			value.y = 100 + (Math.cos(currentDate.getTime() * 0.002) * 10);*/	
			
			var y:int = value.y - 50;
			
			Starling.juggler.tween(value, 0.5, {
				transition: Transitions.EASE_OUT,
				delay: 0,
				repeatCount: 0,
				reverse: true,
				onComplete: function():void  { trace("moveUpEndDown complete"); },
				y: y
			});
		}
	
		
		public static function removeTweenForTarget(target:Object):void
		{
			Starling.juggler.removeTweens(target);
		}
		
		
		public static function wobbleLeftRight(value:Object, reeatCount:int, degrad:int):void {
			
			/*value.pivotX = value.width  / 2.0;
			value.pivotY = value.height / 2.0;*/
			
			/*value.x = value.width  / 2.0;
			value.y = value.height / 2.0;*/
			
			Starling.juggler.tween(value, 0.5, {
				transition: Transitions.EASE_OUT,
				delay: 0,
				repeatCount: reeatCount,
				reverse: true,
				rotation:  deg2rad(degrad),
				onComplete: function():void {
					
					Starling.juggler.tween(value, 0.5, {
						transition: Transitions.EASE_OUT,
						delay: 0,
						repeatCount: 1,
						reverse: true,
						rotation:  deg2rad(-degrad),
						onComplete: function():void {
							
							Starling.juggler.tween(value, 0.5, {
								transition: Transitions.EASE_OUT,
								delay: 0,
								repeatCount: 1,
								reverse: true,
								rotation:  deg2rad(0),
								onComplete: function():void {
								}				
							});
						}				
					});
				}				
			});
		}
		
		
		/**
		 * Supplied object jumps up + 200 and back to oryginal position 
		 */
		public static function jump(value:Object, delay:Number, repeatCount:Number):void {
			
			Starling.juggler.tween(value, 0.2, {
				transition: Transitions.EASE_OUT,
				delay: delay,
				repeatCount: repeatCount,
				reverse: false,
				onComplete: function():void  { 
				
					Starling.juggler.tween(value, 0.2, {
						transition: Transitions.EASE_IN,
						delay: 0,
						repeatCount: 1,
						reverse: false,
						onComplete: function():void  { trace("jump complete"); wobbleLeftRight(value, 1, 45);},
						y: value.y + 200
					});
				
				},
				y: value.y - 200
			});
			
		}
		
		
		/**
		 * Fades in the supplied object
		 */
		public static function fadeIn(value:Object):void {
			
			/*Starling.juggler.tween(value, 0.5, {
				transition: Transitions.EASE_OUT,
				delay: 0,
				repeatCount: 0,
				reverse: false,
				onComplete: function():void  { trace("fade in complete"); },
				visible: true
			});*/
			
			var tween:Tween = new Tween(value, 0.5);
			tween.fadeTo( 1 );
			Starling.juggler.add(tween);
		}
		
		
		/**
		 * Fades out the supplied object
		 */
		public static function fadeOut(value:Object):void {
			
			/*Starling.juggler.tween(value, 0.5, {
				transition: Transitions.EASE_OUT,
				delay: 0,
				repeatCount: 0,
				reverse: false,
				onComplete: function():void  { trace("fade out complete"); },
				visible: false
			});*/
			
			var tween:Tween = new Tween(value, 0.2);
			tween.fadeTo( 0 );
			Starling.juggler.add(tween);
		}
	}
}