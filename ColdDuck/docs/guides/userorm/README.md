# ORM.User.cfc 
	component persistent="true" table="users" output="false" hint="
	I model a User
	"
	{
		/* properties */
		
		property name="userID" column="userID" type="numeric" ormtype="int" fieldtype="id" required="true" hint="The unique user Id"; 
		property name="userName" column="username" type="string" ormtype="string" required="true" default=""; 			
		property name="dateOfBirth" column="dob" type="string" ormtype="string" required="false" default=""; 			
							
	} 

