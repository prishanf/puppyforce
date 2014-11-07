<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Reservation_Key</fullName>
        <field>Reservation_Key__c</field>
        <formula>TEXT(Year(Date__c))+ TEXT(Month(Date__c))+ TEXT(Day(Date__c))+ Puppy_Location__r.Id + Puppy__r.Id</formula>
        <name>Update Reservation Key</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>PuppyResrvationCheckDuplicate</fullName>
        <actions>
            <name>Update_Reservation_Key</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Check Duplicate Reservations when Saving or updating the Reservation</description>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
