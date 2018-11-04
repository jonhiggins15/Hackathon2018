const db = firebase.firestore();
const settings = {timestampsInSnapshots: true};
db.settings(settings);

db.collection("Flag").doc("k261RGNArWj8rquSnpzm").onSnapshot(function(doc){
    if(doc.data().loading == false){window.location.replace("dash.html");}
});