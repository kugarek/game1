package utils
{
	import flash.data.EncryptedLocalStore;
	import flash.utils.ByteArray;
	
	import starling.errors.AbstractClassError;
	
	public class Settings
	{
		
		
		private static var _language:String;
		private static var _languageSet:Boolean = true;
		private static var storedValue:ByteArray;
		private static var bytes:ByteArray;
		
		public function Settings() { throw new AbstractClassError(); }
		
		
		if(!EncryptedLocalStore.getItem("language")) {//if no language settings, make one 
			
			bytes = new ByteArray();
			bytes.writeUTFBytes(Constants.ENG);
			EncryptedLocalStore.setItem("language", bytes);	
			languageSet = false;
			
		}
		
		storedValue = EncryptedLocalStore.getItem("language");//read language settings 
		language = storedValue.readUTFBytes(storedValue.length);
		
		if(language == Constants.PL) {
			
			//Root.resourceManager.localeChain = ["pl_PL"];
			Root.resourceManager.localeChain = ["fr_FR"];
		}else
		{
			//Root.resourceManager.localeChain = ["en_GB"];
			Root.resourceManager.localeChain = ["fr_FR"];
			
		}
		
		trace("Locale chain >> " + Root.resourceManager.localeChain);
		
		/**
		 * Re-sets the language in encrypter local storage
		 * first removes the language and then sets the language with the supplied value
		 * @param value:String whih is the language to be set i.e: "Eng" or "Pl"
		 */
		public static function updateLanguage(value:String):void {
			
			EncryptedLocalStore.removeItem("language");
			
			bytes = new ByteArray();
			bytes.writeUTFBytes(value);
			EncryptedLocalStore.setItem("language", bytes);		
			Root.defaultLanguage = value;
			
			if(value == Constants.PL) {
				
				Root.resourceManager.localeChain = ["pl_PL"];
			}else
			{
				Root.resourceManager.localeChain = ["en_GB"];
			}
			
		}

		
		
		public static function get language():String
		{
			storedValue = EncryptedLocalStore.getItem("language");//read language settings 
			language = storedValue.readUTFBytes(storedValue.length);
			return _language;
		}

		public static function set language(value:String):void
		{
			_language = value;
		}

		public static function get languageSet():Boolean
		{
			return _languageSet;
		}

		public static function set languageSet(value:Boolean):void
		{
			_languageSet = value;
		}


	}
}