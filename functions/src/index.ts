import * as functions from 'firebase-functions';
import { ClientResponse } from 'http';
import { firestore } from 'firebase-admin';

const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

var partyArr = ['Bull Moose Party', 'Lawfull Evil Party', 'Left Foot Over All Party', 'The Reasonablists Party', 'The Real House Wives of Notre Dame Party', 'The Birthday Party'];
partyArr.sort(function(a, b){return 0.5 - Math.random()});

// const express = require('express');

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
export const helloWorld = functions.https.onRequest((request, response) => {
    response.send("Hello from Firebase!");
    console.log("request");
});

exports.createdUser = functions.firestore.document('Room/{roomID}').onUpdate((snap, context)=> {
    const settings = {timestampsInSnapshots: true};
    const db = admin.firestore();
    var count = 0
    
    db.settings(settings);
    db.collection('Users').get().then(function(querySnapshot){
        querySnapshot.forEach(element => {
            var docData = {
                role : partyArr[count]
            }
            console.log(element.data());
            console.log(element.id);

            db.collection('Users').doc(element.id).set(docData, {merge: true});

        });
    });
    console.log(db);

    // console.log(context);
    console.log("Test 2");


        
    return null;
});
