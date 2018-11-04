const firestore = firebase.firestore();
const settings = {timestampsInSnapshots: true};
firestore.settings(settings);

function init(){
    firestore.collection("Users").get().then(function(querySnapshot){
        querySnapshot.forEach(function(doc){
          console.log(doc.id, " => ", doc.data());
        });
      });
}