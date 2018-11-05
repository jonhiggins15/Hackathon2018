var start = new Date;
const db = firebase.firestore();
const settings = {timestampsInSnapshots: true};
db.settings(settings);

// Check if the room is running
db.collection("Room").doc("S9PHUv2mJNGPXaLeZU2I").onSnapshot(function(doc){
    if(doc.data().running == false){window.location.replace("index.html");}
});

// Set name of Curr Player
db.collection("CurrRoom").doc("currUser").onSnapshot(function(currUserId) {
    db.collection("Users").doc(currUserId.data().uid).get().then(function(user){
        $("#PlayersBill").text(user.data().name+"'s Bill");
    });
});

// Write Name of Next Player
db.collection("CurrRoom").doc("nextUser").onSnapshot(function(currUserId) {
    db.collection("Users").doc(currUserId.data().id).get().then(function(user){
        $("#UpNext").text(user.data().name+"'s Bill");
    });
});

//Say if last bill was passed or failed
db.collection("CurrRoom").doc("lastBill").onSnapshot(function(lastBill){
    console.log(lastBill.data().passed);
    if(lastBill.data().passed){
        console.log('Here');
        $("#LastBillPassed").text("Last Bill Passed");
    }else{
        $("#LastBillPassed").text("Last Bill Failed");
    }
});

db.collection("Bill").onSnapshot(function(billRef){
    var peoplePetermanWontPassTo = []
    billRef.forEach(function(doc) {
        peoplePetermanWontPassTo.push(doc.data().id);
    });
    var i = 0;
    while(i<peoplePetermanWontPassTo.length){
        console.log(peoplePetermanWontPassTo[i]);
        db.collection("Policies").doc(peoplePetermanWontPassTo[i]).get().then(function(policyRef){
            console.log("card"+i)
            $("#card"+i).append("<div class='card CardDiv CardHeight nopadding' ><div class='card-body'><h5 class='card-title'>"+policyRef.data().name+"</h5><p class='card-text'>"+policyRef.data().body+"</p></div></div>");
            i++;
        });
    }
})



var seconds_left = 61;
var interval = setInterval(function() {
    $('#Timer').text(--seconds_left);

    if(seconds_left < 1){
        seconds_left = 60;
    }
}, 1000);

