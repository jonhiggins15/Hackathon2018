const db = firebase.firestore();
const settings = {timestampsInSnapshots: true};
db.settings(settings);

function init(){
    db.collection("Room").doc("S9PHUv2mJNGPXaLeZU2I").get().then(function(doc){
        if(doc.data().running == true){window.location.replace("dash.html");}
    });

    db.collection('Users').onSnapshot(function(querySnapshot) {
        $("#NamesDiv").empty();
        var Users = [];
        querySnapshot.forEach(function(doc) {
            Users.push(doc.data().name);
        });
        for(var i = 0;i<Users.length;i++){
            $("#NamesDiv").append('<h1 style="color:'+'#'+Math.random().toString(16).substr(-6)+';">'+Users[i]+'&nbsp</h1>');
        }
    });
}

$("#StartButton").click(function(){
    db.collection("Flag").doc("k261RGNArWj8rquSnpzm").set({
        loading: true
    }).then(function(){
        db.collection("Room").doc("S9PHUv2mJNGPXaLeZU2I").set({
            running: true
        }).then(function() {
            console.log("Document successfully written!");
            window.location.replace("load.html");
        })
    })
    .catch(function(error) {
        console.error("Error writing document: ", error);
    });
});