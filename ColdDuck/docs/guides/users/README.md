# Users.cfc
	/** 
	* Component defined in CFScript
	* @output true 
	*/ 
	component extends="MyBaseClass" { 
		/** 
		* Get the User record for the userId passed in
		* @returnType struct
		* @colddoc:generic "numeric,string,string"
		*/ 
		public function getUserRec(required numeric userId) { 
			return(userRec); 
		}
	
		/** 
		* Set the User details for the userId passed in
		* @userId The id of the User table
		* @userName The user's name
		* @dateOfBirth The user's date of birth in a format that can be parsed 
		*/ 	
		public void function setUserName(required numeric userId, required string userName, string dateOfBirth="") { 
	
		} 	 
	}
