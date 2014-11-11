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
  * Puppy Owner ( Lookup-> User )
  * Registration Status (Pickuplist Draft,Pending, Approved)
  * Status (Formula - Based on the Registration Status display picture for the statses )
   *
 ```
      CASE( Registration_Status__c ,
       'Approved',IMAGE('/servlet/servlet.FileDownload?file=015j00000005I3l','Approved',150,150),
       'Pending',IMAGE('/servlet/servlet.FileDownload?file=015j00000005I3q','Pending',150,150),
       'Draft',IMAGE('/servlet/servlet.FileDownload?file=015j00000005I83','Draft',150,150),''
      )
 ```
  * Picture Path ( String 255 - hidden) Default :'/servlet/servlet.FileDownload?file=015j00000005HzO'
  * Picture (Formula  -Display Puppy Image - image(Picture_Path__c,'Name',150,150)
  * Puppy Age (Formula - calculate the age)
  * Address (Formula - show the full Puppy owner Address)
  * Phone (Formula - Show Phome NUmber
  * Email (Formula - Email)
  
*Puppy Location*
  * Capacity (Number 2)
 
*Puppy Reservation ( Junction Object )*
  * Puppy ( lookup Puppy Obect)
  * Puppy Location ( lookup Puppy Object)
  * Date (Date)
  * Reservation Key (Text 50 - Unique)

*WorkFlow Rules*
 * PuppyResrvationCheckDuplicate - Check Duplicate Reservations when Saving or updating the Reservation
  Rule Criteria : true
  Field Update : Update Reservation Key
  Formula Value : ````TEXT(Year(Date__c))+ TEXT(Month(Date__c))+ TEXT(Day(Date__c))+ Puppy_Location__r.Id + Puppy__r.Id````

 
  
Validation Rules
================
 ####Puppy Reservation####  
  * Check if the puppy has been approved to make the reservation
   Name: Check_Puppy_is_Approved
   Error Location : Puppy , Error Message : Puppy need need to be approved before you can reserve location
   Condition Formula :```` TEXT(Puppy__r.Registration_Status__c) != "Approved" ````

Trigger
  ####PuppyPictureAttachTrigger : ( Object" Attachment)###
    * Update the Puppy image Picture Path when picture is attached via attachement
    ````
    trigger PuppyPictureAttachTrigger on Attachment (after insert,after update) {
    
    Map<id,id> objectIdAttechmentIdMap = new Map<Id,Id>();
    List<Puppy__c> puppiesToUpdate = new List<Puppy__c>();
    for(Attachment attch : trigger.new){
        objectIdAttechmentIdMap.put(attch.ParentId,attch.id);
    }
    List<Puppy__c>  puppyRecords = [select id , Picture_Path__c from Puppy__c where id in :      objectIdAttechmentIdMap.KeySet()]; 
    for(Puppy__c puppy : puppyRecords){
        puppy.Picture_Path__c = '/servlet/servlet.FileDownload?file=' + objectIdAttechmentIdMap.get(puppy.id);
        puppiesToUpdate.add(puppy);
    }
    update puppiesToUpdate;
    
    ````
    ####PuppyReservarionTrigger####
    * Check Location capsacity before regsittering the puppy to the location.  
    ````
    trigger PuppyReservarionTrigger on Puppy_Reservation__c (after insert) {

    List<AggregateResult> results = [Select Puppy_Location__c, Date__c, count(Puppy__c) Num from Puppy_Reservation__c group by Puppy_Location__c, Date__c];
    List<Puppy_Reservation__c> items = [select Puppy_Location__c, Date__c, Puppy_Location__r.capacity__c  from Puppy_Reservation__c where Id IN :Trigger.new];
    
    Map<String,Integer> LocaitonCountMap= new Map<String,Integer>();
    for( AggregateResult r : results){
        LocaitonCountMap.put((String)r.get('Puppy_Location__c')+String.valueof(r.get('Date__c')).substring(0,10),(Integer)r.get('Num'));
    }
  
    for(Puppy_Reservation__c reservation : items ){
        String key = reservation.Puppy_Location__c+ String.valueOf(reservation.Date__c);
        if(LocaitonCountMap.get(key) >= reservation.Puppy_Location__r.capacity__c){
            Trigger.new[0].Puppy_Location__c.addError('Maximum Capacity Exceeds');
        }
    }
    ````
Approval Flow
  After registerting the puppy then user should be able to send it to approve by admin staff. Once Approved, Puppy should be able to reserver a spot for the given day. 
