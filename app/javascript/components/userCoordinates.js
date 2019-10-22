const userCoordinates = () => {
  if (navigator.geolocation){
    navigator.geolocation.getCurrentPosition( position => {
      console.log(position)
      let lat = position.coords.latitude
      let long = position.coords.longitude
      document.querySelector("input[name='latitude']").value = lat
      document.querySelector("input[name='longitude']").value = long
  })
  }
  else {
      console.log("Geolocation not supported by browser");
  }
}

export { userCoordinates }
