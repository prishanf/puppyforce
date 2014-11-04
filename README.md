PuppyForce
==========

Force.com PuppyForce Application.

Employees would like to bring in their dog to work, So this is smaple application that helps manage it. 

Requirments
===========
* Ability to Regsiter Dog/Puppy
* Managment of Desingnatred dog areas.
* Abiility to reserver a spot a puupy for a selected date.
 

Object Design
=============

*Puppy*
  * Name (String 30)
  * Gender (Picklist  Male, Female)
  * Dat of Birth (Date)
  * Color (Text 20)
  * Puppy Owner Lookup (User)
  * Registration Status (Pickuplist Draft,Pending, Approved)
  * Picture Path ( String 255 - hidden)
  * Picture (Formula - image(picture path,'<Puppy Name>',150,150))
  * Puppy Age (Formula - calculate the age)
  * Address (Formula - show the full Puppy owner Address)
  * Phone (Formula - Show Phome NUmber
  * Email (Formula - Email)
  
*Puppy Location*
  * Capacity (Number 2)
  * Number of Puppies (Roll-Up Summary ) 
  * Number Sports Left (Formula )
  
*Puppy Reservation ( Jnction Object )*
  * Puppy ( lookup Puppy Obect)
  * Puppy Location ( lookup Puppy Object)
  * Date (Date) 
  
Validation Rules
================
  * When Puppy Location is Full, then do not allow to Reserver the puppy to the selected location
  * Check if the puppy has been approved to make the reservation
  
Trigger
  Puppy-Object
    * Update the Puppy image Picture Path when picture is attached via attachement
    * Puppy can not be register two different locations on the same date
    
Approval Flow
  After registerting the puppy then user should be able to send it to approve by admin staff. Once Approved, Puppy should be able to reserver a spot for the given day. 
