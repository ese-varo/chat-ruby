var intervalID
var options = {
  method: 'GET',
  headers: {
    'Content-Type': 'application/json'
  },
}

window.addEventListener("load", () => {
  const queryString = window.location
  console.log(queryString.href)
  // setInterval(get_messages(queryString.href), 3000); 
  // setInterval(() => { get_messages(queryString.href); }, 3000);
});

async function get_messages(url) {
  const response = await fetch(url + '.json')
  const data = await response.json()
  render_messages(data)
}

function render_messages(data) {
  console.log(data)
}

// async function getalarms() {
//   const url = BASE_URL + "alarms.json";
//   const response = await fetch(url, options);
//   const data = await response.json();
//   evaluateAlarms(data);
// }
