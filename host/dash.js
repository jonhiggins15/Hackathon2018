var start = new Date;
const db = firebase.firestore();
const settings = {timestampsInSnapshots: true};
db.settings(settings);

db.collection("Room").doc("S9PHUv2mJNGPXaLeZU2I").get().then(function(doc){
    if(doc.data().running == false){window.location.replace("index.html");}
});

db.collection("CurrRoom").doc("currUser").onSnapshot(function(currUserId) {
    db.collection("Users").doc(currUserId.data().uid).get().then(function(user){
        $("#PlayersBill").text(user.data().name+"'s Bill");
    });
});

db.collection("CurrRoom").doc("nextUser").onSnapshot(function(currUserId) {
    console.log(currUserId.data().name);
});

db.collection("CurrRoom").doc("lastBill").onSnapshot(function(lastBill){
    console.log(lastBill.data().passed);
    if(lastBill.data().passed){
        console.log('Here');
        $("#LastBillPassed").text("Last Bill Passed");
    }else{
        $("#LastBillPassed").text("Last Bill Failed");
    }
});



var seconds_left = 61;
var interval = setInterval(function() {
    $('#Timer').text(--seconds_left);

    if(seconds_left < 1){
        seconds_left = 60;
    }
}, 1000);

