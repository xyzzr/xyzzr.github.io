const firebaseConfig = {

  apiKey: "AIzaSyCSj4qcFinWzSHzJQ_tIFa0iTmrDy7xmCg",

  authDomain: "hit-counter-26c68.firebaseapp.com",

  projectId: "hit-counter-26c68",

  storageBucket: "hit-counter-26c68.appspot.com",

  messagingSenderId: "159086284946",

  appId: "1:159086284946:web:83ec76ba4078c00f84564b"

};
firebase.initializeApp(firebaseConfig);

const hitCounter = document.getElementById("playCount");

const db = firebase.database().ref("totalHits");
db.on("value", (snapshot) => {
  hitCounter.textContent = snapshot.val();
});

const userCookieName = "returningVisitor";
checkUserCookie(userCookieName);
function checkUserCookie(userCookieName) {
  const regEx = new RegExp(userCookieName, "g");
  const cookieExists = document.cookie.match(regEx);
  if (cookieExists != null) {
  } else {
    createUserCookie(userCookieName);
    db.transaction(
      (totalHits) => totalHits + 1,
    );
  }
}

function createUserCookie(userCookieName) {
  const userCookieValue = "Yes";
  const userCookieDays = 7;
  let expiryDate = new Date();
  expiryDate.setDate(expiryDate.getDate() + userCookieDays);
  document.cookie =
    userCookieName +
    "=" +
    userCookieValue +
    "; expires=" +
    expiryDate.toGMTString() +
    "path=/";
}