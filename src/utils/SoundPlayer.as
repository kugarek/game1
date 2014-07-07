package utils
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import starling.errors.AbstractClassError;

	public class SoundPlayer
	{
		
		
		private static var bgdMusic:Sound;
		private static var bgdMusicSC:SoundChannel;
		private static var soundChanel:SoundChannel;
		private static var bgdSoundTransform:SoundTransform;
		private static var currentlyPlayed:Vector.<SoundChannel>;
		
		public function SoundPlayer() { throw new AbstractClassError(); }
		
		EmbededAssets.prepareSounds();
		currentlyPlayed = new Vector.<SoundChannel>;
		
		
		
		public static function stopBgdMusic():void
		{
			bgdMusicSC.stop();
		}
		
		public static function playBgdMusic():void
		{
			if(!bgdMusic) {
				
				bgdMusic = EmbededAssets.getSound("BgmGrooveSound");
				bgdSoundTransform = new SoundTransform(0.5);
			}
			
			var index:int = Constants.MINUS_ONE_VALUE;
			
			if(bgdMusicSC) {
				
				index = currentlyPlayed.indexOf(bgdMusicSC);
			}
			
			
			if(index == Constants.MINUS_ONE_VALUE) {
				
				bgdMusicSC = bgdMusic.play(0, int.MAX_VALUE, bgdSoundTransform);
				currentlyPlayed.push(bgdMusicSC);
			}
		}
		
		protected static function onSoundComplete(event:Event):void
		{
			var targetSoundChannel:SoundChannel = event.currentTarget as SoundChannel;
			targetSoundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);			
			var index:int = currentlyPlayed.indexOf(targetSoundChannel);
			targetSoundChannel = null;
			currentlyPlayed.splice(index, 1);
		}
		
		
		public static function playCrownCheeringSound():void
		{
			soundChanel = new SoundChannel();			
			soundChanel = EmbededAssets.getSound("SmallCrowdCheerSFX").play(0,0, new SoundTransform(0.2));
			soundChanel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			currentlyPlayed.push(soundChanel);
		}
		
				
		public static function playFailedDropSound():void
		{
			soundChanel = new SoundChannel();			
			soundChanel = EmbededAssets.getSound("FailSFX").play();
			soundChanel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			currentlyPlayed.push(soundChanel);
		}
		
		
		public static function playDigitName(value:String):void 
		{
			soundChanel = new SoundChannel();			
			soundChanel = EmbededAssets.getSound(value).play();
			soundChanel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			currentlyPlayed.push(soundChanel);
		}
		
		
		
		/**
		 * Stops playing all sounds in the currentlyPlayed collection 
		 */
		public static function stopAllSounds():void
		{
			/*for each(var target:SoundChannel in currentlyPlayed) {				
				
				target.stop();
			}*/
			
			var length:int = currentlyPlayed.length;
			var target:SoundChannel;
			
			for(var i:int = length - 1; i >= 0; i-- )
			{
				target = currentlyPlayed[i];
				target.stop();
				target = null;
				currentlyPlayed.splice(i, 1);
			}
			
			
			
		}
		
		public static function resumeSounds():void
		{
			playBgdMusic();
		}
		
	}
}